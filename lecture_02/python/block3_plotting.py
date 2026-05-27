# BLOCK 3 — Plotting (Python/Matplotlib equivalent)
# Lecture 2: MATLAB Summer Prep | NSBV BC2001
# -----------------------------------------------
# Python parallel: compare with block3_plotting.m

import numpy as np
import matplotlib.pyplot as plt

# Setup
t         = np.linspace(0, 1, 1000)
signal    = np.sin(2 * np.pi * 10 * t)
threshold = 0.5
above     = np.zeros(len(signal))

for i in range(len(signal)):
    if signal[i] > threshold:
        above[i] = signal[i]

# --- Basic Plot ---
# MATLAB: plot(t, signal)
plt.figure()
plt.plot(t, signal)
plt.xlabel('Time (s)')
plt.ylabel('Amplitude')
plt.title('Basic Plot of 10 Hz Sine Wave')
plt.show()

# --- Styled Plot ---
# MATLAB: plot(t, signal, 'b-', 'LineWidth', 1.5)
plt.figure()
plt.plot(t, signal, 'b-', linewidth=1.5)
plt.xlabel('Time (s)')
plt.ylabel('Amplitude')
plt.title('Styled 10 Hz Sine Wave')
plt.show()

# --- Overlay Two Lines (hold on equivalent) ---
# MATLAB uses hold on / hold off; Python just calls plot() twice
plt.figure()
plt.plot(t, signal, 'b-', linewidth=1.5, label='Full Signal')
plt.plot(t, above,  'r-', linewidth=1.5, label='Above Threshold')
plt.xlabel('Time (s)')
plt.ylabel('Amplitude')
plt.title('Signal with Threshold Crossings')
plt.legend()
plt.show()

# --- Subplots — neuroscience-style multi-panel figure ---
# MATLAB: subplot(2,1,1) etc.
fig, axes = plt.subplots(2, 1, figsize=(10, 6))

axes[0].plot(t, signal, 'b-', linewidth=1.5)
axes[0].set_xlabel('Time (s)')
axes[0].set_ylabel('Amplitude')
axes[0].set_title('10 Hz Sine Wave')

axes[1].plot(t, above, 'r-', linewidth=1.5)
axes[1].set_xlabel('Time (s)')
axes[1].set_ylabel('Amplitude')
axes[1].set_title('Values Above Threshold (0.5)')

plt.tight_layout()
plt.show()
