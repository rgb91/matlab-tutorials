%% DEMO 3: MULTI-SUBJECT AVERAGING & PUBLICATION FIGURES
%  Session 13 — 5 July 2026
%  MATLAB functions: mean/std along dims, fill (shaded error), imagesc,
%                    colormap, colorbar, subplot, tiledlayout, exportgraphics
%  Neuroscience context: 20 subjects, Pz P300, standard vs target oddball.
%  ─────────────────────────────────────────────────────────────────────
%
%  This is the workflow that turns a folder of subjects into ONE figure:
%    1. average each condition ACROSS subjects  -> grand-average ERP
%    2. add SEM shading                          -> shows uncertainty
%    3. make it colourmap-ready                  -> erp-image (subj x time)
%    4. polish: labels, legend, font, export     -> publication quality

%% 3A — Load the multi-subject data
addpath("/Users/sanjaysaha/Projects/matlab-tutorials/lecture_13/data/");
load('multisubject_erp.mat');  % erp_std, erp_tgt (20 x time), erp_time, fs
erp_time_ms = erp_time * 1000;      % work in milliseconds for the axis
[n_sub, n_time] = size(erp_std);
fprintf('%d subjects, %d time points, channel %s\n', n_sub, n_time, channel);

%% 3B — Grand average = mean ACROSS subjects (down the columns, dim 1)
%  erp_std is (subjects x time). mean(...,1) collapses subjects, keeping time.
ga_std = mean(erp_std, 1);          % 1 x time
ga_tgt = mean(erp_tgt, 1);
% SEM at each time point = std across subjects / sqrt(n)
sem_std = std(erp_std, 0, 1) / sqrt(n_sub);
sem_tgt = std(erp_tgt, 0, 1) / sqrt(n_sub);
fprintf('Grand-average peak: standard = %.2f uV, target = %.2f uV\n', ...
    max(ga_std), max(ga_tgt));

%% 3C — Plain grand-average plot (two lines)
figure;
plot(erp_time_ms, ga_std, 'LineWidth', 1.5); hold on;
plot(erp_time_ms, ga_tgt, 'LineWidth', 1.5);
xlabel('Time (ms)'); ylabel('Amplitude (\muV)');
legend({'standard', 'target'}, 'Location', 'northwest');
title('Grand-average ERP (no error bars)');

%% 3D — Add SEM as a shaded band (the publication standard)
%  We draw a filled polygon from (mean+SEM) forward and (mean-SEM) back.
figure; hold on;
col_std = [0.20 0.45 0.70];   % blue
col_tgt = [0.80 0.30 0.30];   % red

shaded_errorbar(erp_time_ms, ga_std, sem_std, col_std);
shaded_errorbar(erp_time_ms, ga_tgt, sem_tgt, col_tgt);

xline(0, 'k:');   yline(0, 'k:');       % stimulus onset & baseline
xlabel('Time (ms)'); ylabel('Amplitude (\muV)');
title(sprintf('Grand-average ERP at %s (mean \\pm SEM, n = %d)', channel, n_sub));
legend({'standard', '', 'target', ''}, 'Location', 'northwest');
set(gca, 'FontSize', 12);

%% 3E — erp-image: every subject as one row of a colour map
%  imagesc maps VALUE -> COLOUR. Rows = subjects, columns = time.
%  This shows the single-subject variability the grand average hides.
figure;
tiledlayout(1, 2, 'TileSpacing', 'compact');

nexttile;
imagesc(erp_time_ms, 1:n_sub, erp_std);
set(gca, 'YDir', 'normal');            % subject 1 at the bottom
xlabel('Time (ms)'); ylabel('Subject');
title('Standard'); colorbar;

nexttile;
imagesc(erp_time_ms, 1:n_sub, erp_tgt);
set(gca, 'YDir', 'normal');
xlabel('Time (ms)'); ylabel('Subject');
title('Target'); colorbar;

% Use ONE shared, perceptually-uniform colour scale for both panels so the
% colours mean the same thing in each. 'parula' is default; 'turbo' /
% 'hot' also work. AVOID 'jet' (misleading bright bands).
clim_all = [min([erp_std(:); erp_tgt(:)]), max([erp_std(:); erp_tgt(:)])];
colormap(parula);
nexttile(1); clim(clim_all);
nexttile(2); clim(clim_all);
sgtitle('ERP image: subjects \times time (\muV)');

%% 3F — Peak amplitude per subject -> bar + SEM, paired dots
pk = (erp_time >= 0.25) & (erp_time <= 0.45);   % P300 window
peak_std = max(erp_std(:, pk), [], 2);          % 20 x 1
peak_tgt = max(erp_tgt(:, pk), [], 2);
m   = [mean(peak_std), mean(peak_tgt)];
sem = [std(peak_std)/sqrt(n_sub), std(peak_tgt)/sqrt(n_sub)];

figure; hold on;
bar(m, 'FaceColor', [0.75 0.75 0.78]);
errorbar(1:2, m, sem, 'k', 'LineStyle', 'none', 'LineWidth', 1.5);
% overlay each subject's paired data points (best practice: show the data)
plot([1 2], [peak_std peak_tgt], '-o', 'Color', [0.5 0.5 0.5 0.4], ...
    'MarkerSize', 4, 'MarkerFaceColor', 'w');
set(gca, 'XTick', 1:2, 'XTickLabel', {'standard', 'target'});
ylabel('P300 peak amplitude (\muV)');
title('Per-subject peaks (bar = mean \pm SEM)');

[~, p_pk, ~, st_pk] = ttest(peak_tgt, peak_std);   % paired: same subjects
fprintf('Paired t-test on peaks: t(%d) = %.2f, p = %.3e\n', ...
    st_pk.df, st_pk.tstat, p_pk);

%% 3G — Export a figure at publication resolution
%  exportgraphics writes a tight, high-DPI file (needs R2020a+).
%  Uncomment to save into the session folder:
% exportgraphics(gcf, 'p300_peaks.png', 'Resolution', 300);
fprintf('\nTip: exportgraphics(gcf, ''fig.png'', ''Resolution'', 300) for papers.\n');

%% 3H — Wrap-up
fprintf('\n=== SESSION 13 DONE ===\n');
fprintf('You can now: average across subjects, add SEM shading, build an\n');
fprintf('erp-image colourmap, and export a clean figure. Session 14 rebuilds\n');
fprintf('this exact workflow in Python (NumPy + Matplotlib).\n');


%% ---- local helper: shaded error band -------------------------------
function shaded_errorbar(x, y, e, colour)
% Draw mean line y with a translucent +/- e band in the given colour.
    x = x(:)'; y = y(:)'; e = e(:)';
    fill([x, fliplr(x)], [y + e, fliplr(y - e)], colour, ...
        'FaceAlpha', 0.20, 'EdgeColor', 'none');
    plot(x, y, 'Color', colour, 'LineWidth', 1.8);
end
