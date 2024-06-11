# Importation des donnees
data <- read.csv(url("https://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.cleveland.data"), header = FALSE)

# Modification du nom des colonnes
colnames(data) <- c("age", "sex", "cp", "trestbps", "chol", "fbs", "restecg", "thalach", "exang", "oldpeak", "slope", "ca", "thal", "target")

# Pretraitement de la colonne target
data$target[data$target==2] <- 1
data$target[data$target==3] <- 1
data$target[data$target==4] <- 1

# Suppression des valeurs manquantes
valeurs_manquantes_ca <- which(data$ca %in% "?")
valeurs_manquantes_thal <-which(data$thal %in% "?")
valeurs_manquantes <- c(valeurs_manquantes_ca, valeurs_manquantes_thal)
valeurs_manquantes
data <- data[-valeurs_manquantes,]

# Vérification du type des variables
str(data)

# Modification du type des variables

## Variables qualitatives (factor = variable qualitative)
data$sex <- as.factor(data$sex)
data$cp <- as.factor(data$cp)
data$fbs <- as.factor(data$fbs)
data$restecg <- as.factor(data$restecg)
data$exang <- as.factor(data$exang)
data$slope <- as.factor(data$slope)
data$ca <- as.factor(data$ca)
data$thal <- as.factor(data$thal)
data$target <- as.factor(data$target)

## Variables quantitatives
data$age <- as.integer(data$age)
data$trestbps <- as.integer(data$trestbps)
data$chol <- as.integer(data$chol)
data$thalach <- as.integer(data$thalach)

# Recodage des variables
levels(data$sex) <- c("Femme", "Homme")
levels(data$cp) <- c("Angine stable", "Angine instable", "Autres douleurs", "Asymptomatique")
levels(data$fbs) <- c("Non", "Oui")
levels(data$restecg) <- c("Normal", "Anomalies", "Hypertrophie")
levels(data$exang) <- c("Non", "Oui")
levels(data$slope) <- c("En hausse", "Stable", "En baisse")
levels(data$ca) <- c("Absence d'anomalie", "Faible", "Moyen", "Eleve")
levels(data$thal) <- c("Non", "Thalassemie sous controle", "Thalassemie instable")
levels(data$target) <- c("Non", "Oui")

# Verification du type des variables
str(data)

# Verification valeurs manquantes
apply(data, 2, anyNA)


# Indicateurs cles (variables qualitatives)

# Variable sex
table(data$sex) # Effectifs
prop.table(table(data$sex)) # Frequences
round(prop.table(table(data$sex)), 4) # Frequences arrondies
round(prop.table(table(data$sex)), 4)*100 # Pourcentages

# Variable cp
table(data$cp)
round(prop.table(table(data$cp)), 4)*100

# Variable fbs
table(data$fbs)
round(prop.table(table(data$fbs)), 4)*100

# Variable restecg
table(data$restecg)
round(prop.table(table(data$restecg)), 4)*100

# Variable exang
table(data$exang)
round(prop.table(table(data$exang)), 4)*100

# Variable slope
table(data$slope)
round(prop.table(table(data$slope)), 4)*100

# Variable ca
table(data$ca)
round(prop.table(table(data$ca)), 4)*100

# Variable thal
table(data$thal)
round(prop.table(table(data$thal)), 4)*100

# Variable target
table(data$target)
round(prop.table(table(data$target)), 4)*100

# Indicateurs cles (variables quantitatives)

## Minimum, quartiles, mediane, moyenne et maximum
summary(data$age)
summary(data$trestbps)
summary(data$chol)
summary(data$thalach)
summary(data$oldpeak)

## Variance et ecart-type
var(data$age)
sd(data$age)
var(data$trestbps)
sd(data$trestbps)
var(data$chol)
sd(data$chol)
var(data$thalach)
sd(data$thalach)
var(data$oldpeak)
sd(data$oldpeak)


# Diagrammes a barres (variables qualitatives)

## Variable sex
graph1 <- plot(data$sex,
               xlab = "Sexe",
               ylab = "Effectifs",
               main = "Repartition des patients selon le sexe",
               las = 1,
               # horiz = T
               sub = "Donnees : Heart Disease Data Set (UCI Machine Learning)",
               # names.arg = c("Feminin", "Masculin"),
               # space = 2
               # col = "red"
               col = c("#e63946", "#a8dadc"),
               # border = "blue",
               # density = 80,
               # yaxt = 'n'
               cex.main = 1.8,
               cex.axis = 1,
               cex.lab = 1.2,
               ylim = c(0, 250)
)
text(x = graph1, y = table(data$sex)+10, labels = as.character(table(data$sex)), cex = 1.1, font = 3)

