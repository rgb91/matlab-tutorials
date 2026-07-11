%% EXERCISE 1: Descriptive Statistics — SOLUTION
%  Session 11 — 1 July 2026
%  ─────────────────────────────────────────────────────

%% 1: Load data
load('data/exercise_data.mat');   % eyes_open, eyes_closed, measure
fprintf('Measure: %s\n', measure);
fprintf('eyes_open   n = %d\n', numel(eyes_open));
fprintf('eyes_closed n = %d\n', numel(eyes_closed));

%% 2 & 3: Summary statistics for both conditions
groups = {eyes_open, eyes_closed};
names  = {'eyes open', 'eyes closed'};
fprintf('\n%-12s %8s %8s %8s %8s\n', 'condition', 'mean', 'median', 'std', 'SEM');
for g = 1:2
    x = groups{g};
    fprintf('%-12s %8.2f %8.2f %8.2f %8.2f\n', ...
        names{g}, mean(x), median(x), std(x), std(x)/sqrt(numel(x)));
end
% EXPECTED (approx):
%   eyes open  : mean 3.86  median ~3.9  std 1.30  SEM 0.31
%   eyes closed: mean 6.43  median ~6.5  std 0.99  SEM 0.23

%% 4: Bar chart with SEM error bars
means = [mean(eyes_open), mean(eyes_closed)];
sems  = [std(eyes_open)/sqrt(numel(eyes_open)), ...
         std(eyes_closed)/sqrt(numel(eyes_closed))];
figure;
bar(means, 'FaceColor', [0.6 0.7 0.9]); hold on;
errorbar(1:2, means, sems, 'k', 'LineStyle', 'none', 'LineWidth', 1.5);
set(gca, 'XTickLabel', names);
ylabel(measure);
title('Alpha peak amplitude: eyes open vs closed (mean \pm SEM)');
% Eyes-closed alpha is clearly higher — the classic Berger effect.
