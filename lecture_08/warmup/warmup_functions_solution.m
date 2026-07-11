%% SESSION 8 WARMUP - SOLUTIONS
% Complete, runnable version. Keep for the instructor.

clear; clc;

%% Task 1
disp('Task 1:');
disp( peakToPeak([3 -1 4 1 5]) )          % 6

%% Task 2
disp('Task 2:');
[m, s] = meanStd([2 4 6 8]);
fprintf('mean = %g, std = %.2f\n', m, s)  % mean = 5, std = 2.58

%% Task 3
disp('Task 3:');
[t, y] = makeSine(2, 5, 100, 1);
fprintf('max(y) = %.2f, numel(t) = %d\n', max(y), numel(t)) % 2.00, 100

%% Task 4
disp('Task 4:');
disp( countAbove([1 5 2 8 3], 3) )        % 2

%% Task 5
disp('Task 5:');
disp( clipSignal([-3 0 2 5], 2) )         % -2  0  2  2


% =====================================================================
%  LOCAL FUNCTIONS
% =====================================================================

function p = peakToPeak(x)
    p = max(x) - min(x);
end

function [m, s] = meanStd(x)
    m = mean(x);
    s = std(x);
end

function [t, y] = makeSine(A, f, Fs, dur)
    t = (0:1/Fs:dur-1/Fs)';      % column time vector
    y = A*sin(2*pi*f*t);         % sine of amplitude A at frequency f
end

function n = countAbove(x, thresh)
    n = sum(x > thresh);         % the 0/1 mask, summed, counts the matches
end

function y = clipSignal(x, limit)
    y = x;
    y(y >  limit) =  limit;      % cap the top
    y(y < -limit) = -limit;      % cap the bottom
end
