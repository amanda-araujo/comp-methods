# Introduction to biological diversity analysis
# Species abundance, frequency, richness

#1. Which are the 5 most abundant species overall in the dataset?
#2. How many species are there in each plot? (Richness)
#3. Which the species that is most abundant in each plot?

#Getting the data --------------------------------------------------------------
comm <- read.csv("data/raw/cestes/comm.csv")
colnames(comm)
View(comm)

#1. Which are the 5 most abundant species overall in the dataset?---------------

#me trying (and failing)
dim(comm) #97 57
dimentions <- dim(comm)
dimentions
dimentions[1] #rows
dimentions[2] #colunms: different species

ncol(comm)
nrow(comm)

comm[3]   #colunm 3
comm[, 2] #row 2
class(comm)

?vector
abundance <- vector(length = ncol(comm))
abundance
abundance[1] = 2
abundance

comm[2,3]
class(comm[2,2])
ab = 0
ab = ab + comm[2,3]
ab
abundance[1] = ab
abundance
length(ab)

for (i in ncol(comm)){
  ab = 0
  for (j in nrow(comm)){
      ab = ab + comm[i+1, j+1]
      abundance[i] = ab
  }
}

#solutions from the class
colSums(comm) %>% dplyr::sort(decreasing=T)
five_most_abundant <- sort(colSums(comm), decreasing = TRUE)[2:6]
five_most_abundant
fiveMostAbundant <- tail(sort(mapply(sum,comm[-1])), n = 5)
fiveMostAbundant
commSorted = sort(colSums(comm), decreasing = TRUE)[2:6]
commSorted


#2. How many species are there in each plot? (Richness) ------------------------
#plot == site


#-------------
my_shanon <- function(x) {
  pi <- x/sum(x)
  H <- -sum(pi * log(pi))
}

my_simpson <- function(x) {
  pi <- x/sum(x)
  Simp <- 1 - sum(pi^2)
}




