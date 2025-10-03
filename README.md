# E-commerce-Consumer-Behavior-R-PROJECT
# Overview
This project explores the E-commerce Customer Behaviour Dataset provided on [Kaggle by Laksika Tharmalingam](https://www.kaggle.com/datasets/uom190346a/e-commerce-customer-behavior-dataset). This dataset provides a comprehensive view of customer behaviour within an e-commerce platform. Each entry in the dataset corresponds to a unique customer, offering a detailed breakdown of their interactions and transactions. The information is crafted to facilitate a nuanced analysis of customer preferences, engagement patterns, and satisfaction levels, enabling businesses to make data-driven decisions that enhance the customer experience. <br />

This repo contains the results from the analysis with a quick and easily digestible summary for non-technical audiences. A more detailed report with visualisations intended for technical audiences can be found [Here](https://omoredeiguma.github.io/Web-Hosting-R-E-Commerce.github.io/)

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

<img width="728" height="400" alt="Rplot" src="https://github.com/user-attachments/assets/b438969a-3ce7-4b12-bb1a-282920c26e58" />

<br />


There was an equal distribution of gender (50%). <br/ >

<img width="728" height="400" alt="genRplot" src="https://github.com/user-attachments/assets/584d42f0-db96-4297-b264-59916ec7fcc9" />
<br />


Bronze, silver, and gold membership subscribers were split evenly(33.4%), (33.4%) and (33.4%) respectively.  <br />

<img width="728" height="500" alt="Rplot01" src="https://github.com/user-attachments/assets/0381f711-5935-4b6b-819a-11f6f79162fb" />
 
<br />

The majority of the customers were satisfied (36.3%) <br />
<img width="728" height="500" alt="Rplot02" src="https://github.com/user-attachments/assets/17395cf8-3f95-4528-b9a6-e674d388da35" />



Objective 2: Three customer clusters were identified based on age, items purchased, and total spending:
* Cluster 1: Slightly older, moderate spenders 
* Cluster 2: Younger high-spenders
* Cluster 3: Older low-spenders
Younger customers tend to spend more; therefore, targeted promotions should focus on this high-spending group. For older customers (Cluster 2), marketing strategies should be developed to encourage more spending and larger purchases. accordingly​ <br />

<img width="728" height="360" alt="Clustering Rplot" src="https://github.com/user-attachments/assets/502366b9-0fd4-4a9f-a48a-a9226fae7685" /> <br />


Objective 3: A significant relationship was found between gender and membership type. Female customers are more likely to have Bronze memberships, while males are more likely to have Gold memberships. The company should focus on designing gender-specific membership upgrade strategies <br />

<img width="728" height="400" alt="Gender by Membership Type Rplot" src="https://github.com/user-attachments/assets/c74d76ac-b710-47ad-ba39-40397c82617c" /> <br/ >


Objective 4: Younger customers (20-29) tend to spend more than older ones. Marketing strategies such as loyalty programs and exclusive discounts could help retain these high-spending younger customers, while additional incentives may be needed to encourage spending in the older groups. <br />

<img width="728" height="400" alt="Total Spent by Age Category Rplot" src="https://github.com/user-attachments/assets/37d0ef5b-2dc3-485a-b9f7-d9baa8675e12" /> <br />


Objective 5: Gold members are more likely to report satisfaction, while Bronze and Silver members report lower satisfaction levels. The company should consider enhancing the experience for Bronze and Silver members to improve satisfaction and retention. <br />

<img width="728" height="400" alt="Membership Type by Satisfaction Rplot" src="https://github.com/user-attachments/assets/8df08629-23a4-43ca-b598-0b80001051b6" /> <br/ >


Objective 6: There was no significant difference in the total amount spent for Customers who received a discount ($821.40) and those who did not receive a discount ($868.99). This indicates that discounts do not affect the spending habits of consumers. <br />

<img width="728" height="400" alt="Total Spent by Discount Applied Rplot" src="https://github.com/user-attachments/assets/39001f2f-32ae-4bc5-9fe9-543013befb84" />

