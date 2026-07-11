%% EXERCISE 1 - Build an amplitude spectrum from scratch
% Session 8 take-home. Fill in every line marked TODO, then run.
% You may copy the recipe from Demo 1 - that is allowed and expected.

clear; clc; close all;

% A signal is given to you below (do NOT change these 4 lines):
Fs  = 200;                                   % sampling frequency (Hz)
t   = (0:1/Fs:3-1/Fs)';                      % 3 seconds of time
x   = 2.0*sin(2*pi*7*t) + 1.0*sin(2*pi*40*t);% two tones: 7 Hz and 40 Hz
N   = length(x);

% TODO 1: compute the FFT of x
Y = ;            % <-- fill in

% TODO 2: two-sided magnitude scaled by N
P2 = ;           % <-- fill in

% TODO 3: keep the single-sided part (0 .. Nyquist) and double the inside bins
P1 = ;           % <-- keep elements 1 : N/2+1
P1(2:end-1) = ;  % <-- double the interior bins

% TODO 4: build the matching frequency axis (0 .. Nyquist)
f = ;            % <-- fill in

% TODO 5: plot amplitude vs frequency, label both axes, add a title
% (your plotting code here)

% CHECK: you should see peaks at 7 Hz (height ~2.0) and 40 Hz (height ~1.0).
