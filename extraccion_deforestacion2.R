#se cargan las  librerias necesarias
library("rgrass7")
library("rgdal")
setwd("~/rgrass_cocha")
#se crea una lista con los patrones de las imagenes importadas a grass
annos <- c("deforestacion_1990_2000", "deforestacion_2000_2005", "deforestacion_2005_2010", "deforestacion_2010_2012", 
           "deforestacion_2012_2013", "deforestacion_2013_2014", "deforestacion_2014_2015")
#se hacen las instrucciones para un spatialgriddataframe generico
p <- matrix(data=NA, nrow=7, ncol=7)
df = data.frame(z = c(1:6,NA,8,9),
                xc = c(1,1,1,2,2,2,3,3,3),
                yc = c(rep(c(0, 1.5, 3),3)))
coordinates(df) = ~xc+yc
gridded(df) = TRUE
df = as(df, "SpatialGridDataFrame")
#se copia ese espatialgriddataframe en las variables que van a guardar la información de las imagenes dentro de el
deforestacion_1990_2000 <- df
deforestacion_2000_2005 <- df
deforestacion_2005_2010 <- df
deforestacion_2010_2012 <- df
deforestacion_2012_2013 <- df
deforestacion_2013_2014 <- df
deforestacion_2014_2015 <- df

#se crea una lista con esas variables (spatialgrid dataframes) para poderlo iterar 
dfs = c(deforestacion_1990_2000, deforestacion_2000_2005, deforestacion_2005_2010, deforestacion_2010_2012, deforestacion_2012_2013, deforestacion_2013_2014, deforestacion_2014_2015)
#se itera sobre cada uno de los años y la lista de variables para extraer la información masivamente de grass
for (i in seq(1:7)){
ptrn=paste("\"*",annos[i],"*\"")
ptrn=gsub(" " ,"" ,ptrn)
print(ptrn)
#se lista la imagen con el patron que se ingreso en la variable annos
a <- execGRASS("g.list", parameters = list(type = "raster", pattern = ptrn))
b <- attributes(a)$resOut
print(annos[i])
dfs[i] <- readRAST(c(b[1]), 
                   cat=c(FALSE),
                   ignore.stderr = get.ignore.stderrOption(),
                   NODATA=0, plugin=get.pluginOption(), mapset=NULL,
                   useGDAL=get.useGDALOption(), close_OK=TRUE, drivername="HFA",
                   driverFileExt=".img", return_SGDF=TRUE)
}
#se extraen los spatialgridataframe de la lista que se creo originalmente
def1990_2000 <- dfs[[1]]@data
def2000_2005 <- dfs[[2]]@data
def2005_2010 <- dfs[[3]]@data
def2010_2012 <- dfs[[4]]@data
def2012_2013 <- dfs[[5]]@data
def2013_2014 <- dfs[[6]]@data
def2014_2015 <- dfs[[7]]@data


