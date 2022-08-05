# An introduction to multivariate analysis

library(vegan)

#Getting data ------------------------------------------------------------------
data(dune)
data("dune.env")
View(dune) #community matrix
View(dune.env)
table(dune.env$Management)

#dune:
#20 sites (different places)
#we want to check which sites are close to with other
#we could do this by looking for the differential species presence in each site


#Cluster analysis of the dune vegetation ---------------------------------------
#We calculate two dissimilarity indices between sites: Bray-Curtis distance and
#Chord distance

bray_distance <- vegdist(dune)
bray_distance

#Chord distance, euclidian distance normalized to 1
chord_distance <- dist(decostand(dune, "norm"))
chord_distance

#We perform the cluster analysis. Which is the default clustering method?
library(cluster)

b_cluster <- hclust(bray_distance, method = "average")
c_cluster <- hclust(chord_distance, method = "average")

#Plot
par(mfrow = c(1, 2))
plot(b_cluster)
plot(c_cluster)
par(mfrow = c(1, 1))

#Prettier plot
par(mfrow = c(1, 2))
plot(b_cluster, hang = -1, main = "", axes = F)
axis(2, at = seq(0, 1, 0.1), labels = seq(0, 1, 0.1), las = 2)
plot(c_cluster, hang = -1, main = "", axes = F)
axis(2, at = seq(0, 1, 0.1), labels = seq(0, 1, 0.1), las = 2)
par(mfrow = c(1, 1))


#Principal Component Analysis --------------------------------------------------
?decostand
is(chord_distance)
?rda

norm <- decostand(dune, "norm")
pca <- rda(norm)
summary(pca) #The 2 first components: Proportion Explained  0.2917 0.2086
plot(pca) #similarities between sites, start seeing groups and patterns

plot(pca, choices = c(2, 3)) #choosing which components to plot

#PCA for the environmental matrix
names(dune.env)
apply(dune.env, 2, class) #all variables are char
library(dplyr)

#transforming to numeric
dune.env$A1 <- as.numeric(dune.env$A1)
dune.env$Moisture <- as.numeric(dune.env$Moisture)
dune.env$Manure <- as.numeric(dune.env$Manure)

pca_env <- rda(dune.env[, c("A1", "Moisture", "Manure")])
plot(pca_env)
