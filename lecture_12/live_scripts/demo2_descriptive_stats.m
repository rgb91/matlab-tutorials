%% DEMO 2: DESCRIPTIVE STATISTICS
%  Session 11 — 1 July 2026
%  MATLAB functions: mean, median, std, var, min, max, range, numel
%  Neuroscience context: summarising resting alpha power across subjects
%  ─────────────────────────────────────────────────────────────────────
%
%  Before testing anything, we DESCRIBE the data:
%    - Centre   : where is the middle?      (mean, median)
%    - Spread   : how variable is it?        (std, var, range)
%    - Precision: how well do we know the mean? (SEM = std / sqrt(n))

%% 2A — Load the data
load('data/group_data.mat');   % control, treatment (1×20 each), measure
fprintf('Measure: %s\n', measure);
fprintf('control:   n = %d\n', numel(control));
fprintf('treatment: n = %d\n', numel(treatment));

%% 2B — Centre of the data
fprintf('\n--- CONTROL group ---\n');
fprintf('mean   = %.3f\n', mean(control));
fprintf('median = %.3f\n', median(control));
% mean is the arithmetic average; median is the middle value when sorted.
% If mean and median differ a lot, the data are skewed or have outliers.

%% 2C — Spread of the data
fprintf('std    = %.3f   (typical distance from the mean)\n', std(control));
fprintf('var    = %.3f   (std squared)\n', var(control));
fprintf('range  = %.3f   (max - min)\n', max(control) - min(control));
fprintf('min    = %.3f,  max = %.3f\n', min(control), max(control));
% MATLAB's std uses the SAMPLE formula (divide by n-1) by default.

%% 2D — SEM: how precisely do we know the mean?
%  The standard error of the mean shrinks as we collect more subjects.
n   = numel(control);
sem = std(control) / sqrt(n);
fprintf('SEM    = %.3f   (std / sqrt(n))\n', sem);
% Rule of thumb: mean ± 2*SEM is roughly a 95%% confidence interval.

%% 2E — Summarise BOTH groups in a small table
groups = {control, treatment};
names  = {'control', 'treatment'};
fprintf('\n%-10s %8s %8s %8s %8s\n', 'group', 'mean', 'median', 'std', 'SEM');
for g = 1:2
    x = groups{g};
    fprintf('%-10s %8.2f %8.2f %8.2f %8.2f\n', ...
        names{g}, mean(x), median(x), std(x), std(x)/sqrt(numel(x)));
end

%% 2F — Visualise the distributions (histograms)
figure;
subplot(1,2,1);
histogram(control, 8); title('Control'); xlabel(measure); ylabel('count');
subplot(1,2,2);
histogram(treatment, 8); title('Treatment'); xlabel(measure); ylabel('count');

%% 2G — Bar chart of group means with SEM error bars
means = [mean(control), mean(treatment)];
sems  = [std(control)/sqrt(numel(control)), ...
         std(treatment)/sqrt(numel(treatment))];
figure;
bar(means, 'FaceColor', [0.6 0.7 0.9]); hold on;
errorbar(1:2, means, sems, 'k', 'LineStyle', 'none', 'LineWidth', 1.5);
set(gca, 'XTickLabel', names);
ylabel(measure);
title('Group means \pm SEM');
% The error bars show the difference looks substantial relative to the
% uncertainty. demo3 tests whether it is statistically significant.

%% 2H — A boxplot is a compact alternative (Statistics Toolbox)
%  boxplot needs data + grouping labels. Comment out if no toolbox.
allvals  = [control(:); treatment(:)];
alllabel = [repmat({'control'},   numel(control),   1); ...
            repmat({'treatment'}, numel(treatment), 1)];
figure;
boxplot(allvals, alllabel);
ylabel(measure);
title('Distribution by group (boxplot)');
