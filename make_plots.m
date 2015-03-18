%% timing plot
clc
clear
close all

jmi_data = load('tmzout/all-jmi.time');
mrmr_data = load('tmzout/all-mrmr.time');
mim_data = load('tmzout/all-mim.time');
lasso_time = 216.27;
lasso_sele = 35;
npfs_time = 59.137;
npfs_sele = 191;
sels = 100:100:900;
rf_time = 143.14;
rf_sele = 300;

h = figure;
hold on;
box on;
plot(sels, jmi_data, 'r', 'LineWidth', 3)
plot(sels, mrmr_data, 'b', 'LineWidth', 3)
plot(sels, mim_data, 'k', 'LineWidth', 3)
plot(lasso_sele, lasso_time, 'c*', 'LineWidth', 5)
plot(npfs_sele, npfs_time, 'k*', 'LineWidth', 5)
plot(rf_sele, rf_time, 'r*', 'LineWidth', 5)
xlabel('Selected Features', 'FontSize', 22)
ylabel('Time (seconds)', 'FontSize', 22)
legend('JMI', 'mRMR', 'MIM', 'Lasso', 'NPFS-MIM', 'RFC', 'Location', 'best')
set(gca, 'fontsize', 22)
saveas(h, 'eps/timings.eps', 'eps2c')
%% rf weights
clc
clear
close all
dat = importdata('tmzout/qiime-dir/feature_importance_scores.txt');

weights = zeros(length(dat), 1);
for i = 2:length(dat)
  w = strsplit(dat{i}, '\t');
  weights(i-1) = str2num(w{2});
end
%%
close all
w = weights(1:700);
h = figure; 
plot(log(abs(w)), 'LineWidth', 2);
ylabel('log(Decrease in Accuracy)', 'FontSize', 22);
xlabel('Top Ranked Features', 'FontSize', 22);
axis tight;
set(gca, 'fontsize', 22);
saveas(h, 'eps/rf-weights.eps', 'eps2c');
%% 
clc;
clear;
close all;


% cat sel-feat.txt | sed -e "s/(F[0-9]*) //g" -e "s/ &.*//g" -e "s/^/'/g" -e "s/$/'/g" | tr '\n' ', '
feats = {'Bacteroidetes, Bacteroidia, Bacteroidales, Bacteroidaceae, Bacteroides, uniformis (ID1733364)', ...
  'Bacteroidetes, Bacteroidia, Bacteroidales, Bacteroidaceae, Bacteroides (ID197367)',...
  'Firmicutes, Clostridia, Clostridiales, Lachnospiraceae (ID340761)',...
  'Firmicutes, Clostridia, Clostridiales, Ruminococcaceae (ID180285)',...
  'Bacteroidetes, Bacteroidia, Bacteroidales, Bacteroidaceae, Bacteroides, ovatus (ID180606)',...
  'Firmicutes, Clostridia, Clostridiales, Ruminococcaceae (ID352347)',...
  'Bacteroidetes, Bacteroidia, Bacteroidales, Bacteroidaceae, Bacteroides (ID3465233)',...
  'Firmicutes, Clostridia, Clostridiales (ID173876)',...
  'Firmicutes, Clostridia, Clostridiales, Lachnospiraceae (ID193477)',...
  'Bacteroidetes, Bacteroidia, Bacteroidales, Rikenellaceae (ID4453609)',...
  'Firmicutes, Clostridia, Clostridiales, Lachnospiraceae, Ruminococcus, gnavus (ID191755)',...
  'Bacteroidetes, Bacteroidia, Bacteroidales, Porphyromonadaceae, Parabacteroides (ID847228)',...
  'Firmicutes, Clostridia, Clostridiales, Lachnospiraceae, Coprococcus (ID2740950)',...
  'Bacteroidetes, Bacteroidia, Bacteroidales, Bacteroidaceae, Bacteroides (ID190913)',...
  'Firmicutes, Clostridia, Clostridiales, Lachnospiraceae (ID176306)'};

% cat sel-feat.txt | sed -e "s/.* & //g" -e "s/\\\\//g" | tr '\n' ','
vals = [-6.20923 ,5.14587  ,4.18384 ,-4.11038 ,-3.96605 ,-3.65923 ,3.34877 ,...
  -2.49844 ,-2.28077 ,1.94571 ,1.32321 ,1.30030 ,-1.12856 ,0.89408 ,-0.58509]*1e-3;

h = figure; 
hold on;
box on;
stem(find(vals < 0), abs(vals(vals < 0)), 'LineWidth', 2)
stem(find(vals >= 0), abs(vals(vals >= 0)), 'r', 'LineWidth', 2)
ylabel('Difference in Relative Abundance', 'FontSize', 22)
text(3,0.006,'Higher Abundance in Vegetarians', 'Color', 'red', 'FontSize', 22)
text(3,0.0055,'Higher Abundance in Omnivores', 'Color', 'blue', 'FontSize', 22)
set(gca, 'fontsize', 20)
% ax = gca;
% ax.XTick = [0:length(vals)];
saveas(h, 'eps/differences.eps', 'eps2c')

for i = 1:length(feats)
  disp(['(',num2str(i), ') ', feats{i}, '\\']);
end
%% rf weights
clc
clear
close all
dat = importdata('outputs/AmericanGut-Gut-Diet-Results-RF/feature_importance_scores.txt');

weights = zeros(length(dat), 1);
for i = 2:length(dat)
  w = strsplit(dat{i}, '\t');
  weights(i-1) = str2num(w{2});
end
%%
w = weights;%(1:700);
h = figure; 
plot(log(abs(w)), 'LineWidth', 2);
ylabel('log(Decrease in Accuracy)', 'FontSize', 22);
xlabel('Top Ranked Features', 'FontSize', 22);
axis tight;
set(gca, 'fontsize', 22);
saveas(h, 'eps/rf-agp-weights.eps', 'eps2c');
