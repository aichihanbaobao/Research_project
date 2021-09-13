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
data = as_tibble(data)
#多一步整理数据
data <- data %>%
  gather(key = "text", value ="value",-tree_tips,-tree_type)

data[,4]=as.numeric(unlist(data[,4]))
colnames(data)[3] <- "MODELS"
data$MODELS<- factor(data$MODELS,levels=c('ER_order','ER_un','ER_inc','SYM_order','SYM_un','SYM_inc','ARD_order','ARD_un','ARD_inc','pars_order','pars_un','pars_inc'))
#---------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------
plot <- ggplot(data,aes(y=value, x=MODELS,  fill=MODELS)) +
 # stat_boxplot(geom ='errorbar', width = 0.6,)+
  geom_boxplot(linetype = "dashed",outlier.alpha = 0.1) +
  stat_boxplot(aes(ymin = ..lower.., ymax = ..upper..),outlier.alpha = 0.1) +
  stat_boxplot(geom = "errorbar", aes(ymin = ..ymax..)) +
  stat_boxplot(geom = "errorbar", aes(ymax = ..ymin..))+
  theme_ridges(font_size = 10,line_size = 0.1) +
  theme_bw()+
  theme(legend.position = "bottom",
        legend.text.align = 0,
        legend.title.align = 0.5,
        legend.key.width=unit(0.52,'cm'),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank()
  ) +
  scale_fill_cyclical(values = c("#028174","#028174","#028174","#248BD6","#248BD6","#248BD6","#FA9F42","#FA9F42","#FA9F42","#F3533A", "#F3533A","#F3533A"), 
                      guide =guide_legend(nrow = 1,
                      label.position = "bottom",
                      title.position = "bottom",
                      
                      label.vjust = 0.55,
                      label.theme = element_text(angle = 270,size = 10)))+
  xlab(" ") +
  ylab("ACCURACY")+
  facet_grid(tree_type ~ factor(tree_tips, levels=c('32','64','128','256','512')))

plot
  #---------------------------------------------------------------------------------------

