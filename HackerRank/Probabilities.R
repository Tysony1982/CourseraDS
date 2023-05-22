
prob <- 4/5
trials <- 4
round(pbinom(2, size = trials, prob = prob, lower.tail = FALSE), digits = 3)
round(pbinom(1, size = trials, prob = prob), digits = 3)
