# From taxonomical to functional and phylogenetic diversity in R
# Part II

#Getting the data --------------------------------------------------------------
comm <- read.csv("data/raw/cestes/comm.csv")
colnames(comm)
View(comm)

traits <- read.csv("data/raw/cestes/traits.csv")
colnames(traits)
View(traits)


#Exploring it ------------------------------------------------------------------
head(comm)[,1:6]
head(traits)[,1:6]

#Changing the rownames of the dataframe 'comm'
rownames(comm)
comm[,1]
rownames(comm) <- paste0("Site", comm[,1]) #change the row names
comm <- comm[,-1]                          #delete the first column
head(comm)[,1:6]

#Transform column traits$Sp into the rownames of the dataframe
rownames(traits)
traits$Sp
rownames(traits) <- traits$Sp  #change the row names
head(traits)
traits <- traits[,-1]          #delete the first column
head(traits)[,1:6]


#Species richness --------------------------------------------------------------
library(vegan)
richness <- vegan::specnumber(comm)
richness

#Taxonomic diversity -----------------------------------------------------------
shannon <- vegan::diversity(comm)  #default: shannon
shannon
simpson <- vegan::diversity(comm, index = "simpson")
simpson

#Functional diversity ----------------------------------------------------------
#When analyzing functional traits the distance between individuals is no longer
#determined by their belonging to a species, but to their position in the trait
#space.
#Gower distance is a common distance metric used in trait-based ecology.

library(cluster)
library(FD)
?gowdis
?daisy #Dissimilarity Matrix Calculation

gow <- cluster::daisy(traits, metric = "gower") #Gower: distance metric
gow2 <- FD::gowdis(traits)
identical(gow, gow2)
class(gow)
class(gow2)
plot(gow, gow2, asp = 1)

#Rao's quadratic entropy calculations in R
library(SYNCSA)
tax <- rao.diversity(comm)
fun <- rao.diversity(comm, traits = traits)
plot(fun$Simpson, fun$FunRao, pch = 19, asp = 1)
abline(a = 0, b = 1)

#Calculating FD indices with package PD ----------------------------------------
library(FD)
#we can use the distance matrix to calculate functional diversity indices
FuncDiv1 <- dbFD(x = gow, a = comm, messages = F)
#the returned object has Villéger's indices and Rao calculation
names(FuncDiv1)
#We can also do the calculation using the traits matrix directly
FuncDiv <- dbFD(x = traits, a = comm, messages = F)

#Next: How to we summarize visually, interpret community composition and trait
#data?
library(taxize)

splist <-

classification_data <- classification(splist$TaxonName, db = "ncbi")
str(classification)
length(classification_data)

