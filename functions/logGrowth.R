# Creating a function for logistic growth
logGrowth <- function(t, y, p) {
  N <- y[1]              #initial pop
  with(as.list(p), {     #with all the parameters p
    dN.dt <- r * N * (1 - a * N)
    return(list(dN.dt))  #solution of the equation
  })
}
