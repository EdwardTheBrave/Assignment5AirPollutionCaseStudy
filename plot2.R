
#Question: 

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips=="24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

# Reading the data (must be located on our working directory)
if(!exists("NEI")){
        NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
}
#we subset the NEI df so we only have Baltimore information when plotting the pollution meassures
baltimore_data <- subset(NEI, fips == 24510)

# we assign to a new variable the table containing the total emissions by year on Baltimore
baltimore_emissions <- with(baltimore_data, tapply(Emissions, year, sum))

# we open the export PNG system so we can save the chart as an image later on.
png('plot2.png')

# change of charting options so we don't get scientific notation in Y margin with big numbers.
options(scipen=5)

#Creating the barplot that compares the PM2.5 Emissions evolution by year in the USA
barplot(baltimore_emissions, col = 'blue', xlab = 'Year', ylab = 'PM2.5 Emission', main = 'Total PM2.5 Emissions by Year in Baltimore')

# closing the png system to save the plot as PNG file on our working directory
dev.off()

