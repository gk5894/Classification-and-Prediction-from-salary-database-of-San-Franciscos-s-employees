# Classification and Prediction from salary database of San-Francisco's employees

## *Abstract*

### Analysis of Salaries in San Francisco

We are proposing an analysis by classification and clustering of the citizens based on the salaries they are earning in San Francisco. One way to recognize how a city government works is by looking at who it employs and how its employees are   compensated. This data contains the names, job title, and compensation for San Francisco city employees on an annual basis from 2011 to 2014. The positions studied span a wide range of duties and responsibilities. We have tried and tested different models of the dataset to classify the different jobs into some generalized categories. We have plotted some graphs from the dataset which gives us the basic idea about where to focus on in the entire dataset. By using classification techniques like KNN and Logistic regression wetried classifying the employees in male or female based on their income in various categories. Principle Component analysis was used to do dimension reduction on the dataset. By doing this analysis we have managed to highlight some trends in the salaries distributed amongst the employees of a metropolitan city. The focus of this analysis was to showcase this trends and stats for further study of appropriately compensating the employees of any metropolitan city.

# Introduction

A new study by the finance site GOBankingRates discovers that of the 50 most populous cities in the country, San Francisco requires the most income to reach a comfort level determined by the 50-30-20 budgeting rule. Under the rule, 50 percent of income covers necessities, 30 percent covers discretionary items and 20 percent is for savings. If your income is sufficient to cover your cost-of-living expenses, you can live comfortably.

The study found that you would need to earn $110,357 to achieve that goal in San Francisco — more than New York, Honolulu or Washington, D.C. In fact, the three largest cities in the Bay Area ranked in the top four: San Jose was second ($87,153); New York third ($86,446) and Oakland fourth ($80,438).

New York City joined Philadelphia and Massachusetts in passing legislation that will ban employers from asking job applicants about their salary history, in an attempt to narrow the wage gap between women and men. More than 20 other cities and states including San Francisco and California have similar legislation in the works. The goal is to prevent gender discrimination
from being passed from one workplace to the next by basing an employee’s pay on his or her prior salary.

These statistics inspired us to study on the actual data for getting into those intricate details and discovering some of the undiscovered facts from the dataset.

Another study, by Attom Data Solutions in January, calculated that renters in the Marin County/San Francisco metro area will spend more than 77 percent of their salary, on average, to pay rent in 2017. The national average is 38.7 percent.


## Problem Description

* We have a taken a database which consists of employee names, Job titles, base pay and
various aspects related to them. It includes the overtime pay, benefits and date.

* These variables are further cleaned and categorized for further classification.  
* Before starting the actual analysis, a lot of cleaning needs to be done on the data.  
* The cleaning process includes removing the variables which are unnecessary, and removing the null values.  
* There are also some missing values which needs to be replaced.  
* Dimensional Reduction was performed to select the specific variables which showed high Eigen values.  
* The jobtitles given in the data are too specific and varied which cannot be used to classify the data, so we have to categorize it further.  
* Similarly, our analysis is mainly based on the Gender of the employees so we need to find the Gender of the employees. We have used the first names of the employees to find their

#### Gender.  
* Using the Job Title, Gender and salaries of the Employees we have applied KNN and Logistic Regression algorithms to them.  
* In KNN the half of the data was used to train the system and half of the data was used to test the accuracy of the system.  
* Among KNN and Logistic Regression the algorithm which shows the most accuracy will be chosen.

#### Evaluation of Database
* This is the sample of data which we are using. The data consists of 11 variables, from which we have used the variables which were the most important for our classification.

* The most important variables were the Employee name, Job Title and the Total Pay. Stevens Institute of Technology – Fall 2017 3 Multivariate Data Analysis BIA-652

#### Analysis of Salaries in San Francisco
* We used the Employee name to find the Gender of the employees which was further used to classify the employees based on gender.

* We have used the Job Title and further categorized the it into more specific Jobs. Like all the Jobs in the Fire fighter and Museum guard were put in the Public Services.

* We have removed some of the columns in the data as it was not that important and the missing values.

#### Data Processing and Preparation
* In the data, the Gender of the Employees was not available, so to find the Gender of the Employees we have used the Gender package in R.

* In this the name of the Employee is split in First and Last name. Based on the First name the package assigns the Gender to the name.

* Like from the example provided we can see that the name Katherine Mak is split in two parts “Katherine” and “Mak”. Here “Katherine” is the first name, from this name the Gender of the person is predicted and Katherine is assigned as female.

* Similarly, in the second example based on the name Alexander the gender is assigned as male.

* Here from the example we see that there are many different Job Titles which needs to be categorized further.

* There are Job Titles as Automotive Mechanic, IS Engineer-Senior, etc which are further categorized into STEM.

* Similarly, the other remaining Jobs are categorized into Healthcare, Police/Law and Security, Public Services and Transit/Transportation.

