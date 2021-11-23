% Import data & Define trials
clear all;
fsample = 1000; % Sampling Frequency (Hz)
nchan = 32; % Number of EEG Channels
filename_a = 'E:\MATLAB\Dataset\WT\S7026_D2-A\100_CH'; % Path of the files with partial filename
trialname = 'S7026_new_2.xls'; % Excel file containing trial segmentation information
trialrange = 'A1:C108'; 
initial_chan = 65; % The first EEG channel's label (Here could be 1, 33, 65 and 97)
% Load the Open Ephys data with trial definition
[data5_A] = loaddata_sleeping(filename_a,fsample,nchan,initial_chan,trialname,trialrange);

% Band-pass Filter
cfg                = [];
cfg.bpfilter       = 'yes'; % Band-pass Filter
cfg.bpfreq         = [2 50]; % Frequency Range
cfg.demean         = 'yes'; % Demean (Baseline correct) ...
cfg.detrend        = 'yes'; % Removing linear trends
cfg.baselinewindow = [-Inf 0];% using the mean activity in this window

data_EEG_filt = ft_preprocessing(cfg, data5_A); % Apply the Filter

% Rename the labels
load label.mat; % Load label file
data_EEG_filt.label = label; % Replace with the new label 

%Dynamic Connectivity Analysis
trial_number = length(data_EEG_filt.trialinfo); % The number of the trials
spindleconnectivity_average = zeros(496,11,2000); % Create a new temporary matrix
spindleconnectivity_number = 0; 
for i = 1 : 1 : trial_number
    k = i * 2;
    m = k - 1;
    if (data_EEG_filt.trialinfo(i) == 4); % All trial label should be 4 here
        no_temp = i;
        % Frequency Analysis
        wake_no = no_temp;
        trials_temp = [wake_no];
        timestart_temp = data_EEG_filt.time{1, wake_no}(1); % First time sample
        timeend_temp = data_EEG_filt.time{1, wake_no}(2000); % The last time sample
        cfg = [];
        cfg.method    = 'wavelet'; % Morlet Wavelet Transform
        cfg.output    = 'powandcsd'; % Output with power spectrum and cross power spectrum
        cfg.foi       = 12 : 0.5 : 17; % Freq range
        cfg.toi       = timestart_temp : 0.001 : timeend_temp; % Time range
        cfg.trials = trials_temp;
        cfg.pad= 'nextpow2'; % A configure to boost the calculation speed (Fieldtrip official recommended)
        freq_filt = ft_freqanalysis(cfg, data_EEG_filt);

        %Connectivity Analysis
        cfg = [];
        cfg.method = 'coh'; % Coherence Algorithm;
        cfg.complex = 'imag'; % Imaginary part of coherence 
        stat_filt = ft_connectivityanalysis(cfg, freq_filt);
        
        % Absolute value of iCOH
        spindleconnectivity_average_temp = abs(stat_filt.cohspctrm);
        
        % Sum
        spindleconnectivity_average = spindleconnectivity_average + spindleconnectivity_average_temp;
        spindleconnectivity_number = spindleconnectivity_number + 1;
        trial_no_temp = no_temp ;
        
        %Extract Short-distance Channel Combinations
        short_distance_label = [1,8,62,91,146,172,244,287,307,344,377,406,419,442,468,469,476,487,491,496];
        for j = 1 : 1 : 20
            short_distance_tmp = short_distance_label(j)
            connectivity_channelcombination_short(j,:,:) = spindleconnectivity_average_temp(short_distance_tmp,:,:);
        end
        
        %Extract high-connectivity pixels for each electrode pair
        %Calculate mean iCOH for each electrode pair
        connectivity_channelcombination_avg = zeros(20,1,2000);
        connectivity_channelcombination_avg = mean(abs(connectivity_channelcombination_short),2);
        connectivity_channelcombination_avg = mean(connectivity_channelcombination_avg,3);
        %Extract electrode pairs with high mean iCOH
        connectivity_channelcombination_avg_max = max(connectivity_channelcombination_avg);
        connectivity_channelcombination_avg_min = min(connectivity_channelcombination_avg(connectivity_channelcombination_avg > 0));
        connectivity_channelcombination_avg_threshold = connectivity_channelcombination_avg_min + 0.7 * (connectivity_channelcombination_avg_max - connectivity_channelcombination_avg_min);
        connectivity_channelcombination_hc = find(connectivity_channelcombination_avg > connectivity_channelcombination_avg_threshold);
        
        %Average Connectivity Figure
        connectivity_channelcombination_hc_length = length(connectivity_channelcombination_hc);
        for g = 1 : 1 : connectivity_channelcombination_hc_length
            connectivity_hc_label_tmp = connectivity_channelcombination_hc(g);
            connectivity_hc(g,:,:) = abs(connectivity_channelcombination_short(connectivity_hc_label_tmp,:,:));
        end
        connectivity_hc_avg = mean(connectivity_hc);
        connectivity_hc_avg = squeeze(connectivity_hc_avg);
        
        %Extract high connectivity pixels
        hc_pixel_max = max(max(abs(connectivity_hc_avg)));
        hc_pixel_min = min(min(connectivity_hc_avg(connectivity_hc_avg > 0)));
        hc_pixel_threshold = hc_pixel_min + (0.7 * (hc_pixel_max - hc_pixel_min)); % 70% Threshold
        [hc_pixel_freq,hc_pixel_time] = find(abs(connectivity_hc_avg) > hc_pixel_threshold);
        hc_pixel_time_total{i} = hc_pixel_time;
        
    end
