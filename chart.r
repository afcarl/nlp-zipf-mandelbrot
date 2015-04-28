library(ggplot2)
library(minpack.lm)

stats <- read.csv("test/stats.txt", header=FALSE)

zipf <- predict(nls(V3 ~ k/V1, data = stats, start = c(k = 5)))
mandelbrot_start <- coef(nls(log(V3) ~ log(P/(V1+d)^b), stats, start = c(P = 1, d = 1, b = 1)))
mandelbrot <- predict(nlsLM(V3 ~ P/(V1+d)^b, data = stats, start = mandelbrot_start))

d <- data.frame(x=stats['V1'], y1=stats['V3'], y2=zipf, y3=mandelbrot)

ggplot(d, aes(V1, colour=Legenda), log="y") + 
  geom_line(aes(y=V3, colour="data")) +
  geom_line(aes(y=y2, colour="Zipf")) +
  geom_line(aes(y=y3, colour="Mandelbrot")) +
  scale_colour_manual(values=c("red", "blue", "green")) +
  scale_y_log10() +
  labs(title = "Zipf - Mandelbrot", x = "Rank", y = "Frequency")


sum_of_words <- sum(stats$V3)
counter_sum <- 0
i <- 0
while (i <= length(stats$V3) && counter_sum < sum_of_words/2) {
  i <- i + 1
  counter_sum <- counter_sum + stats$V3[i]
}
cat("Number of words which cover 50% of corpus:",i)
cat("Number of hapax legomena:", sum(stats$V3[stats$V3 == 1]))
