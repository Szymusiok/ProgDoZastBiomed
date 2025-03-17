#%%
import matplotlib
import pandas as pd
import numpy as np
import mne
import matplotlib.pyplot as plt
matplotlib.pyplot.show()

raw = mne.io.read_raw_fif('dane/sub-01_ses-meg_task-facerecognition_run-01_meg.fif', preload=True)
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

raw.plot()

raw.filter(l_freq=0.1, h_freq=None)
raw.plot()

raw.filter(l_freq=None, h_freq=0.4)
raw.plot()