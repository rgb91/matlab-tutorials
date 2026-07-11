"""
Generate datasets for Session 13 (ANOVA + multi-subject averaging & figures).
NSBV BC2001 MATLAB prep. Reproducible (fixed seed).

Files produced (saved in this folder AND copied to ../../lecture_14/data):
  anova_data.mat        - resting alpha power for THREE groups (control / mild /
                          severe), independent subjects. For the anova1 +
                          multcompare demo.
  multisubject_erp.mat  - single-channel (Pz) ERP for 20 subjects x time, in two
                          conditions (standard / target). For grand-average,
                          SEM error bars, publication figures, and the erp-image
                          colourmap (subjects x time).
  exercise_anova.mat    - firing rate (Hz) for THREE stimulus contrasts, n=15
                          each. In-class ANOVA exercise.
  exercise_figure.mat   - 2-condition multi-subject ERP (16 subjects) for the
                          in-class publication-figure exercise.
  homework_s13.mat      - THREE-condition multi-subject ERP (independent design:
                          different subjects per condition) for the take-home:
                          grand-average figure + erp-image + anova1 on peaks.

All ground-truth statistics are printed so they can go straight into the
instructor answer key.
"""
import numpy as np
from scipy.io import savemat
from scipy import stats

rng = np.random.default_rng(13)   # session 13 seed
fs = 256

# ---------------------------------------------------------------- helpers
def erp_bump(t, amp, peak_t=0.30, width=0.045):
    """A P300-like positive deflection peaking at peak_t seconds."""
    return amp * np.exp(-((t - peak_t) ** 2) / (2 * width ** 2))

def subject_erp(t, amp, rng, noise=0.8):
    """One subject's averaged ERP waveform = signal bump + smooth noise."""
    sig = erp_bump(t, amp)
    # low-frequency 'residual' noise so averaged waveforms look realistic
    resid = (noise * 0.6) * np.sin(2*np.pi*rng.uniform(3, 7)*t + rng.uniform(0, 2*np.pi))
    resid += noise * rng.standard_normal(len(t)) * 0.25
    # smooth the white part a little
    k = np.ones(5) / 5
    resid = np.convolve(resid, k, mode='same')
    return sig + resid

def summ(name, x):
    x = np.asarray(x, float)
    print(f'  {name:10s} n={x.size:2d}  mean={x.mean():6.3f}  sd={x.std(ddof=1):6.3f}  '
          f'sem={x.std(ddof=1)/np.sqrt(x.size):6.3f}')

print('=' * 64)
# ======================================================================
# 1) anova_data.mat  -- three independent groups, resting alpha power
# ======================================================================
n = 16
control = rng.normal(6.0, 1.2, n)
mild    = rng.normal(4.6, 1.2, n)
severe  = rng.normal(3.1, 1.1, n)

values = np.concatenate([control, mild, severe])
group  = np.array(
    [['control']] * n + [['mild']] * n + [['severe']] * n, dtype=object).reshape(1, -1)

F, p = stats.f_oneway(control, mild, severe)
k = 3
N = 3 * n
df_between, df_within = k - 1, N - k
print('anova_data.mat  (resting alpha power, uV^2)')
summ('control', control); summ('mild', mild); summ('severe', severe)
print(f'  anova1: F({df_between},{df_within}) = {F:.3f}, p = {p:.3e}')
# pairwise (Tukey-ish via t-tests, for the answer key intuition)
for a, b, na, nb in [('control', 'mild', control, mild),
                     ('control', 'severe', control, severe),
                     ('mild', 'severe', mild, severe)]:
    t, pp = stats.ttest_ind(na, nb)
    print(f'    {a:8s} vs {b:8s}: t = {t:+.2f}, p = {pp:.3e}')
savemat('anova_data.mat', {
    'control': control.reshape(1, -1),
    'mild':    mild.reshape(1, -1),
    'severe':  severe.reshape(1, -1),
    'values':  values.reshape(1, -1),
    'group':   group,
    'measure': 'resting alpha power (uV^2)'})

print('=' * 64)
# ======================================================================
# 2) multisubject_erp.mat -- 20 subjects x time, two conditions (Pz)
# ======================================================================
pre, post = 0.1, 0.6
elen = int(round((pre + post) * fs))
erp_time = np.linspace(-pre, post, elen)

n_sub = 20
erp_std = np.zeros((n_sub, elen))
erp_tgt = np.zeros((n_sub, elen))
for s in range(n_sub):
    amp_std = rng.normal(3.0, 0.9)     # standard: small P300
    amp_tgt = rng.normal(6.5, 1.1)     # target: large P300
    erp_std[s] = subject_erp(erp_time, amp_std, rng)
    erp_tgt[s] = subject_erp(erp_time, amp_tgt, rng)

