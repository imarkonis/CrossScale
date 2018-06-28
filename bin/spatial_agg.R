library(ncdf4); library(raster); library(data.table); library(reshape2); library(scalegram); 

load("./data/spatial.Rdata")

#show 6 events in GPM with same mean
gpm_event_dates <- format(gpm_events[, unique(time)], "%d-%m-%Y") 

gpm_events_brick <- dt_to_brick(gpm_events, var_name = "prcp")
plot(gpm_events_brick, col = rev(colorspace::sequential_hcl(40)),
     main = event_dates)

g4 <- scalegram_space(gpm_events_brick)
g4$sg_plot

gpm_sp_scale <- scalegram_space(gpm_events_brick, plot = F)
gpm_sp_scale[, variable := factor(variable, labels = gpm_event_dates)]
scalegram_multiplot(gpm_sp_scale, smooth = T, log_x = F, log_y = F) 

rdr_events_brick <- dt_to_brick(rdr_events, var_name = "prcp")
rdr_event_dates <- format(rdr_events[, unique(time)], "%d-%m-%Y") 

g5 <- scalegram_space(rdr_events_brick)
g5$sg_plot

rdr_sp_scale <- scalegram_space(rdr_events_brick, plot = F)
rdr_sp_scale[, variable := factor(variable, labels = rdr_event_dates)]
scalegram_multiplot(rdr_sp_scale, smooth = T, log_x = F, log_y = F) 





