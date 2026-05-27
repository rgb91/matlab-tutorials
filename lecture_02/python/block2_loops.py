# BLOCK 2 — Loops (Python equivalent)
# Lecture 2: MATLAB Summer Prep | NSBV BC2001
# -----------------------------------------------
# Python parallel: compare with block2_loops.m

import numpy as np

# Setup — recreate signal from Block 1
t      = np.linspace(0, 1, 1000)
signal = np.sin(2 * np.pi * 10 * t)

# --- Basic FOR Loop ---
# Syntax is almost identical to MATLAB!
print("Counting with a for loop:")
for i in range(1, 6):           # range(1,6) → 1,2,3,4,5  (MATLAB: 1:5)
    print(i)

# --- FOR Loop with condition (threshold detection) ---
threshold = 0.5
above     = np.zeros(len(signal))   # pre-allocate (MATLAB: zeros(1, length(signal)))

for i in range(len(signal)):        # MATLAB: for i = 1:length(signal)
    if signal[i] > threshold:
        above[i] = signal[i]

print("\nNumber of samples above threshold:", np.sum(above != 0))

# --- WHILE Loop ---
count = 0
x     = 0.0

while x < 1:
    x     += 0.25
    count += 1
    print(f"Step {count}: x = {x:.2f}")

# --- BREAK and CONTINUE ---
print("\nBreak example — stop at 4:")
for i in range(1, 11):
    if i == 4:
        break
    print(i)

print("\nContinue example — skip even numbers:")
for i in range(1, 9):
    if i % 2 == 0:        # MATLAB: mod(i, 2) == 0
        continue
    print(i)
