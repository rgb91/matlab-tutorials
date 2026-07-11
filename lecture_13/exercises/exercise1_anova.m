%% EXERCISE 1 (in-class): ONE-WAY ANOVA
%  Session 13 — 5 July 2026
%  Data: exercise_anova.mat — firing rate (Hz) of a neuron under three
%        stimulus contrasts: low, medium, high (n = 15 each).
%  Question: does stimulus contrast change firing rate?
%
%  Fill in each TODO. Run section-by-section with Ctrl+Enter.
%  Requires: Statistics and Machine Learning Toolbox.

%% Step 0 — Load
load('data/exercise_anova.mat');   % low, medium, high, values, group, measure
fprintf('Measure: %s\n', measure);

%% Step 1 — Describe each group (mean and SEM)
%  TODO: print mean and SEM (std/sqrt(n)) for low, medium, high.



%% Step 2 — Build the value column + matching label vector
%  TODO: stack low, medium, high into one column vector `y`
%        and build a matching cell array of labels `g`
%        (hint: use [ ]' and repmat({'low'}, numel(low), 1) etc.)



%% Step 3 — Run the one-way ANOVA
%  TODO: call anova1(y, g, 'off') and capture [p, tbl, stats].
%        Pull F, df_between (tbl{2,3}), df_within (tbl{3,3}) and print
%        "F(df1,df2) = ..., p = ...".



%% Step 4 — Post-hoc comparison
%  TODO: run multcompare(stats) and say which contrasts differ.



%% Step 5 — One sentence
%  TODO (comment): write the result the way a methods section would.
%  A one-way ANOVA showed ...
