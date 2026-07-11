%% EXERCISE 4 - The mystery signal (challenge)
% Session 8 take-home. Fill in every TODO.
%
% data/mystery_signal.csv is a recording with an UNKNOWN dominant rhythm.
% Your job: load it, analyse it, and report the dominant frequency in Hz.
% Write your final answer in a comment at the bottom of this file.

clear; clc; close all;
dataDir = 'data';

% TODO 1: load mystery_signal.csv (columns: time_s, amplitude_uV)
M = ;
t = M(:,1);
x = M(:,2);

% TODO 2: work out Fs from the time column, and N from the signal length
Fs = ;
N  = ;

% TODO 3: plot the raw signal (time domain). Can you guess the frequency
%         just by looking? (Usually no - that is the point.)

% TODO 4: build the single-sided amplitude spectrum (Y, P2, P1, f)

% TODO 5: find and print the dominant frequency, and plot the spectrum.

% TODO 6: write your answer here ->  Dominant frequency = ____ Hz
