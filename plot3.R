#Question: 

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

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
#we subset the NEI df so we only have Baltimore information and we group it by year and type, retrieving the total emissions per combination
df <- NEI %>%
        filter(fips == 24510) %>%
        group_by(year, type) %>%
        summarise(total_emissions = sum(Emissions))

# we open the export PNG system so we can save the chart as an image later on.
png('plot3.png')

# we plot the df created earlier and plot it with lines to see the evolution and points to facilitate the location of each observation. 
# Each colour is a different type. We use ggplot library
ggplot(df, aes(x = year, y = total_emissions, colour = type)) + 
        geom_line() + 
        geom_point() +
        labs(x = 'Year', y = 'Emissions', title = 'Total emissions over the Years', subtitle = 'By Type in Baltimore')

# closing the png system to save the plot as PNG file on our working directory
dev.off()