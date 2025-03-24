import numpy as np
import mne
import matplotlib.pyplot as plt
import pandas as pd

# Perform the same tasks for the remaining four subjects and document the latency
# and amplitude of the peaks within the specified time range of 0-0.2 seconds,
# or 0-0.3 seconds if needed for an averaged signal from chosen channel.
# Channels can be selected manually through visual inspection or by choosing the one
# with the highest signal amplitude at a given time point.
# Present the outcomes of latency and amplitude measurements in a tabular format
# and calculate the mean and standard deviation an generate a comparision plot.

DATA_DIR = 'dane'
SUBJECTS = [f'sub-{i:02d}' for i in range(1, 6)]
EVENT_DICT = {
    "Initial Famous Face": 5,
    "Initial Unfamiliar Face": 13,
    "Initial Scrambled Face": 17,
}

TMIN, TMAX = 0.0, 0.2

results = []

for subj in SUBJECTS:
    fname = f'{DATA_DIR}/{subj}_ses-meg_task-facerecognition_run-01_meg.fif'
    raw = mne.io.read_raw_fif(fname, preload=True)
    raw.filter(1,40, fir_design='firwin')

    events = mne.find_events(raw)
    epochs = mne.Epochs(raw, events, event_id=EVENT_DICT,
                        tmin=-0.2, tmax=0.6, baseline=(None, 0),
                        preload=True)

    for cond, code in EVENT_DICT.items():
        evoked = epochs[cond].average()
        picks = mne.pick_types(evoked.info, meg='mag', eeg=False)

        tmask = (evoked.times >= TMIN) & (evoked.times <= TMAX)
        data = evoked.data[picks][:, tmask]

        peak_idx = np.unravel_index(np.argmax(np.abs(data)), data.shape)
        chan_idx, time_idx = peak_idx
        chan_name = evoked.ch_names[picks[chan_idx]]
        print(f'Channel with peak: {chan_name}')
        latency = evoked.times[tmask][time_idx]*1000
        amplitude = data[chan_idx][time_idx]

        results.append({
            'Subject': subj,
            'Condition': cond,
            'Channel': chan_name,
            'Latency_ms': latency,
            'Amplitude': amplitude
        })

df = pd.DataFrame(results)

#-----------------------

summary = df.groupby('Condition')[['Latency_ms', 'Amplitude']].agg(['mean', 'std'])

print("\nPer‑subject peak latency & amplitude (ms, Tesla):")
print(df.to_string(index=False))

print("\nGroup summary (mean ± SD):")
print(summary)

plt.figure(figsize=(8,4))
plt.errorbar(
    summary.index, summary['Latency_ms']['mean'],
    yerr=summary['Latency_ms']['std'], marker='o'
)
plt.title('Mean Peak Latency ± SD (0–200 ms)')
plt.xlabel('Condition')
plt.ylabel('Latency (ms)')
plt.show()

plt.figure(figsize=(8,4))
plt.errorbar(
    summary.index, summary['Amplitude']['mean'],
    yerr=summary['Amplitude']['std'], marker='o'
)
plt.title('Mean Peak Amplitude ± SD (0–200 ms)')
plt.xlabel('Condition')
plt.ylabel('Amplitude')
plt.show()

