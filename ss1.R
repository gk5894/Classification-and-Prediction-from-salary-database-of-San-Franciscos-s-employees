#loading or installing necessary packages

if (!require("ggplot2")) {
  install.packages("ggplot2", repos="http://cran.rstudio.com/") 
  library("ggplot2")
}

if (!require("reshape2")) {
  install.packages("reshape2", repos="http://cran.rstudio.com/") 
  library("reshape2")
}

if (!require("tm")) {
  install.packages("tm", repos="http://cran.rstudio.com/") 
  library("tm")
}

if (!require("RColorBrewer")) {
  install.packages("RColorBrewer", repos="http://cran.rstudio.com/") 
  library("RColorBrewer")
}

if (!require("wordcloud")) {
  install.packages("wordcloud", repos="http://cran.rstudio.com/") 
  library("wordcloud")
}

if (!require("dplyr")) {
  install.packages("dplyr", repos="http://cran.rstudio.com/") 
  library("dplyr")
}

if (!require("gender")) {
  install.packages("gender", repos="http://cran.rstudio.com/") 
  library("gender")
}

if (!require("tidyr")) {
  install.packages("tidyr", repos="http://cran.rstudio.com/") 
  library("tidyr")
}
library(scales)
library(stringr)
library(readr)

#Importing Dataset
df1 <- read.csv("/Users/grv/Desktop/652/Project/Salaries1.csv",header=T, na.strings="")

str(df)
summary(df)
df1 <- subset(df1, !is.na(EmployeeName) & !is.na(OvertimePay) & !is.na(OtherPay) &  !is.na(BasePay) & !is.na(JobTitle) & !is.na(Benefits))

#Removing empty/Unecessary Fields
df <- df1[c(2:10)]

#Separating First and Last name
salaries_e <- extract(df, EmployeeName, c("FirstName", "LastName"), "([^ ]+) (.*)", remove = FALSE)
salaries_e$GenderYear <- 2012

genderdf1 <- gender_df(salaries_e, name_col = "FirstName", year_col = "GenderYear", method = c("ssa", "ipums", "napp", "demo"))
salaries_g <- merge(salaries_e, genderdf1[ , c("name", "gender")], by.x="FirstName", by.y="name", all.x=TRUE, )
salaries_g$gender <- as.factor(salaries_g$gender)
salaries_g$GenderYear <- NULL

#Omitting fields with no Gender assigned
not_set_gender_fields <-salaries_g %>% select(EmployeeName, gender) %>% filter(is.na(gender)) %>% unique() %>% select(EmployeeName)

#Omitting fields with unrecognized sectors
not_set_sector_fields <- salaries_g %>% select(JobTitle,Sector) %>% filter(is.na(Sector)) %>% unique() %>% select(JobTitle)

#Categorizing Jobtitles
salaries_g[grep("police|sherif|probation|sergeant|investigator|guard|security|custodian|lawyer|judge|criminalist|criminal|COURT", salaries_g$JobTitle, ignore.case = TRUE), "Sector"] <- "POLICE/LAW n SECURITY"