* This has to be done as it is difficult to classify the Employees with their current Job Titles which are too specific and varied.

* For the analysis of the data we need the numeric values of the variables, so we have assigned numbers to the Job Titles.

* This was done using the grep function in R  

* For example, the STEM job title was assigned number 3 and similarly Healthcare was assigned number 2 and so on.

## Methods Used

PCA – Principle Component Analysis is a technique used to emphasized variation and bring out
strong patterns in a dataset. It’s often used to make data easy to explore and visualize.

We used PCA to apply dimension reduction on our dataset which will help us determine the most
significant variables among the 12 variables we had for representing the variations.

1. We used ‘prcomp’ package in R for implementing the PCA analysis on the data.
 
2. It performs a principal components analysis on the given data matrix and returns the results
 as an object of class.
 
3. We get the following result after the applying it on the normalized dataset.
 

1. By using the ‘$rotation’ we get to see the principal components for each variable.
 
2. By interpreting this output, we try to determine the most significant principle components.
 
3. To see the Eigen values, we print ‘p_var’ and get following values
 

Stevens Institute of Technology – Fall 2017 6 Multivariate Data Analysis BIA-652

Analysis of Salaries in San Francisco

1. By observing the Eigen values, we get a clue how many principle components should be
used for the final analysis.
 
2. We consider first 5 values since they seem to be the deciding factors.
 
3. We calculate proportion of variance and get the following results
 
4. Here we can clearly see the distribution of the proportion of variance.
 
5. By getting Cumulative Proportion of variance we get the following results.
 
6. Here we finalize that the first 5 principle components represent 98.76 % of the variations
in the data.
 

Stevens Institute of Technology – Fall 2017 7 Multivariate Data Analysis BIA-652

• Scree Plot of the Proportion of Variance

Analysis of Salaries in San Francisco

• Scree Plot of Proportion of Variance(Cumulative).

Stevens Institute of Technology – Fall 2017 8 Multivariate Data Analysis BIA-652

The curve
stabilizes after 5th
PC

Analysis of Salaries in San Francisco

Classification  
• KNN classification –

K nearest neighbors is a simple algorithm that stores all available cases and classifies
new cases based on a similarity measure (e.g., distance functions). KNN has been used
in statistical estimation and pattern recognition already in the beginning of 1970’s as a
non-parametric technique.

1. We used KNN as our first method to classify the workers in Male or Female based
on the salaries they were paid in the different categories.
 
2. ‘caret’ Library of R was used to apply KNN classification on the trained data.
 
3. We used ‘pca’ as preprocess as we have applied PCA on the dataframe earlier.
 
4. We also used method to be “repeatedcv” i.e. repeated Cross- Validation for greater
 accuracy.
 
5. We got the following graph after running the code.
 

Stevens Institute of Technology – Fall 2017 9 Multivariate Data Analysis BIA-652

Analysis of Salaries in San Francisco

1. We get the following confusion matrix of KNN
 
2. By calculating the accuracy, we get  
Accuracy = ((10378+7016)/25827) *100 = 67.34 %
 

• Logistic Regression Classification –

Logistic regression is another technique borrowed by machine learning from the field of
statistics. It is the go-to method for binary classification problems (problems with two class
values).

Logistic regression is named for the function used at the core of the method, the logistic
function.  

The logistic function, also called the sigmoid function was developed by statisticians to
describe properties of population growth in ecology, rising quickly and maxing out at the
carrying capacity of the environment. It’s an S-shaped curve that can take any real-valued
number and map it into a value between 0 and 1, but never exactly at those limits.

1 / (1 + e^-value)

Where e is the base of the natural logarithms (Euler’s number or the EXP() function in your
spreadsheet) and value is the actual numerical value that you want to transform. Below is
a plot of the numbers between -5 and 5 transformed into the range 0 and 1 using the logistic
function.

1. We used Logistic regression as a second method to classify our results.
 
2. “caret” library we described earlier also contains the package to apply logistic
 regression on the trained dataset.
 
3. We use ‘glm’ method to do Logistic regression analysis on our data.
 
4. Here also we used repeated cross validation technique for better results.
 
5. We get the following confusion matrix after the process
 

Stevens Institute of Technology – Fall 2017 10 Multivariate Data Analysis BIA-652

Analysis of Salaries in San Francisco

