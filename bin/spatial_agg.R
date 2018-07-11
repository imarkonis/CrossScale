library(csa)

load("./data/spatial.Rdata")

#show 6 events in GPM with same mean
gpm_event_dates <- format(gpm_events[, unique(time)], "%d-%m-%Y") 

gpm_events_brick <- dt.to.brick(gpm_events, var_name = "prcp")
plot(gpm_events_brick, col = rev(colorspace::sequential_hcl(40)),
     main = gpm_event_dates)

g4 <- csas(gpm_events_brick)
g4$plot

gpm_sp_scale <- csas(gpm_events_brick, plot = F)
gpm_sp_scale[, variable := factor(variable, labels = gpm_event_dates)]
csa.multiplot(gpm_sp_scale, smooth = T, log_x = F, log_y = F) 

rdr_events_brick <- dt.to.brick(rdr_events, var_name = "prcp")
rdr_event_dates <- format(rdr_events[, unique(time)], "%d-%m-%Y") 

g5 <- csas(rdr_events_brick)
g5$plot

rdr_sp_scale <- csas(rdr_events_brick, plot = F)
rdr_sp_scale[, variable := factor(variable, labels = rdr_event_dates)]
csa.multiplot(rdr_sp_scale, smooth = T, log_x = F, log_y = F) 





