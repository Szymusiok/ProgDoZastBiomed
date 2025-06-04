# Generowanie wektora "wzrost" o dlugosci 1000 o sredniej 175 i odchyleniu 12
set.seed(123) # ziarno generatora, aby wyniki byly odtwarzalne
wzrost <- rnorm(n = 1000, mean = 175, sd = 12)

# statystyki opisowe:
srednia_wzrost <- mean(wzrost)
mediana_wzrost <- median(wzrost)
odch_std_wzrost <- sd(wzrost)

# wypisanie wynikow
cat("Srednia wzrostu: ", round(srednia_wzrost,2),"cm\n")
cat("Mediana wzrostu: ", round(mediana_wzrost,2),"cm\n")
cat("Odchylenie standardowe: ", round(odch_std_wzrost,2),"cm\n")

# histogram
hist(wzrost,
     breaks = 30, # liczba slupkow histogramu
     main = "Histogram: Wzrost (N=1000)",
     xlab = "Wzrost (cm)",
     ylab = "Czestosc",
     col = "lightblue",
     border = "white")

# obliczanie percentyli
percentyle <- quantile(wzrost, probs = c(0.25,0.50,0.75))
cat("25. percentyl: ",round(percentyle[1],2),"cm\n")
cat("50. percentyl: ",round(percentyle[2],2),"cm\n")
cat("75. percentyl: ",round(percentyle[3],2),"cm\n")

# obliczanie IQR
Q1 <- percentyle[1]
Q3 <- percentyle[3]

# dolna i gorna granica
dolna_granica <- Q1 - 1.5 * IQR_wzrost
gorna_granica <- Q3 + 1.5 * IQR_wzrost

cat("IQR: ",round(IQR_wzrost,2),"cm\n")
cat("Dolna granica: ",round(dolna_granica,2),"cm\n")
cat("Gorna granica: ",round(gorna_granica,2),"cm\n")

# wybranie obserwacji ponizej dolnej lub powyzej gornej granicy
outliery <- wzrost[wzrost < dolna_granica | wzrost > gorna_granica]

# Pokazanie ile jest takich wartosci i wypisanie 10 z nich
length(outliery)
sort(outliery)[1:10]

# przeprowadzenie testu na wygenerowanych danych czy srednia znaczaco rozni sie od 170cm?
test_t <- t.test(wzrost, mu = 170, alternative = "two.sided")
print(test_t)

# obliczenie prawdopodobienstwa ze wybrana osoba ma > 190cm metoda teoretyczna korzystajac z wlasciwosci rozkladu normalnego
p_teoretyczne <- 1 - pnorm(190, mean = 175, sd = 12)
cat("Teoretyczne prawdopodobienstwo: ", round(p_teoretyczne,4),"\n")







