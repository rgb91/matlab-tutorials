# MATLAB for Neuroscience — Lesson 4 Reference Sheet
### NSBV BC2001 | Custom Functions & EEG Signal Visualisation

---

## Quick Syntax Cards

### Defining a Custom Function
```matlab
% File: my_function.m  ← filename MUST match the function name
function output = my_function(input1, input2)
    % DOCSTRING: describe what the function does
    output = input1 + input2;
end
```

### Multiple Output Function
```matlab
function [out1, out2, out3] = signal_stats(x)
    out1 = mean(x);
    out2 = std(x);
    out3 = max(abs(x));
end
```
Call it with: `[m, s, p] = signal_stats(data);`

### Calling a Function with Fewer Outputs Than Defined
```matlab
m = signal_stats(data);   % only gets the FIRST output; rest are discarded
```

---

## EEG Signal Generation Cheatsheet

| Brain Band | Frequency (Hz) | Associated State |
|------------|---------------|-----------------|
| Delta (δ)  | 0.5 – 4       | Deep sleep |
| Theta (θ)  | 4 – 8         | Drowsiness, memory encoding |
| Alpha (α)  | 8 – 13        | Relaxed, eyes closed |
| Beta (β)   | 13 – 30       | Alert, active cognition |
| Gamma (γ)  | 30 – 80       | High-level processing |

### Standard EEG Parameters
```matlab
Fs = 256;                       % Sampling rate (Hz)
t  = 0 : 1/Fs : T - 1/Fs;      % Time vector for duration T seconds
```

### Sine Wave Template
```matlab
amplitude = 2.5;
frequency = 10;     % Hz
wave = amplitude * sin(2 * pi * frequency * t);
```

### Adding Noise
```matlab
noise = 0.5 * randn(1, length(t));   % Gaussian white noise
```

---

## Plotting Reference

### Multi-panel Figures
```matlab
figure;
subplot(rows, cols, panel_number);
plot(x, y);
xlabel('label'); ylabel('label'); title('title');
grid on;
```

### Stacking EEG Channels
```matlab
offset = 8;    % µV gap between channels
for ch = 1:n_channels
    plot(t, eeg_multi(ch,:) + (ch-1)*offset);
    hold on;
end
```

### Marking Peaks
```matlab
[pks, locs] = findpeaks(signal, 'MinPeakHeight', 1.0, ...
                                'MinPeakDistance', Fs*0.05);
plot(t(locs), pks, 'rv', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
```

---

## Common Mistakes & Fixes

| Mistake | Fix |
|---------|-----|
| Filename doesn't match function name | Rename the `.m` file to exactly match `function name` |
| 1-indexed vs 0-indexed confusion | MATLAB is **1-indexed** — `x(1)` is the first element |
| Matrix size mismatch in arithmetic | Use `size(A)` to check; ensure vectors are same length |
| `randn(N)` gives NxN matrix | Use `randn(1,N)` for a row vector |
| Plot doesn't update | Click "Run Section" not just Enter; check you saved the file |

---

## Recommended Resources

### Official Documentation
- **MATLAB Function Syntax**: https://uk.mathworks.com/help/matlab/ref/function.html
- **findpeaks**: https://uk.mathworks.com/help/signal/ref/findpeaks.html
- **Plotting guide**: https://uk.mathworks.com/help/matlab/learn_matlab/plots.html

### YouTube Tutorials
| Topic | Channel | Search Query |
|-------|---------|-------------|
| Writing functions | MATLAB | "MATLAB functions tutorial MathWorks" |
| Subplots & figures | MATLAB | "MATLAB subplot tutorial" |
| Signal processing basics | Mike X Cohen | "Mike X Cohen MATLAB signal processing" |
| EEG analysis in MATLAB | Mike X Cohen | "Mike X Cohen EEG MATLAB" |

> **Highly recommended:** Mike X Cohen's free course *"MATLAB for Brain and Cognitive Scientists"*  
> Book companion videos: https://www.youtube.com/c/MikeXCohen

### Digital Notebook Checklist (add to your notebook this lesson)
- [ ] How to write a function in a separate `.m` file
- [ ] Function syntax: `function [out1, out2] = name(in1, in2)`
- [ ] What `Fs`, `t`, `T` mean in signal generation
- [ ] Formula for a sine wave: `A * sin(2 * pi * f * t)`
- [ ] How to use `subplot` for multi-panel figures
- [ ] How `findpeaks` works and its key parameters

---

## Lesson Progress Tracker

| Lesson | Date | Topic | Status |
|--------|------|-------|--------|
| 1 | 20 May 2026 | MATLAB interface, arrays, matrices | ✅ Done |
| 2 | 22 May 2026 | Variables, data types, built-in functions | ✅ Done |
| 3 | 23 May 2026 | Loops, conditionals, first plot | ✅ Done |
| **4** | **Next** | **Custom functions, EEG signals** | 🔵 Up next |
| 5 | TBD | Signal processing: filtering, FFT | ⬜ Planned |
| 6 | TBD | Statistics for neuroscience data | ⬜ Planned |
| 7 | TBD | Working with real EEG data files | ⬜ Planned |
| 8 | TBD | Group-level analysis & figures | ⬜ Planned |
| 9 | TBD | Electrophysiology: spike detection | ⬜ Planned |
| 10 | TBD | Final project & exam prep | ⬜ Planned |

---

*Generated for NSBV BC2001 summer prep | Barnard College*
