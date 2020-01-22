#References
#https://youtu.be/POiHEJqmiC0
#http://www.statslectures.com/index.php/r-stats-videos-tutorials/bivariate-analysis/4-7-chi-square-test
#https://www.r-statistics.com/2010/05/exporting-r-output-to-ms-word-with-r2wd-an-example-session/
#https://cran.r-project.org/web/packages/gridExtra/vignettes/tableGrob.html
#https://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html

library(gridExtra)
library(grid)
library(corrplot)
library(PerformanceAnalytics)
dat <- read.table(file.choose(), header = T, sep = "\t")
attach(dat)
names(dat)

#Starting with Q28a because having errors in Q25
fName <- quote(Q2)

tab = table(Q2, eval(fName))
d <- head(tab)
ChiUnc <- chisq.test(tab, correct = F) # Does not use Yates Correction
contrib <- round(100*ChiUnc$residuals^2/ChiUnc$statistic,3)
ChiCor <- chisq.test(tab, correct = T) # Uses Yates
fish <- fisher.test(tab, conf.int = T, conf.level = 0.95) # Fisher test

#Build Report
pdf(gsub(" ", "", paste(fName,"Results.pdf"), fixed = T))
grid.table(d)

tName <- paste(fName, "Barplot")
barplot(tab, main= tName, beside = T, legend = T, theme=ttheme_default())

tName <- paste(fName, "Residual Corrplot")
corrplot(ChiUnc$residuals, main= tName, is.corr = F, mar=c(0,0,2,0), cl.align = "l")

tName <- paste(fName, "Contribution Corrplot")
corrplot(contrib, main= tName, is.corr = F, mar=c(0,0,2,0), cl.align = "l")
chart.Correlation(dat, histogram = T, pch=19)
graphics.off()

#sink(gsub(" ", "", paste(fName,"Results.txt"), fixed = T))
#paste("---------------------",fName,"---------------------")
#print(ChiUnc)
#print(ChiCor)
#print(fish)
#print("------------------------------------------------")
#sink()

#reset
rm(ChiUnc)
rm(ChiCor)
rm(fish)
rm(dat)
rm(contrib)
rm(fName)
rm(tab)
rm(tName)

