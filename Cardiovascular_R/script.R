#data <- read.csv("data.csv", sep = ",")
data <- read.csv(url("https://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.cleveland.data"), header = FALSE)


#----------
#PREPARATION DATA
#Renomer les colonnes
colnames(data) <- c("age","sex","cp","trestbps","chol","fbs","restecg","thalac","exang","oldpeak","slope","ca","thal","target")

#Nettoyer les données
data$target[data$target==2] <- 1
data$target[data$target==3] <- 1
data$target[data$target==4] <- 1

#suppression ligne
#data <- data[-1,] #supprime la premiere ligne
#data <- data[,-1] #supprime la premiere colonne

#valeur manquante
apply(data,2, anyNA) #1 sur les lignes, 2 sur les colonnes

valeur_manquantes <- c(which(data$thal %in% "?"),which(data$ca %in% "?"))
valeur_manquantes
data <- data[-valeur_manquantes,]

#codage type de données 
str(data)
## varibale qualitative
data$sex <- as.factor(data$sex)
data$cp <- as.factor(data$cp)
data$fbs <- as.factor(data$fbs)
data$restecg <- as.factor(data$restecg)
data$exang <- as.factor(data$exang)
data$slope <- as.factor(data$slope)
data$ca <- as.factor(data$ca)
data$thal <- as.factor(data$thal)
data$target <- as.factor(data$target)

##variable quantitative
data$age <- as.integer(data$age)
data$trestbps <- as.integer(data$trestbps)
data$chol <- as.integer(data$chol)
data$thalac <- as.integer(data$thalac)

#recodage des variables
levels(data$sex) <- c("Femme","Homme")
levels(data$cp) <- c("Angine stable","Angine instable","Autres douleurs","Asymptomatique")
levels(data$fbs) <- c("Non","Oui")
levels(data$restecg) <- c("Normal","Anomalies","Hypertrophie")
levels(data$exang) <- c("Non","Oui")
levels(data$slope) <- c("En hausse","Stable","En baisse")
levels(data$ca) <- c("Absence d'anomalie","Faible","Moyen","Elevé")
levels(data$thal) <- c("Non","Thal sous contrôle","Thal instable")
levels(data$target) <- c("Non","Oui")

str(data)



#-----------
#STATISTIQUE

#Indicateurs clés (qualitatif)
table(data$sex) #Effectif
prop.table(table(data$sex)) #Frequence
round(prop.table(table(data$sex)),4)*100 #Percentage

table(data$cp)
round(prop.table(table(data$cp)),4)*100

table(data$fbs) #Glycémie élevé
round(prop.table(table(data$fbs)),4)*100

table(data$restecg)
round(prop.table(table(data$restecg)),4)*100

table(data$thal)
round(prop.table(table(data$thal)),4)*100

table(data$target)
round(prop.table(table(data$target)),4)*100
