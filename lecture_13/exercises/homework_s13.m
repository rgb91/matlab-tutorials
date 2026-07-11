%% HOMEWORK — Session 13
%  Full pipeline: multi-subject figure + colourmap + ANOVA.
%  Data: homework_s13.mat — a P300 dose study. Three INDEPENDENT groups of
%        subjects (different people per group): placebo / low_dose / high_dose.
%        Variables:
%           erp_placebo   (14 x time)   Pz ERP, one row per subject
%           erp_low_dose  (15 x time)
%           erp_high_dose (13 x time)
%           erp_time      (1 x time, seconds)
%           peak_values, peak_group   (already-stacked peaks + labels, optional)
%           cond_names, fs, channel
%
%  Do all four parts. A worked solution is in ../solutions.
%  Requires: Statistics and Machine Learning Toolbox.

%% Part A — Grand averages with SEM shading (all three conditions)
%  TODO:
%   1. Load the data; make time_ms = erp_time*1000.
%   2. For each condition compute the grand average (mean across subjects)
%      and the SEM (std across subjects / sqrt(n)).
%   3. Plot all three grand-average lines on ONE axes with SEM bands.
%      Use three distinct colours, a legend, axis labels, and a title.



%% Part B — erp-image colourmap for the high-dose group
%  TODO: imagesc(time_ms, 1:n, erp_high_dose); set YDir normal; add a
%        colorbar and a perceptually-uniform colormap (parula/turbo, NOT jet).
%        Label the axes (Time (ms) / Subject).



%% Part C — Peak amplitude per subject, then ANOVA
%  TODO:
%   1. For each subject in each group, find the peak in 250-450 ms.
%   2. Stack the peaks into a column `y` and matching labels `g`.
%      (Or reuse peak_values / peak_group from the file.)
%   3. Run anova1(y, g, 'off'); report F(df1,df2) and p.
%   4. Run multcompare(stats); state which doses differ.



%% Part D — Two-sentence write-up (as a comment)
%  TODO: report the peak means +/- SEM per group and the ANOVA result the
%  way a lab report would, e.g.:
%  "P300 peak amplitude increased with dose (placebo ... , low ... ,
%   high ... uV). A one-way ANOVA confirmed a significant effect of dose
%   (F(...) = ..., p < 0.001); post-hoc tests showed ..."
