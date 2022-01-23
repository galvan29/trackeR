#librerie
library(rayshader)
library(ggplot2)
library(tidyverse)

#Capitolo 3.1 "Lettura"
dataframe <- readTCX("filepath/file.tcx")


#Capitolo 3.4 "Unità di misura"
runChangeUnit <- changeUnits(run, variable = "speed", unit = "km_per_h", sport = "running")


#Capitolo 3.7 "Installazione"
install.packages("trackeR")

devtools::install\_github("trackerproject/trackeR")


#Capitolo 3.8 "Caricamento"
library("trackeR")


#Capitolo 4.1 "Costruttore trackRdata()"
trackeRdata(dat, units = NULL, sport = NULL, 
            session_threshold = 2, correct_distances = FALSE, 
            from_distances = TRUE, country = NULL, mask = TRUE, 
            lgap = 30, lskip = 5, m = 11, silent = FALSE)
 

#Capitolo 4.2 "Runs"
data(runs, package = "trackeR")

runs


#Capitolo 5.1 "Morning_Run.tcx"
morningRun <- readTCX("C:/Users/matte/OneDrive/Desktop/dataframe/Morning_Run.tcx")

str(morningRun)

morningRunTD <- trackeRdata(morningRun)


#Capitolo 5.1.1 "Summary"
summary(morningRunTD)


#Capitolo 5.2.1 "Creazione grafico plot"
plot(morningRunTD, what = c("speed", "pace", "altitude","heart_rate"))


#Capitolo 5.2.2 "Creazione Mappa"
leaflet_route(morningRunTD)


#Capitolo 5.2.3 "Zones"
zones_alt <- zones(morningRunTD, what = "altitude", breaks = c(135:164, 179:180))
plot(zones_alt) + theme(legend.position = "None")


#Capitolo 5.2.4 "Relazione Velocità Cadenza"
remotes::install_github("tylermorganwall/rayshader")

ggmorning=ggplot(morningRun) + stat_density_2d(aes(x=speed, y=cadence_running, 
                fill=stat(nlevel)), geom="polygon", n=200, bins=50, contour=TRUE) +
                xlab("Speed (m/s)") + ylab("Cadence Running (steps/min)") +
                scale_fill_viridis_c(option="A")
plot_gg(ggmorning, width = 5, height=5, raytrace = FALSE, preview = TRUE)


#Capitolo 5.2.5 "Profilo Distribuzione"
dProfile <- distributionProfile(morningRunTD, session = 1, what = c("speed", "heart_rate"),
                                grid = list(speed = seq(0, 12.5, by = 0.05), 
                                heart_rate = seq(0, 250)))
plot(dProfile, multiple = TRUE) + theme(legend.position = "None")


dProfile <- distributionProfile(morningRunTD,
                                session = 1, what = c("pace", "heart_rate"),
                                grid = list(pace = seq(0, 12.5, by = 0.05), 
                                            heart_rate = seq(0, 250)))
cProfile <- concentrationProfile(dProfile, what = "pace")
plot(cProfile, multiple = TRUE, smooth = TRUE) + theme(legend.position = "None")
