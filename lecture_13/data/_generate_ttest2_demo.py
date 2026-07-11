"""
Extra dataset for teaching ttest2 with a MODERATE, realistic p-value (~0.03)
— so students see a p that is clearly < 0.05 but nowhere near 0.
Neuroscience context: N170 face-ERP peak amplitude (uV), two participant groups.
Reproducible; seed chosen so the realised two-sample p lands near 0.03.
"""
import numpy as np
from scipy.io import savemat
from scipy import stats

# search a few seeds for a realised p close to 0.03 (keeps it honest & reproducible)
target, best = 0.03, None
for seed in range(200):
    rng = np.random.default_rng(seed)
    a = rng.normal(6.0, 1.6, 16)     # control
    b = rng.normal(7.4, 1.6, 16)     # treatment (modestly larger)
    t, p = stats.ttest_ind(a, b)
    if best is None or abs(p - target) < abs(best[2] - target):
        best = (seed, t, p, a, b)

seed, t, p, control, treatment = best
measure = 'N170 peak amplitude (uV)'
savemat('ttest2_demo_data.mat', {
    'control': control.reshape(1, -1),
    'treatment': treatment.reshape(1, -1),
    'measure': measure})

n1, n2 = control.size, treatment.size
sem = lambda x: x.std(ddof=1)/np.sqrt(x.size)
print(f'seed={seed}  measure={measure}')
print(f'control    n={n1} mean={control.mean():.2f}  sd={control.std(ddof=1):.2f}  SEM={sem(control):.2f}')
print(f'treatment  n={n2} mean={treatment.mean():.2f}  sd={treatment.std(ddof=1):.2f}  SEM={sem(treatment):.2f}')
print(f'ttest2:  t({n1+n2-2}) = {t:.3f},  p = {p:.4f}')
# Cohen's d
psd = np.sqrt(((n1-1)*control.std(ddof=1)**2 + (n2-1)*treatment.std(ddof=1)**2)/(n1+n2-2))
print(f"Cohen's d = {(treatment.mean()-control.mean())/psd:.2f}")
