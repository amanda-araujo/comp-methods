# Model selection

library(bbmle)

# Read data
cuckoo <- read.csv("data/raw/valletta_cuckoo.csv")


# Create models to represent each hypothesis -------------------------------

h1 <- glm(Beg ~ Mass, data = cuckoo,
          family = poisson(link = log))

h2 <- glm(Beg ~ Mass + Species, data = cuckoo,
          family = poisson(link = log))

h3 <- glm(Beg ~ Mass * Species, data = cuckoo,
          family = poisson(link = log))

h0 <- glm(Beg ~ 0, data = cuckoo,
          family = poisson(link = log))

summary(h3)
summary(h2)
summary(h1)

# Akaike information criterion (AIC)
# Search fro the model with the lowest AIC value
# Models with dAIC < 2 are equally plausible
AIC(h3)
AIC(h0)

AICtab(h0, h1, h2, h3) #df: degrees of freedom
AICtab(h0, h1, h2, h3, base = TRUE, weights = TRUE)


