%% HOMEWORK — SOLUTION: Session 13
%  Full pipeline: multi-subject figure + colourmap + ANOVA.
%  Data: homework_s13.mat (P300 dose study, 3 independent groups)

%% Part A — Grand averages with SEM shading
load('data/homework_s13.mat');   % erp_placebo/low_dose/high_dose, erp_time, ...
time_ms = erp_time * 1000;

conds  = {erp_placebo, erp_low_dose, erp_high_dose};
labels = {'placebo', 'low dose', 'high dose'};
cols   = [0.45 0.45 0.45;      % grey
          0.20 0.55 0.75;      % blue
          0.80 0.30 0.30];     % red

figure; hold on;
h = gobjects(1, 3);
for i = 1:3
    x  = conds{i};
    n  = size(x, 1);
    ga = mean(x, 1);
    sem = std(x, 0, 1) / sqrt(n);
    fill([time_ms, fliplr(time_ms)], [ga+sem, fliplr(ga-sem)], ...
        cols(i,:), 'FaceAlpha', 0.18, 'EdgeColor', 'none');
    h(i) = plot(time_ms, ga, 'Color', cols(i,:), 'LineWidth', 1.8);
end
xline(0, 'k:'); yline(0, 'k:');
xlabel('Time (ms)'); ylabel('Amplitude (\muV)');
title(sprintf('Grand-average P300 by dose at %s', channel));
legend(h, labels, 'Location', 'northwest');
set(gca, 'FontSize', 12);

%% Part B — erp-image colourmap (high-dose group)
n_hi = size(erp_high_dose, 1);
figure;
imagesc(time_ms, 1:n_hi, erp_high_dose);
set(gca, 'YDir', 'normal');
colormap(parula); colorbar;
xlabel('Time (ms)'); ylabel('Subject');
title('High-dose group: single-subject ERPs (\muV)');

%% Part C — Peak per subject -> ANOVA -> post-hoc
pk = (erp_time >= 0.25) & (erp_time <= 0.45);
peaks = cell(1, 3);
fprintf('\n%-10s %8s %8s %8s\n', 'group', 'mean', 'std', 'SEM');
for i = 1:3
    peaks{i} = max(conds{i}(:, pk), [], 2);
    x = peaks{i};
    fprintf('%-10s %8.2f %8.2f %8.2f\n', ...
        labels{i}, mean(x), std(x), std(x)/sqrt(numel(x)));
end

% stack + label (or simply use peak_values / peak_group from the file)
y = [peaks{1}; peaks{2}; peaks{3}];
g = [repmat(labels(1), numel(peaks{1}), 1); ...
     repmat(labels(2), numel(peaks{2}), 1); ...
     repmat(labels(3), numel(peaks{3}), 1)];

[p, tbl, stats] = anova1(y, g, 'off');
F = tbl{2,5}; df1 = tbl{2,3}; df2 = tbl{3,3};
fprintf('\nANOVA on peaks: F(%d,%d) = %.2f, p = %.3e\n', df1, df2, F, p);
% Expected ~ F(2,39) = 40.4, p ~ 3.2e-10.

figure; c = multcompare(stats);
title('P300 peak by dose — Tukey HSD');
fprintf('\nPairwise (diff, p):\n');
for r = 1:size(c,1)
    fprintf('  %s vs %s: diff=%.2f, p=%.3e\n', ...
        labels{c(r,1)}, labels{c(r,2)}, c(r,4), c(r,6));
end

%% Part D — Write-up
% P300 peak amplitude increased with dose (placebo ~3.2, low ~4.9,
% high ~6.7 uV, mean values). A one-way ANOVA confirmed a significant effect
% of dose (F(2,39) = 40.4, p < 0.001). Tukey post-hoc tests showed every pair
% of doses differed significantly, i.e. placebo < low dose < high dose.
