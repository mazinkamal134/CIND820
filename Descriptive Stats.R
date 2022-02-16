# install the required packages
install.packages("tidyverse")
install.packages("RODBC")
install.packages("dplyr")
install.packages("sqldf") 
# load the libraries
library("RODBC")
library("dplyr")
library("sqldf")
library("tidyverse")

# create and open SQL connection
conn <- odbcDriverConnect('driver={SQL Server};server=.;database=CIND820_Filtered;Trusted_Connection=true;')

# read the data using the sql connection
rest_data <- sqlQuery(conn, "SELECT * FROM dbo.BCRestaurants")
rev_data <- sqlQuery(conn, "SELECT * FROM dbo.BCRestaurantReviews")

# convert the date into a data frame
rest_data <- as.data.frame(rest_data)
rev_data <- as.data.frame(rev_data)

# Biz Stat
hist(rest_data$Stars, xlab = "Stars", main = "Rating Stars Distribution")
summary(rest_data$Stars)
summary(rest_data$ReviewCount)
par(mfrow=c(1,2))
boxplot(rest_data$ReviewCount, outline = FALSE)
boxplot(rest_data$ReviewCount, outline = TRUE)
par(mfrow=c(1,1))
pie(table(rest_data$PriceRange)[-5], main = "Price Range")

# Review Stat
summary(rev_data$Stars)
hist(rev_data$Stars, xlab = "Stars", main = "Review Stars Distribution")
boxplot(rev_data$Stars, main = "Review Star Rating Summary")
par(mfrow=c(1,2))
barplot(table(rev_data$Stars), main = "Review Star Rating", xlab = "Stars", ylab = "Count")
pie(table(rev_data$Stars))


# Creating a data frame for ggplot function
rev_stars_stat = as.data.frame(table(rev_data$Stars))

rev_stars_stat %>% ggplot(aes(Var1, Freq))+
  geom_col() +
  labs(title="Review Star Rating", x = "Stars", y = "Count")+
  geom_text(aes(label = Freq), nudge_y = -3000, color="white")

#sum(rev_stars_stat$Freq[rev_stars_stat$Var1 %in% c(4,5)])/sum(rev_stars_stat$Freq)

