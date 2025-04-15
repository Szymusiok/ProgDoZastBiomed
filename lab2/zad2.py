import numpy as np
import matplotlib.pyplot as plt

# Parametry sygnału
f1 = 10   # Częstotliwość pierwszej składowej
f2 = 30   # Częstotliwość drugiej składowej
T = 1     # Czas trwania [s]

# ---------------------------
# 1. Idealne próbkowanie
# ---------------------------
fs_ideal = 1000                     # Wysoka częstotliwość próbkowania
t_ideal = np.arange(0, T, 1/fs_ideal)
signal_ideal = np.sin(2 * np.pi * f1 * t_ideal) + np.sin(2 * np.pi * f2 * t_ideal)

# Transformata Fouriera dla sygnału przy idealnym próbkowaniu
N_ideal = len(signal_ideal)
X_ideal = np.fft.fft(signal_ideal)
freq_ideal = np.fft.fftfreq(N_ideal, d=1/fs_ideal)
# Obliczenie amplitudy
amplitude_ideal = 2.0/N_ideal * np.abs(X_ideal[:N_ideal//2])

# ---------------------------
# 2. Próbkowanie z aliasingiem
# ---------------------------
fs_alias = 25                      # Niska częstotliwość próbkowania powodująca aliasing
t_alias = np.arange(0, T, 1/fs_alias)
signal_alias = np.sin(2 * np.pi * f1 * t_alias) + np.sin(2 * np.pi * f2 * t_alias)

# Transformata Fouriera dla sygnału z aliasingiem
N_alias = len(signal_alias)
X_alias = np.fft.fft(signal_alias)
freq_alias = np.fft.fftfreq(N_alias, d=1/fs_alias)
amplitude_alias = 2.0/N_alias * np.abs(X_alias[:N_alias//2])

# ---------------------------
# Rysowanie wykresów widma
# ---------------------------
plt.figure(figsize=(12, 6))

# Widmo dla idealnego próbkowania
plt.subplot(1, 2, 1)
plt.stem(freq_ideal[:N_ideal//2], amplitude_ideal, basefmt=" ")
plt.title("Widmo – idealne próbkowanie (fs = 1000 Hz)")
plt.xlabel("Częstotliwość [Hz]")
plt.ylabel("Amplituda")
plt.grid(True)

# Widmo dla próbkowania z aliasingiem
plt.subplot(1, 2, 2)
plt.stem(freq_alias[:N_alias//2], amplitude_alias, basefmt=" ")
plt.title("Widmo – aliasing (fs = 25 Hz)")
plt.xlabel("Częstotliwość [Hz]")
plt.ylabel("Amplituda")
plt.grid(True)

plt.tight_layout()
plt.show()

# ---------------------------
# Przebieg sygnałów
# ---------------------------
plt.figure(figsize=(12, 6))
plt.plot(t_ideal, signal_ideal, label='Idealne (fs=1000 Hz)', alpha=0.75)
plt.plot(t_alias, signal_alias, 'o-', label='Aliasing (fs=25 Hz)', alpha=0.75)
plt.title("Porównanie przebiegów czasowych")
plt.xlabel("Czas [s]")
plt.ylabel("Amplituda")
plt.legend()
plt.grid(True)
plt.show()
