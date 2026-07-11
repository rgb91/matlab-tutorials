function [f, amp] = get_spectrum(signal, fs)
% GET_SPECTRUM  Compute the single-sided amplitude spectrum.
%   [f, amp] = get_spectrum(signal, fs)
%
%   Inputs:
%       signal  –  1-D vector (time-domain signal)
%       fs      –  sampling frequency in Hz
%
%   Outputs:
%       f       –  frequency axis (Hz), from 0 to fs/2
%       amp     –  amplitude spectrum (single-sided)

N   = length(signal);
Y   = fft(signal);
P2  = abs(Y / N);               % two-sided amplitude
P1  = P2(1:floor(N/2)+1);       % keep positive half
P1(2:end-1) = 2 * P1(2:end-1);  % double interior bins
f   = (0:floor(N/2)) * (double(fs) / double(N));  % frequency axis
amp = P1;
end


% function [f, amp] = get_spectrum(signal, fs)
% % GET_SPECTRUM  Compute the single-sided amplitude spectrum.
% %   [f, amp] = get_spectrum(signal, fs)
% %
% %   Inputs:
% %       signal  –  1-D vector (time-domain signal)
% %       fs      –  sampling frequency in Hz
% %
% %   Outputs:
% %       f       –  frequency axis (Hz), from 0 to fs/2
% %       amp     –  amplitude spectrum (single-sided)
% 
% N   = length(signal);
% Y   = fft(signal);
% P2  = abs(Y / N);               % two-sided amplitude
% P1  = P2(1:floor(N/2)+1);       % keep positive half
% P1(2:end-1) = 2 * P1(2:end-1);  % double interior bins
% f   = (0:floor(N/2)) * double(fs / N);  % frequency axis
% amp = P1;
% end