## Variable cp
graph2 <- plot(data$cp,
               xlab = "Douleurs thoraciques",
               ylab = "Effectifs",
               main = "Repartition des patients selon les douleurs thoraciques",
               space = 0.3,
               col = c("#e63946", "#f1faee", "#a8dadc", "#457b9d"),
               cex.main = 1.5,
               cex.lab = 1.2,
               ylim = c(0,170)
)
text(x = graph2, y = table(data$cp)+7, labels = as.character(table(data$cp)), cex = 1.1, font = 3)

# Diagramme circulaire (variables qualitatives)

## Variable target
pie(table(data$target),
    main = "Repartition des patients selon l'apparition d'une maladie cardiovasculaire",
    clockwise = TRUE,
    col = c("#2a9d8f", "#f4a261"),
    cex.main = 1.2,
)

# Boite a moustaches (variables quantitatives)

## Variable age
boxplot(data$age,
        ylab = "Age",
        main = "Boite a moustache de la population selon l'age",
        col = "#e63946",
        las = 1,
        cex.main = 1.7,
        cex.lab = 1.2,
        sub = "Donnees : Heart Disease Data Set (UCI Machine Learning)",
        # horizontal = TRUE
        notch = TRUE,
        # border = "blue"
        ylim = c(20,80)
)

# Histogrammes (variables quantitatives)

## Variable trestbps
graph3 <- hist(data$trestbps,
               xlab = "Tension arterielle au repos",
               ylab = "Effectifs",
               main = "Repartition des patients selon la tension arterielle au repos",
               las = 1,
               sub = "Donnees : Heart Disease Data Set (UCI Machine Learning)",
               col = "lightslateblue",
               ylim = c(0,80),
               xlim = c(80,200),
               cex.main = 1.4,
               cex.lab = 1.2)
text(x = graph3$mids, graph3$counts, labels = graph3$counts, adj = c(0.5, -0.5))


# Diagramme a barres croises

## Variables target/sex
graph4 <- barplot(table(data$target, data$sex),
                  beside = TRUE,
                  col = c("#003049", "#d62828"),
                  xlab = "Sexe",
                  ylab = "Patients",
                  las = 1,
                  main = "Repartition des patents selon la presence d'une maladie cardiovasculaire \n et le sexe",
                  ylim = c(0,150),
                  cex.main = 1.2,
                  cex.lab = 1.2
)
legend("top", legend = levels(data$target), fill = c("#003049", "#d62828"), title = "Maladie cardiovasculaire", horiz = TRUE)
text(x = graph4, y = table(data$target, data$sex)+7, labels = as.character(table(data$target, data$sex)), cex = 1.1, font = 3)

# Boites a moustaches croisees

## Variable target/age
boxplot(data$age ~ data$target,
        main = "Boite a moustaches de la population selon l'age et la presence \n de maladie cardiovasculaire",
        xlab = "Presence d'une maladie cardiovasculaire",
        ylab = "Age",
        col = "yellow",
        las = 1,
        ylim = c(20, 80),
        cex.main = 1.2,
        cex.lab = 1.2
)

## Variable target/trestbps
boxplot(data$trestbps ~ data$target,
        main = "Boite a moustaches de la population selon la tension arterielle au repos \n et la presence de maladie cardiovasculaire",
        xlab = "Presence d'une maladie cardiovasculaire",
        ylab = "Tension arterielle au repos",
        col = "yellow",
        las = 1,
        cex.main = 1.2,
        cex.lab = 1.2
)

## Calcul des pourcentages
round(prop.table(table(data$sex, data$target), margin = 1), 4)*100
round(prop.table(table(data$cp, data$target), margin = 1), 4)*100
round(prop.table(table(data$fbs, data$target), margin = 1), 4)*100
round(prop.table(table(data$restecg, data$target), margin = 1), 4)*100
round(prop.table(table(data$exang, data$target), margin = 1), 4)*100
round(prop.table(table(data$slope, data$target), margin = 1), 4)*100
round(prop.table(table(data$ca, data$target), margin = 1), 4)*100
round(prop.table(table(data$thal, data$target), margin = 1), 4)*100

