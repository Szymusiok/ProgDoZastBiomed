# wczytanie pliku csv do data frame
data <- read.csv("data/heart_disease_dataset.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)

# 1 = mezczyzna, 0 = kobieta
# tworze tabele czestosci 2x2 - wiersze = plec, kolumny = choroba
tab_sex_disease <- table(data$Sex, data$Disease)
rownames(tab_sex_disease) <- c("Kobiety", "Mezczyzni")
colnames(tab_sex_disease) <- c("Brak choroby", "Choroba serca")

# obliczanie odsetka pacjentow z choroba
liczba_kobiet_chorych <- tab_sex_disease["Kobiety", "Choroba serca"]
liczba_kobiet_ogolem <- sum(tab_sex_disease["Kobiety", ])

liczba_mezczyzn_chorych <- tab_sex_disease["Mezczyzni", "Choroba serca"]
liczba_mezczyzn_ogolem <- sum(tab_sex_disease["Mezczyzni", ])

pct_kobiet_chorych <- 100*liczba_kobiet_chorych/liczba_kobiet_ogolem
pct_mezczyzn_chorych <- 100*liczba_mezczyzn_chorych/liczba_mezczyzn_ogolem

cat("Odsetek kobiet chorych na serce: ",round(pct_kobiet_chorych,2),"%\n")
cat("Odsetek mezczyzn chorych na serce: ",round(pct_mezczyzn_chorych,2),"%\n\n")

if(pct_kobiet_chorych >= pct_mezczyzn_chorych)
{
  roznica_proc <- pct_kobiet_chorych - pct_mezczyzn_chorych
  cat("W grupie kobiet jest o ", round(roznica_proc,2),"pp wiecej chorujacych na serce.\n")
} else
{
  roznica_proc <- pct_mezczyzn_chorych - pct_kobiet_chorych
  cat("W grupie mezczyzn jest o ", round(roznica_proc,2),"pp wiecej chorujacych na serce.\n")
}

# obliczanie sredniego cholesterolu za pomoca funkcji tapply() ktora dla wektora cholesterolu
# obliczy srednia a jako indeksy grupowania poda wektora plci i wektor choroby
sredni_chol_matrix <- tapply(data$Serum.cholesterol.in.mg.dl, INDEX = list(Sex = data$Sex, Disease = data$Disease), FUN = mean, na.rm = TRUE)
rownames(sredni_chol_matrix) <- c("Kobiety", "Mezczyzni")
colnames(sredni_chol_matrix) <- c("Bez choroby", "Z choroba")

sredni_chol_matrix


# rysowanie histogramu wieku osob z choroba
disease_df <- subset(data, Disease == "True")
hist_info <- hist(disease_df$Age,
     breaks = seq(from = min(disease_df$Age, na.rm = TRUE),
                  to = max(disease_df$Age, na.rm = TRUE),
                  by = 1),
     main = "Histogram wieku pacjentów z chorobą serca",
     xlab = "Wiek (lata)",
     ylab = "Liczba pacjentów",
     col = "salmon",
     border = "white")

# wektor dlugosci rowny liczbie przedzialow
counts <- hist_info$counts
# wektor zawierajacy granice przedzialow
breaks <- hist_info$breaks

# indeks najwyzej liczebnosci
ind_max <- which.max(counts)
dolna_granica_przedzialu <- breaks[ind_max]
gorna_granica_przedzialu <- breaks[ind_max+1]

cat("Najwieksza liczba pacjentow z choroba jest w przedzialu wiekowym:\n",
    dolna_granica_przedzialu, "-",gorna_granica_przedzialu, "lat (liczba obserwacji:",counts[ind_max],")\n")


# rysowanie wykresu pudelkowego
boxplot(data$Maximum.heart.rate.achieved ~ data$Disease,
        data = data,
        main = "Maksymalne tetno a obecnosc choroby serca",
        xlab = "Obecnosc choroby serca",
        ylab = "Maksymalne tetno (bpm)",
        names = c("Bez choroby", "Z choroba"),
        col = c("lightgreen","lightcoral"))


# wykres slupkowy czestosci wystepowania choroby serca w zaleznosci od obecnosci bolu dlawicowego podczas testu wysilkowego
tab_angina_disease <- table(data$Exercise.induced.angina, data$Disease)
rownames(tab_angina_disease) <- c("Bez anginy", "Z angina")
colnames(tab_angina_disease) <- c("Bez choroby", "Z choroba")

barplot(tab_angina_disease,
        beside = TRUE,
        legend.text = TRUE,
        args.legend = list(x = "topright",
                           legend = c("Bez choroby", "Z choroba")),
        col = c("lightblue", "tomato"),
        main = "Czestosc choroby serca w zaleznosci od obecnosci anginy",
        xlab = "Angina podczas wysilku",
        ylab = "Liczba pacjentow",
        names.arg = c("Bez anginy", "Z angina"))









