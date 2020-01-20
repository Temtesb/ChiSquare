library(gridExtra)
library(grid)
library(corrplot)
library(PerformanceAnalytics)


setwd(fPath)

#q <- readline(prompt = "which question?")
#dFile <- gsub(" ", "", paste(eval(q),".txt"), fixed = T)

#dat <- read.table(dFile, header = T, sep = "\t")
dat <- read.table(file.choose(), header = T, sep = "\t")
attach(dat)
names(dat)

c <- colnames(dat)

#Starting with Q28a because having errors in Q25
fName <- quote(Q22b)

tab = table(Q26c, eval(fName))

ChiUnc <- chisq.test(tab, correct = F) # Does not use Yates Correction
ChiCor <- chisq.test(tab, correct = T) # Uses Yates
#fish <- fisher.test(tab, conf.int = T, conf.level = 0.95) # Fisher test

#contrib <- 100*ChiUnc$residuals^2/ChiUnc$statistic
#contrib <- ChiCor$residuals^2
contrib <-ChiUnc$residuals
contrib2 <-contrib^2

#print(contrib)

#round(contrib, 1)

#Build Report table  not currently making
#win.metafile(gsub(" ", "", paste(fName," Table Results.wmf"), fixed = T))
#grid.table(dat)

#build corrplot residules not currently making
#win.metafile(gsub(" ", "", paste(fName," Corrplot Contribution.wmf"), fixed = T))
#tName <- paste(fName, "Contribution Corrplot")
#corrplot(contrib, main= tName, is.corr = F, mar=c(0,0,2,0), cl.align = "l")
#par(xpd=TRUE)
#corrplot(contrib2, main= tName, 
#         addCoef.col = "white",
#         tl.col = "black", 
#         method = "shade",
#         col = gray.colors(100),
#         outline = t, 
#         is.corr = F, 
#         mar=c(0.5,0,2,0), 
#         cl.align = "l")


#build barplot  Not currently making 
win.metafile(gsub(" ", "", paste(fName," Barplot Results.wmf"), fixed = T))
tName <- paste(fName, "Barplot")
barplot(tab,  
        main= text(11, 95, 
                   family = "serif",
                   tName, cex = 1.2),
        #       ylim = c(0,90),
        #This line manually adjusts the y scale
        beside = T, 
        legend = T, 
        args.legend = list(xjust = 1), 
        mar=c(0,0,6,1))


#build corrplot
#win.metafile(gsub(" ", "", paste(fName," Corrplot Residuals.wmf"), fixed = T))
#tName <- paste(fName, "Residual Corrplot")
#tName <- text(family="serif", tName)
#corrplot(ChiUnc$residuals, addCoef.col = "white", tl.col = "black", method = "shade", col = gray.colors(100), outline = t, main= tName, is.corr = F, mar=c(0,0,2,0), cl.align = "l")
#corrplot(ChiCor$residuals, addCoef.col = "white", tl.col = "black", method = "shade", col = gray.colors(100), outline = t, main= tName, is.corr = F, mar=c(0,0,2,0), cl.align = "l")
#corrplot(ChiUnc$residuals, 
#         addCoef.col = "white", 
#         tl.col = "black", 
#         method = "shade", 
#         col = gray.colors(100), 
#         outline = t, 
#         main= tName, 
#         is.corr = F, 
#         mar=c(0,0,4,0), 
#         cl.align = "l")



#corrplot(contrib, 
#         addCoef.col = "white", 
#         tl.col = "black", 
#         method = "shade", 
#         col = gray.colors(100), 
#         outline = t, 
#         main= tName, 
#         is.corr = F, 
#         mar=c(0,0,4,0), 
#         cl.align = "l")


#win.metafile(gsub(" ", "", paste(fName," Correlation Histogram.wmf"), fixed = T))
#chart.Correlation(dat[,1:8], histogram = T, pch="+")
graphics.off()

sink(gsub(" ", "", paste(fName,"Results.txt"), fixed = T))
paste("---------------------",fName,"---------------------")
print(ChiUnc)
print(ChiCor)
print(fish)
print("------------------------------------------------")
sink()

#reset
rm(ChiUnc)
rm(ChiCor)
rm(fish)
rm(dat)
rm(contrib)
rm(contrib2)
rm(fName)
rm(tab)
rm(tName)
rm(c)
rm(boring_function)
