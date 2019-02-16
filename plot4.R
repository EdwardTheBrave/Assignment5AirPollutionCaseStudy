#Question: 

#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# loading necessary libraries into the workspace
library(dplyr)
library(ggplot2)

# Reading the data (must be located on our working directory)
if(!exists("NEI")){
        NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
}
#we subset the SCC df so we only have Coal related information and we merge it with NEI df and group it by year, 
#retrieving the total emissions per combination and making some transformations

df <- SCC %>%
        filter(grepl('Coal', Short.Name)) %>%
        mutate(SCC = as.character(SCC)) %>%
        inner_join(NEI, by = 'SCC') %>%
        select(Emissions, Short.Name, year) %>%
        group_by(year) %>%
        summarise(total_emissions = sum(Emissions))

# we open the export PNG system so we can save the chart as an image later on.
png('plot4.png')

# change of charting options so we don't get scientific notation in Y margin with big numbers.
options(scipen=5)

#plotting the evolution of Coal related sources emissions. We appreciate a great decrease
ggplot(df, aes(x = year, y = total_emissions)) + 
        geom_line(stat = 'identity', colour = 'green', lwd = 3) + 
        geom_point() +
        labs(x = 'Year', y = 'Emissions', title = 'Total emissions over the Years', subtitle = 'Coal combustion-related across the US')


# closing the png system to save the plot as PNG file on our working directory
dev.off()
