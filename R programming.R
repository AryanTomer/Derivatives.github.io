getwd()
setwd('C:/Users/ENVY/OneDrive/Desktop/Bhav copy nov - feb')
# Firstly, combine all the files together
dataset_bhavcopy <- list.files(pattern = '.csv')
data_frame <- lapply(dataset_bhavcopy, read.csv)
combined_dataset <- do.call(rbind, data_frame)
# use library(dplyr) to filter data seamlessly
library(dplyr)
# Filter rows containing specific objects ("BERGEPAINT" or "ASIANPAINT")
sample1 <- combined_dataset %>%
  filter(SYMBOL %in% c("BERGEPAINT", "ASIANPAINT"))
filtered_data <- filter(sample1,INSTRUMENT=="OPTSTK")
arranged_data <- arrange(filtered_data, TIMESTAMP)
Asian_paints <- filter(arranged_data, SYMBOL=="ASIANPAINT")
Berger_paints <- filter(arranged_data, SYMBOL=="BERGEPAINT")
# After filtering data according to the needs, clean the data using select()
Asian_data_final <- Asian_paints %>%
  select(STRIKE_PR,OPTION_TYP,OPEN_INT,TIMESTAMP)
Berger_data_final <- Berger_paints %>%
  select(STRIKE_PR,OPTION_TYP,OPEN_INT,TIMESTAMP)
head(Berger_data_final)
# use write.csv to export the data frame into your system
write.csv(Asian_data_final,file="ASIANPAINT_PCR_data.csv")
write.csv(Berger_data_final,file="BERGERPAINTS_PCR_data.csv")
head(combined_dataset)
# now, create another variable future_stock for another data frame and repeat the same process
future_stock <- combined_dataset %>%
  filter(SYMBOL %in% c("BERGEPAINT", "ASIANPAINT","NIFTY"))
futurestock <- filter(future_stock,INSTRUMENT=="FUTSTK")
rm(futurestock)
futurestock <- future_stock %>%
  filter(INSTRUMENT %in% c("FUTSTK","FUTIDX"))
Asian_berger_Nifty_future <- futurestock %>%
  select(INSTRUMENT,SYMBOL,EXPIRY_DT,OPTION_TYP,CLOSE,OPEN_INT,TIMESTAMP)
write.csv(Asian_berger_Nifty_future,file="ASIAN_BERGER_NIFTY.csv")
