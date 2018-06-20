library(scalegram)
#source("./source/spatial_tools.R")
load("./data/nl_prcp_obs_raw.rdata")  #Created in data_import
load("./data/nl_prcp_mod_raw.rdata")  #Created in data_import

rm(gpm_cells, knmi_stations, rdr_cells)

#Aggregate to a single cell
knmi_prcp_nl <- knmi_prcp[, mean(prcp), time]
knmi_prcp_nl <- knmi_prcp_nl[complete.cases(knmi_prcp_nl)]

rdr_prcp_nl <- rdr_prcp[, mean(prcp), time]
gpm_prcp_nl <- gpm_prcp[, mean(prcp), time]

#Put all sets together to us multiplot
set_1 <- data.frame(scalegram(gpm_prcp_nl$V1, plot = F, fast = T), dataset = "gpm")
set_2 <- data.frame(scalegram(rdr_prcp_nl$V1, plot = F, fast = T), dataset = "radar")
set_3 <- data.frame(scalegram(knmi_prcp_nl$V1, plot = F, fast = T), dataset = "station")
set_4 <- data.frame(scalegram(ncep_prcp$prcp, plot = F, fast = T), dataset = "ncep")
set_5 <- data.frame(scalegram(cnrm_prcp$prcp, plot = F, fast = T), dataset = "cnrm")

scalegram_multiplot(rbind(set_1, set_2, set_3, set_4, set_5))
