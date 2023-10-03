#----------------------------------------- PROBLEM 2 -----------------------------------------

library(readr)

#Load the data into a vector
data_vector <- readLines("C:\\Users\\r_hop\\git-rasmushopen\\suites_dw_Table1.txt")
data_vector

#load the info into a new vector, could be useful later
#also save the var names
info_vector <- data_vector[1:11]
var_vector <- data_vector[13]


#remove the seperator line and top information we stored in the info vector
data_vector <- data_vector[-(1:14)]


#Save the variable descrpitions in a txt file
info_file <- file("variable_info.txt", open = "w")

for (line in info_vector) {
  cat(line, "\n", file = info_file)
}

close(info_file)


#replace | with comma
data_vector <- gsub("\\|", ",", data_vector)
var_vector <- gsub("\\|", ",", var_vector)

#Write data file using cat function
data_file <- file("data.csv", open = "w")

for (line in data_vector) {
  cat(line, "\n", file = data_file)
}

close(data_file)

# Read the finished .csv back into R in the normal way.
df <- read_csv("data.csv")

var_vector <- gsub(" ", "", var_vector) #Remove all spacing for the variable names
var_vector <- unlist(strsplit(var_vector, ",")) #Use unlist and strsplit to make seperations between each element for the var names

#Add column names
colnames(df) <- var_vector

#look at the data frame, looks good!
df

#----------------------------------------- PROBLEM 3 -----------------------------------------

boxplot(df$a_26, main = "Box and whisker plot", 
        ylab = "Linear diameter of the galaxy in kpc")

hist(df$a_26, main = "Histogram", 
        xlab = "Linear diameter of the galaxy in kpc", 
        ylab = "Frequency", breaks = seq(0, 66, by = 1))

#Looking at the data, smaller objects does not seem to be underrepresented at all!
#From the distribution, most of the galaxies seem to be within the smaller range of <5kpc.
#According to the paper, smaller (dwarf) galaxies within the radius of <10 Mpc,
#are easier to discover. The paper is limited to <11 Mpc, so most of the smaller
#galaxies should be easier to disover. 