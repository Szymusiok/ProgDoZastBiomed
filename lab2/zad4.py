import numpy as np
import matplotlib.pyplot as plt

# Parametry sygnału
fs = 1000          # Częstotliwość próbkowania
T = 1.0            # Czas trwania sygnału
N = int(fs * T)    # Liczba próbek
t = np.linspace(0, T, N, endpoint=False)

f = 5.5  # Częstotliwość sygnału

# Generacja sygnału
s = np.sin(2 * np.pi * f * t)

# Obliczenie FFT
S = np.fft.fft(s)
freqs = np.fft.fftfreq(N, d=1/fs)
idx = np.where(freqs >= 0)
freqs = freqs[idx]
S = S[idx]

# Normalizacja amplitudy
amp = 2 * np.abs(S) / N

# -------------------------------
# Okienkowanie sygnału przy użyciu okna Hamminga
window = np.hamming(N)
s_windowed = s * window

# FFT sygnału okienkowanego
S_windowed = np.fft.fft(s_windowed)
S_windowed = S_windowed[idx]

# Korekta amplitudy
coherent_gain = np.sum(window) / N
amp_windowed = 2 * np.abs(S_windowed) / (N * coherent_gain)

# -------------------------------
# Wykresy widm
plt.figure(figsize=(12, 5))

# Widmo sygnału bez okienkowania
plt.subplot(1, 2, 1)
plt.xlim(0, 20)
plt.plot(freqs, amp, 'b')
plt.xlabel('Częstotliwość [Hz]')
plt.ylabel('Amplituda')
plt.title('Widmo amplitudowe (brak okienkowania)')
plt.grid(True)

# Widmo sygnału z okienkowaniem (Hamming)
plt.subplot(1, 2, 2)
plt.xlim(0, 20)
plt.plot(freqs, amp_windowed, 'r')
plt.xlabel('Częstotliwość [Hz]')
plt.ylabel('Amplituda')
plt.title('Widmo amplitudowe (okienkowanie - okno Hamminga)')
plt.grid(True)

plt.tight_layout()
plt.show()
