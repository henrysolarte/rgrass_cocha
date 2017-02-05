annos <- c("1986_febrero", "1999_julio", "2002_octubre", "2005_noviembre", "2008_septiembre", "2012_agosto", "2012_julio", "2016_enero")
p <- matrix(data=NA, nrow=8, ncol=8)
for (i in annos){
ptrn=paste("\"*",i,"*\"")
ptrn=gsub(" " ,"" ,ptrn)
print(ptrn)
a <- execGRASS("g.list", parameters = list(type = "raster", pattern = ptrn))
b <- attributes(a)$resOut
print(i)
i <- readRAST(c(b[1],b[2],b[3],b[4],b[5],b[6]), cat=c(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE))
str(i)
}	

