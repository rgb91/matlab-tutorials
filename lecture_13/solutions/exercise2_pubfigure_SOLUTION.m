%% EXERCISE 2 — SOLUTION: PUBLICATION FIGURE
%  Session 13 — 5 July 2026
%  Data: exercise_figure.mat (16 subjects, eyes open vs closed, Pz)

%% Step 0 — Load
load('data/exercise_figure.mat');   % erp_open, erp_closed, erp_time, fs, ...
time_ms = erp_time * 1000;
n_sub   = size(erp_open, 1);

%% Step 1 — Grand averages (mean across subjects)
ga_open   = mean(erp_open,   1);
ga_closed = mean(erp_closed, 1);

%% Step 2 — SEM at each time point
sem_open   = std(erp_open,   0, 1) / sqrt(n_sub);
sem_closed = std(erp_closed, 0, 1) / sqrt(n_sub);

%% Step 3 — Shaded grand-average plot
figure; hold on;
c_open   = [0.20 0.45 0.70];
c_closed = [0.85 0.55 0.10];

fill([time_ms, fliplr(time_ms)], ...
     [ga_open+sem_open, fliplr(ga_open-sem_open)], ...
     c_open, 'FaceAlpha', 0.20, 'EdgeColor', 'none');
plot(time_ms, ga_open, 'Color', c_open, 'LineWidth', 1.8);

fill([time_ms, fliplr(time_ms)], ...
     [ga_closed+sem_closed, fliplr(ga_closed-sem_closed)], ...
     c_closed, 'FaceAlpha', 0.20, 'EdgeColor', 'none');
plot(time_ms, ga_closed, 'Color', c_closed, 'LineWidth', 1.8);

xline(0, 'k:'); yline(0, 'k:');
xlabel('Time (ms)'); ylabel('Amplitude (\muV)');
title(sprintf('Grand-average ERP at %s (mean \\pm SEM, n = %d)', channel, n_sub));
legend({'', 'eyes open', '', 'eyes closed'}, 'Location', 'northwest');
set(gca, 'FontSize', 12);

%% Step 4 — Peak comparison
pk = (erp_time >= 0.25) & (erp_time <= 0.45);
peak_open   = max(erp_open(:, pk),   [], 2);
peak_closed = max(erp_closed(:, pk), [], 2);
fprintf('Grand-average peak: open = %.2f uV, closed = %.2f uV\n', ...
    max(ga_open), max(ga_closed));
fprintf('Per-subject mean peak: open = %.2f, closed = %.2f uV\n', ...
    mean(peak_open), mean(peak_closed));
% Eyes-closed shows the larger response (~4.8 vs ~2.8 uV peak).
