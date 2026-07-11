%% SESSION 8 WARMUP - WRITING FUNCTIONS IN MATLAB  (15-20 min)
% Focus: defining and calling your own functions.
%
% HOW THIS FILE WORKS:
%   - The TEST CALLS are at the top (run them with the Run button).
%   - The FUNCTIONS live at the BOTTOM, as "local functions".
%   - Fill in each function body where it says TODO. The script will
%     error until a function actually assigns its output - that is your
%     cue that it still needs finishing.
%
% (If you ever put a function in ITS OWN file instead, the file name must
%  match the function name exactly, e.g. peakToPeak.m)

clear; clc;

%% Task 1 - single output
disp('Task 1:');
disp( peakToPeak([3 -1 4 1 5]) )          % expected: 6

%% Task 2 - two outputs (note the [a, b] = ... call)
disp('Task 2:');
[m, s] = meanStd([2 4 6 8]);
fprintf('mean = %g, std = %.2f\n', m, s)  % expected: mean = 5, std = 2.58

%% Task 3 - build a vector inside a function (feeds today's FFT work)
disp('Task 3:');
[t, y] = makeSine(2, 5, 100, 1);
fprintf('max(y) = %.2f, numel(t) = %d\n', max(y), numel(t)) % expected: 2.00, 100

%% Task 4 - logical indexing inside a function
disp('Task 4:');
disp( countAbove([1 5 2 8 3], 3) )        % expected: 2

%% Task 5 - STRETCH: logical assignment
disp('Task 5:');
disp( clipSignal([-3 0 2 5], 2) )         % expected: -2  0  2  2


% =====================================================================
%  LOCAL FUNCTIONS  -  fill in each body
% =====================================================================

function p = peakToPeak(x)
% TODO: return the peak-to-peak range of x (largest value minus smallest)

end

function [m, s] = meanStd(x)
% TODO: return the mean (m) and the standard deviation (s) of x

end

function [t, y] = makeSine(A, f, Fs, dur)
% TODO 1: build a column time vector t from 0 to dur, step 1/Fs
% TODO 2: build y, a sine wave of amplitude A and frequency f over t

end

function n = countAbove(x, thresh)
% TODO: return how many elements of x are greater than thresh
% Hint: x > thresh gives a vector of 0s and 1s; sum() counts the 1s

end

function y = clipSignal(x, limit)
% TODO: copy x into y, then set any value above  limit to  limit,
%       and any value below -limit to -limit  (use logical assignment)

end
