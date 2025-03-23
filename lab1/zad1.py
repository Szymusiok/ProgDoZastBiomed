import numpy as np
import mne
import matplotlib.pyplot as plt

# Plot the averaged signal for all channels in patient 1 for each trigger
# ['Initial Famous Face,' 'Initial Unfamiliar Face,' 'Initial Scrambled Face'].
# Compare this signal with that from the MEG1631 channel and explain why
# analysing only one channel or a group of several channels might be preferable
# over analysing the averaged signal from all channels.

# Load file
raw = mne.io.read_raw_fif('dane/sub-01_ses-meg_task-facerecognition_run-01_meg.fif', preload=True)
# Put a filter (1-40Hz) to clean data
raw.filter(1, 40, fir_design='firwin')
print()

# Find and map events
events = mne.find_events(raw)
event_dict = {
    "Initial Famous Face": 5,
    "Initial Unfamiliar Face": 13,
    "Initial Scrambled Face": 17,
}
print()

epochs = mne.Epochs(raw, events, event_id=event_dict, tmin=-0.2, tmax=0.6, baseline=(None, 0), preload=True)

for trigger in event_dict.keys():

    # Calculate average from all channels for specified trigger
    evoked = epochs[trigger].average()

    fig = evoked.plot_topomap(0.17, ch_type="mag", show_names=True, colorbar=True, size=6, res=128)
    fig.suptitle("Visual response")

    avg_all_channels = np.mean(evoked.data, axis=0)

    if 'MEG1631' in evoked.ch_names:
        idx = evoked.ch_names.index('MEG1631')
        signal_MEG1631 = evoked.data[idx,:]
    else:
        continue

    times = evoked.times

    plt.figure(figsize=(10,5))
    plt.plot(times, avg_all_channels, label='All channels', color='blue')
    plt.plot(times, signal_MEG1631, label='MEG1631', color='red')
    plt.title(f"Response for {trigger}")
    plt.xlabel('Time [s]')
    plt.ylabel('Amplitude')
    plt.legend()
    plt.show()

    plt.figure(figsize=(10, 5))
    plt.plot(times, avg_all_channels, label='All channels', color='blue')
    plt.plot(times, signal_MEG1631, label='MEG1631', color='red')
    plt.title(f"Zoomed amplitude response for {trigger}")
    plt.xlabel('Time [s]')
    plt.ylabel('Amplitude')
    plt.legend()
    plt.ylim(-2e-12, 2e-12)
    plt.show()