# peak amplitude per subject in the 250-450 ms window
pk = (erp_time >= 0.25) & (erp_time <= 0.45)
peak_std = erp_std[:, pk].max(axis=1)
peak_tgt = erp_tgt[:, pk].max(axis=1)
t_pair, p_pair = stats.ttest_rel(peak_tgt, peak_std)   # same subjects -> paired
print('multisubject_erp.mat  (Pz P300, 20 subjects, uV)')
summ('standard', peak_std); summ('target', peak_tgt)
print(f'  grand-avg peak standard = {peak_std.mean():.2f} uV, target = {peak_tgt.mean():.2f} uV')
print(f'  paired t-test target vs standard: t({n_sub-1}) = {t_pair:.2f}, p = {p_pair:.3e}')
savemat('multisubject_erp.mat', {
    'erp_std': erp_std, 'erp_tgt': erp_tgt,
    'erp_time': erp_time.reshape(1, -1),
    'fs': fs, 'channel': 'Pz',
    'cond_names': np.array([['standard', 'target']], dtype=object)})

print('=' * 64)
# ======================================================================
# 3) exercise_anova.mat -- firing rate under 3 stimulus contrasts
# ======================================================================
ne = 15
low  = rng.normal(12.0, 3.0, ne)
med  = rng.normal(18.0, 3.2, ne)
high = rng.normal(22.0, 3.4, ne)
ex_vals = np.concatenate([low, med, high])
ex_grp  = np.array(
    [['low']] * ne + [['medium']] * ne + [['high']] * ne, dtype=object).reshape(1, -1)
Fe, pe = stats.f_oneway(low, med, high)
print('exercise_anova.mat  (firing rate, Hz, 3 contrasts)')
summ('low', low); summ('medium', med); summ('high', high)
print(f'  anova1: F({3-1},{3*ne-3}) = {Fe:.3f}, p = {pe:.3e}')
savemat('exercise_anova.mat', {
    'low': low.reshape(1, -1), 'medium': med.reshape(1, -1),
    'high': high.reshape(1, -1),
    'values': ex_vals.reshape(1, -1), 'group': ex_grp,
    'measure': 'firing rate (Hz)'})

print('=' * 64)
# ======================================================================
# 4) exercise_figure.mat -- 16-subject, 2-condition ERP for pub figure
# ======================================================================
n_sub2 = 16
erp_open   = np.zeros((n_sub2, elen))
erp_closed = np.zeros((n_sub2, elen))
for s in range(n_sub2):
    erp_open[s]   = subject_erp(erp_time, rng.normal(2.5, 0.8), rng)
    erp_closed[s] = subject_erp(erp_time, rng.normal(5.0, 1.0), rng)
print('exercise_figure.mat  (16 subjects, eyes open vs closed)')
summ('open peak',   erp_open[:, pk].max(axis=1))
summ('closed peak', erp_closed[:, pk].max(axis=1))
savemat('exercise_figure.mat', {
    'erp_open': erp_open, 'erp_closed': erp_closed,
    'erp_time': erp_time.reshape(1, -1), 'fs': fs, 'channel': 'Pz',
    'cond_names': np.array([['eyes open', 'eyes closed']], dtype=object)})

print('=' * 64)
# ======================================================================
# 5) homework_s13.mat -- 3-condition multi-subject ERP (independent design)
#    different subjects per condition -> anova1 is valid on the peaks.
# ======================================================================
ns = [14, 15, 13]           # unequal n on purpose (realistic)
amps = [3.0, 5.0, 7.0]      # placebo / low-dose / high-dose
cond_labels = ['placebo', 'low_dose', 'high_dose']
erp_by_cond = []
peaks_by_cond = []
for ci in range(3):
    mat = np.zeros((ns[ci], elen))
    for s in range(ns[ci]):
        mat[s] = subject_erp(erp_time, rng.normal(amps[ci], 1.0), rng)
    erp_by_cond.append(mat)
    peaks_by_cond.append(mat[:, pk].max(axis=1))

# stack peaks + labels for anova1
hw_vals = np.concatenate(peaks_by_cond)
hw_grp  = np.array([[cond_labels[ci]] for ci in range(3) for _ in range(ns[ci])],
                   dtype=object).reshape(1, -1)
Fh, ph = stats.f_oneway(*peaks_by_cond)
print('homework_s13.mat  (P300 peak by dose, independent subjects)')
for ci in range(3):
    summ(cond_labels[ci], peaks_by_cond[ci])
print(f'  anova1 on peaks: F({3-1},{sum(ns)-3}) = {Fh:.3f}, p = {ph:.3e}')
for a, b in [(0, 1), (0, 2), (1, 2)]:
    t, pp = stats.ttest_ind(peaks_by_cond[a], peaks_by_cond[b])
    print(f'    {cond_labels[a]:9s} vs {cond_labels[b]:9s}: t = {t:+.2f}, p = {pp:.3e}')

savemat('homework_s13.mat', {
    'erp_placebo':   erp_by_cond[0],
    'erp_low_dose':  erp_by_cond[1],
    'erp_high_dose': erp_by_cond[2],
    'erp_time':      erp_time.reshape(1, -1),
    'peak_values':   hw_vals.reshape(1, -1),
    'peak_group':    hw_grp,
    'fs': fs, 'channel': 'Pz',
    'cond_names': np.array([cond_labels], dtype=object)})
print('=' * 64)
print('DONE. Ground-truth stats above -> instructor answer keys.')
