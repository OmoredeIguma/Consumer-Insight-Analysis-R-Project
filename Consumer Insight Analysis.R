set.seed(1234)
df_raw<- read.csv("~/E-commerce.csv", 
                  na.strings = c("","NA"))

library(dplyr)
################ DATA CLEANING AND TRANSFORMATION ################

# Created a new data frame for data transformation
df <- df_raw

# Check for NA values
colSums(is.na(df_raw))

# Changed the column names the default case from to snake case for readability

library(janitor)

df <- df %>%
            clean_names()



#Re-coded Satisfaction Level column
df <- df %>%
            mutate(Satisfaction_Level_Coded = case_when(
            satisfaction_level == "Unsatisfied" ~ "0",
            satisfaction_level == "Neutral" ~ "1",
            satisfaction_level == "Satisfied" ~ "2"
            ))


# From the "DescTools" package, the function "Mode" was used to obtain the most occurring values so it can be used  to replace missing values in the satisfaction level column
library(DescTools)

Mode(df$Satisfaction_Level_Coded, na.rm = TRUE)



# Replaced missing data in the Satisfaction Level column with Satisfied
df$satisfaction_level[is.na(df$satisfaction_level)] <- "Satisfied"



# Created an age category variable column for a one-way ANOVA test and for descriptive statistics

df <- df %>%
            mutate(age_category = case_when(
            age >= 20 & age <= 29 ~ "20-29",
            age >= 30 & age <= 39 ~ "30-39",
            age >= 40 & age <= 49 ~ "40-49"
            ))


# Total spend not normally distributed (Histogram & QQ-Plot)
hist(df$total_spend, xlab = "Total Spend", main = "Histogram of Total Spend")

library(ggpubr)
ggqqplot(df$total_spend)

## Inverse Normal Distribution

# Rank the data set

total_spend_ranking <- rank(df$total_spend, 
                            na.last = "keep", 
                            ties.method = "average")

# Fractional ranking

fractional_rank <- (total_spend_ranking - 0.5) / sum(!is.na(total_spend_ranking))

total_spend_mean <- mean(df$total_spend)

total_spend_std_dev <- sd(df$total_spend)

IDF <- qnorm(fractional_rank, total_spend_mean, total_spend_std_dev)

# Adding the inverse normal distribution values to a new column
df["total_spend_transformed"] <- qnorm(fractional_rank, 
                                       total_spend_mean, 
                                       total_spend_std_dev)



# Total Spend now approximately normally distributed (Histogram & QQ-Plot)
hist(df$total_spend_transformed, 
     xlab = "Total Spend", 
     main = "Histogram of Total Spend Transformed")


ggqqplot(df$total_spend_transformed)



################ Descriptive Statistics ################

### Age Category
age_cat <- as.data.frame(table(df$age_category))

colnames(age_cat) <- c("Age_Category", "Frequency")

age_cat <- age_cat %>%
                      mutate(Percentage = round(case_when(
                        Age_Category == "20-29" ~ 69/350 * 100,
                        Age_Category == "30-39" ~ 223/350 * 100,
                        Age_Category == "40-49" ~ 58/350 * 100
                        ),digits = 1))

print(age_cat)



### Visualisation
library(sjPlot)

plot_frq(df$age_category,
         sort.frq = "desc",
          show.n = FALSE) +
  theme_minimal() +
  xlab("Age Category")



### GENDER

gen <- as.data.frame(table(df$gender))

colnames(gen) <- c("Gender", 
                   "Frequency")

gen <- gen %>%
  mutate(Percentage = round(case_when(
    Gender == "Female" ~ 175/350 * 100,
    Gender == "Male" ~ 175/350 * 100
  ), digits = 1))

print(gen)


### Visualisation

plot_frq(df$gender,
         sort.frq = "desc",
         show.n = FALSE) +
  theme_minimal() +
  xlab("Gender")



### MEMBERSHIP TYPE 

mem_type <- as.data.frame(table(df$membership_type))


colnames(mem_type) <- c("Membership_Type", "Frequency")

