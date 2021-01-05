library(bnlearn)
library(lavaan)
library(dagitty)

######################## DATA LOADING & PREPROCESSING #####################3

# Read dataset
df <- read.csv('Datasets/Dataset_Coeff_Estimation.csv')

# Add ordering to variables and change to numeric for bnlearn
df$Caffeine <- as.double(ordered(df$Caffeine, levels =c("0","1","2","3","4","5","6")))
df$Cannabis <- as.double(ordered(df$Cannabis, levels =c("0","1","2","3","4","5","6")))
df$Meth <- as.double(ordered(df$Meth, levels =c("0","1","2","3","4","5","6")))
df$Age <- as.double(ordered(df$Age, levels =c("18-24","25-34","35-44","45-54","55-64","65+")))
df$Education <- as.double(ordered(df$Education, levels=c("Left school before 16","Left school at 16","Left school at 17","Left school at 18","College or university dropout","Professional certificate/ diploma","University degree","Masters degree","Doctorate degree")))
df$Gender <- as.double(df$Gender)

# Inspect dataframe
df

# Fit model structure without specifying any constraints and visualize result
unconstrained_fit <- tabu(df)
plot(unconstrained_fit)

# Inspect fit
unconstrained_fit

# Compute BIC score
score(unconstrained_fit, df)

# In this unconstrained fit almost everything is caused by everything (bron bijzoeken waarom hij overfit).

#### Blacklist experiments ####

# Almost everything is connected. Connections to age and Gender (thank god) make 
# no sense. To fix this, we use independencies found in assignment 1 to blacklist some connections
blacklist <- data.frame(
  "from" = c(
    "Gender",
    "Age",
    rep("Escore",6), #1
    rep("Oscore",6), #2
    rep("Ascore",6), #3
    rep("Cscore",6), #4
    rep("Nscore",6), #5
    rep("Sensation_seeking",8), #6
    rep("Impulsive",7), #7
    rep("Education",9), #8
    rep("Caffeine",12), #9
    rep("Cannabis",12), #10
    rep("Meth",12) #11
    
  ),
  "to" = c(
    "Age",
    "Gender",
    "Oscore", "Ascore", "Cscore","Nscore", "Age", "Gender", #Escore
    "Escore", "Ascore", "Cscore","Nscore", "Age", "Gender", #Oscore
    "Escore","Oscore","Cscore","Nscore", "Age", "Gender", #Ascore
    "Escore","Oscore","Ascore","Nscore", "Age", "Gender", #Cscore
    "Oscore","Ascore","Cscore","Escore", "Age", "Gender", #Nscore
    "Oscore","Ascore","Cscore","Escore", "Nscore", "Age", "Gender", "Impulsive", #Sensation_seeking
    "Oscore","Ascore","Cscore","Escore", "Nscore", "Age", "Gender", #Impulsive
    "Oscore","Ascore","Cscore","Escore", "Nscore", "Age", "Gender", "Sensation_seeking", "Impulsive", #Education
    "Oscore","Ascore","Cscore","Escore", "Nscore", "Age", "Gender", "Sensation_seeking", "Impulsive", "Education", "Cannabis", "Meth", #Caffeine
    "Oscore","Ascore","Cscore","Escore", "Nscore", "Age", "Gender", "Sensation_seeking", "Impulsive", "Education", "Caffeine", "Meth", #Cannabis
    "Oscore","Ascore","Cscore","Escore", "Nscore", "Age", "Gender", "Sensation_seeking", "Impulsive", "Education", "Cannabis", "Caffeine" #Meth
  ))

blacklisted_fit_1 <- tabu(df, blacklist = blacklist, optimized = FALSE)
score(blacklisted_fit_1, df)
plot(blacklisted_fit_1)

blacklisted_fit_1

# Assume tests can be dependent
dependent_test_blacklist <- data.frame(
  from = c("Meth", "Cannabis", "Caffeine", "Sensation_seeking", "Impulsive", "Education", "Gender",
           "Meth", "Cannabis", "Caffeine", "Sensation_seeking", "Impulsive", "Education", "Age"), 
  to = c(rep("Age",7),
         rep("Gender",7)))

blacklisted_fit_2 <- tabu(df, blacklist = dependent_test_blacklist, max.iter = 10)
score(blacklisted_fit_2, df)
plot(blacklisted_fit_2)

# Blacklist from Lieuwe
loops2 <- data.frame(
  "from" = c(
    rep("Escore",2), 
    rep("Oscore",2), 
    rep("Ascore",2), 
    rep("Cscore",2), 
    rep("Nscore",2),
    rep("Sensation_seeking",2),
    rep("Impulsive",2),
    rep("Education",9),
    rep("Caffeine",10),
    rep("Cannabis",10),
    rep("Meth",10)
    
  ),
  "to" = c(
    "Age", "Gender",
    "Age", "Gender",
    "Age", "Gender",
    "Age", "Gender",
    "Age", "Gender",
    "Age", "Gender",
    "Age", "Gender",
    "Oscore","Ascore","Cscore","Escore", "Nscore", "Age", "Gender", "Sensation_seeking", "Impulsive",
    "Oscore","Ascore","Cscore","Escore", "Nscore", "Age", "Gender", "Sensation_seeking", "Impulsive", "Education",
    "Oscore","Ascore","Cscore","Escore", "Nscore", "Age", "Gender", "Sensation_seeking", "Impulsive", "Education",
    "Oscore","Ascore","Cscore","Escore", "Nscore", "Age", "Gender", "Sensation_seeking", "Impulsive", "Education"
  ))

blacklisted_fit_3 <- tabu(df, blacklist = loops2)
plot(blacklisted_fit_3)

##### Tabu list size experiments ####

