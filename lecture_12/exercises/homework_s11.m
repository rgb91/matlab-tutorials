%% HOMEWORK — Session 12
%  ─────────────────────────────────────────────────────────────
%
%  PART A: Write a condition_stats function  (save as condition_stats.m)
%
%  Signature:
%    summary = condition_stats(values, group)
%
%  Inputs:
%    values — 1-D numeric vector of measurements (one per subject)
%    group  — cell array of condition labels, same length as values
%             e.g. {'control','patient','control', ...}
%
%  Output:
%    summary — a struct ARRAY, one element per unique condition, with fields:
%       .condition  (the label, a string)
%       .n          (number of subjects in that condition)
%       .mean       (mean of that condition's values)
%       .sd         (standard deviation)
%       .sem        (sd / sqrt(n))
%
%  Hints:
%    - Find the unique labels with: conditions = unique(group);
%    - For each condition, build a logical mask with strcmp(group, conditions{k})
%    - Use that mask to pull out values(mask)
%
%  ─────────────────────────────────────────────────────────────
%  PART B: Apply it to real data
%
%  File: homework_data.mat
%    values      — 1×24 mean ERP amplitude (uV)
%    group       — 1×24 cell array of 'control' / 'patient'
%    subject_ids — 1×24 cell array of subject codes
%    measure     — text label
%
%  Tasks:
%  1. Load homework_data.mat
%  2. Call YOUR condition_stats on values and group
%  3. Print a summary table (condition, n, mean, sd, sem)
%  4. Run a two-sample t-test (ttest2) between the two conditions
%     and report t, df, p, and whether it is significant
%  5. Make a bar chart of the two means with SEM error bars
%  ─────────────────────────────────────────────────────────────

%% Part B: starter code

% TODO 1: Load the data


% TODO 2: Call condition_stats(values, group)


% TODO 3: Print the summary table (loop over the struct array)


% TODO 4: Split values by condition and run ttest2
%   Hint: ctrl = values(strcmp(group, 'control'));
%         pat  = values(strcmp(group, 'patient'));


% TODO 5: Bar chart of means with SEM error bars

