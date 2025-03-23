#%%
import matplotlib
import pandas as pd
import numpy as np
import mne
import matplotlib.pyplot as plt

matplotlib.pyplot.show()

dane = 'dane/sub-01_ses-meg_task-facerecognition_run-01_meg.fif'

raw = mne.io.read_raw_fif(dane, preload=True)
print(raw.info)

number_of_time_samples = raw.n_times
time_sec = raw.times
channels_names = raw.ch_names[:5]
number_of_channels = raw.info['nchan']
sampling_frequency = raw.info['sfreq']
last_sample_timestamp = raw.times[-1]

print("Sampling frequency: {} Hz".format(sampling_frequency))
print("Timestamp of the last recorded sample: {:.2f} seconds".format(last_sample_timestamp))
print("Names of the first five channels: {}".format(", ".join(channels_names)))
print("Total number of channels: {}".format(number_of_channels))
print("Total number of timesteps: {}".format(number_of_time_samples))

#raw.plot()
#raw.filter(l_freq=0.1, h_freq=None)
#raw.plot()
#raw.filter(l_freq=None, h_freq=40)
#raw.plot()

channel_name = "MEG0143"
time = raw.times
start_index = 26500
stop_index = 27500
single_channel_signal_cropped = raw.get_data(channel_name, start = start_index, stop =stop_index)
plt.plot(time[start_index:stop_index], single_channel_signal_cropped[0])
plt.title(f'MEG Data for Channel {channel_name}')
plt.xlabel('Time [s]')
plt.ylabel('Magnetic field [fT]')
#plt.show()

print()
events = mne.find_events(raw)
events = mne.pick_events(events, exclude=[ 256,  261,  262,  263,  269,
  270,  271,  273,  274,  275, 4096, 4101, 4102, 4103, 4109, 4110, 4111, 4113, 4114,
 4115, 4352])

event_dict = {
    "Initial Famous Face": 5,
    "Immediate Repeat Famous Face": 6,
    "Delayed Repeat Famous Face": 7,
    "Initial Unfamiliar Face": 13,
    "Immediate Repeat Unfamiliar Face": 14,
    "Delayed Repeat Unfamiliar Face": 15,
    "Initial Scrambled Face": 17,
    "Immediate Repeat Scrambled Face": 18,
    "Delayed Repeat Scrambled Face": 19}

event_groups = {
    "famous" : ["Initial Famous Face", "Immediate Repeat Famous Face", "Delayed Repeat Famous Face"],
    "unfamiliar" : ["Initial Unfamiliar Face", "Immediate Repeat Unfamiliar Face", "Delayed Repeat Unfamiliar Face"],
    "scrambled": ["Initial Scrambled Face", "Immediate Repeat Scrambled Face", "Delayed Repeat Scrambled Face"]
}

#fig = mne.viz.plot_events(events, sfreq=raw.info["sfreq"], first_samp=raw.first_samp, event_id=event_dict)

epochs = mne.Epochs(raw,events,tmin=-0.2, tmax=0.6, event_id=event_dict, preload=True)

evoked = epochs.average()
#evoked.plot(picks='mag')

fig = evoked.plot_topomap(0.17, ch_type="mag", show_names=True, colorbar=False, size=6, res=128)
fig.suptitle("Visual response")

#epochs.plot_image(picks=["MEG1611", "MEG1631"])

#choosen_channel = "MEG1631"
#epochs["Initial Famous Face"].plot_image(picks = choosen_channel)

#epochs["Initial Unfamiliar Face"].plot_image(picks = choosen_channel)

#epochs["Initial Scrambled Face"].plot_image(picks = choosen_channel)
print()
print()
print()

event_labels = ['Initial Famous Face', 'Initial Unfamiliar Face', 'Initial Scrambled Face']
channel_of_interest = "MEG1631"
latency_magnitude_dict = {}
time_range = (0.0, 0.2)

for event_label in event_labels:
    avg_epoch = epochs[event_label].average()   # Average the epochs for the specific event
    data = avg_epoch.copy().pick([channel_of_interest]).get_data() # Pick the channel of interest and get the data for the specific event
    data *= 1e15     # Multiply the entire signal by 10^15 to change the data into femtoteslas
    time_points = avg_epoch.times     # Get the time points for the averaged epoch
    start_idx, end_idx = np.where((time_points >= time_range[0]) & (time_points <= time_range[1]))[0][[0, -1]]  # Find the start and end indices for the specified time range
    max_time_point = time_points[start_idx + np.argmax(np.abs(data[:, start_idx:end_idx + 1]))]
    max_magnitude = np.max(np.abs(data[:, start_idx:end_idx + 1]))
    latency = max_time_point - time_range[0] # Calculate latency as the difference between the time point and the start of the time range
    latency_magnitude_dict[event_label] = {'latency': latency, 'magnitude': max_magnitude}

for event_label, values in latency_magnitude_dict.items():
    print(f'Event: {event_label}\nLatency: {values["latency"]:.3f} [s] \nMagnitude: {values["magnitude"]:.3f}[fT] \n')
