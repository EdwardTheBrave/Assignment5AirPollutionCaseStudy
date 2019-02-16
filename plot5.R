#Question: 

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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
#we subset the SCC df so we only have information from motor vehicles in Baltimore and we merge it with NEI df and group it by year, 
#retrieving the total emissions per combination and making some transformations
df <- NEI %>%
        filter(fips == '24510' & type == 'ON-ROAD') %>%
        group_by(year, fips) %>%
        summarise(total_emissions = sum(Emissions))

# we open the export PNG system so we can save the chart as an image later on.
png('plot5.png')

# change of charting options so we don't get scientific notation in Y margin with big numbers.
options(scipen=5)

#plotting the evolution of motor vehicles emissions in Baltimore. We appreciate a great decrease
ggplot(df, aes(x = year, y = total_emissions)) + 
        geom_line(stat = 'identity', colour = 'purple', lwd = 3) + 
        geom_point() +
        labs(x = 'Year', y = 'Emissions', title = 'Total emissions over the Years', subtitle = 'Motor vehicles in Baltimore')


# closing the png system to save the plot as PNG file on our working directory
dev.off()

