# wczytanie pliku csv do data frame
data <- read.csv("data/heart_disease_dataset.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)

# zamiana ze stringa True na boolean wartosc
data$Disease <- as.logical(data$Disease)

set.seed(42)

# nie chcemy trenowac modelu na wszystkch danych dlatego 70% bierzemy do treningu a 30% do testu
n <- nrow(data)

indeks <- sample(1:n, size = floor(0.7*n)) # losuje 70% wierszy

train_df <- data[indeks,] # dane do treningu
test_df <- data[-indeks,] # dane do testowania

cat("Liczba obserowacji w zbiorze treningowym: ",nrow(train_df),"\n")
cat("Liczba obserowacji w zbiorze testowym: ",nrow(test_df),"\n")

# definicja formuly - rownanie regresji
formula_modelu <- Disease ~ Age + Sex + Serum.cholesterol.in.mg.dl + Maximum.heart.rate.achieved + Exercise.induced.angina + Resting.blood.pressure

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
pred_prob <- predict(object = model_logit, newdata = test_df, type = "response")
# konwersja przy progu 0.5
pred_klasa <- ifelse(pred_prob >= 0.5,1,0)

# sprawdzenie kilku pierwszych przewidywanych prawdopodobienstw
head(data.frame(
  Actual = test_df$Disease,
  PredP = round(pred_prob,3),
  PredClass = pred_klasa
))


# macierz pomylek
conf_mat <- table(
  Actual = test_df$Disease,
  Pred = pred_klasa
)

# obliczanie podstawowych miar (TN,FP,FN,TP)
TN <- conf_mat["FALSE", "0"]
FP <- conf_mat["FALSE", "1"]
FN <- conf_mat["TRUE", "0"]
TP <- conf_mat["TRUE", "1"]

accuracy <- (TP + TN)/sum(conf_mat)
sensitivity <- TP/(TP+FN)
specificity <- TN/(TN+FP)
precision <- TP/(TP+FP)
F1_score <- 2*(precision*sensitivity)/(precision+sensitivity)

# wypianie wartosci
cat("Miara jakosci klasyfikacja na zbiorze testowym\n")
cat("Dokladnosc ", round(accuracy,4),"\n")
cat("Czulosc: ", round(sensitivity, 4), "\n")
cat("Specyficznosc: ", round(specificity, 4), "\n")
cat("Precyzja: ", round(precision, 4), "\n")
cat("F1-score: ", round(F1_score, 4), "\n\n")

cat("Macierz pomylek\n")
print(conf_mat)

# rysujemy krzywa ROC aby zobaczyc jak model radzi sobie przy roznych progach odciecia
# ladowanie pakietu pROC
if(!require(pROC)){
  install.packages("pROC")
  library(pROC)

} else {
  library(pROC)
}

# tworze obiekt na podstawie prawdziwych wartosci oraz przewidywanych prawdopodobienstw
roc_obj <- roc(response = test_df$Disease, predictor = pred_prob)
auc_value <- auc(roc_obj)
cat("Pole pod krzywa ROC: ", round(auc_value,4),"\n")

# rysowanie tej krzywej
plot(roc_obj,
     main = paste("Krzywa ROC, AUC = ",round(auc_value,3)),
     col = "blue",
     lwd = 2)

# linia "strzalu" aby latwiej ocenic model
abline(a=0,b=1,col="gray",lty=2)








