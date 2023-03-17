
x <- 1

if(x == 1) {
  print(1)
} else if(x > 0) {
  print("More then 0 but not 1")
} else {
  print("You negative baby")
}

for (i in 1:10) {
  print(i)
}

x <- c("a","b","c","d")

for (i in 1:4) {
  print(x[i])
}

for (i in seq_along(x)) {
  print(x[i])
}

for (letter in x) print(letter)

for(i in seq_along(x)) {
  print(x[i])
}

computeEstimate <- function() {
  x < - rnorm(1)
  print(x)
  x
}

x0 <- 1
tol <- 1e-8
repeat {
  x1 <- computeEstimate()
  if(abs(x1 - x0) < tol) { ## Close enough?
    break
  } else {
    x0 <- x1
  }
}

above10 <- function(x) {
  use <- x > 10
  x[use]
}