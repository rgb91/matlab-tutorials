%% Task 1
% Single output function. Write function p = peakToPeak(x) 
% that returns the largest value minus the smallest. 
% Test: peakToPeak([3 -1 4 1 5]).
disp('Task 1:')
peakToPeak_distance = peakToPeak([3 -1 4 1 5]);
disp(peakToPeak_distance)

%% Task 2
% Two outputs — the [a, b] = … call. Write function [m, s] = meanStd(x) 
% returning mean and standard deviation. 
% Call as [m, s] = meanStd([2 4 6 8]).
listofnums = [2 4 6 8];
[m, s] = meanStd(listofnums);
disp("Mean " + m)
disp("Std Dev " + s)

%% Task 3
% Build a vector inside a function (this feeds the FFT work). 
% Write function [t, y] = makeSine(A, f, Fs, dur) returning a time vector 
% and an amplitude-A sine at frequency f. 
% Test: [t, y] = makeSine(2, 5, 100, 1); then check max(y) and numel(t).

[t, y] = makeSine(2, 5, 100, 1);
disp("MAX " + max(y))
disp("NUMEL " + numel(t))

figure;
plot(t, y)
grid on;



%% Task 4
% Logical indexing inside a function. Write function 
% n = countAbove(x, thresh) returning how many elements exceed thresh. 
% Test: countAbove([1 5 2 8 3], 3).

disp("Count Above " + countAbove([1 5 2 8 3], 2));


%%  Stretch — logical assignment. Write function y = clipSignal(x, limit) 
% that caps values above limit at limit and below -limit at -limit. 
% Test: clipSignal([-3 0 2 5], 2).

clipped_signal  = clipSignal([-3 0 2 5], 2);
disp("Clipped Signal " + mat2str(clipped_signal));

%% Functions (Task 1 to Task 5)
function p = peakToPeak(x)
    p = max(x) - min(x);
end

function [a, b] = meanStd(x)
    a = mean(x);
    b = std(x);
end

function [t, y] = makeSine(A, f, Fs, dur)
    t = (0 : 1/Fs : dur-1/Fs);
    y = A * sin(2 * pi * t * f);
end

function n = countAbove(x, thresh)
    % count = 0
    % for i = 1:length(x)
    %     if x(i) > thresh
    %         count = count + 1;
    %     end
    % end
    n = sum(x > thresh);
end

function y = clipSignal(x, limit)
    y = x;
    y(y > limit) = limit;
    y(y < -limit) = -limit;
end