## Test du Khi-2 (variables qualitatives)
## H0 : Les deux variables sont independantes (si p-value > 0,05)
## H1 : Les deux variables sont dependantes (si p-value < 0,05)
chisq.test(data$sex, data$target)
chisq.test(data$cp, data$target)
chisq.test(data$fbs, data$target)
chisq.test(data$restecg, data$target)
chisq.test(data$exang, data$target)
chisq.test(data$slope, data$target)
chisq.test(data$ca, data$target)
chisq.test(data$thal, data$target)

## Calcul des moyennes
tapply(data$age, data$target, mean)
tapply(data$trestbps, data$target, mean)
tapply(data$chol, data$target, mean)
tapply(data$thalach, data$target, mean)
tapply(data$oldpeak, data$target, mean)

## Test de Shapiro-Wilk
### H0 : L'echantillon suit une distribution normale (si p-value > 0,05)
### H1 : L'echantillon ne suit pas une distribution normale (si p-value < 0,05)
library(dplyr)
shapiro.test(filter(data, target == "Oui")$age) # H1
shapiro.test(filter(data, target == "Oui")$trestbps) # H1
shapiro.test(filter(data, target == "Oui")$chol) # H0
shapiro.test(filter(data, target == "Oui")$thalach) # H0
shapiro.test(filter(data, target == "Oui")$oldpeak) # H1

## Test de Mann-Whitney
### H0 : Il n'y a pas de difference significative entre la moyenne des deux variables (si p-value > 0,05)
### H1 : Il y a une difference significative entre la moyenne des deux variables (si p-value < 0,05)
wilcox.test(data$age~data$target)
wilcox.test(data$trestbps~data$target)
wilcox.test(data$oldpeak~data$target)

## Test de Student
### H0 : Il n'y a pas de difference significative entre la moyenne des deux variables (si p-value > 0,05)
### H1 : Il y a une difference significative entre la moyenne des deux variables (si p-value < 0,05)
t.test(data$chol~data$target)
t.test(data$thalach~data$target)


# Modele de regression logistique

## Division du jeu de donnees en jeu d'entrainement et de test
set.seed(99)
library(caTools)
split = sample.split(data$target, SplitRatio = 0.8)
train = subset(data, split == TRUE)
test = subset(data, split == FALSE)

## Creation du modele
RegressionLogistique = glm(target ~., data = train, family = "binomial")
summary(RegressionLogistique)

## Optimisation du modele de regression logistique pour ne conserver que les variables significatives
RegressionLogistique = update(RegressionLogistique, .~.-restecg)
RegressionLogistique = update(RegressionLogistique, .~.-slope)
RegressionLogistique = update(RegressionLogistique, .~.-thal)
RegressionLogistique = update(RegressionLogistique, .~.-age)
RegressionLogistique = update(RegressionLogistique, .~.-fbs)
RegressionLogistique = update(RegressionLogistique, .~.-chol)
RegressionLogistique = update(RegressionLogistique, .~.-thalach)
# RegressionLogistique = update(RegressionLogistique, .~.-cp)
RegressionLogistique = update(RegressionLogistique, .~.-trestbps)
summary(RegressionLogistique)
# Critere AIC sans la variable cp : 202,23
# Critere AIC avec la variable cp : 177,71

## Predictions
prediction = predict(RegressionLogistique, test, type = "response")
prediction
tableau_prediction = as.data.frame(prediction)
creation_fonction = function(x){
  return(ifelse(x>0.5,1,0))
}
tableau_prediction = apply(tableau_prediction, 2, creation_fonction)

## Mesure des performances du modele
levels(test$target) <- c(0,1)
library(caret)
confusionMatrix(as.factor(test$target), as.factor(tableau_prediction))

## Tableau de comparaison
tableau_comparaison = cbind(test, tableau_prediction)
tableau_comparaison$prediction <- as.factor(tableau_comparaison$prediction)
levels(tableau_comparaison$target) <- c("Non", "Oui")
levels(tableau_comparaison$prediction) <- c("Non", "Oui")

## Test de Hosmer et Lemeshow
## H0 : L'ajustement du modele aux donnees est bon (si p-value > 0.05)
## H1 : L'ajustement du modele aux donnees est mauvais (si p-value < 0.05)
library(performance)
performance_hosmer(RegressionLogistique)

## Creation de la courbe ROC
library(pROC)
par(pty = "s")
roc(train$target, RegressionLogistique$fitted.values,
    plot = TRUE,
    main = "Courbe ROC du modele de regression logistique",
    col = "#377eb8",
    lwd = 4,
    xlab = "Taux de Faux Positifs",
    ylab = "Taux de Vrais Positifs",
    legacy.axes = TRUE
)

