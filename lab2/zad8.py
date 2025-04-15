import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import chirp, spectrogram

# -------------------------------
# 1. Symulacja sygnału świergotowego (chirp)

fs = 44100              # Częstotliwość próbkowania
duration = 1.0          # Czas trwania sygnału
t = np.linspace(0, duration, int(fs*duration), endpoint=False)

# Generacja sygnału chirp
signal = chirp(t, f0=2000, t1=duration, f1=8000, method='linear')

# -------------------------------
# 2. Widmo amplitudowe sygnału

N = len(signal)
X = np.fft.fft(signal)
freqs = np.fft.fftfreq(N, d=1/fs)

mask = freqs >= 0
freqs_pos = freqs[mask]
amp_spectrum = 2.0 * np.abs(X[mask]) / N

# -------------------------------
# 3. Obliczenie spektrogramu
frequencies, times, Sxx = spectrogram(signal, fs, nperseg=1024)

# -------------------------------
# 4. Wizualizacja
plt.figure(figsize=(14, 6))

# Widmo amplitudowe
plt.subplot(1, 2, 1)
plt.plot(freqs_pos, amp_spectrum, color='blue')
plt.xlabel("Częstotliwość [Hz]")
plt.ylabel("Amplituda")
plt.title("Widmo amplitudowe sygnału świergotowego")
plt.grid(True)

# Spektrogram
plt.subplot(1, 2, 2)
plt.pcolormesh(times, frequencies, 10*np.log10(Sxx), shading='gouraud', cmap='viridis')
plt.ylabel("Częstotliwość [Hz]")
plt.xlabel("Czas [s]")
plt.title("Spektrogram sygnału świergotowego")
cbar = plt.colorbar()
cbar.set_label("Moc [dB]")
plt.tight_layout()
plt.show()
