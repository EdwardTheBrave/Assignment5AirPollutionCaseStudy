
#Question: 

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Reading the data (must be located on our working directory)
if(!exists("NEI")){
        NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
}

# we assign to a new variable the table containing the total emissions by year
total_emissions <- with(NEI, tapply(Emissions, year, sum))

# we open the export PNG system so we can save the chart as an image later on.
png('plot1.png')

# change of charting options so we don't get scientific notation in Y margin with big numbers.
options(scipen=5)

#Creating the barplot that compares the PM2.5 Emissions evolution by year in the USA
barplot(total_emissions, col = 'blue', xlab = 'Year', ylab = 'PM2.5 Emission', main = 'Total PM2.5 Emissions by Year in the USA')

# closing the png system to save the plot as PNG file on our working directory
dev.off()
