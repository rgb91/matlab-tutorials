# BLOCK 2 — Noise, Signal Statistics & Basic Signal Processing (Python)
# Lecture 3: MATLAB Summer Prep | NSBV BC2001
# -----------------------------------------------
# Python parallel: compare with block2_noise_statistics.m

import numpy as np
import matplotlib.pyplot as plt

t     = np.linspace(0, 1, 1000)
clean = np.sin(2 * np.pi * 10 * t)

# --- 1. Adding Gaussian noise ---
# MATLAB: randn(size(clean))  →  Python: np.random.randn(*clean.shape)
noise_level = 0.5
noise       = noise_level * np.random.randn(*clean.shape)
noisy       = clean + noise

fig, axes = plt.subplots(2, 1, figsize=(10, 6))
axes[0].plot(t, clean, 'b-', linewidth=1.5)
axes[0].set_title('Clean Signal'); axes[0].set_ylabel('Amplitude')

axes[1].plot(t, noisy, color='0.6', linewidth=0.8, label='Noisy')
axes[1].plot(t, clean, 'b-',        linewidth=1.5, label='Clean')
axes[1].set_title('Noisy vs Clean'); axes[1].set_ylabel('Amplitude')
axes[1].set_xlabel('Time (s)'); axes[1].legend()
plt.tight_layout(); plt.show()

# --- 2. Descriptive statistics ---
print('--- Signal Statistics ---')
print(f'Mean:    {np.mean(noisy):.4f}')
print(f'Std Dev: {np.std(noisy):.4f}')
print(f'Min:     {np.min(noisy):.4f}')
print(f'Max:     {np.max(noisy):.4f}')
print(f'Range:   {np.ptp(noisy):.4f}')   # ptp = peak-to-peak (max - min)

# --- 3. Simple moving average (smoothing) ---
# NumPy doesn't have movmean built-in; use np.convolve for a clean implementation
def moving_average(x, w):
    """Compute a centred moving average of window size w."""
    return np.convolve(x, np.ones(w) / w, mode='same')

window_size = 20
smoothed    = moving_average(noisy, window_size)

plt.figure(figsize=(10, 4))
plt.plot(t, noisy,    color='0.8', linewidth=0.8, label='Noisy')
plt.plot(t, smoothed, 'r-',        linewidth=2,   label='Smoothed')
plt.plot(t, clean,    'b--',       linewidth=1.5, label='Clean')
plt.xlabel('Time (s)'); plt.ylabel('Amplitude')
plt.title('Noisy vs Smoothed vs Clean'); plt.legend()
plt.show()

# --- 4. Signal-to-Noise Ratio ---
signal_power = np.mean(clean ** 2)
noise_power  = np.mean(noise ** 2)
snr_val      = 10 * np.log10(signal_power / noise_power)
print(f'\nSignal-to-Noise Ratio: {snr_val:.2f} dB')

# --- 5. Histogram ---
plt.figure(figsize=(7, 4))
plt.hist(noisy, bins=40, color=[0.4, 0.6, 0.9], edgecolor='white')
plt.xlabel('Amplitude'); plt.ylabel('Count')
plt.title('Distribution of Signal Values')
plt.axvline(np.mean(noisy), color='red', linestyle='--', linewidth=2, label='Mean')
plt.legend(); plt.show()
