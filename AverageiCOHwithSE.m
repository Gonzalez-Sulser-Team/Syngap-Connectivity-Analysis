clear all
KO_name = ["S7017","S7019","S7020","S7022","S7025","S7027","S7028","S7029","S7033","S7035","S7037","S7038"];
WT_name = ["S7018","S7021","S7023","S7026","S7030","S7031","S7032","S7034","S7036","S7039","S7040","S7041"];

% Calculate average iCOH of all electrode pairs across animals in two groups
% With standard error
for j = 1 : 1 : 12
    filename = append(KO_name(j),"_new_2_abs_20.mat");
    load(filename,'spindleconnectivity_avg');
    load(filename,'short_distance_label');
    connecitivity_single_all496_tmp = squeeze(mean(spindleconnectivity_avg));
    connecitivity_single_all496_tmp = mean(connecitivity_single_all496_tmp);
    connectivity_single_all496_KO(j,:) = connecitivity_single_all496_tmp;
    clear connecitivity_single_all496_tmp;
end
connectivity_single_all496_KO_avg = mean(connectivity_single_all496_KO);
for i = 1 : 1 : 2000
    connectivity_single_all496_KO_min(i) = min(connectivity_single_all496_KO(:,i));
    connectivity_single_all496_KO_max(i) = max(connectivity_single_all496_KO(:,i));
    stderror_all496_KO(i) = std(connectivity_single_all496_KO(:,i)) / sqrt( length(connectivity_single_all496_KO(:,i)));
end

for j = 1 : 1 : 12
    filename = append(WT_name(j),"_new_2_abs_20.mat");
    load(filename,'spindleconnectivity_avg');
    load(filename,'short_distance_label');
    connecitivity_single_all496_tmp = squeeze(mean(spindleconnectivity_avg));
    connecitivity_single_all496_tmp = mean(connecitivity_single_all496_tmp);
    connectivity_single_all496_WT(j,:) = connecitivity_single_all496_tmp;
    clear connecitivity_single_all496_tmp;
end
connectivity_single_all496_WT_avg = mean(connectivity_single_all496_WT);
for i = 1 : 1 : 2000
    connectivity_single_all496_WT_min(i) = min(connectivity_single_all496_WT(:,i));
    connectivity_single_all496_WT_max(i) = max(connectivity_single_all496_WT(:,i));
    stderror_all496_WT(i) = std(connectivity_single_all496_WT(:,i)) / sqrt( length(connectivity_single_all496_WT(:,i)));
end

% Calculate average iCOH of short-distance electrode pairs across animals in two groups
% With standard error
for j = 1 : 1 : 12
    filename = append(KO_name(j),"_new_2_abs_20.mat");
    load(filename,'spindleconnectivity_avg');
    load(filename,'short_distance_label');
    for i = 1 : 1 : 20
        connectivity_short20(i,:,:) = spindleconnectivity_avg(short_distance_label(i),:,:);
    end
    connecitivity_single_short20_tmp = squeeze(mean(connectivity_short20));
    connecitivity_single_short20_tmp = mean(connecitivity_single_short20_tmp);
    connectivity_single_short20_KO(j,:) = connecitivity_single_short20_tmp;
    clear connecitivity_single_short20_tmp;
    clear connectivity_short20;
end
connectivity_single_short20_KO_avg = mean(connectivity_single_short20_KO);
for i = 1 : 1 : 2000
    connectivity_single_short20_KO_min(i) = min(connectivity_single_short20_KO(:,i));
    connectivity_single_short20_KO_max(i) = max(connectivity_single_short20_KO(:,i));
    stderror_short20_KO(i) = std(connectivity_single_short20_KO(:,i)) / sqrt( length(connectivity_single_short20_KO(:,i)));
end

for j = 1 : 1 : 12
    filename = append(WT_name(j),"_new_2_abs_20.mat");
    load(filename,'spindleconnectivity_avg');
    load(filename,'short_distance_label');
    for i = 1 : 1 : 20
        connectivity_short20(i,:,:) = spindleconnectivity_avg(short_distance_label(i),:,:);
    end
    connecitivity_single_short20_tmp = squeeze(mean(connectivity_short20));
    connecitivity_single_short20_tmp = mean(connecitivity_single_short20_tmp);
    connectivity_single_short20_WT(j,:) = connecitivity_single_short20_tmp;
    clear connecitivity_single_short20_tmp;
    clear connectivity_short20;
end
connectivity_single_short20_WT_avg = mean(connectivity_single_short20_WT);
for i = 1 : 1 : 2000
    connectivity_single_short20_WT_min(i) = min(connectivity_single_short20_WT(:,i));
    connectivity_single_short20_WT_max(i) = max(connectivity_single_short20_WT(:,i));
    stderror_short20_WT(i) = std(connectivity_single_short20_WT(:,i)) / sqrt( length(connectivity_single_short20_WT(:,i)));

