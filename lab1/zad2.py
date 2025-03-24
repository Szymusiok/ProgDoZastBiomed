import numpy as np
import mne
import matplotlib.pyplot as plt

# Perform the same tasks for the remaining four subjects and document the latency
# and amplitude of the peaks within the specified time range of 0-0.2 seconds,
# or 0-0.3 seconds if needed for an averaged signal from chosen channel.
# Channels can be selected manually through visual inspection or by choosing the one
# with the highest signal amplitude at a given time point.
# Present the outcomes of latency and amplitude measurements in a tabular format
# and calculate the mean and standard deviation an generate a comparision plot.

def load_raw_file(data):
    return mne.io.read_raw_fif(data, preload=True)

def zad2(raw):
    raw.filter(1, 40, fir_design='firwin')

    # Find and map events
    events = mne.find_events(raw)
    event_dict = {
        "Initial Famous Face": 5,
        "Initial Unfamiliar Face": 13,
        "Initial Scrambled Face": 17,
    }
    print()

    epochs = mne.Epochs(
        raw, events, event_id=event_dict, tmin=-0.2, tmax=0.6,
        baseline=(None, 0), preload=True
    )

    for trigger in event_dict.keys():

        # Calculate average from all channels for specified trigger
        evoked = epochs[trigger].average()

        picks = mne.pick_types(evoked.info, meg='mag', eeg=False)
        avg_all_channels = np.mean(evoked.data[picks, :], axis=0)

        if 'MEG1631' in evoked.ch_names:
            idx = evoked.ch_names.index('MEG1631')
            signal_MEG1631 = evoked.data[idx, :]
        else:
            continue

        times = evoked.times

        plt.figure(figsize=(10, 5))
        plt.plot(times, avg_all_channels, label='All channels', color='blue')
        plt.plot(times, signal_MEG1631, label='MEG1631', color='red')
        plt.title(f"Response for {trigger} for {raw.filenames}")
        plt.xlabel('Time [s]')
        plt.ylabel('Amplitude')
        plt.legend()
        plt.show()

        fig = evoked.plot_topomap(
            0.17, ch_type="mag", show_names=True,
            colorbar=False, size=6, res=128
        )



raw2 = load_raw_file('dane/sub-02_ses-meg_task-facerecognition_run-01_meg.fif')
raw3 = load_raw_file('dane/sub-03_ses-meg_task-facerecognition_run-01_meg.fif')
raw4 = load_raw_file('dane/sub-04_ses-meg_task-facerecognition_run-01_meg.fif')
raw5 = load_raw_file('dane/sub-05_ses-meg_task-facerecognition_run-01_meg.fif')

zad2(raw2)
zad2(raw3)
zad2(raw4)
zad2(raw5)



