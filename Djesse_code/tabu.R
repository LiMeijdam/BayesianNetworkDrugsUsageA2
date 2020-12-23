library(bnlearn)
library(lavaan)
library(dagitty)

# Read dataset
df <- read.csv('Datasets/Dataset_Coeff_Estimation.csv')

# Add ordering to variables and change to numeric for bnlearn
df$Caffeine <- as.numeric(ordered(df$Caffeine, levels =c("0","1","2","3","4","5","6")))
df$Cannabis <- as.numeric(ordered(df$Cannabis, levels =c("0","1","2","3","4","5","6")))
df$Meth <- as.numeric(ordered(df$Meth, levels =c("0","1","2","3","4","5","6")))
df$Age <- as.numeric(ordered(df$Age, levels =c("18-24","25-34","35-44","45-54","55-64","65+")))
df$Education <- as.numeric(ordered(df$Education, levels=c("Left school before 16","Left school at 16","Left school at 17","Left school at 18","College or university dropout","Professional certificate/ diploma","University degree","Masters degree","Doctorate degree")))
df$Gender <- as.numeric(df$Gender)

# Inspect dataframe
df

# Fit model structure without specifying any constraints and visualize result
unconstrained_fit <- tabu(df)
plot(unconstrained_fit)

# Inspect fit
unconstrained_fit

# Compute BIC score
score(unconstrained_fit, df)

# Almost everything is connected. Connections to age and Gender (thank god) make 
# no sense. To fix this, we can use blacklists to remove implausible connections
blacklist <- data.frame(
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

blacklisted_fit <- tabu(df, blacklist = blacklist)
plot(blacklisted_fit)

# Score
score(blacklisted_fit, df)

# Increase tabu list size to see how this affects the model
increased_tabu <- tabu(df, blacklist = blacklist, max.tabu = 3)
plot(increased_tabu)

# Score. Resulting network is exactly the same
score(increased_tabu, df)

# Try to convert this model to lavaan
g <- dagitty('dag { Age Escore Caffeine Gender Nscore Oscore Ascore Cscore Impulsive Sensation_seeking Education Cannabis Meth Age -> Gender Age -> Nscore Gender -> Nscore Age -> Oscore Gender -> Oscore Gender -> Ascore Age -> Cscore Gender -> Cscore Gender -> Impulsive Nscore -> Impulsive Escore -> Impulsive Oscore -> Impulsive Ascore -> Impulsive Cscore -> Impulsive Age -> Sensation_seeking Gender -> Sensation_seeking Escore -> Sensation_seeking Oscore -> Sensation_seeking Ascore -> Sensation_seeking Impulsive -> Sensation_seeking Gender -> Education Oscore -> Education Cscore -> Education Sensation -> Education Age -> Cannabis Gender -> Cannabis Education -> Cannabis Escore -> Cannabis Oscore -> Cannabis Cscore -> Cannabis Sensation -> Cannabis Age -> Meth Gender -> Meth Education -> Meth Nscore -> Meth Escore -> Meth Oscore -> Meth Ascore -> Meth Sensation -> Meth }')
plot(increased_tabu_dagitty)

M <- lavCor(df, cor.smooth=TRUE)
model1 <- toString(g,"lavaan")
msem <- lavaan(model1, sample.cov=M, sample.nobs=nrow(df),estimator="ML", auto.var=TRUE, fixed.x = FALSE)
model1