end

% Calculate average iCOH of electrode pairs with significant differences across animals in two groups
% With standard error
for j = 1 : 1 : 12
    filename = append(KO_name(j),"_new_2_abs_20.mat");
    load(filename,'spindleconnectivity_avg');
    load(filename,'short_distance_label');
    for i = 1 : 1 : 45
        connectivity_lowp45(i,:,:) = spindleconnectivity_avg(combination_label(i),:,:);
    end
    connecitivity_single_lowp45_tmp = squeeze(mean(connectivity_lowp45));
    connecitivity_single_lowp45_tmp = mean(connecitivity_single_lowp45_tmp);
    connectivity_single_lowp45_KO(j,:) = connecitivity_single_lowp45_tmp;
    clear connecitivity_single_lowp45_tmp;
    clear connectivity_lowp45;
end
connectivity_single_lowp45_KO_avg = mean(connectivity_single_lowp45_KO);
for i = 1 : 1 : 2000
    connectivity_single_lowp45_KO_min(i) = min(connectivity_single_lowp45_KO(:,i));
    connectivity_single_lowp45_KO_max(i) = max(connectivity_single_lowp45_KO(:,i));
    stderror_lowp45_KO(i) = std(connectivity_single_lowp45_KO(:,i)) / sqrt( length(connectivity_single_lowp45_KO(:,i)));

end

for j = 1 : 1 : 12
    filename = append(WT_name(j),"_new_2_abs_20.mat");
    load(filename,'spindleconnectivity_avg');
    load(filename,'short_distance_label');
    for i = 1 : 1 : 45
        connectivity_lowp45(i,:,:) = spindleconnectivity_avg(combination_label(i),:,:);
    end
    connecitivity_single_lowp45_tmp = squeeze(mean(connectivity_lowp45));
    connecitivity_single_lowp45_tmp = mean(connecitivity_single_lowp45_tmp);
    connectivity_single_lowp45_WT(j,:) = connecitivity_single_lowp45_tmp;
    clear connecitivity_single_lowp45_tmp;
    clear connectivity_lowp45;
end
connectivity_single_lowp45_WT_avg = mean(connectivity_single_lowp45_WT);
for i = 1 : 1 : 2000
    connectivity_single_lowp45_WT_min(i) = min(connectivity_single_lowp45_WT(:,i));
    connectivity_single_lowp45_WT_max(i) = max(connectivity_single_lowp45_WT(:,i));
    stderror_lowp45_WT(i) = std(connectivity_single_lowp45_WT(:,i)) / sqrt( length(connectivity_single_lowp45_WT(:,i)));

end

% Generate plot with average iCOH of all electrode pairs across animals in two groups
% With standard error range
figure(1)
x = 1 : 1 : 2000
h_KO_min = plot(x, connectivity_single_all496_KO_avg - stderror_all496_KO, 'b');
h_KO_min.Annotation.LegendInformation.IconDisplayStyle = 'off';
hold on;
h_KO_max = plot(x, connectivity_single_all496_KO_avg + stderror_all496_KO, 'b');
h_KO_max.Annotation.LegendInformation.IconDisplayStyle = 'off';
x2 = [x, fliplr(x)];
inBetween = [connectivity_single_all496_KO_avg - stderror_all496_KO, fliplr(connectivity_single_all496_KO_avg + stderror_all496_KO)];
h_KO = fill(x2, inBetween, [0.7 0.8 1]);
set(h_KO,'facealpha',.3)
hold on
h_WT_min = plot(x, connectivity_single_all496_WT_avg - stderror_all496_WT, 'r');
h_WT_min.Annotation.LegendInformation.IconDisplayStyle = 'off';
hold on;
h_WT_max = plot(x, connectivity_single_all496_WT_avg + stderror_all496_WT, 'r');
h_WT_max.Annotation.LegendInformation.IconDisplayStyle = 'off';
x2 = [x, fliplr(x)];
inBetween = [ connectivity_single_all496_WT_avg - stderror_all496_WT, fliplr(connectivity_single_all496_WT_avg + stderror_all496_WT)];
h_WT = fill(x2, inBetween, [1 0.7 0.8]);
set(h_WT,'facealpha',.3)
hold on
plot(x, connectivity_single_all496_KO_avg,'b', 'LineWidth', 2)
hold on
plot(x, connectivity_single_all496_WT_avg,'r', 'LineWidth', 2)
hold on
xlim([0 2000])
ylim([0.2 0.5])
title('Average Connectivity with Standard Erroes during Spindles (-500 - 1500 ms) from All 496 Combinations ');
xlabel('Time (ms)')
ylabel('Connectivity (Absolute Imag Coherence)')
xticks([0 500 1000 2000]);
xticklabels({'Begin','First Spindle Happened (500ms)','1000ms','Over (2000ms)'});
legend('KO Range','WT Range','KO Average','WT Average')

