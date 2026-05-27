"""
============================================================
LESSON 4  |  Custom Functions & EEG-like Signal Visualisation
NSBV BC2001 – MATLAB for Neuroscience  (Python Reference)
============================================================

This file mirrors lesson4_main.m using Python + NumPy + Matplotlib.
It is provided as a REFERENCE so you can compare syntax side-by-side.
You do NOT need to submit Python code for the course — MATLAB is the
required language.  However, Python is widely used in neuroscience
research, so knowing both is a valuable skill.

Dependencies:
    pip install numpy matplotlib scipy
"""

import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import find_peaks


# ============================================================
# PART A: CUSTOM FUNCTIONS
# In Python, functions live in the SAME file (or in a module).
# ============================================================

def my_mean(x):
    """Compute arithmetic mean without using np.mean."""
    total = 0
    for val in x:
        total += val
    return total / len(x)


def signal_stats(x):
    """Return (mean, std, peak_abs) for a signal array."""
    mn = np.mean(x)
    sd = np.std(x, ddof=1)   # ddof=1 matches MATLAB's std()
    pk = np.max(np.abs(x))
    return mn, sd, pk


def normalize_signal(x):
    """Z-score normalization: zero mean, unit variance."""
    return (x - np.mean(x)) / np.std(x, ddof=1)


# --- Test the functions ---
data = np.array([3, 7, 2, 9, 4, 6, 1, 8], dtype=float)

print(f"Custom mean  = {my_mean(data):.4f}")
print(f"NumPy mean   = {np.mean(data):.4f}")

mn, sd, pk = signal_stats(data)
print(f"Mean: {mn:.2f}  |  Std: {sd:.2f}  |  Peak: {pk:.2f}")


# ============================================================
# PART B: GENERATING EEG-LIKE SIGNALS
# ============================================================

Fs = 256          # Sampling rate (Hz)
T  = 4            # Duration (seconds)
t  = np.arange(0, T, 1/Fs)   # equivalent to MATLAB: 0:1/Fs:T-1/Fs

alpha_wave = 3.0 * np.sin(2 * np.pi * 10 * t)
theta_wave = 1.5 * np.sin(2 * np.pi *  6 * t)
noise      = 0.5 * np.random.randn(len(t))

eeg_signal = alpha_wave + theta_wave + noise

# Plot components
fig, axes = plt.subplots(4, 1, figsize=(10, 8), sharex=True)
fig.suptitle('Synthetic EEG Components')

axes[0].plot(t, alpha_wave, color='blue')
axes[0].set_ylabel('Alpha')

axes[1].plot(t, theta_wave, color='red')
axes[1].set_ylabel('Theta')

axes[2].plot(t, noise, color='grey')
axes[2].set_ylabel('Noise')

axes[3].plot(t, eeg_signal, color='black')
axes[3].set_ylabel('Summed EEG')
axes[3].set_xlabel('Time (s)')

for ax in axes:
    ax.grid(True, alpha=0.4)
    ax.set_xlim([0, T])

plt.tight_layout()
plt.savefig('eeg_components_python.png', dpi=150)
plt.show()


# ============================================================
# PART C: MULTI-CHANNEL EEG VISUALISATION
# ============================================================

n_channels    = 4
channel_names = ['Fz', 'Cz', 'Pz', 'Oz']
freq_per_ch   = [9.0, 10.0, 11.0, 10.5]
colours       = ['steelblue', 'tomato', 'seagreen', 'mediumpurple']

# Pre-allocate: shape = (channels, samples)
eeg_multi = np.zeros((n_channels, len(t)))

for ch in range(n_channels):
    eeg_multi[ch] = (2.5 * np.sin(2 * np.pi * freq_per_ch[ch] * t)
                   + 1.0 * np.sin(2 * np.pi * 6 * t)
                   + 0.4 * np.random.randn(len(t)))

offset  = 8
t_mask  = t <= 2        # first 2 seconds

fig, ax = plt.subplots(figsize=(10, 5))
for ch in range(n_channels):
    ax.plot(t[t_mask],
            eeg_multi[ch, t_mask] + ch * offset,
            color=colours[ch],
            linewidth=1,
            label=channel_names[ch])

ax.set_yticks([ch * offset for ch in range(n_channels)])
ax.set_yticklabels(channel_names)
ax.set_xlabel('Time (s)')
ax.set_ylabel('Channel')
ax.set_title('4-Channel Synthetic EEG')
ax.legend(loc='upper right')
ax.grid(True, alpha=0.3)
plt.tight_layout()
plt.savefig('multichannel_eeg_python.png', dpi=150)
plt.show()


# ============================================================
# PART D: PEAK DETECTION  (scipy.signal.find_peaks)
# ============================================================

clean_eeg = 2.5 * np.sin(2 * np.pi * 10 * t)

peak_locs, properties = find_peaks(
    clean_eeg,
    height=1.0,           # MinPeakHeight equivalent
    distance=Fs * 0.05    # MinPeakDistance in samples
)

print(f"Number of peaks found: {len(peak_locs)}")

fig, ax = plt.subplots(figsize=(10, 4))
ax.plot(t, clean_eeg, 'b', linewidth=1.2, label='Signal')
ax.plot(t[peak_locs], clean_eeg[peak_locs], 'rv',
        markersize=10, label='Detected peaks')
ax.set_xlabel('Time (s)')
ax.set_ylabel('Amplitude')
ax.set_title('Peak Detection in EEG-like Signal')
ax.legend()
ax.grid(True, alpha=0.4)
plt.tight_layout()
plt.savefig('peak_detection_python.png', dpi=150)
plt.show()


# ============================================================
# MATLAB vs PYTHON — QUICK SYNTAX COMPARISON
# ============================================================
#
# MATLAB                            | Python (NumPy)
# ----------------------------------|----------------------------------
# zeros(1, N)                       | np.zeros(N)
# ones(3, 4)                        | np.ones((3, 4))
# length(x)                         | len(x)  or  x.shape[0]
# size(A, 1)                        | A.shape[0]
# x(k)  [1-indexed]                 | x[k-1]  [0-indexed]
# x(2:5)                            | x[1:5]
# A(:, 2)                           | A[:, 1]
# for k = 1:10                      | for k in range(1, 11):
# fprintf('%d\n', k)                | print(k)
# mod(k, 3)                         | k % 3
# subplot(4, 1, 1)                  | axes[0] (after plt.subplots)
# findpeaks(x, 'MinPeakHeight', h)  | find_peaks(x, height=h)
# std(x)   [ddof=1 by default]      | np.std(x, ddof=1)
# randn(1, N)                       | np.random.randn(N)
"""
"""
