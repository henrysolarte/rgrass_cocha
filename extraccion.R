library("rgrass7")
library("rgdal")
annos <- c("1986_febrero", "1999_julio", "2002_octubre", "2005_noviembre", "2008_septiembre", "2012_agosto", "2012_julio", "2016_enero")
p <- matrix(data=NA, nrow=8, ncol=8)
df = data.frame(z = c(1:6,NA,8,9),
                xc = c(1,1,1,2,2,2,3,3,3),
                yc = c(rep(c(0, 1.5, 3),3)))
coordinates(df) = ~xc+yc
gridded(df) = TRUE
df = as(df, "SpatialGridDataFrame")
febrero_1986 <- df
julio_1999 <- df
octubre_2002 <- df
noviembre_2005 <- df
septiembre_2008 <- df
agosto_2012 <- df
julio_2012 <- df
enero_2016 <- df
dfs = c(febrero_1986,julio_1999,octubre_2002, noviembre_2005, septiembre_2008, agosto_2012,julio_2012,enero_2016)
for (i in seq(1:8)){
ptrn=paste("\"*",annos[i],"*\"")
ptrn=gsub(" " ,"" ,ptrn)
print(ptrn)
a <- execGRASS("g.list", parameters = list(type = "raster", pattern = ptrn))
b <- attributes(a)$resOut
print(annos[i])
dfs[i] <- readRAST(c(b[1],b[2],b[3],b[4],b[5],b[6]), cat=c(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE))
}	
febrero_1986 <- dfs[[1]]
julio_1999 <- dfs[[2]]
octubre_2002 <- dfs[[3]]
noviembre_2005 <- dfs[[4]]
septiembre_2008 <- dfs[[5]]
agosto_2012 <- dfs[[6]]
julio_2012 <- dfs[[7]]
enero_2016 <- dfs[[8]]
