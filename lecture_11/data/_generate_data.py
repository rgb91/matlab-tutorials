"""
Generate datasets for Session 11 (Epoching recap + Descriptive stats + t-tests).
NSBV BC2001 MATLAB prep. Reproducible (fixed seed).

Files produced:
  continuous_eeg.mat   - 2-channel continuous EEG, 30 events in 2 conditions
                         (standard / target oddball). For the epoching recap demo.
  epoched_conditions.mat - pre-cut epochs for two conditions at Pz. For the
                         descriptive-stats and t-test demos (skips extraction).
  group_data.mat       - resting alpha power, control vs treatment (eyes-closed).
                         Clean 1-D vectors for descriptive stats + ttest2.
  exercise_data.mat    - second control/treatment dataset for the in-class exercise.
  homework_data.mat    - subject-level values + condition labels (cell array) +
                         ground-truth stats, for the homework function.
"""
import numpy as np
from scipy.io import savemat
from scipy import stats

rng = np.random.default_rng(11)   # session 11 seed
fs = 256

# ----------------------------------------------------------------------
# Helper: a simple ERP "bump" (Gaussian) peaking at peak_t seconds
def erp_bump(t, amp, peak_t=0.12, width=0.035):
    return amp * np.exp(-((t - peak_t) ** 2) / (2 * width ** 2))

def background(n, fs, rng):
    t = np.arange(n) / fs
    # ongoing oscillations: alpha 10 Hz + slow drift + white noise
    sig = (2.5 * np.sin(2*np.pi*10*t + rng.uniform(0, 2*np.pi))   # alpha
           + 1.2 * np.sin(2*np.pi*6*t + rng.uniform(0, 2*np.pi))  # theta
           + 1.5 * np.sin(2*np.pi*0.5*t))                          # slow drift
    sig += 1.5 * rng.standard_normal(n)                            # white noise
    return sig

# ======================================================================
# 1) continuous_eeg.mat  (epoching recap demo)
# ======================================================================
dur = 12.0
N = int(dur * fs)                  # 3072
t = np.arange(N) / fs
ch_names = np.array([['Cz', 'Pz']], dtype=object)

# events: 30 events, jittered spacing, two conditions interleaved
n_events = 30
gap = rng.uniform(0.32, 0.40, size=n_events)
event_times = np.cumsum(gap) + 0.5
event_times = event_times[event_times < dur - 0.5]   # keep in bounds
n_events = len(event_times)
event_samples = np.round(event_times * fs).astype(int)