mem_type <- mem_type %>%
                        mutate(Percentage = round(case_when(
                        Membership_Type == "Bronze" ~ 116/350 * 100,
                        Membership_Type == "Gold" ~ 117/350 * 100,
                        Membership_Type == "Silver" ~ 117/350 * 100
                        ), digits = 1))
print(mem_type)


## Visualisation

plot_frq(df$membership_type,
         sort.frq = "desc",
         show.n = FALSE) +
  theme_minimal() +
  xlab("Membership Type")



### SATISFACTION LEVEL 

sat_lvl <- as.data.frame(table(df$satisfaction_level))

colnames(sat_lvl) <- c("Satisfaction_Level", "Frequency")

sat_lvl <- sat_lvl %>%
                      mutate(Percentage = round(case_when(
                      Satisfaction_Level == "Neutral" ~ 107/350 * 100,
                      Satisfaction_Level == "Satisfied" ~ 127/350 * 100,
                      Satisfaction_Level == "Unsatisfied" ~ 116/350 * 100
                      ), digits = 1))
print(sat_lvl)


## Visualisation
plot_frq(df$satisfaction_level,
         sort.frq = "desc",
         show.n = FALSE) +
  theme_minimal() +
  xlab("Satisfaction Level")




################ K-Means Cluster Analysis ################

# Creating a different data frame with only the variables needed for clustering
k_means_df <- select(df, 
                     age, 
                     total_spend, 
                     items_purchased)


# Optimal number of clusters needed was 3 using the elbow method
library(factoextra)
fviz_nbclust(x = k_means_df, 
             FUNcluster = kmeans, 
             method = "wss") +
  labs(subtitle = "Elbow Method")


# K-means clustering using 3 clusters
K_Means_Clustering <- kmeans(k_means_df, 
                             centers = 3,
                             iter.max = 50, 
                             nstart = 25)
print(K_Means_Clustering)

# Visualization of the K-Means Clusters
fviz_cluster(K_Means_Clustering, 
             data = k_means_df)

# Saving the cluster membership to the data set
df["cluster_membership"] <- K_Means_Clustering$cluster

# Classifying the clusters
df <- df %>%
  mutate(cluster_membership = case_when(
    cluster_membership == 1 ~ "Slightly older, moderate-spenders",
    cluster_membership == 2 ~ "Younger high-spenders",
    cluster_membership == 3 ~ "Older low-spenders"
  ))


######### Chi-Square Test for Independence (Gender & Membership Type) #########

tab_xtab(
  var.row = df$gender,
  var.col = df$membership_type,
  show.row.prc = TRUE,
  show.exp = TRUE,
  tdcol.n = "black",
  tdcol.row = "black",
  tdcol.expected = "black",
  title = "Crosstabulation between Gender and Membership Type"
)






## Visuals

gender_member_viz <- plot_xtab(
  x = df$membership_type,
  grp = df$gender,
  margin = "col",
  bar.pos = "dodge",
  show.summary = FALSE,
  coord.flip = FALSE,
  show.total = FALSE,
  show.prc = TRUE,
  show.n = FALSE,
  title = "Percentage of Gender by Membership Type"
) +
  theme_minimal() +
  xlab("Membership Type") +
  scale_fill_manual(values = c("Female" = "pink",
                               "Male" = "lightblue"))

gender_member_viz$data = gender_member_viz$data[gender_member_viz$data$prc!= 0,]

print(gender_member_viz)

######### One-Way Analysis of Variance (Total Spend by Age Category) ######### 

### ANOVA Descriptive
anova_descriptive <- df %>%
  group_by(age_category) %>%
  summarise(n = n(),
            Mean = round(mean(total_spend), 2),
            Standard_Deviation = round(sd(total_spend), 2))



anova_descriptive <- anova_descriptive %>%
  mutate(Variance = round(case_when(
    Standard_Deviation == 378.66 ~ sqrt(378.66),
    Standard_Deviation == 338.43 ~ sqrt(338.43),
    Standard_Deviation == 15.28 ~ sqrt(15.28)
  ), 2))


print(anova_descriptive)



### Changed Age_Category Variable to a Factor Variable
df$age_category <- as.factor(df$age_category)



