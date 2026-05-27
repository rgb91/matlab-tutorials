# BLOCK 1 — Vectors & Arrays (Python/NumPy equivalent)
# Lecture 2: MATLAB Summer Prep | NSBV BC2001
# -----------------------------------------------
# Python parallel: compare with block1_vectors_arrays.m

import numpy as np

# --- Row vs Column Vectors ---
# In NumPy, a simple 1D array is like a MATLAB row vector
row_vec = np.array([1, 2, 3, 4, 5])
col_vec = row_vec.reshape(-1, 1)        # convert to column vector (2D)

print("Row vector:", row_vec)
print("Column vector:\n", col_vec)

# --- Colon Operator → np.arange ---
# MATLAB: t = 0:0.1:1
t_arange  = np.arange(0, 1.1, 0.1)     # note: stop is exclusive in Python

# --- Linspace (same name in NumPy!) ---
# MATLAB: t = linspace(0, 1, 11)
t_linspace = np.linspace(0, 1, 11)

print("\nnp.arange result:", t_arange)
print("np.linspace result:", t_linspace)

# --- Indexing ---
# CRITICAL difference: Python uses 0-based indexing, MATLAB uses 1-based
v = np.array([10, 20, 30, 40, 50])
print("\nFirst element (index 0):", v[0])     # MATLAB: v(1)
print("Last element:", v[-1])                  # MATLAB: v(end)
print("Elements index 1 to 3:", v[1:4])        # MATLAB: v(2:4)

# --- Element-wise Operations ---
# NumPy arrays are element-wise by default (no .^ needed)
v = np.array([1, 2, 3, 4, 5])
print("\nMultiply by 2:", v * 2)
print("Square each element:", v ** 2)          # MATLAB: v .^ 2

w = np.array([10, 10, 10, 10, 10])
print("Add two arrays:", v + w)

# --- Size, Length, Numel equivalents ---
print("\nShape (like size):", v.shape)
print("Length:", len(v))
print("Number of elements:", v.size)           # MATLAB: numel

# --- Neuroscience Example — Simulating a Time Axis ---
t      = np.linspace(0, 1, 1000)              # 1 second, 1000 samples
signal = np.sin(2 * np.pi * 10 * t)           # 10 Hz sine wave

print("\nFirst 5 values of the signal:", signal[:5])
