# TAKE-HOME ASSIGNMENT — Noisy Neuron Simulator (Python)
# Lecture 3: MATLAB Summer Prep | NSBV BC2001
# -----------------------------------------------
# This script simulates a noisy neural recording across three trials,
# computes statistics, smooths the data, and produces a clean
# multi-panel publication-quality figure.
# -----------------------------------------------

import numpy as np
import matplotlib.pyplot as plt

# --- Parameters ---
fs          = 1000       # sampling frequency (Hz)
duration    = 2          # seconds
t           = np.linspace(0, duration, fs * duration)
n_trials    = 3
freq_hz     = 8          # alpha-band signal
noise_level = 0.6

# --- Helper function (defined before use in Python) ---
def generate_trial(t, freq, noise_level):
    """
    Create a noisy sine wave trial.
    Parameters:
        t           : time vector (numpy array, seconds)
        freq        : signal frequency (Hz)
        noise_level : std dev of Gaussian noise
    Returns:
        y : noisy signal (numpy array)
    """
    clean = np.sin(2 * np.pi * freq * t)
    noise = noise_level * np.random.randn(len(t))
    return clean + noise

def moving_average(x, w):
    """Centred moving average of window size w."""
    return np.convolve(x, np.ones(w) / w, mode='same')

# --- Step 1: Generate three trials ---
trials = np.zeros((n_trials, len(t)))   # rows = trials, cols = samples

for trial in range(n_trials):
    trials[trial, :] = generate_trial(t, freq_hz, noise_level)

# --- Step 2: Trial average ---
trial_average = np.mean(trials, axis=0)   # mean across rows (axis=0)

# --- Step 3: Smooth the average ---
smoothed_avg = moving_average(trial_average, 30)

# --- Step 4: Statistics per trial ---
print(f"{'Trial':<10} {'Mean':<12} {'Std Dev':<12} {'Max':<10}")
print('-' * 46)
for trial in range(n_trials):
    print(f"{trial+1:<10} {np.mean(trials[trial]):<12.4f} "
          f"{np.std(trials[trial]):<12.4f} {np.max(trials[trial]):<10.4f}")

# --- Step 5: Publication-quality 3-panel figure ---
fig, axes = plt.subplots(3, 1, figsize=(11, 8))

# Panel 1: Individual trials
colors = [[0.6, 0.6, 0.9], [0.9, 0.6, 0.6], [0.6, 0.9, 0.6]]
for trial in range(n_trials):
    axes[0].plot(t, trials[trial], color=colors[trial],
                 linewidth=0.8, label=f'Trial {trial+1}')
axes[0].set_ylabel('Amplitude')
axes[0].set_title('Individual Trials (3 repetitions)')
axes[0].legend(loc='upper right')
axes[0].spines['top'].set_visible(False)
axes[0].spines['right'].set_visible(False)

# Panel 2: Trial average + smoothed
axes[1].plot(t, trial_average, color='0.7', linewidth=0.8, label='Raw average')
axes[1].plot(t, smoothed_avg,  'b-',        linewidth=2,   label='Smoothed')
axes[1].set_ylabel('Amplitude')
axes[1].set_title('Trial Average (grey) and Smoothed Average (blue)')
axes[1].legend()
axes[1].spines['top'].set_visible(False)
axes[1].spines['right'].set_visible(False)

# Panel 3: Histogram of smoothed values
axes[2].hist(smoothed_avg, bins=35, color=[0.3, 0.5, 0.8], edgecolor='white')
axes[2].set_xlabel('Amplitude'); axes[2].set_ylabel('Count')
axes[2].set_title('Distribution of Smoothed Average Values')
mean_val = np.mean(smoothed_avg)
axes[2].axvline(mean_val, color='red', linestyle='--', linewidth=1.5,
                label=f'Mean = {mean_val:.2f}')
axes[2].legend()
axes[2].spines['top'].set_visible(False)
axes[2].spines['right'].set_visible(False)

fig.suptitle(f'Simulated {freq_hz} Hz Neural Signal — {n_trials} Trials', fontsize=14)
plt.tight_layout()

# --- Step 6: Save figure ---
fig.savefig('noisy_neuron_simulator.png', dpi=150, bbox_inches='tight')
print('\nFigure saved: noisy_neuron_simulator.png')
plt.show()
