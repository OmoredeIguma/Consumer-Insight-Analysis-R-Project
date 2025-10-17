# E-commerce-Consumer-Behavior-R-PROJECT
# Overview
This project explores the E-commerce Customer Behaviour Dataset provided on [Kaggle by Laksika Tharmalingam](https://www.kaggle.com/datasets/uom190346a/e-commerce-customer-behavior-dataset). This dataset provides a comprehensive view of customer behaviour within an e-commerce platform. Each entry in the dataset corresponds to a unique customer, offering a detailed breakdown of their interactions and transactions. The information is crafted to facilitate a nuanced analysis of customer preferences, engagement patterns, and satisfaction levels, enabling businesses to make data-driven decisions that enhance the customer experience. <br />

This repository contains the results from the analysis, along with a concise and easily digestible summary for non-technical audiences. A more detailed report with the same visualisations here and more, which is intended for technical audiences, which goes in-depth into the data cleaning process, explanation of the R code used for the generation of the results can be found [Here](https://omoredeiguma.github.io/Web-Hosting-R-E-Commerce.github.io/) <br />

The R script titled "Consumer Insight Analysis" can be found above.

Note: This dataset was synthetically generated for illustrative purposes, and any resemblance to real individuals or scenarios is coincidental. <br />

# Data Preparation
An age category variable measured on an ordinal scale was created using the Age variable. <br />
The descriptive statistics option was used to check for missing values in the dataset. The variable "Satisfaction level" had 2 missing cases, which were replaced using the mode (the most frequent). Furthermore, the variable Total Spent was not normally distributed in order to conduct an independent samples t-test, so an Inverse Normal Transformation was done to achieve normality.

# Objectives
Objective 1: Descriptive statistics for Age Category, Membership Type, and Satisfaction Level. This was achieved using frequency count, mean, and percentages. <br />

Objective 2: Customer Segmentation. This involved the use of the elbow method and K-means cluster analysis. The elbow method was used to determine the optimal number of clusters for the K-Means Cluster Analysis. <br />

Objective 3: Relationship Between Gender and Membership Type. This was achieved using a chi-square test for independence to examine if there is a significant relationship between gender and membership type. <br />

Objective 4: Relationship Between Demographics and Spending between the variables total spent and age category. This was achieved using a one-way analysis of variance test. <br />

Objective 5: Customer Satisfaction Analysis. This involved using a chi-square test for independence to examine if there is a significant relationship between satisfaction level and membership type. <br />

Objective 6: Effect of Discounts on Purchase Behaviour. This was achieved using an independent samples t-test to compare the average total spent between customers who received a discount versus those who did not. <br />

# Insights
Objective 1: From the descriptive statistics, of the 350 samples, 63.7% of the customers were in the age range 31-39, 19.7% were between 20-29, and 16.6% were between 40-49. <br />

<img width="728" height="500" alt="Age Category Rplot" src="https://github.com/user-attachments/assets/5b3a8474-e2ac-461f-a8ed-31537cb2237a" /> <br />


There was an equal distribution of gender (50%). <br/ >

<img width="728" height="500" alt="Gender Rplot" src="https://github.com/user-attachments/assets/bace699d-af5f-4707-b8bd-64767e85f6eb" /><br />


Bronze, silver, and gold membership subscribers were split evenly(33.4%), (33.4%) and (33.4%) respectively.  <br />

<img width="728" height="500" alt="Membership Type Rplot" src="https://github.com/user-attachments/assets/2fd3b04a-92ca-4053-8eda-3524403037c8" /> <br />

The majority of the customers were satisfied (36.3%) <br />
<img width="728" height="500" alt="Satisfaction Level Rplot" src="https://github.com/user-attachments/assets/e9a075fa-9e04-401b-916d-551d23f1778b" /> <br />




Objective 2: Three customer clusters were identified based on age, items purchased, and total spending:
* Cluster 1: Slightly older, moderate spenders 
* Cluster 2: Younger high-spenders
* Cluster 3: Older low-spenders
Younger customers tend to spend more; therefore, targeted promotions should focus on this high-spending group. For older customers (Cluster 2), marketing strategies should be developed to encourage more spending and larger purchases. accordingly​ <br />

<img width="728" height="360" alt="Clustering Rplot" src="https://github.com/user-attachments/assets/502366b9-0fd4-4a9f-a48a-a9226fae7685" /> <br />


Objective 3: A significant relationship was found between gender and membership type. Female customers are more likely to have Bronze memberships, while males are more likely to have Gold memberships. The company should focus on designing gender-specific membership upgrade strategies <br />

<img width="728" height="500" alt="Gender by Membership Type Rplot" src="https://github.com/user-attachments/assets/0df862a3-83a4-4586-86c4-3e27e2a5a44b" /> <br/ >


Objective 4: Younger customers (20-29) tend to spend more than older ones. Marketing strategies such as loyalty programs and exclusive discounts could help retain these high-spending younger customers, while additional incentives may be needed to encourage spending in the older groups. <br />

<img width="728" height="500" alt="Total Spent by Age Category Rplot" src="https://github.com/user-attachments/assets/ed633359-1571-4169-ab1f-cd7b83ee156c" />


 <br />


Objective 5: Gold members are more likely to report satisfaction, while Bronze and Silver members report lower satisfaction levels. The company should consider enhancing the experience for Bronze and Silver members to improve satisfaction and retention. <br />

<img width="728" height="500" alt="Membership Type by Satisfaction Rplot" src="https://github.com/user-attachments/assets/f1edf339-f77a-43d8-b151-734c479f59f8" /> <br/ >


Objective 6: There was no significant difference in the total amount spent for Customers who received a discount ($821.40) and those who did not receive a discount ($868.99). This indicates that discounts do not affect the spending habits of consumers. <br />

<img width="728" height="500" alt="Total Spent by Discount Applied Rplot" src="https://github.com/user-attachments/assets/fed8665c-766a-4dba-9717-f4217be90b46" />





