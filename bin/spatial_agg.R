library(ncdf4); library(raster); library(data.table); library(reshape2); library(scalegram); 

load("./data/nl_prcp_obs_raw.rdata"); rm(knmi_prcp, knmi_stations)

#show 5 events in GPM with same mean
gpm_prcp[, day_mean := mean(prcp), time]
gpm_prcp_5 <- merge(gpm_prcp[day_mean > 23.5 & day_mean < 24], gpm_cells) #top 5 events
event_dates <- gpm_prcp_5[, unique(time)]
gpm_prcp_5_brick <- dt_to_brick(gpm_prcp_5, var_name = "prcp")

gpm_sp_scale <- scalegram_brick(gpm_prcp_5_brick, 10)
scalegram_multiplot(gpm_sp_scale[variable %in% 1:10], smooth = T, log_x = F, log_y = F) 
plot(gpm_prcp_5_brick)

rdr_prcp_5 <- merge(rdr_prcp[time %in% event_dates], rdr_cells)
rdr_prcp_5_brick <- dt_to_brick(rdr_prcp_5, var_name = "prcp")

rdr_sp_scale <- scalegram_brick(rdr_prcp_5_brick, 10)
scalegram_multiplot(rdr_sp_scale[ variable %in% 1:10], smooth = T, log_x = F, log_y = F) 
scalegram_multiplot(rdr_sp_scale[ variable %in% 1:10], log_x = F, log_y = F) 
plot(rdr_prcp_5_brick)

gpm_nc_file <- paste0(data_gpm_path, "/imerg_daily_3.37-7.22E_50.66-53.56N.nc")
rdr_nc_file <- paste0(data_knmi_radar_path, "/radar_sum.nc")

thres <- 50
x <- brick(rdr_nc_file)
no_layer <- nlayers(x)
out <- list()
for(j in 1:no_layer){
  i <- 2
  x_layer <- x[[j]]
  x_layer[,] <- scale(x_layer[,], center = T, scale = T)
  ncells <- length(x_layer)
  x_agg <- list(x_layer)
  while(ncells > thres){
    x_agg[[i]] <- aggregate(x_layer, fact = i)
    ncells <- length(x_agg[[i]])
    i <- i + 1
    print(paste0(i, ".", j))
  }
  out[[j]] <- sapply(sapply(x_agg, getValues), sd, na.rm = T)
}

rdr_sp_scale <- data.table(melt(out))
rdr_sp_scale$scale <- rep(1:nrow(rdr_sp_scale[L1 == 1]), max(rdr_sp_scale$L1))
colnames(rdr_sp_scale)[2] = "variable"
rdr_sp_scale <- rdr_sp_scale[, c(3, 1, 2)]
scalegram_multiplot(rdr_sp_scale[ variable %in% 1:10], smooth = T)

thres <- 50
x <- brick(gpm_nc_file)
no_layer <- nlayers(x)
out <- list()
for(j in 1:no_layer){
  i <- 2
  x_layer <- x[[j]]
  x_layer[,] <- scale(x_layer[,], center = T, scale = T)
  ncells <- length(x_layer)
  x_agg <- list(x_layer)
  while(ncells > thres){
    x_agg[[i]] <- aggregate(x_layer, fact = i)
    ncells <- length(x_agg[[i]])
    i <- i + 1
    print(paste0(i, ".", j))
  }
  out[[j]] <- sapply(sapply(x_agg, getValues), sd, na.rm = T)
}

gpm_sp_scale <- data.table(melt(out))
gpm_sp_scale$scale <- rep(1:nrow(gpm_sp_scale[L1 == 1]), max(gpm_sp_scale$L1))
colnames(gpm_sp_scale)[2] = "variable"
gpm_sp_scale <- gpm_sp_scale[, c(3, 1, 2)]
scalegram_multiplot(gpm_sp_scale, smooth = F)
