rm(list=ls())
library(ggridges)
library(ggplot2)
library(dplyr)
library(tidyr)
library(forcats)
library(Rmisc)  
library(ggpubr) 

load('Rdata/Simulate_0.33_0.66.Rdata')
#load('Rdata/Simulate_0.80_1.00.Rdata')
#load('Rdata/Simulate_0.00_0.20.Rdata')
#load('Rdata/ARD_Simulate_0.33_0.66.Rdata')
#load('Rdata/ARD_Simulate_0.80_1.00.Rdata')
#load('Rdata/ARD_Simulate_0.00_0.20.Rdata')

#---------------------------------------------------------------------------------------
data <- as_tibble(data)
#多一步整理数据
data <- data %>%
  gather(key = "text", value ="value",-tree_tips,-tree_type)

data[,4] <- as.numeric(unlist(data[,4]))
colnames(data)[3] <- "MODELS"
data$MODELS<- factor(data$MODELS,levels=c('pars_inc','pars_un','pars_order','ARD_inc','ARD_un','ARD_order','SYM_inc','SYM_un','SYM_order','ER_inc','ER_un','ER_order'))
#---------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------
plot <- ggplot(data,aes(y=MODELS, x=value,  fill=MODELS)) +
  geom_density_ridges(alpha=0.9, stat="binline", scale = 0.85, bins=20, size = 0.3, draw_baseline = FALSE) +
  theme_ridges(font_size = 10,line_size = 0.1) +
  theme(
    legend.position="none",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 10)
  ) +
  theme_bw()+
  scale_fill_cyclical(values = c("#F3533A", "#F3533A","#F3533A","#FA9F42","#FA9F42","#FA9F42","#248BD6","#248BD6","#248BD6","#028174","#028174","#028174"), guide = guide_legend(reverse = TRUE))+
  xlab("ACCURACY") +
  ylab("MODELS")+
  xlim(0.3,1.1)+
  #facet_grid(tree_type ~ tree_tips )+
  facet_grid(tree_type ~ factor(tree_tips, levels=c('32','64','128','256','512')))

plot

















