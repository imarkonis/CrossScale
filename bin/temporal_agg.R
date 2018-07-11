library(csa); library(ggpubr)

load("./data/temporal.Rdata")  #Created in data_prep

#Put all sets together to use multiplot for 3 examples
set_1 <- data.frame(csa(gpm_nl$prcp, plot = F), dataset = "gpm")
set_2 <- data.frame(csa(rdr_nl$prcp, plot = F), dataset = "radar")
set_3 <- data.frame(csa(knmi_nl$prcp, plot = F), dataset = "station")
set_4 <- data.frame(csa(ncep_nl$prcp, plot = F), dataset = "ncep")
set_5 <- data.frame(csa(cnrm_nl$prcp, plot = F), dataset = "cnrm")

g1 <- csa.multiplot(rbind(set_1, set_2, set_3, set_4, set_5))

set_1 <- data.frame(csa(gpm_nl$prcp, plot = F, fast = T), dataset = "gpm")
set_2 <- data.frame(csa(rdr_nl$prcp, plot = F, fast = T), dataset = "radar")
set_3 <- data.frame(csa(knmi_nl$prcp, plot = F, fast = T), dataset = "station")
set_4 <- data.frame(csa(ncep_nl$prcp, plot = F, fast = T), dataset = "ncep")
set_5 <- data.frame(csa(cnrm_nl$prcp, plot = F, fast = T), dataset = "cnrm")

g2 <- csa.multiplot(rbind(set_1, set_2, set_3, set_4, set_5))
g3 <- csa.multiplot(rbind(set_1, set_2, set_3, set_4, set_5), smooth = T)

gg_all <- ggarrange(g1 + theme(legend.position = c(0.81, 0.78), legend.background = element_rect(fill = NA)) , 
                    g2  + rremove("legend"), g3 + rremove("legend"), 
                   labels = c("a", "b", "c"),
                   nrow = 1, ncol = 3)

ggsave("./results/figs/csa_all.pdf", gg_all, units = "cm", width = 30, height = 10)
ggsave("./results/figs/csa_all.png", gg_all, units = "cm", width = 30, height = 10)

set_1_comp <- set_3[set_3$scale %in% set_1$scale, ]
set_1_comp$dataset <- set_1$dataset
set_1_comp$var <- set_1_comp$var/set_1$var

set_2_comp <- set_3[set_3$scale %in% set_2$scale, ]
set_2_comp$dataset <- set_2$dataset
set_2_comp$var  <- set_2_comp$var/set_2$var

set_4_comp <- set_3[set_3$scale %in% set_4$scale, ]
set_4_comp$dataset <- set_4$dataset
set_4_comp$var <- set_4_comp$var/set_4$var

set_5_comp <- set_3[set_3$scale %in% set_5$scale, ]
set_5_comp$dataset <- set_5$dataset
set_5_comp$var <- set_5_comp$var/set_5$var

set_comp <- rbind(set_1_comp, set_2_comp, set_4_comp, set_5_comp)
gg4 <- csa.multiplot(set_comp, log_x = T, log_y = F)

ggsave("./results/figs/csa_comp.pdf", gg4, units = "cm", width = 20, height = 10)
ggsave("./results/figs/csa_comp.png", gg4, units = "cm", width = 12, height = 10)

#set_1$var/set_5$var[1:13] Make a plot with the diffs of gpm and each other csa
