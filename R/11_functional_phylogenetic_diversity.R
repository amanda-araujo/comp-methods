# From taxonomical to functional and phylogenetic diversity
#A diversity index is a quantitative measure that reflects how many different
#types (such as species) there are in a dataset (a community), and that can
#simultaneously take into account the phylogenetic relations among the individuals
#distributed among those types, such as richness, divergence or evenness.
#These indices are statistical representations of biodiversity in different
#aspects (richness, evenness, and dominance).

Community.A <- c(10, 6, 4, 1)
Community.B <- c(17, rep(1, 7)) #8 elements, larger diversity, rep: repetition function

library(vegan)

#Ecological Diversity Indices --------------------------------------------------
#Shannon, Simpson, and Fisher diversity indices and species richness.
?vegan :: diversity

diversity(Community.A, "shannon")
diversity(Community.B, "shannon")
#shannon: even similar

diversity(Community.A, "simpson")
diversity(Community.B, "simpson")

diversity(Community.A, "invsimpson")
diversity(Community.B, "invsimpson")
#invsimpson: more robust for this kind of thing (?)

hist(Community.A, breaks = 10)
hist(Community.B, breaks = 10)

#Renyi and Hill Diversities and Corresponding Accumulation Curves --------------
?renyi

ren_comA <- renyi(Community.A)
ren_comB <- renyi(Community.B)

renAB <- rbind(ren_comA, ren_comB)
plot(renAB)
matplot(t(renAB), type = 'l', axes = F, ylab = "Rényi diversity") #made for matrixes
box()
axis(side = 2)
axis(side = 1, labels = c(0, 0.25, 0.5, 1, 2, 4, 8, 16, 32, 64, "Inf"), at = 1 : 11)
legend("topright", legend = c("Community A", "Community B"),
       lty = c(1, 2),
       col = c(1, 2))

#taxonomy diversity can be very wide
#how a diversity index should work (we know)
#

ren_comB_Hill <- renyi(Community.B, hill = T)
ren_comB_Hill

