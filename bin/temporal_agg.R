library(scalegram); library(ggpubr)

load("./data/temporal.Rdata")  #Created in data_prep

#Put all sets together to use multiplot for 3 examples
set_1 <- data.frame(scalegram(gpm_nl$V1, plot = F), dataset = "gpm")
set_2 <- data.frame(scalegram(rdr_nl$V1, plot = F), dataset = "radar")
set_3 <- data.frame(scalegram(knmi_nl$V1, plot = F), dataset = "station")
set_4 <- data.frame(scalegram(ncep_prcp$prcp, plot = F), dataset = "ncep")
set_5 <- data.frame(scalegram(cnrm_prcp$prcp, plot = F), dataset = "cnrm")

g1 <- scalegram_multiplot(rbind(set_1, set_2, set_3, set_4, set_5))

set_1 <- data.frame(scalegram(gpm_nl$V1, plot = F, fast = T), dataset = "gpm")
set_2 <- data.frame(scalegram(rdr_nl$V1, plot = F, fast = T), dataset = "radar")
set_3 <- data.frame(scalegram(knmi_nl$V1, plot = F, fast = T), dataset = "station")
set_4 <- data.frame(scalegram(ncep_prcp$prcp, plot = F, fast = T), dataset = "ncep")
set_5 <- data.frame(scalegram(cnrm_prcp$prcp, plot = F, fast = T), dataset = "cnrm")

g2 <- scalegram_multiplot(rbind(set_1, set_2, set_3, set_4, set_5))

set_1 <- data.frame(scalegram(gpm_nl$V1, plot = F, fast = T), dataset = "gpm")
set_2 <- data.frame(scalegram(rdr_nl$V1, plot = F, fast = T), dataset = "radar")
set_3 <- data.frame(scalegram(knmi_nl$V1, plot = F, fast = T), dataset = "station")
set_4 <- data.frame(scalegram(ncep_prcp$prcp, plot = F, fast = T), dataset = "ncep")
set_5 <- data.frame(scalegram(cnrm_prcp$prcp, plot = F, fast = T), dataset = "cnrm")

g3 <- scalegram_multiplot(rbind(set_1, set_2, set_3, set_4, set_5), smooth = T)

gg_all <- ggarrange(g1$plot + theme(legend.position = c(0.81, 0.78), legend.background = element_rect(fill = NA)) , 
                    g2$plot  + rremove("legend"), g3$plot + rremove("legend"), 
                   labels = c("a", "b", "c"),
                   nrow = 1, ncol = 3)

ggsave("./results/figs/scalegrams_all.pdf", gg_all, units = "cm", width = 30, height = 10)


#set_1$var/set_5$var[1:13] Make a plot with the diffs of gpm and each other scalegram
