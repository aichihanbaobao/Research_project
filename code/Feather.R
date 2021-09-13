rm(list=ls())
library(ape)
library(paleotree)
library(phytools)
library(castor)

#获取3态模型，2态模型
load('Rdata/multi-state-model.Rdata')
tree <- read.nexus("empirical_data/feather.nex")
plot(ladderize(tree))
is.rooted(tree)

char <- as.data.frame(readxl::read_xlsx("empirical_data/Barrett 2015 supply.xlsx",skip = 2))
char_1 <- char[,c(3,4,11:16)]
head(char_1)
#char_1 <- na.omit(char_1)
char_1[,1] <- paste(char_1[,1],char_1[,2], sep = "_")
char_1 <- char_1[,-2]
head(char_1)

identical(tree$tip.label,char_1[,1])
char_1 <- char_1[match(tree$tip.label,char_1[,1]),]

#bulid Pterosauria
char_1[1,1] <- 'Pterosauria'
identical(tree$tip.label,char_1[,1])

#计算branch length by FAD（max）????????????


all_model=c('pars_incorder','pars_unorder','pars_order','ARD_incorder','ARD_unorder','ARD_order','SYM_incorder','SYM_unorder','SYM_order','ER_incorder','ER_unorder','ER_order')

#不同模型12，不同翼龙2，2/3态 2，【48个图】



#开始写模型的loop，

#multi-state Pterosauria-filaments(2)
tip_states3 <- c(2,2,1,1,1,1,1,1,1,1,1,3,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,3,2,1,1,2,1,2,2,3,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,2,3,3)
m <- matrix(nrow=0,ncol=3)
for (i in 1:3){
  x <- asr_max_parsimony(tree, tip_states3, 3, transition_costs =get(all_model[(i+9)]) )
  m <- rbind(m,  x$ancestral_likelihoods[1,])
  save(x,file = paste0('featherRdata/',all_model[i],'_F_3.Rdata'))
}
for (i in 4:12){
  x <- asr_mk_model(tree, tip_states3, 3, rate_model=get(all_model[i]), Ntrials=2)
  m <- rbind(m,  x$ancestral_likelihoods[1,])
  assign(paste0(all_model[i],'_F_3'),x)
  save(x,file = paste0('featherRdata/',all_model[i],'_F_3.Rdata'))
}  


multi_F_3 <- m
  
#multi-state Pterosauria-Scales(1)
tip_states4 <- c(1,2,1,1,1,1,1,1,1,1,1,3,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,3,2,1,1,2,1,2,2,3,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,2,3,3)
m <- matrix(nrow=0,ncol=3)

for (i in 1:3){
  x <- asr_max_parsimony(tree, tip_states4, 3, transition_costs =get(all_model[i+9]) )
  m <- rbind(m,  x$ancestral_likelihoods[1,])
  save(x,file = paste0('featherRdata/',all_model[i],'_S_3.Rdata'))
}
for (i in 4:12){
  x <- asr_mk_model(tree, tip_states4, 3, rate_model=get(all_model[i]), Ntrials=2)
  m <- rbind(m,  x$ancestral_likelihoods[1,])
  assign(paste0(all_model[i],'_F_3'),x)
  save(x,file = paste0('featherRdata/',all_model[i],'_S_3.Rdata'))
}  

multi_S_3 <- m



save(multi_F_3,multi_S_3,file = 'featherRdata/barchart.Rdata' )

