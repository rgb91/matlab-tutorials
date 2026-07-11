function [t, y] = makeSine(Amp, f, Fs, dur)
    t = (0 : 1/Fs : dur-1/Fs);
    y = Amp * sin(2 * pi * t * f);
end