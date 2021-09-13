rm(list = ls())
library(phangorn)
library(phytools)
library(castor)

tree <- read.nexus("empirical_data/feather.nex")
plot(ladderize(tree))
is.rooted(tree)

char <- as.data.frame(readxl::read_xlsx("empirical_data/Barrett 2015 supply.xlsx",skip = 2))
char_1 <- char[,c(3,4,9,11:16)]
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
xxxx=as.data.frame(char_1[,1:2])




#time scales branch length by FAD（max）???没弄完
ttree= bin_timePaleoPhy(
  tree = tree,
  timeList = char_1[,1:2],
  type = "mbl",
  vartime = 1, 
  ntrees = 1, 
  plot = TRUE
)


load("featherRdata/ER_order_S_3.Rdata")
load("featherRdata/pars_unorder_S_3.Rdata")
load("featherRdata/pars_order_S_3.Rdata")
load("featherRdata/pars_incorder_S_3.Rdata")
load("featherRdata/ARD_unorder_S_3.Rdata")
load("featherRdata/ARD_order_S_3.Rdata")
load("featherRdata/ARD_incorder_S_3.Rdata")



#multi-state Pterosauria-Scales(1)
tip_states4 <- c(1,2,1,1,1,1,1,1,1,1,1,3,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,3,2,1,1,2,1,2,2,3,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,2,3,3)

feed.mode<-setNames(tip_states4,char_1[,1])
cols<-setNames(c("#00AFBB", "#E7B800", "#FC4E07"),levels(as.factor(feed.mode)))

plotTree(tree,offset=1,fsize=0.6,ftype="i",lwd=1)
nodelabels(node=1:tree$Nnode+Ntip(tree),cex=0.3,
           pie=x$ancestral_likelihoods,piecol=cols)
tiplabels(pie=to.matrix(feed.mode[tree$tip.label],levels(as.factor(feed.mode))),
          piecol=cols,cex=0.2,adj = 0.52)
legend("topleft",c('Scales','Filaments','Feather'),pch=21,pt.cex=1.3,pt.bg=cols,cex = 0.8,box.lty=0)









load("featherRdata/ER_order_F_3.Rdata")
load("featherRdata/ER_incorder_F_3.Rdata")
load("featherRdata/SYM_incorder_F_3.Rdata")
load("featherRdata/pars_unorder_F_3.Rdata")
load("featherRdata/pars_order_F_3.Rdata")
load("featherRdata/pars_incorder_F_3.Rdata")
load("featherRdata/ARD_unorder_F_3.Rdata")
load("featherRdata/ARD_order_F_3.Rdata")
load("featherRdata/ARD_incorder_F_3.Rdata")




#Filaments(2)
tip_states3 <- c(2,2,1,1,1,1,1,1,1,1,1,3,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,3,2,1,1,2,1,2,2,3,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,2,3,3)

feed.mode<-setNames(tip_states3,char_1[,1])
cols<-setNames(c("#00AFBB", "#E7B800", "#FC4E07"),levels(as.factor(feed.mode)))

plotTree(tree,offset=1,fsize=0.6,ftype="i",lwd=1)
nodelabels(node=1:tree$Nnode+Ntip(tree),cex=0.3,
           pie=x$ancestral_likelihoods,piecol=cols)
tiplabels(pie=to.matrix(feed.mode[tree$tip.label],levels(as.factor(feed.mode))),
          piecol=cols,cex=0.2,adj = 0.52)
legend("topleft",c('Scales','Filaments','Feather'),pch=21,pt.cex=1.3,pt.bg=cols,cex = 0.8,box.lty=0)


