#Question: 

#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips=="06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

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
        filter(fips %in% c('24510','06037') & type == 'ON-ROAD') %>%
        mutate(fips = case_when(
                fips == '24510' ~ 'Baltimore',
                fips == '06037' ~ 'Los Angeles'
        )) %>%
        group_by(year, fips) %>%
        summarise(total_emissions = sum(Emissions))


# we open the export PNG system so we can save the chart as an image later on.
png('plot6.png')

# change of charting options so we don't get scientific notation in Y margin with big numbers.
options(scipen=5)

#plotting the evolution of motor vehicles emissions in Baltimore and L.A.. We appreciate a greater change in Los Angles.
ggplot(df, aes(x = year, y = total_emissions, colour = fips)) + 
        geom_line(stat = 'identity') + 
        geom_point() +
        labs(x = 'Year', y = 'Emissions', title = 'Total emissions over the Years', subtitle = 'Motor vehicles Baltimore vs L.A.')


# closing the png system to save the plot as PNG file on our working directory
dev.off()