# condition assignment: 1 = standard (frequent), 2 = target (oddball)
event_type = rng.permutation(
    np.array([1]*(n_events - n_events//2) + [2]*(n_events//2)))
cond_names = np.array([['standard', 'target']], dtype=object)

# build 2 channels of background
data = np.vstack([background(N, fs, rng), background(N, fs, rng)])

# inject ERP at each event; target has larger amplitude. Pz (ch 2) strongest.
win_t = np.arange(-int(0.1*fs), int(0.4*fs)) / fs   # template window axis
for k in range(n_events):
    if event_type[k] == 1:        # standard
        amp_cz = rng.normal(2.5, 0.5)
        amp_pz = rng.normal(3.0, 0.5)
    else:                          # target
        amp_cz = rng.normal(5.5, 0.5)
        amp_pz = rng.normal(7.0, 0.5)
    s = event_samples[k] - int(0.1*fs)
    e = s + len(win_t)
    if s < 0 or e > N:
        continue
    data[0, s:e] += erp_bump(win_t, amp_cz)
    data[1, s:e] += erp_bump(win_t, amp_pz)

savemat('continuous_eeg.mat', {
    'data': data, 'fs': fs, 'ch_names': ch_names, 'time': t.reshape(1, -1),
    'event_samples': event_samples.reshape(1, -1),
    'event_times': event_times.reshape(1, -1),
    'event_type': event_type.reshape(1, -1),
    'cond_names': cond_names})

# ---- ground truth: epoch Pz, peak in 50-250 ms, compare conditions ----
pre, post = 0.1, 0.4
pre_s, post_s = round(pre*fs), round(post*fs)
elen = pre_s + post_s
epoch_time = np.linspace(-pre, post, elen)
def extract(ch):
    eps = []
    for k in range(n_events):
        s = event_samples[k] - pre_s
        e = s + elen
        if s < 0 or e > N: 
            eps.append(None); continue
        seg = data[ch, s:e].copy()
        seg -= seg[epoch_time < 0].mean()   # baseline correct
        eps.append(seg)
    return eps
eps_pz = extract(1)
pk_win = (epoch_time >= 0.05) & (epoch_time <= 0.25)
peaks_std = np.array([e[pk_win].max() for k, e in enumerate(eps_pz) if e is not None and event_type[k]==1])
peaks_tgt = np.array([e[pk_win].max() for k, e in enumerate(eps_pz) if e is not None and event_type[k]==2])
ts, ps = stats.ttest_ind(peaks_tgt, peaks_std, equal_var=True)
print('=== continuous_eeg.mat ===')
print(f'  events: {n_events}  (standard={np.sum(event_type==1)}, target={np.sum(event_type==2)})')
print(f'  Pz peak standard: mean={peaks_std.mean():.2f} sd={peaks_std.std(ddof=1):.2f} n={len(peaks_std)}')
print(f'  Pz peak target  : mean={peaks_tgt.mean():.2f} sd={peaks_tgt.std(ddof=1):.2f} n={len(peaks_tgt)}')
print(f'  ttest2 target vs standard: t={ts:.3f} p={ps:.2e}')

# save epoched_conditions.mat (Pz) for the stats demos
epochs_standard = np.array([e for k,e in enumerate(eps_pz) if e is not None and event_type[k]==1])
epochs_target   = np.array([e for k,e in enumerate(eps_pz) if e is not None and event_type[k]==2])
savemat('epoched_conditions.mat', {
    'epochs_standard': epochs_standard, 'epochs_target': epochs_target,
    'epoch_time': epoch_time.reshape(1, -1), 'fs': fs, 'channel': 'Pz'})
print('=== epoched_conditions.mat ===')
print(f'  epochs_standard: {epochs_standard.shape}, epochs_target: {epochs_target.shape}')

# ======================================================================
# 2) group_data.mat  (descriptive stats + ttest2 demo)
#    resting alpha power (uV^2), eyes-closed; control vs treatment
# ======================================================================
control   = rng.normal(5.0, 1.2, size=20)
treatment = rng.normal(3.5, 1.2, size=20)
savemat('group_data.mat', {
    'control': control.reshape(1, -1),
    'treatment': treatment.reshape(1, -1),
    'measure': 'alpha power (uV^2)'})
tg, pg = stats.ttest_ind(control, treatment, equal_var=True)
print('=== group_data.mat ===')
for nm, v in [('control', control), ('treatment', treatment)]:
    print(f'  {nm}: mean={v.mean():.3f} median={np.median(v):.3f} sd={v.std(ddof=1):.3f} '
          f'SEM={v.std(ddof=1)/np.sqrt(len(v)):.3f} min={v.min():.3f} max={v.max():.3f}')
print(f'  ttest2 control vs treatment: t={tg:.3f} p={pg:.4f}')
t1, p1 = stats.ttest_1samp(control, 0)
print(f'  one-sample ttest control vs 0: t={t1:.2f} p={p1:.2e}')

# ======================================================================
# 3) exercise_data.mat  (in-class exercise: different numbers)
#    P100 ERP peak amplitude (uV): eyes-open vs eyes-closed
# ======================================================================
eyes_open   = rng.normal(4.0, 1.0, size=18)
eyes_closed = rng.normal(6.5, 1.0, size=18)
savemat('exercise_data.mat', {
    'eyes_open': eyes_open.reshape(1, -1),
    'eyes_closed': eyes_closed.reshape(1, -1),
    'measure': 'alpha peak amplitude (uV)'})
te, pe = stats.ttest_ind(eyes_open, eyes_closed, equal_var=True)
print('=== exercise_data.mat ===')
for nm, v in [('eyes_open', eyes_open), ('eyes_closed', eyes_closed)]:
    print(f'  {nm}: mean={v.mean():.3f} sd={v.std(ddof=1):.3f} SEM={v.std(ddof=1)/np.sqrt(len(v)):.3f}')
print(f'  ttest2 open vs closed: t={te:.3f} p={pe:.4e}')

# ======================================================================
# 4) homework_data.mat  (subject-level values + condition labels)
# ======================================================================
n_hw = 24
labels = np.array(['control']*12 + ['patient']*12)
vals = np.concatenate([rng.normal(8.0, 1.5, 12), rng.normal(5.5, 1.5, 12)])
perm = rng.permutation(n_hw)
labels, vals = labels[perm], vals[perm]
subject_ids = np.array([f'P{i+1:02d}' for i in range(n_hw)])
group = np.array([[s for s in labels]], dtype=object)
subj = np.array([[s for s in subject_ids]], dtype=object)
c = vals[labels=='control']; p = vals[labels=='patient']
th, ph = stats.ttest_ind(c, p, equal_var=True)
savemat('homework_data.mat', {
    'values': vals.reshape(1, -1), 'group': group, 'subject_ids': subj,
    'measure': 'mean ERP amplitude (uV)'})
print('=== homework_data.mat ===')
print(f'  control : n={len(c)} mean={c.mean():.3f} sd={c.std(ddof=1):.3f} SEM={c.std(ddof=1)/np.sqrt(len(c)):.3f}')
print(f'  patient : n={len(p)} mean={p.mean():.3f} sd={p.std(ddof=1):.3f} SEM={p.std(ddof=1)/np.sqrt(len(p)):.3f}')
print(f'  ttest2 control vs patient: t={th:.3f} p={ph:.4f}')
