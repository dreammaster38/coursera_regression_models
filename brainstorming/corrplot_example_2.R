library(corrplot)
data(mtcars)
M <- cor(mtcars)
##  different color series
col1 <- colorRampPalette(c("#7F0000","red","#FF7F00","yellow","white", 
                           "cyan", "#007FFF", "blue","#00007F"))
col2 <- colorRampPalette(c("#67001F", "#B2182B", "#D6604D", "#F4A582", "#FDDBC7",
                           "#FFFFFF", "#D1E5F0", "#92C5DE", "#4393C3", "#2166AC", "#053061"))  
col3 <- colorRampPalette(c("red", "white", "blue")) 
col4 <- colorRampPalette(c("#7F0000","red","#FF7F00","yellow","#7FFF7F", 
                           "cyan", "#007FFF", "blue","#00007F"))   
wb <- c("white","black")


par(ask = TRUE)


## different color scale and methods to display corr-matrix
corrplot(M, method="number", col="black", addcolorlabel="no")
corrplot(M, method="number")
corrplot(M)
corrplot(M, order ="AOE")
corrplot(M, order ="AOE", addCoef.col="grey")

corrplot(M, order="AOE", col=col1(20), cl.length=21,addCoef.col="grey")
corrplot(M, order="AOE", col=col1(10),addCoef.col="grey")

corrplot(M, order="AOE", col=col2(200))
corrplot(M, order="AOE", col=col2(200),addCoef.col="grey")
corrplot(M, order="AOE", col=col2(20), cl.length=21,addCoef.col="grey")
corrplot(M, order="AOE", col=col2(10),addCoef.col="grey")

corrplot(M, order="AOE", col=col3(100))
corrplot(M, order="AOE", col=col3(10))



corrplot(M, method="color", col=col1(20), cl.length=21,order = "AOE", addCoef.col="grey")

if(TRUE){
  
  corrplot(M, method="square", col=col2(200),order = "AOE")
  
  corrplot(M, method="ellipse", col=col1(200),order = "AOE")
  
  
  corrplot(M, method="shade", col=col3(20),order = "AOE")
  
  corrplot(M, method="pie", order = "AOE")
  
  
  ## col=wb
  corrplot(M, col = wb, order="AOE", outline=TRUE, addcolorlabel="no")
  ## like Chinese wiqi, suit for either on screen or white-black print.
  corrplot(M, col = wb, bg="gold2",  order="AOE", addcolorlabel="no")
}