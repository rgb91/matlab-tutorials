# BLOCK 3 — Importing Data & Publication-Quality Plotting (Python)
# Lecture 3: MATLAB Summer Prep | NSBV BC2001
# -----------------------------------------------
# Python parallel: compare with block3_data_import_plotting.m
# Key library: pandas for reading/writing CSV (equivalent to MATLAB tables)

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd      # pandas = Python's table/data library (like MATLAB's table)

# --- 1. Creating and saving a CSV ---
t   = np.linspace(0, 2, 2000)
ch1 = np.sin(2*np.pi*10*t) + 0.3*np.random.randn(len(t))
ch2 = np.sin(2*np.pi*20*t) + 0.3*np.random.randn(len(t))
ch3 = np.sin(2*np.pi*5*t)  + 0.3*np.random.randn(len(t))

# Build a DataFrame (pandas equivalent of MATLAB table)
df = pd.DataFrame({
    'time_s':   t,
    'channel1': ch1,
    'channel2': ch2,
    'channel3': ch3
})
df.to_csv('simulated_eeg.csv', index=False)
print('CSV saved: simulated_eeg.csv')

# --- 2. Reading the CSV back ---
loaded = pd.read_csv('simulated_eeg.csv')
print('\nLoaded DataFrame preview:')
print(loaded.head())          # .head() shows first 5 rows — equivalent to disp(table(1:5,:))

t2   = loaded['time_s'].values
sig1 = loaded['channel1'].values
sig2 = loaded['channel2'].values
sig3 = loaded['channel3'].values

# --- 3. Multi-channel EEG-style stacked display ---
offset = 3
plt.figure(figsize=(12, 5))
plt.plot(t2, sig1,            'b',  linewidth=0.8, label='Ch1 (10Hz)')
plt.plot(t2, sig2 + offset,   'r',  linewidth=0.8, label='Ch2 (20Hz)')
plt.plot(t2, sig3 + 2*offset, 'k',  linewidth=0.8, label='Ch3 (5Hz)')
plt.yticks([0, offset, 2*offset], ['Ch1 (10Hz)', 'Ch2 (20Hz)', 'Ch3 (5Hz)'])
plt.xlabel('Time (s)')
plt.title('Simulated Multi-Channel EEG Recording')
plt.legend(loc='upper right')
plt.tight_layout(); plt.show()

# --- 4. Publication-quality figure with annotation ---
fig, ax = plt.subplots(figsize=(11, 4))

ax.plot(t2, sig1, color=[0.2, 0.4, 0.8], linewidth=1)
ax.set_xlabel('Time (s)', fontsize=13)
ax.set_ylabel('Amplitude (a.u.)', fontsize=13)
ax.set_title('Channel 1 — 10 Hz Signal', fontsize=14)

# Shade a region of interest
roi_start, roi_end = 0.5, 1.0
y_min, y_max = ax.get_ylim()
ax.axvspan(roi_start, roi_end, alpha=0.2, color='orange', label='ROI')
ax.text(roi_start + 0.02, y_max * 0.8, 'ROI', fontsize=11, color='darkorange')

# Threshold line
threshold = 0.8
ax.axhline(threshold, color='red', linestyle='--', linewidth=1.5, label=f'Threshold ({threshold})')

ax.spines['top'].set_visible(False)     # remove top border  (like 'box off' in MATLAB)
ax.spines['right'].set_visible(False)   # remove right border
ax.legend()
plt.tight_layout()

# --- 5. Save the figure ---
fig.savefig('channel1_figure.png', dpi=150, bbox_inches='tight')
print('\nFigure saved: channel1_figure.png')
plt.show()