### ANOVA model building 
library(rstatix)

welch_anova <- df %>%
                    welch_anova_test(total_spend ~ age_category) %>%
                    mutate( p = case_when(
                            p <0.001 ~ "<0.001"
                            )) %>%
                    mutate(across(c(3:5), round, 2))


print(welch_anova)



### Effect size for the one-way anova
library(effectsize)

anova_effect <- epsilon_squared(aov(total_spend ~ age_category,
                                    data = df)) %>%
  mutate(across(c(2:4), round, 2))

print(anova_effect)



# Post-hoc test (Games-Howell Test)
post_hoc <- df %>%
  games_howell_test(total_spend ~ age_category) %>%
  mutate(p.adj = case_when(
    p.adj <0.001 ~ "<0.001"
  )) %>%
  mutate(across(c(4:6), round, 2))

print(post_hoc) 


### Visual representation of the anova result
box_plot_visual <- boxplot(df$total_spend ~ df$age_category,
                           main = "Total Spend per Age Category",
                           xlab = "Age Category",
                           ylab = "Total Spend")




###### Ch-Square Test for Independence (Membership Type vs Satisfaction Level) ######

tab_xtab(
  var.row = df$membership_type,
  var.col = df$satisfaction_level,
  show.exp = TRUE,
  show.row.prc = TRUE,
  tdcol.n = "black",
  tdcol.expected = "black",
  tdcol.row = "black",
  title = "Crosstabulation between Membership Type and Level of Satisfaction"
)


### Post-hoc
std_residuals_mem_sat <- as.data.frame(round(chisq.test(df$membership_type,
                                                        df$satisfaction_level)$stdres, 1))


colnames(std_residuals_mem_sat) <- c("Membership Type",
                                     "Satisfaction Level",
                                     "Standardised Residuals")


print(std_residuals_mem_sat)

### Visualisation
member_satisfaction_viz <- plot_xtab(
                                      x = df$membership_type,
                                      grp = df$satisfaction_level,
                                      margin = "row",
                                      bar.pos = "dodge",
                                      coord.flip = FALSE,
                                      show.total = FALSE,
                                      show.n = FALSE,
                                      show.prc = TRUE,
                                      title = "Percentage of Membership Type by Level of Satisfaction",
                                      legend.title = "Satisfaction Level"
) +
  theme_minimal() +
  xlab("Membership Type") + 
  scale_fill_manual(values = c("Neutral" = "grey", 
                               "Satisfied" = "darkgreen", 
                               "Unsatisfied" = "darkred"))

member_satisfaction_viz$data = member_satisfaction_viz$data[member_satisfaction_viz$data$prc != 0 ,]

print(member_satisfaction_viz)

###### two-tailed t-Test (Total Spend by Discount Applied) ######

### Descriptive statistics

t_test_descriptive <- df %>%
  group_by(discount_applied) %>%
  summarise(n = n(),
            Mean = round(mean(total_spend_transformed), 2),
            Standard_Deviation =
              round(sd(total_spend_transformed), 2))



t_test_descriptive <- t_test_descriptive %>%
                                            mutate(Variance = case_when(
                                            Standard_Deviation == 461.18 ~ 
                                              round(sqrt(461.18), 2),
                                            Standard_Deviation == 213.59 ~ 
                                              round(sqrt(213.59), 2)
                                            ))


print(t_test_descriptive)



### T-TEST MODEL
t_test_model <- t_test(data = df, 
                       total_spend_transformed ~ discount_applied, 
                       var.equal = TRUE,
                       detailed = TRUE, 
                       conf.level = 0.95) %>%
                mutate_if(is.numeric, ~round(.,2))



print(t_test_model)


# Effect size for the t-test (Cohen's d)
t_test_effect <- cohens_d(data = df, 
                          total_spend_transformed ~ discount_applied,
                          var.equal = TRUE) %>%
                  mutate_if(is.numeric, ~round(.,2))



print(t_test_effect)



# Visualisation
boxplot(df$total_spend_transformed ~ df$discount_applied,
        main = "Total Spend by Discount Applied",
        xlab = "Discount Applied",
        ylab = "Total Spend")
