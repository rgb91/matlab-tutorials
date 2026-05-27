# TAKE-HOME ASSIGNMENT — My First Neuroscience Signal (Python)
# Lecture 2: MATLAB Summer Prep | NSBV BC2001
# -----------------------------------------------
# This script simulates two brain rhythm sine waves (5 Hz and 12 Hz),
# combines them, detects values above a threshold, and produces a
# three-panel neuroscience-style figure.
# -----------------------------------------------

import numpy as np
import matplotlib.pyplot as plt

# Step 1 — Create a 2-second time vector with 2000 samples
t = np.linspace(0, 2, 2000)   # 2 seconds, sampled at 1000 Hz

# Step 2 — Create two sine waves and combine them
wave_5hz  = np.sin(2 * np.pi * 5  * t)   # 5 Hz — like a theta rhythm
wave_12hz = np.sin(2 * np.pi * 12 * t)   # 12 Hz — like an alpha/low-beta rhythm
combined  = wave_5hz + wave_12hz          # sum of both waves

# Step 3 — Threshold detection using a for loop
threshold    = 0.8
above_thresh = np.zeros(len(combined))   # pre-allocate

for i in range(len(combined)):
    if combined[i] > threshold:
        above_thresh[i] = combined[i]    # keep value if above threshold

# Step 4 — Plot three subplots
fig, axes = plt.subplots(3, 1, figsize=(12, 8))

# Panel 1: 5 Hz wave alone
axes[0].plot(t, wave_5hz, 'b-', linewidth=1.5)
axes[0].set_xlabel('Time (s)')
axes[0].set_ylabel('Amplitude')
axes[0].set_title('5 Hz Sine Wave (Theta-like Rhythm)')

# Panel 2: 12 Hz wave alone
axes[1].plot(t, wave_12hz, 'm-', linewidth=1.5)
axes[1].set_xlabel('Time (s)')
axes[1].set_ylabel('Amplitude')
axes[1].set_title('12 Hz Sine Wave (Alpha/Beta-like Rhythm)')

# Panel 3: Combined signal with threshold crossings in red
axes[2].plot(t, combined, 'k-', linewidth=1, label='Combined Signal')

# Mark threshold crossings in red
thresh_t = t[above_thresh != 0]
thresh_v = above_thresh[above_thresh != 0]
axes[2].plot(thresh_t, thresh_v, 'r.', markersize=4, label='Above Threshold')

axes[2].set_xlabel('Time (s)')
axes[2].set_ylabel('Amplitude')
axes[2].set_title('Combined Signal — Red dots = Above Threshold (0.8)')
axes[2].legend()

plt.tight_layout()
plt.show()
