library(ncdf4); library(raster); library(data.table); library(reshape2); library(scalegram); 

load("./data/spatial.Rdata")

#show 6 events in GPM with same mean
event_dates <- format(gpm_events[, unique(time)], "%d-%m-%Y") 

gpm_events_brick <- dt_to_brick(gpm_5, var_name = "prcp")
plot(gpm_events_brick, col = rev(colorspace::sequential_hcl(40)),
     main = event_dates)

gpm_sp_scale <- scalegram_space(gpm_events_brick, 10)
gpm_sp_scale[, variable := factor(variable, labels = event_dates)]
scalegram_multiplot(gpm_sp_scale, smooth = T, log_x = F, log_y = F) 


