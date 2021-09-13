rm(list = ls())
#build a 256 tips tree:symmetric and asymmetric
library(phangorn)
library(phytools)
library(castor)

make.sym.tree <- function(n = 32){
  if(((log2(n))%%1==0) == FALSE){
    stop("n is not in the geometric sequence: a1= 2, r = 2")
  }
  taxa <- paste("t", 1:n, sep = "")
  taxa <- as.list(taxa)
  repeat{
    taxa2 <- list()
    j <- 0
    for(i in 1:(length(taxa)/2)){
      taxa2[[i]] <- paste("(", taxa[[(i + j)]], ",", taxa[[(i + j + 1)]], ")", sep = "") 
      j <- j + 1
    } 
    taxa <- taxa2
    if(length(taxa) == 1){
      break
    }
  }
  tree <- paste(taxa[[1]], ";", sep = "")
  tree <- read.newick(text = tree)
  tree$edge.length <- rep(1/ (log2(n)), nrow(tree$edge))
  return(tree)
}

#function to make a perfectly asymmetrical tree with a height of 1
make.asym.tree <- function(n = 32){
  taxa <- paste("t", 1:n, sep = "")
  taxa <- as.list(taxa)
  bl <- 1/(n - 1)
  tree <- paste(taxa[[1]], ":", bl, sep = "") 
  for(i in 2:n){
    tree <- paste("(", tree, ",", taxa[[i]], ":", (bl * (i-1)), ")", sep = "")
    if(i != n){
      tree <- paste(tree, ":", bl, sep = "")
    }
  }
  tree <- paste(tree, ";", sep = "")
  tree <- read.newick(text = tree)
  return(tree)
}

#最后要用循环写出来
#---------------------------------------------------------------------------------------
#make a symmetrical tree of 32 tips
t32_sym <- make.sym.tree()
plot(t32_sym, cex = 0.5)

#make a asymmetrical tree of 32 tips
t32_asym<- make.asym.tree()
plot(t32_asym, cex = 0.5)
#---------------------------------------------------------------------------------------




#---------------------------------------------------------------------------------------
#make a symmetrical tree of 64 tips
t64_sym <- make.sym.tree(64)
plot(t64_sym, cex = 0.5)

#make a asymmetrical tree of 64 tips
t64_asym<- make.asym.tree(64)
plot(t64_asym, cex = 0.5)
#---------------------------------------------------------------------------------------




#---------------------------------------------------------------------------------------
#make a symmetrical tree of 128 tips
t128_sym <- make.sym.tree(128)
plot(t128_sym, cex = 0.5)

#make a asymmetrical tree of 128 tips
t128_asym<- make.asym.tree(128)
plot(t128_asym, cex = 0.5)
#---------------------------------------------------------------------------------------




#---------------------------------------------------------------------------------------
#make a symmetrical tree of 256 tips
t256_sym <- make.sym.tree(256)
plot(t256_sym, cex = 0.5)

#make a asymmetrical tree of 256 tips
t256_asym<- make.asym.tree(256)
plot(t256_asym, cex = 0.5)
#---------------------------------------------------------------------------------------




#---------------------------------------------------------------------------------------
#make a symmetrical tree of 512 tips
t512_sym <- make.sym.tree(512)
plot(t512_sym, cex = 0.5)

#make a asymmetrical tree of 512 tips
t512_asym<- make.asym.tree(512)
plot(t512_asym, cex = 0.5)
#---------------------------------------------------------------------------------------

save(t32_sym,t32_asym,t64_sym,t64_asym,t128_sym,t128_asym,t256_sym,t256_asym,t512_sym,t512_asym, file = 'tree.Rdata')
#load('tree.Rdata')
