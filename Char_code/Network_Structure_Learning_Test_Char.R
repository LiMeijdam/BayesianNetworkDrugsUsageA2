library(bnlearn)
data("learning.test")
fit <-pc.stable(learning.test)
plot(fit)


# Read in the .csv that was created during the preprocessing

df <- read.csv('/home/preclineu/chafra/Desktop/BayesianNetworkDrugsUsageA1-main/Datasets/Dataset_Prediction.csv')
head(df)


# Transforming the non numerical ordinal values to numerical values with ordering

# BNLearn wants all data to be a double so we will transform all data to doubles 

df$Caffeine <- as.double( ordered(df$Caffeine, levels =c("0","1","2","3","4","5","6")))
df$Cannabis <- as.double( ordered(df$Cannabis, levels =c("0","1","2","3","4","5","6")))
df$Meth <- as.double( ordered(df$Meth, levels =c("0","1","2","3","4","5","6")))
df$Age <- as.double( ordered(df$Age, levels =c("18-24","25-34","35-44","45-54","55-64","65+")))
df$Education <- as.double( ordered(df$Education, levels=c("Left school before 16","Left school at 16","Left school at 17","Left school at 18","College or university dropout","Professional certificate/ diploma","University degree","Masters degree","Doctorate degree")))


# BNLearn wants all data to be a double so we will transform all data to doubles 

df$Gender <- as.double(df$Gender) 
df$Nscore <- as.double(df$Nscore) 
df$Escore <- as.double(df$Escore) 
df$Oscore <- as.double(df$Oscore) 
df$Ascore <- as.double(df$Ascore) 
df$Cscore <- as.double(df$Cscore) 

# Confirm that all variables are succesfully transformed into doubles
str(df)

# We need to inform structure learning which loops are illogical given our background knowledge
loops <- data.frame(
  "from" = c(
             rep("Escore",6), 
             rep("Oscore",6), 
             rep("Ascore",6), 
             rep("Cscore",6), 
             rep("Nscore",6),
             rep("Sensation_seeking",7),
             rep("Impulsive",7),
             rep("Education",9),
             rep("Caffeine",12),
             rep("Cannabis",12),
             rep("Meth",12)
             
             ),
  "to" = c(
           "Oscore", "Ascore", "Cscore","Nscore", "Age", "Gender",
           "Escore", "Ascore", "Cscore","Nscore", "Age", "Gender",
           "Escore","Oscore","Cscore","Nscore", "Age", "Gender",
           "Escore","Oscore","Ascore","Nscore", "Age", "Gender",
           "Oscore","Ascore","Cscore","Escore", "Age", "Gender",
           "Oscore","Ascore","Cscore","Escore", "Nscore", "Age", "Gender",
           "Oscore","Ascore","Cscore","Escore", "Nscore", "Age", "Gender",
           "Oscore","Ascore","Cscore","Escore", "Nscore", "Age", "Gender", "Sensation_seeking", "Impulsive",
           "Oscore","Ascore","Cscore","Escore", "Nscore", "Age", "Gender", "Sensation_seeking", "Impulsive", "Education", "Cannabis", "Meth",
           "Oscore","Ascore","Cscore","Escore", "Nscore", "Age", "Gender", "Sensation_seeking", "Impulsive", "Education", "Caffeine", "Meth",
           "Oscore","Ascore","Cscore","Escore", "Nscore", "Age", "Gender", "Sensation_seeking", "Impulsive", "Education", "Cannabis", "Caffeine"
           ))
loops

fit_constraint_based <- pc.stable(df, blacklist = loops)
plot(fit_constraint_based)
fit_constraint_based

fit_score_based <- tabu(df, blacklist = loops)
plot(fit_score_based)

# lavaan


