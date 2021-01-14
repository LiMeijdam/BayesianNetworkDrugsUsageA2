library(bnlearn)
library(lavaan)
library(dagitty)

######################## DATA LOADING & PREPROCESSING #####################3

# Read dataset
df <- read.csv('Datasets/Dataset_Coeff_Estimation.csv')

# # Add ordering to variables and change to numeric for bnlearn
# df$Caffeine <- as.double(ordered(df$Caffeine, levels =c("0","1","2","3","4","5","6")))
# df$Cannabis <- as.double(ordered(df$Cannabis, levels =c("0","1","2","3","4","5","6")))
# df$Meth <- as.double(ordered(df$Meth, levels =c("0","1","2","3","4","5","6")))
# df$Age <- as.double(ordered(df$Age, levels =c("18-24","25-34","35-44","45-54","55-64","65+")))
# df$Education <- as.double(ordered(df$Education, levels=c("Left school before 16","Left school at 16","Left school at 17","Left school at 18","College or university dropout","Professional certificate/ diploma","University degree","Masters degree","Doctorate degree")))
# df$Gender <- as.double(df$Gender)

# After experimentation with and without ordering the class labels,
# We decided to order them because this resulted in more expressive path coefficients

df$Caffeine <- ordered(df$Caffeine, levels =c("0","1","2","3","4","5","6"))
df$Cannabis <- ordered(df$Cannabis, levels =c("0","1","2","3","4","5","6"))
df$Meth <- ordered(df$Meth, levels =c("0","1","2","3","4","5","6"))

# Age and Education have a certain ordinal ordering which we will make use of:

df$Age <- ordered(df$Age, levels =c("18-24","25-34","35-44","45-54","55-64","65+"))
df$Education <- ordered(df$Education, levels=c("Left school before 16","Left school at 16","Left school at 17","Left school at 18","College or university dropout","Professional certificate/ diploma","University degree","Masters degree","Doctorate degree"))

# We need our numerical data as doubles in order for the algorithm to accept them

df$Gender <- as.double(df$Gender) 
df$Nscore <- as.double(df$Nscore) 
df$Escore <- as.double(df$Escore) 
df$Oscore <- as.double(df$Oscore) 
df$Ascore <- as.double(df$Ascore) 
df$Cscore <- as.double(df$Cscore) 

# Inspect dataframe
str(df)

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

blacklisted_fit_1 <- tabu(df, blacklist = blacklist)
score(blacklisted_fit_1, df)
plot(blacklisted_fit_1)

blacklisted_fit_1

## Whitelisting
whitelist <- data.frame(
  "from" = c(
    rep("Gender", 5),
    rep("Age", 5)
  ),
  "to" = c(
    "Oscore","Ascore","Cscore","Escore", "Nscore",
    "Oscore","Ascore","Cscore","Escore", "Nscore"
  )
)

whitelist_fit_1 <- tabu(df, blacklist = blacklist, whitelist = whitelist)

## Whitelisting connections from age, gender to the respective scores slightly decreases the score
score(whitelist_fit_1, df)
plot(whitelist_fit_1)

#### Max iteration experiments ####
scores = vector()
for (iter in seq(1, 50)) {
  fit <- tabu(df, blacklist = blacklist, max.iter = iter)
  scores <- c(scores, score(fit, df))
}
plot(scores, type = "l", xlab="Iteration", ylab="BIC", col = "blue")
scores
# After 38 iterations the score doesn't improve any further -> -54363.56


##### Tabu list size experiments ####

# The size of the tabu list determines how repetitions of recent moves are allowed
# by the algorithm. The default value is 10.
scores = vector()
for (tabu_size in seq(1, 50)) {
  fit <- tabu(df, blacklist = blacklist, tabu = tabu_size,)
  scores <- c(scores, score(fit, df))
}
plot(scores, type = "l", xlab="Iteration", ylab="BIC", col = "blue")

blacklisted_fit_2 <- tabu(df, blacklist = blacklist, tabu=100, max.tabu = 10, max.iter = 20, score="loglik-g")
score(blacklisted_fit_2, df)
plot(blacklisted_fit_2)
plot(blacklisted_fit_1)







