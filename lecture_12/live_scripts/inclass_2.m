%% Descriptive Statistics
% using 'group_data.mat'

%% Load data
load("group_data.mat")
fprintf("Measure: %s\n", measure);
fprintf("Control: number of samples: %d\n", numel(control));
fprintf("Treatment: number of samples: %d\n", numel(treatment));

%% Calculate means and standard deviations for control and treatment groups
mean_control = mean(control);
std_control = std(control);
mean_treatment = mean(treatment);
std_treatment = std(treatment);

fprintf("Mean of Control: %.3f, Treatment:  %.3f\n", mean_control, mean_treatment);
fprintf("Std Deviation of Control: %.3f, Treatment:  %.3f\n", std_control, std_treatment);

%% Spread of data
fprintf("std of Control:  %.3f\n", std(control));
fprintf("var of Control:  %.3f\n", var(control));
fprintf("range of Control: %.3f\n", max(control) - min(control));
fprintf("min = %.3f, max = %.3f\n", min(control), max(control));

%% SEM - standard error of mean
n_control = numel(control);
sem_control = std_control / sqrt(n_control);
fprintf("Standard Error of Mean for Control: %.3f\n", sem_control);


%% Summarize BOTH groups in a small table
groups = {control, treatment};
names  = {'control', 'treatment'};
fprintf('\n%-10s %8s %8s %8s %8s\n', 'group', 'mean', 'median', 'std', 'SEM');
for g = 1:2
    x = groups{g};
    fprintf('%-10s %8.2f %8.2f %8.2f %8.2f\n', ...
        names{g}, mean(x), median(x), std(x), std(x)/sqrt(numel(x)));
end


%% Visualize the distribution in histograms
figure;
subplot(1, 2, 1);
histogram(control, 8); title("Control"); xlabel(measure); ylabel('count');
subplot(1, 2, 2);
histogram(treatment, 8); title("Treatment"); xlabel(measure); ylabel('count');


%% Bar chart of group means with SEM error bars
means = [mean(control), mean(treatment)];
sems  = [std(control)/sqrt(numel(control)), ...
    std(treatment)/sqrt(numel(treatment))];
figure;
bar(means, 'FaceColor', [0.6 0.7 0.9]); hold on;
errorbar(1:2, means, sems, 'w', 'LineStyle', 'none', 'LineWidth', 1.5);
set(gca, 'XTickLabel', names);
ylabel(measure);
title('Group means \pm SEM');

%% A boxplot is a compact alternative (Statistics Toolbox)
%  boxplot needs data + grouping labels. Comment out if no toolbox.
allvals  = [control(:); treatment(:)];
alllabel = [repmat({'control'},   numel(control),   1); ...
    repmat({'treatment'}, numel(treatment), 1)];
figure;
boxplot(allvals, alllabel);
ylabel(measure);
title('Distribution by group (boxplot)');