6. We calculate the accuracy as before for Logistic regression
Accuracy = ((10864+5794/25827) *100 = 64.49 %

Comparing Accuracy’s

1. After performing the KNN classification and Logistic regression classification
techniques on the data we compared their accuracies side by side to highlight the
recommended method.
 
2. Accuracy = ((10378+7016)/25827) *100 = 67.34 % (KNN)
 
3. Accuracy = ((10864+5794/25827) *100 = 64.49 % (LR)
 
4. We can clearly see that accuracy of KNN is greater than that of the Logistic regression
 and hence it is recommended method for classification.
 

Stevens Institute of Technology – Fall 2017 11 Multivariate Data Analysis BIA-652

Analysis of Salaries in San Francisco

Plots and Graphs  
1. Gender box plot –

o This is a box plot representing the distribution of salaries between males and
females.

o Male employees earn significantly higher salaries in all 4 quartiles.  
o Female employees are concentrated in 48000-127000 salary category whereas
majority of the male employees are located in 75000-160000 category of annual

salaries.  
o The top most points represent the outliers in the plot.

Stevens Institute of Technology – Fall 2017 12 Multivariate Data Analysis BIA-652

Analysis of Salaries in San Francisco

2. Distribution of Managerial Jobs –

This plot describes the managerial jobs that are distributed amongst the male and female
employees in San Francisco. We used strings like ‘supervisor’, ‘manager’, ‘chief’,
‘director’ to separate leader’s jobs from that of other workers or team members.

We used following code to get the plot

o There are more leaders in male population of the workforce.  
o Whereas, more females are observed in the “Team members” category.
o This demonstrates uneven distribution of leadership roles in the city.

Stevens Institute of Technology – Fall 2017 13 Multivariate Data Analysis BIA-652

Analysis of Salaries in San Francisco

3. Distribution of Managerial Jobs (Salary Groups) -

Here we categorized the employees based on the salary groups as 0-50k, 100k-150k, and
so on. And we plotted a graph that demonstrates the distribution of this salary groups.

We used ‘cut’ function of R which divides the range of x into intervals and codes the
values in x according to which interval they fall. The leftmost interval corresponds to level
one, the next leftmost to level two and so on.

1. Here we can see managers are considerably paid higher than team member or lower
designation employees.
 
2. Most managers earn between 100k-150k salary group whereas the team members earn
50k-100k category.
 
3. This highlights the fact how unevenly the managers are paid in the organizations.
 

Stevens Institute of Technology – Fall 2017 14 Multivariate Data Analysis BIA-652

Analysis of Salaries in San Francisco

4. Sector Box Plot –

We had categorized the employees in 8 sectors based on their profession. We had very
diverse job titles so we had to categorize them into some sectors so as to carry out some
legitimate analysis. Following is the box plot generated from the data.

1. It is observed that ‘White collar’ jobs appear to be highest paying jobs in among
all other sectors.
 
2. “Public Services” people have more stable distribution throughout.
 
3. “Real Estate” people have most diverse distribution because of probably very
 unstable real estate price variations.
 
4. Most “Retail” sector jobs are under 100k which is also a noticeable fact.
 

Stevens Institute of Technology – Fall 2017 15 Multivariate Data Analysis BIA-652

Analysis of Salaries in San Francisco

5. Word Cloud of Jobs –  
o We developed word cloud of the people from the top 80% quartile of the total

income and displayed the job titles that come under that quartile.

o Second word cloud represents the lowest 20% quartile of the total income and
displayed the job titles that come under that quartile.

Stevens Institute of Technology – Fall 2017 16 Multivariate Data Analysis BIA-652

Analysis of Salaries in San Francisco

Conclusion

After studying and analyzing different trends and distribution of the salaries from the dataset, we
have come to the conclusion that the distribution of salaries is quite uneven in the city of San
Francisco. We observed how there is considerable difference in the salaries of the male and female
employees in the same sectors. Female employees were highly underpaid as compared to their
male counterparts in the same profession. We also saw the pay-gap between the managerial
positions and the team members of different professions which shows uneven payment in an
organization. Our final conclusion being that San Francisco needs to regulate the way their city’s
employees are compensated in order for everyone to be able to survive in the city peacefully.

Future Research

We have tried and highlighted the areas that the city of San Francisco needs to focus on and try to
improve the underpaid employees.

1. This will help them improve the overall economic condition of their administration. Better
lives for employees with appropriate salaries can be expected with some legislative
changes from the administration’s side.
 
2. Also, the gender-pay-gap can be reduced by proposing new rules for equal payment for
both genders.
 
3. Managing jobs salaries can be regulated to divert some of the cash flow towards the
underpaid sectors of the economy
 
4. The dataset can also be further used to discover how much bonuses the employees are
receiving from their respective sectors.
 
5. The facts like ‘How the employees are paid for overtime’ can also be explored from the
given dataset.
 
6. If we somehow get state tax data on these salaries we can probably get clearer picture of
the overall economic factors affecting the incomes.
 

References

https://www.kaggle.com/kaggle/sf-salaries
https://machinelearningmastery.com
http://www.sfchronicle.com/

http://www.sfgate.com/

https://www.glassdoor.com

Stevens Institute of Technology – Fall 2017 17 Multivariate Data Analysis BIA-652 