salaries_g[grep("doctor|nurs|anesth|epidemiologist|psychologist|nutritionist|chemist|emergency med|pathologist|health|hlth|therapist|hospital|imaging|physician|orthopedic|pharm|dental|dentist|medical|ACUPUNCTURIST|radiologic| audiometrist|emergency|
                med|audiologist|Psychiatric", salaries_g$JobTitle, ignore.case = TRUE), "Sector"] <- "HEALTHCARE"

salaries_g[grep("science|biology|eng|biologist|engineer|automotive| metal|ngr|technician", salaries_g$JobTitle, ignore.case = TRUE), "Sector"] <- "STEM"

salaries_g[grep("training|teacher|exam|trainer|TRAINEE", salaries_g$JobTitle, ignore.case = TRUE), "Sector"] <- "EDUCATION"

salaries_g[grep("mta|transit|airport|captain", salaries_g$JobTitle, ignore.case = TRUE), "Sector"] <- "TRANSIT/TRANSPORTATION"

salaries_g[grep("clerk|retail|cashier|store|customer|purchaser|patrol", salaries_g$JobTitle, ignore.case = TRUE), "Sector"] <- "RETAIL"

salaries_g[grep("architect|estate|contract|cement|real prop", salaries_g$JobTitle, ignore.case = TRUE), "Sector"] <- "REAL ESTATE"

salaries_g[grep("tourism|sport|speaker|dj|vj|journalist|designer|art|media|cook|
                chef|barber|painter|carpenter|photographer|animal keeper|marketing |repairer|plumber|housekeeper|baker|curator| animal|machinist|roofer|gardener|commissioner|crafts|electrical|windowcleaner|worker|driver|repair|electrician|glazier|wire|
                communications|communication|planner| wharfinger|cement mason", salaries_g$JobTitle, ignore.case = TRUE), "Sector"] <- "SERVICES"

salaries_g[grep("energy", salaries_g$JobTitle, ignore.case = TRUE), "Sector"] <- "ENERGY"

salaries_g[grep("fire|firefighter|asphalt plant supervisor|mayor|govrnmt|affairs|museum|librarian|public|parking control officer|duty|street signs|water|city planning|asphalt|counselor|Marriage|PUBLIC SERVICE|TRAFFIC HEARING|cfdntal|TRAFFIC HEARING|PARK SECTION|child| municipal|attorney|METER READER", salaries_g$JobTitle, ignore.case = TRUE), "Sector"] <- "PUBLIC SERVICES"

salaries_g[grep("management|consultant|manager|admin|board of supervisors|secretary|assistant|asst|auditor|analyst|chief investment officer|director|accountant|account|board|dept head|dep dir| payroll",salaries_g$JobTitle, ignore.case = TRUE), "Sector"] <- "WHITE COLLAR"

salaries_g$Sector2 <- as.factor(salaries_g$Sector)

## Salaries Summary by Gender (Removing N/A)

salaries_g2 <- filter(salaries_g, TotalPayBenefits >0, !is.na(gender), !is.na(Sector2), )

#Assigning Numerical values to sectors
salaries_g2[grep("POLICE/LAW n SECURITY",salaries_g2$Sector, ignore.case = TRUE), "SectorN"] <- "1"
salaries_g2[grep("HEALTHCARE",salaries_g2$Sector, ignore.case = TRUE), "SectorN"] <- "2"
salaries_g2[grep("STEM",salaries_g2$Sector, ignore.case = TRUE), "SectorN"] <- "3"
salaries_g2[grep("EDUCATION",salaries_g2$Sector, ignore.case = TRUE), "SectorN"] <- "4"
salaries_g2[grep("TRANSIT/TRANSPORTATION",salaries_g2$Sector, ignore.case = TRUE), "SectorN"] <- "5"
salaries_g2[grep("RETAIL",salaries_g2$Sector, ignore.case = TRUE), "SectorN"] <- "6"
salaries_g2[grep("REAL ESTATE",salaries_g2$Sector, ignore.case = TRUE), "SectorN"] <- "7"
salaries_g2[grep("SERVICES",salaries_g2$Sector, ignore.case = TRUE), "SectorN"] <- "8"
salaries_g2[grep("ENERGY",salaries_g2$Sector, ignore.case = TRUE), "SectorN"] <- "9"
salaries_g2[grep("PUBLIC SERVICES",salaries_g2$Sector, ignore.case = TRUE), "SectorN"] <- "10"
salaries_g2[grep("WHITE COLLAR",salaries_g2$Sector, ignore.case = TRUE), "SectorN"] <- "11"

#Assigning Numerical values to Genders
salaries_g2[grep("male",salaries_g2$gender, ignore.case = TRUE), "GenderN"] <- "1"
salaries_g2[grep("female",salaries_g2$gender, ignore.case = TRUE), "GenderN"] <- "2"
salaries_g3 <- salaries_g2[c(5:11,15,16)]

#training testing for dataset with outliers
train_index <- sample(c(TRUE, FALSE), replace = TRUE, size = nrow(salaries_g3), prob = c(0.7, 0.3))

# split the data according to the train index
training <- as.data.frame(salaries_g3[train_index, ])
testing <- as.data.frame(salaries_g3[!train_index, ])
str(training)
training1<-training[,-9]

training1$BasePay = as.numeric(as.factor(training1$BasePay))
training1$OvertimePay = as.numeric(as.factor(training1$OvertimePay))
training1$OtherPay= as.numeric(as.factor(training1$OtherPay))
training1$Benefits = as.numeric(as.factor(training1$Benefits))
training1$TotalPay = as.numeric(as.factor(training1$TotalPay))
training1$TotalPayBenefits = as.numeric(as.factor(training1$TotalPayBenefits))
training1$Year = as.numeric(as.factor(training1$Year))
training1$SectorN = as.numeric(as.factor(training1$SectorN))

#Using inbuilt R package for PCA
prn_comp <- prcomp(training1,scale. = T)
names(prn_comp)

prn_comp$rotation

#Computing Standard Deviation of each principal component
stdev <- prn_comp$sdev

#Computing Variance (Eigen values)
p_var <- stdev^2
p_var

#Proportion of Variance
prop_var <- p_var*100/sum(p_var)
prop_var[1:9]

#Cumulative Variance
cvar <- cumsum(prop_var)
cvar

#Plotting Scree plot of Proportion of Variance 
plot(prop_var, xlab = "Principal Component",
     ylab = "Proportion of Variance",
     type = "b")

#Plotting Cumulative Scree plot of Variance
plot(cvar, xlab = "Principal Component",
     ylab = "Cumulative Proportion of Variance",
     type = "b")

training1$GenderN<-as.factor(training$GenderN)

library(caret)

#Classification and Prediction using KNN with PCA
pred_model_pca <- train(GenderN~., data=training, method = "knn", preProcess = "pca",
                   trControl = trainControl(preProcOptions = list(pcaComp = 5),
                   method = "repeatedcv", number = 5))

knn.probs=predict(pred_model_pca,testing,type="raw") 
table(knn.probs,testing$GenderN)
summary(pred_model_pca)
plot(pred_model_pca)

#Classification and Prediction using Logistic regression with PCA
pred_model_glm <- train(GenderN~., data=training, method = "glm", preProcess = "pca",
                  trControl = trainControl(preProcOptions = list(pcaComp = 5),
                  method = "repeatedcv", number = 5))

glm.probs=predict(pred_model_glm,testing,type="raw") 
table(glm.probs,testing$GenderN)
summary(pred_model_glm)


#Classification and Prediction using Logistic regression without PCA
pred_glm <- train(GenderN~., data=training, method = "glm")
model=predict(pred_glm,testing,type="raw") 
table(model,testing$GenderN)

#All tables
table(knn.probs,testing$GenderN)
table(glm.probs,testing$GenderN)
table(model,testing$GenderN)

#Boxplot of m/f
by(salaries_g2$TotalPayBenefits,salaries_g2$gender,summary)
qplot(x=gender, y=TotalPayBenefits, data=salaries_g2, geom='boxplot') + scale_y_continuous(labels = scales::dollar, breaks = c(50000, 100000, 150000, 200000, 250000))

## Data Enhancement Salary Groups (0-50K-100K-150K-200K)
sal_grp <- salaries_g2
sal_grp$SalaryGroup <- cut(salaries_g2$TotalPayBenefits, 
                               breaks = c(-Inf, 50000, 100000, 150000, 200000, Inf), 
                               labels = c("< 50,000", "50,000 - 100,000", "100,000 - 150,000", "150,000 - 200,000", ">200,000"), 
                               right = FALSE)
## Salaries Summary by Managerial Level via Gender
sal_grp <- sal_grp %>% 
  mutate(JobTitle = tolower(JobTitle)) %>% 
  mutate(Leaders = ifelse(grepl("supervisor|manager|chief|head|mayor|director", JobTitle), "Leaders", "Team_Members")) %>%
  mutate(Leaders = as.factor(ifelse(grepl("assistant", JobTitle), "Team_Members", "Leaders")))

### Gender 
ggplot(sal_grp, aes( x = Leaders, fill = gender)) + 
  geom_bar(position = "fill") + 
  scale_y_continuous(labels = scales::percent, breaks=seq(0,1,0.10)) + 
  labs(x="Managerial Level", y="Ratio", fill ="Gender", title = "General male/female ratio") + 
  theme_grey()

### Salary Groups
ggplot(sal_grp, aes( x = Leaders, fill = SalaryGroup)) + 
  geom_bar(position = "fill") + 
  scale_y_continuous(labels = scales::percent, breaks=seq(0,1,0.10)) + 
  labs(x="Managerial Level", y="Ratio", fill ="Salary group", title = "Salary groups ratio on different managerial levels") + 
  theme_grey()

## Salaries Summary by Sector and histogram
by(sal_grp$TotalPayBenefits,sal_grp$Sector2,summary)
q <- qplot(x=Sector2, y=TotalPayBenefits, data=sal_grp, geom='boxplot') + scale_y_continuous(labels = scales::dollar, breaks = c(50000, 100000, 150000, 200000, 250000))
q + theme(axis.text.x = element_text(angle = 90, hjust = 1))

##Graph for Common jobs in Top (80%) and Bottom(20%) quartile of TotalPayBenefits
library(wordcloud)
library(tm)
library(corpus)
Q80 = sal_grp %>%
  filter(TotalPayBenefits>=quantile(TotalPayBenefits,0.80))

jobcorpus <- Corpus(VectorSource(Q80$JobTitle))
jobcorpus <- tm_map(jobcorpus, PlainTextDocument)
jobcorpus <- tm_map(jobcorpus, removePunctuation)
jobcorpus <- tm_map(jobcorpus, removeWords, stopwords('english'))
wordcloud(jobcorpus, max.words = 100, random.order = FALSE,colors=brewer.pal(8, 'Dark2'))

Q20 = sal_grp %>%
  filter(TotalPayBenefits<=quantile(TotalPayBenefits,0.20))
jobcorpus <- Corpus(VectorSource(Q20$JobTitle))
jobcorpus <- tm_map(jobcorpus, PlainTextDocument)
jobcorpus <- tm_map(jobcorpus, removePunctuation)
jobcorpus <- tm_map(jobcorpus, removeWords, stopwords('english'))
wordcloud(jobcorpus, max.words = 100, random.order = FALSE,colors=brewer.pal(8, 'Dark2'))
