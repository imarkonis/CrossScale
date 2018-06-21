#devtools::install_git("https://github.com/imarkonis/scalegram")
library(scalegram); library(ggpubr)
#source("./source/spatial_tools.R")
load("./data/nl_prcp_obs_raw.rdata")  #Created in data_import
load("./data/nl_prcp_mod_raw.rdata")  #Created in data_import

rm(gpm_cells, knmi_stations, rdr_cells)

#Aggregate to a single cell
knmi_prcp_nl <- knmi_prcp[, mean(prcp, na.rm = T), time]
knmi_prcp_nl <- knmi_prcp_nl[complete.cases(knmi_prcp_nl)]
rdr_prcp_nl <- rdr_prcp[, mean(prcp, na.rm = T), time]
gpm_prcp_nl <- gpm_prcp[, mean(prcp, na.rm = T), time]

#Put all sets together to use multiplot for 3 examples
set_1 <- data.frame(scalegram(gpm_prcp_nl$V1, plot = F), dataset = "gpm")
set_2 <- data.frame(scalegram(rdr_prcp_nl$V1, plot = F), dataset = "radar")
set_3 <- data.frame(scalegram(knmi_prcp_nl$V1, plot = F), dataset = "station")
set_4 <- data.frame(scalegram(ncep_prcp$prcp, plot = F), dataset = "ncep")
set_5 <- data.frame(scalegram(cnrm_prcp$prcp, plot = F), dataset = "cnrm")

g1 <- scalegram_multiplot(rbind(set_1, set_2, set_3, set_4, set_5))

set_1 <- data.frame(scalegram(gpm_prcp_nl$V1, plot = F, fast = F), dataset = "gpm")
set_2 <- data.frame(scalegram(rdr_prcp_nl$V1, plot = F, fast = F), dataset = "radar")
set_3 <- data.frame(scalegram(knmi_prcp_nl$V1, plot = F, fast = F), dataset = "station")
set_4 <- data.frame(scalegram(ncep_prcp$prcp, plot = F, fast = F), dataset = "ncep")
set_5 <- data.frame(scalegram(cnrm_prcp$prcp, plot = F, fast = F), dataset = "cnrm")

g2 <- scalegram_multiplot(rbind(set_1, set_2, set_3, set_4, set_5))

set_1 <- data.frame(scalegram(gpm_prcp_nl$V1, plot = F, fast = T), dataset = "gpm")
set_2 <- data.frame(scalegram(rdr_prcp_nl$V1, plot = F, fast = T), dataset = "radar")
set_3 <- data.frame(scalegram(knmi_prcp_nl$V1, plot = F, fast = T), dataset = "station")
set_4 <- data.frame(scalegram(ncep_prcp$prcp, plot = F, fast = T), dataset = "ncep")
set_5 <- data.frame(scalegram(cnrm_prcp$prcp, plot = F, fast = T), dataset = "cnrm")

g3 <- scalegram_multiplot(rbind(set_1, set_2, set_3, set_4, set_5), smooth = T)

gg_all <- ggarrange(g1$plot + theme(legend.position = c(0.81, 0.78), legend.background = element_rect(fill = NA)) , 
                    g2$plot  + rremove("legend"), g3$plot + rremove("legend"), 
                   labels = c("a", "b", "c"),
                   nrow = 1, ncol = 3)

ggsave("./results/figs/scalegrams_all.pdf", gg_all, units = "cm", width = 30, height = 10)
#set_1$var/set_5$var[1:13] Make a plot with the diffs of gpm and each other scalegram
