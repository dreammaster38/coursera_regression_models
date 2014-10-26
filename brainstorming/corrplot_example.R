library(corrplot)

data(mtcars)
mcor <- cor(mtcars)
# Print mcor and round to 2 digits
round(mcor, digits=2)

# Generate a lighter palette
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(mcor, method="shade", shade.col=NA, tl.col="black", tl.srt=45,
         col=col(200), addCoef.col="black", order="FPC")