import numpy as np
import matplotlib.pyplot as plt

# -------------------------------
# 1. Generowanie przykładowego sygnału
t = np.linspace(0, 2 * np.pi, 500)
freq = 5
clean_signal = np.sin(freq * t)

# Generowanie szumu gaussowskiego
noise = np.random.normal(0, 0.5, size=t.shape)
signal = clean_signal + noise

# -------------------------------
# 2. Filtr średniej ruchomej

window_size = 20  # Rozmiar okna
# Okno filtru
window = np.ones(window_size) / window_size

# -------------------------------
# 3. Splot sygnału z oknem
filtered_signal = np.convolve(signal, window, mode='same')

# -------------------------------
# 4. Wizualizacja

plt.figure(figsize=(12, 6))
plt.plot(t, signal, label="Sygnał zaszumiony", alpha=0.6)
plt.plot(t, filtered_signal, label="Sygnał po filtracji (średnia ruchoma)", linewidth=2, color='red')
plt.xlabel("Czas")
plt.ylabel("Amplituda")
plt.title("Filtr dolnoprzepustowy - średnia ruchoma")
plt.legend()
plt.grid(True)
plt.show()