end
% Averaging connectivity matrix
spindleconnectivity_avg = spindleconnectivity_average ./ spindleconnectivity_number;
% Create a temp connectivity dataset
stat_filt2 = stat_filt;
% Replace with average connectivity matrix
stat_filt2.cohspctrm = spindleconnectivity_avg;

%Calculate the duration of each trial
for i = 1 : 1 : trial_number
    hc_pixel_time_tmp = hc_pixel_time_total{i};
    hc_pixel_time_tmp = unique(hc_pixel_time_tmp);
    hc_pixel_duration_tmp = length(hc_pixel_time_tmp);
    hc_pixel_duration(i) = hc_pixel_duration_tmp;
end

%Extract electrode pairs (short-distance only) with high mean iCOH
for i = 1 : 1 : 20
    label_num = short_distance_label(i);
    seizure_spindles_tmp = zeros(1,11,2000);
    seizure_spindles_tmp = seizureconnectivity_avg(label_num,:,:);
    seizure_spindles_tmp = reshape(seizure_spindles_tmp,[11 2000]);
    seizure_subplot{i} = seizure_spindles_tmp;
    seizure_subplot_avg_tmp = mean(abs(seizure_spindles_tmp(:)));
    seizure_subplot_avg(i) = seizure_subplot_avg_tmp;
end

% Extract the frequency and time coordinates of high connectivity
% components in coherencegram
connectivity_short_max = max(abs(seizure_subplot_avg));
connectivity_short_min = min(seizure_subplot_avg(seizure_subplot_avg >0));
[spindles_subplot_avg_loca_x,spindles_subplot_avg_loca_y] = find(abs(seizure_subplot_avg) > (connectivity_short_min +  ((connectivity_short_max - connectivity_short_min)* 0.7)));
spindles_subplot_avg_loca = spindles_subplot_avg_loca_y;

% Output the average connectivity for each short-distance electrode pair
% Output the time coordinates of high connectivity in mean iCOH figure
% across short-distance electrode pair
% Output the average duration of high connectivity components for each
% animal
AAAA_shortdistance_combination_avg = seizure_subplot_avg;
AAAA_shortdistance_combination_hc = spindles_subplot_avg_loca_y.';
AAAA_hc_pixel_duration = hc_pixel_duration;

% Extract the iCOH Matrices for selected electrode pairs with high mean
% iCOH
high_connectivity_matrices_all_avg = zeros(11,2000);
connectivity_path_num = length(spindles_subplot_avg_loca);
for i = 1 : 1 : connectivity_path_num
    connectivity_path_label = spindles_subplot_avg_loca(i);
    connectivity_path_label_2 = short_distance_label(connectivity_path_label);
    high_connectivity_matrices_tmp = abs(seizureconnectivity_avg(connectivity_path_label_2,:,:));
    high_connectivity_matrices_tmp = reshape(high_connectivity_matrices_tmp,[11 2000]);
    high_connectivity_matrices_all_avg = high_connectivity_matrices_all_avg + high_connectivity_matrices_tmp;
end
high_connectivity_matrices_all_avg = high_connectivity_matrices_all_avg ./ connectivity_path_num;
high_connectivity_matrices_range = high_connectivity_matrices_all_avg > 0;
high_connectivity_matrices_all_avg_max = max(max(high_connectivity_matrices_all_avg));
high_connectivity_matrices_all_avg_min = min(min(high_connectivity_matrices_all_avg(high_connectivity_matrices_all_avg > 0)));
[high_connectivity_matrices_xmax,high_connectivity_matrices_ymax] = find(high_connectivity_matrices_all_avg> (high_connectivity_matrices_all_avg_min + ((high_connectivity_matrices_all_avg_max - high_connectivity_matrices_all_avg_min) * 0.7)));

% Save the dataset for each animal for further analysis
save S7041_new_2_abs_20