import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import butter, filtfilt

# -------------------------------
# 1. Generowanie sygnału
fs = 1000                 # Częstotliwość próbkowania
t = np.linspace(0, 1, fs, endpoint=False)

# Sygnał składający się z dwóch sinusoid
signal = np.sin(2 * np.pi * 50 * t + 0.3) + 0.5*np.sin(2 * np.pi * 200 * t - 0.7)

# -------------------------------
# 2. Definicja filtru Butterwortha

cutoff = 100              # Częstotliwość odcięcia
order = 3                 # Rząd filtru
nyq = 0.5 * fs            # Częstotliwość Nyquista
normal_cutoff = cutoff / nyq

# Współczynniki filtru
b, a = butter(order, normal_cutoff, btype='low', analog=False)

# -------------------------------
# 3. Filtrowanie sygnału z użyciem funkcji filtfilt
filtered_signal = filtfilt(b, a, signal)

# -------------------------------
# 4. Obliczenie widma fazowego sygnału oryginalnego i filtrowanego

N = fs
X_orig = np.fft.fft(signal, n=N)
X_filt = np.fft.fft(filtered_signal, n=N)
freqs = np.fft.fftfreq(N, 1/fs)

idx = np.where(freqs >= 0)
freqs = freqs[idx]
phase_orig = np.angle(X_orig[idx])
phase_filt = np.angle(X_filt[idx])

# -------------------------------
# 5. Wizualizacja

fig, axs = plt.subplots(2, 2, figsize=(14, 10))

# Wykres sygnałów w dziedzinie czasu
axs[0, 0].plot(t, signal, label="Sygnał oryginalny")
axs[0, 0].set_title("Sygnał oryginalny")
axs[0, 0].set_xlabel("Czas [s]")
axs[0, 0].set_ylabel("Amplituda")
axs[0, 0].legend()
axs[0, 0].grid(True)

axs[0, 1].plot(t, filtered_signal, label="Sygnał filtrowany (filtfilt)", color="orange")
axs[0, 1].set_title("Sygnał filtrowany (filtfilt)")
axs[0, 1].set_xlabel("Czas [s]")
axs[0, 1].set_ylabel("Amplituda")
axs[0, 1].legend()
axs[0, 1].grid(True)

# Wykresy widma fazowego
axs[1, 0].plot(freqs, phase_orig, label="Faza oryginalnego", color="blue")
axs[1, 0].set_title("Widmo fazowe - sygnał oryginalny")
axs[1, 0].set_xlabel("Częstotliwość [Hz]")
axs[1, 0].set_ylabel("Faza [rad]")
axs[1, 0].legend()
axs[1, 0].grid(True)

axs[1, 1].plot(freqs, phase_filt, label="Faza filtrowanego", color="green")
axs[1, 1].set_title("Widmo fazowe - sygnał filtrowany")
axs[1, 1].set_xlabel("Częstotliwość [Hz]")
axs[1, 1].set_ylabel("Faza [rad]")
axs[1, 1].legend()
axs[1, 1].grid(True)

plt.tight_layout()
plt.show()
