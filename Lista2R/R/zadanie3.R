# wczytanie pliku csv do data frame
data <- read.csv("data/heart_disease_dataset.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)
data$Disease <- as.logical(data$Disease)

set.seed(42)
n <- nrow(data)
indeks <- sample(1:n, size = floor(0.7*n)) # losuje 70% wierszy

train_df <- data[indeks,] # dane do treningu
test_df <- data[-indeks,] # dane do testowania

cat("Liczba obserowacji w zbiorze treningowym: ",nrow(train_df),"\n")
cat("Liczba obserowacji w zbiorze testowym: ",nrow(test_df),"\n")

# definicja formuly - rownanie regresji
formula_modelu <- data$Disease ~ data$Age + data$Sex + data$Serum.cholesterol.in.mg.dl + data$Maximum.heart.rate.achieved + data$Exercise.induced.angina + data$Resting.blood.pressure

# wywolanie glm na zbiorze treningowym
model_logit <- glm(formula = formula_modelu, data = train_df, family = binomial(link = "logit"))

# podsumowanie modelu
summary(model_logit)

# wyciagniecie wspolczynniku beta
beta_est <- coef(model_logit)

# obliczanie ilorazu szans
odds_ratios <- exp(beta_est)

# przedzialy ufnosci
confint_logit <- confint(model_logit)
confint_OR <- exp(confint_logit)

wyniki_OR <- data.frame(
  Variable = names(beta_est),
  Beta = beta_est,
  OddsRatio = odds_ratios,
  CI_lower_OR = confint_OR[,1],
  CI_upper_OR = confint_OR[,2]
)

wyniki_OR


# predykcja prawdopodobienstw dla zbioru testoewgo



















