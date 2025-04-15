import numpy as np
import matplotlib.pyplot as plt

# -------------------------------
# 1. Definicja sygnałów

# Długość sygnału oraz os czasu
N = 512  # liczba próbek
t = np.linspace(0, 1, N, endpoint=False)

# Sygnały:
x = np.cos(2 * np.pi * 50 * t)
h = np.sin(2 * np.pi * 30 * t)

# -------------------------------
# 2. Splot w dziedzinie czasu

y_conv = np.convolve(x, h, mode='full')

# -------------------------------
# 3. Zastosowanie twierdzenia o splotu
L = len(x) + len(h) - 1

# FFT dla obu sygnalow
X = np.fft.fft(x, L)
H = np.fft.fft(h, L)

# FFT splotu = iloczyn FFT:
Y_freq = X * H

# Odwrotna FFT
y_ifft = np.fft.ifft(Y_freq)

# -------------------------------
# 4. Porównanie wyników

# Różnica pomiędzy splotem a wynikiem z IFFT
error = np.linalg.norm(y_conv - y_ifft.real)
print("Norma różnicy (błąd) pomiędzy splotami:", error)

# -------------------------------
# 5. Wizualizacja wyników

plt.figure(figsize=(12, 10))

# Wykres sygnału x(t)
plt.subplot(4, 1, 1)
plt.plot(t, x, label="x(t) - cos(2π·50t)")
plt.title("Sygnał x(t)")
plt.xlabel("Czas [s]")
plt.ylabel("Amplituda")
plt.legend()
plt.grid(True)

# Wykres sygnału h(t)
plt.subplot(4, 1, 2)
plt.plot(t, h, label="h(t) - sin(2π·30t)", color='orange')
plt.title("Sygnał h(t)")
plt.xlabel("Czas [s]")
plt.ylabel("Amplituda")
plt.legend()
plt.grid(True)

# Splot klasyczny
plt.subplot(4, 1, 3)
plt.plot(np.arange(len(y_conv)), y_conv, label="Splot (np.convolve)", color='blue')
plt.title("Splot sygnałów x(t) i h(t) - metoda bez FFT")
plt.xlabel("Numer próbki")
plt.ylabel("Amplituda")
plt.legend()
plt.grid(True)

# Splot uzyskany za pomocą FFT (IFFT)
plt.subplot(4, 1, 4)
plt.plot(np.arange(len(y_ifft)), y_ifft.real, label="IFFT z FFT(x)*FFT(h)", color='red')
plt.title("Splot sygnałów x(t) i h(t) - metoda z zastosowaniem twierdzenia o splocie")
plt.xlabel("Numer próbki")
plt.ylabel("Amplituda")
plt.legend()
plt.grid(True)

plt.tight_layout()
plt.show()
