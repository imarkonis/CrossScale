load("./data/nl_prcp_obs_raw.rdata")  #Created in data_import
load("./data/nl_prcp_mod_raw.rdata")  #Created in data_import

#Temporal aggregation: aggregate to a single cell
knmi_prcp_nl <- knmi_prcp[, mean(prcp, na.rm = T), time]
colnames(knmi_prcp_nl)[2] = "prcp"
knmi_prcp_nl <- knmi_prcp_nl[complete.cases(knmi_prcp_nl)]
rdr_prcp_nl <- rdr_prcp[, mean(prcp, na.rm = T), time]
colnames(rdr_prcp_nl)[2] = "prcp"
gpm_prcp_nl <- gpm_prcp[, mean(prcp, na.rm = T), time]
colnames(gpm_prcp_nl)[2] = "prcp"

save(knmi_prcp_nl, rdr_prcp_nl, gpm_prcp_nl, ncep_prcp, cnrm_prcp, 
     file = "./data/nl_prcp_temp_agg.Rdata")

# Spatial aggregation: pick 6 events between 10 and 11 average prcp
gpm_prcp[, day_mean := mean(prcp), time]
gpm_prcp_events <- merge(gpm_prcp[day_mean > 10.3 & day_mean < 11], gpm_cells) 

save(gpm_prcp_events, file = "./data/nl_prcp_sp_agg.Rdata")