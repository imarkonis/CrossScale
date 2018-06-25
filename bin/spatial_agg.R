library(ncdf4); library(raster); library(data.table); library(reshape2); library(scalegram); 

load("./data/nl_prcp_sp_agg.Rdata")

#show 6 events in GPM with same mean
event_dates <- format(gpm_prcp_5[, unique(time)], "%d-%m-%Y") 

gpm_prcp_5_brick <- dt_to_brick(gpm_prcp_5, var_name = "prcp")
plot(gpm_prcp_5_brick, col = rev(colorspace::sequential_hcl(40)),
     main = event_dates)

gpm_sp_scale <- scalegram_space(gpm_prcp_5_brick, 10)
gpm_sp_scale[, variable := factor(variable, labels = event_dates)]
scalegram_multiplot(gpm_sp_scale, smooth = T, log_x = F, log_y = F) 


