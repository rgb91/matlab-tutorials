"""
Generates the synthetic EEG-like data files used in Session 8.
Run once; produces eeg_sample.mat / .csv / .txt and mystery_signal.csv.
The signals are deliberately built from known sine components so the
FFT results are fully predictable and the instructor can verify answers.
"""
import numpy as np
from scipy.io import savemat

# ---------------------------------------------------------------
# Common recording parameters
fs = 256          # sampling frequency in Hz
dur = 4.0         # seconds
N = int(fs * dur) # 1024 samples
t = np.arange(N) / fs

# ---------------------------------------------------------------
# 1) eeg_sample : DOMINANT component is 8 Hz.
#    Components: 8 Hz (amp 1.0), 15 Hz (0.5), 30 Hz (0.3) + light noise
rng = np.random.default_rng(7)         # fixed seed -> reproducible
sig = (1.0 * np.sin(2*np.pi*8*t)
       + 0.5 * np.sin(2*np.pi*15*t)
       + 0.3 * np.sin(2*np.pi*30*t)
       + 0.15 * rng.standard_normal(N))
sig = sig.astype(np.float64)

# .mat : store signal, fs and t (loads as a struct-like set of variables)
savemat("eeg_sample.mat",
        {"signal": sig.reshape(-1, 1), "fs": float(fs), "t": t.reshape(-1, 1)})

# .csv : two columns with a header row -> time, amplitude
np.savetxt("eeg_sample.csv",
           np.column_stack([t, sig]),
           delimiter=",", header="time_s,amplitude_uV", comments="",
           fmt="%.6f")

# .txt : single column of amplitude values, no header (whitespace file)
np.savetxt("eeg_sample.txt", sig, fmt="%.6f")

# ---------------------------------------------------------------
# 2) mystery_signal : used for take-home Exercise 4.
#    DOMINANT component is 12 Hz (amp 1.2) + 5 Hz (0.4) + 25 Hz (0.6) + noise
rng2 = np.random.default_rng(42)
mys = (1.2 * np.sin(2*np.pi*12*t)
       + 0.4 * np.sin(2*np.pi*5*t)
       + 0.6 * np.sin(2*np.pi*25*t)
       + 0.20 * rng2.standard_normal(N))
np.savetxt("mystery_signal.csv",
           np.column_stack([t, mys]),
           delimiter=",", header="time_s,amplitude_uV", comments="",
           fmt="%.6f")

print("fs =", fs, "Hz | N =", N, "samples | duration =", dur, "s")
print("eeg_sample dominant frequency  = 8 Hz  (others: 15, 30 Hz)")
print("mystery_signal dominant freq   = 12 Hz (others: 5, 25 Hz)")
print("Frequency resolution df = fs/N =", fs / N, "Hz")
print("Files written:", "eeg_sample.mat, eeg_sample.csv, eeg_sample.txt, mystery_signal.csv")
