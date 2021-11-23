% This function will import the Open Ephys file into the Fieldtrip
% and add the trial information from Excel file into the data set
function [data] = loaddata_sleeping(filename_a,fsample,nchan,initial_chan,trialname,trialrange)

data_2 = []; % Create a temporory dataset

% Loading the data file into MATLAB
for j = 1 : 1 : nchan % The loop to load data from all channels
        labelnum2 = initial_chan - 1 + j;
        labelnum2_string = num2str(labelnum2);
        filename_b = '.continuous';
        filename = [filename_a,labelnum2_string,filename_b];
        [data_temp, timestamps_temp, info_temp] = load_open_ephys_data(filename);
        dat(j,:) = data_temp(:,1);
        data_2.label{j,1} = labelnum2_string;
        data_2.hdr.label{j,1} = labelnum2_string;
        data_2.hdr.chantype{j,1} = 'eeg';
        data_2.hdr.chanunit{j,1} = 'uV';
end

data_2.time{1,1} = timestamps_temp.';
data_2.fsample = fsample;
data_2.hdr.Fs  = fsample; %            sampling frequency
data_2.hdr.nChans = nchan; %            number of channels
data_2.hdr.nSamples = length(data_2);%           number of samples per trial
data_2.hdr.nSamplesPre = 0;%         number of pre-trigger samples in each trial
data_2.hdr.nTrials = 1; %           number of trials

%Define Trials
%Importing the trial information into the MATLAB from Excel files
T = readtable(trialname,'range',trialrange);
% T = T_temp;
segment_number = length(table2array(T));
event_temp = zeros(segment_number,3);
event_temp(1:segment_number,1:3) = table2array(T);
sampleinfo_temp = event_temp;
sampleinfo_temp(:,2:3) = sampleinfo_temp(:,2:3) .* 1000;
data_2.sampleinfo = sampleinfo_temp(:,2:3);
data_2.sampleinfo(:,1) = data_2.sampleinfo(:,1) + 1;
data_2.trialinfo = sampleinfo_temp(:,1);
for n = 1:1:segment_number
    data_2.trial{1,n} = dat(:,(data_2.sampleinfo(n,1)) : (data_2.sampleinfo(n,2)));
    data_2.time{1,n} = (timestamps_temp((data_2.sampleinfo(n,1)) : (data_2.sampleinfo(n,2)),:)).';
end

%Verify the format of the raw data
[data] = ft_datatype_raw(data_2);
