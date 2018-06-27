load("./data/observ_raw.rdata")  #Created in data_import
load("./data/model_raw.rdata")  #Created in data_import

#Temporal aggregation: aggregate to a single cell
knmi_nl <- knmi_prcp[, mean(prcp, na.rm = T), time]
colnames(knmi_nl)[2] = "prcp"
knmi_nl <- knmi_nl[complete.cases(knmi_nl)]
rdr_nl <- rdr_prcp[, mean(prcp, na.rm = T), time]
colnames(rdr_nl)[2] = "prcp"
gpm_nl <- gpm_prcp[, mean(prcp, na.rm = T), time]
colnames(gpm_nl)[2] = "prcp"

cnrm_nl <- cnrm_prcp #Model data raw are in a single cell so no aggregation is needed
ncep_nl <- ncep_prcp #Name changes for uniformity

save(knmi_nl, rdr_nl, gpm_nl, ncep_nl, cnrm_nl, 
     file = "./data/temporal.Rdata")

# Spatial aggregation: pick 6 events between 10 and 11 average prcp
gpm_prcp[, day_mean := mean(prcp), time]
gpm_prcp_events <- merge(gpm_prcp[day_mean > 10.3 & day_mean < 11], gpm_cells) 

save(gpm_prcp_events, file = "./data/spatial.Rdata")