# Population Ecology: using deSolve to solve ODEs in R


library(deSolve)
library(ggplot2) # because we will plot things
library(tidyr) # because we will manipulate some data


# Logistic growth model --------------------------------------------------------

# get the function from another file
source("functions/logGrowth.R")

# named vector with parameters
p <- c(r = 1, a = 0.001)
# initial condition
y0 <- c(N = 10)
# time steps
t <- 1:20
t <- seq(1, 20, by = 0.5) # by = 'time step'
                          # length.out = 'number of partitions'

# give the function and the parameters to the ode function
out_log <- ode(y = y0, times = t, func = logGrowth, parms = p)

class(out_log) # "deSolve" "matrix"
head(out_log)
summary(out_log)

# Plotting the result using ggplot2. We will need to convert the out object
# into a data.frame.
df_log <- as.data.frame(out_log)
ggplot(df_log) +
  geom_line(aes(x = time, y = N)) +
  theme_classic()


# Lokta-Volterra competition model ---------------------------------------------

# get the function from another file
source("functions/Lotka_Volterra_comp.R")

# LV parameters
a <- matrix(c(0.02, 0.01, 0.01, 0.03), nrow = 2) # a_11, a_12, a_21, a_22
r <- c(1, 1)
p2 <- list(r, a)
N0 <- c(10, 10)
t2 <- c(1:100)

out_lv <- ode(y = N0, times = t2, func = LVComp, parms = p2)

head(out_lv)
summary(out_lv)

# tidy format: output >> data.frame
df_lv <- pivot_longer(as.data.frame(out_lv), cols = 2:3) #cols = 'cols we want to colapse'

head(df_lv)
tail(df_lv)

ggplot(df_lv) +
  geom_line(aes(x = time, y = value, color = name)) +
  labs(x = "Time", y = "N", color = "Species") + #labels
  theme_classic()

# separating each color by 'name': 2 lines for the 2 species

