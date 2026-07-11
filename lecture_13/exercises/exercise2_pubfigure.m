%% EXERCISE 2 (in-class): PUBLICATION FIGURE FROM MULTI-SUBJECT DATA
%  Session 13 — 5 July 2026
%  Data: exercise_figure.mat — Pz ERP for 16 subjects, two conditions
%        (eyes open vs eyes closed): erp_open, erp_closed (16 x time),
%        erp_time (s), fs, channel, cond_names.
%  Goal: make ONE clean grand-average figure with SEM shading.
%
%  Fill in each TODO.

%% Step 0 — Load
load('data/exercise_figure.mat');
time_ms = erp_time * 1000;
n_sub = size(erp_open, 1);
fprintf('%d subjects, channel %s\n', n_sub, channel);

%% Step 1 — Grand averages (mean ACROSS subjects)
%  TODO: ga_open  = mean over subjects of erp_open   (use mean(...,1))
%        ga_closed = mean over subjects of erp_closed



%% Step 2 — SEM at each time point
%  TODO: sem_open  = std(erp_open, 0, 1) / sqrt(n_sub)
%        sem_closed = ...



%% Step 3 — Shaded grand-average plot
%  TODO: plot both grand averages vs time_ms. Add an SEM band for each
%        (fill(...) with FaceAlpha ~0.2, or errorbar every ~10th point).
%        Label axes (Time (ms) / Amplitude (\muV)), add a legend and title.
%        Mark stimulus onset with xline(0,'k:').



%% Step 4 — Which condition has the bigger response?
%  TODO: compute each subject's peak in the 250-450 ms window
%        (pk = erp_time>=0.25 & erp_time<=0.45; max(...,[],2))
%        and print the two grand-average peak values.