% Generate plot Average iCOH of short-distance electrode pairs across animals in two groups
% With standard error range
figure(2)
x = 1 : 1 : 2000
h_KO_min = plot(x, connectivity_single_short20_KO_avg - stderror_short20_KO, 'b');
h_KO_min.Annotation.LegendInformation.IconDisplayStyle = 'off';
hold on;
h_KO_max = plot(x, connectivity_single_short20_KO_avg + stderror_short20_KO, 'b');
h_KO_max.Annotation.LegendInformation.IconDisplayStyle = 'off';
x2 = [x, fliplr(x)];
inBetween = [connectivity_single_short20_KO_avg - stderror_short20_KO, fliplr(connectivity_single_short20_KO_avg + stderror_short20_KO)];
h_KO = fill(x2, inBetween, [0.7 0.8 1]);
set(h_KO,'facealpha',.3)
hold on
h_WT_min = plot(x, connectivity_single_short20_WT_avg - stderror_short20_WT, 'r');
h_WT_min.Annotation.LegendInformation.IconDisplayStyle = 'off';
hold on;
h_WT_max = plot(x, connectivity_single_short20_WT_avg + stderror_short20_WT, 'r');
h_WT_max.Annotation.LegendInformation.IconDisplayStyle = 'off';
x2 = [x, fliplr(x)];
inBetween = [ connectivity_single_short20_WT_avg - stderror_short20_WT, fliplr(connectivity_single_short20_WT_avg + stderror_short20_WT)];
h_WT = fill(x2, inBetween, [1 0.7 0.8]);
set(h_WT,'facealpha',.3)
hold on
plot(x, connectivity_single_short20_KO_avg,'b', 'LineWidth', 2)
hold on
plot(x, connectivity_single_short20_WT_avg,'r', 'LineWidth', 2)
hold on 
xlim([0 2000])
ylim([0.2 0.5])
title('Average Connectivity with Standard Erroes during Spindles (-500 - 1500 ms) from 20 Short Distance Combinations ');
xlabel('Time (ms)')
ylabel('Connectivity (Absolute Imag Coherence)')
xticks([0 500 1000 2000]);
xticklabels({'Begin','First Spindle Happened (500ms)','1000ms','Over (2000ms)'});
legend('KO Range','WT Range','KO Average','WT Average')

% Generate plot Average iCOH of electrode pairs with significant differences across animals in two groups
% With standard error range
figure(3)
x = 1 : 1 : 2000
h_KO_min = plot(x, connectivity_single_lowp45_KO_avg - stderror_lowp45_KO, 'b');
h_KO_min.Annotation.LegendInformation.IconDisplayStyle = 'off';
hold on;
h_KO_max = plot(x, connectivity_single_lowp45_KO_avg + stderror_lowp45_KO, 'b');
h_KO_max.Annotation.LegendInformation.IconDisplayStyle = 'off';
x2 = [x, fliplr(x)];
inBetween = [connectivity_single_lowp45_KO_avg - stderror_lowp45_KO, fliplr(connectivity_single_lowp45_KO_avg + stderror_lowp45_KO)];
h_KO = fill(x2, inBetween, [0.7 0.8 1]);
set(h_KO,'facealpha',.3)
hold on
h_WT_min = plot(x, connectivity_single_lowp45_WT_avg - stderror_lowp45_WT, 'r');
h_WT_min.Annotation.LegendInformation.IconDisplayStyle = 'off';
hold on;
h_WT_max = plot(x, connectivity_single_lowp45_WT_avg + stderror_lowp45_WT, 'r');
h_WT_max.Annotation.LegendInformation.IconDisplayStyle = 'off';
x2 = [x, fliplr(x)];
inBetween = [ connectivity_single_lowp45_WT_avg - stderror_lowp45_WT, fliplr(connectivity_single_lowp45_WT_avg + stderror_lowp45_WT)];
h_WT = fill(x2, inBetween, [1 0.7 0.8]);
set(h_WT,'facealpha',.3)
hold on
plot(x, connectivity_single_lowp45_KO_avg,'b', 'LineWidth', 2)
hold on
plot(x, connectivity_single_lowp45_WT_avg,'r', 'LineWidth', 2)
hold on
xlim([0 2000])
ylim([0.2 0.5])
title('Average Connectivity with Standard Erroes during Spindles (-500 - 1500 ms) from 45 Low P-valued Combinations ');
xlabel('Time (ms)')
ylabel('Connectivity (Absolute Imag Coherence)')
xticks([0 500 1000 2000]);
xticklabels({'Begin','First Spindle Happened (500ms)','1000ms','Over (2000ms)'});
legend('KO Range','WT Range','KO Average','WT Average')