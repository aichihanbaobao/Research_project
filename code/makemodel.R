
library(ape)
library(paleotree)
library(phytools)
library(castor)
#创建3态模型
#---------------------------------------------------------------------------------------
#ER order
ER_order <- matrix(c(0,1,0, 1,0,1, 0,1,0),3,3,byrow=TRUE,
                   dimnames=list(c("a","b","c"),c("a","b","c")))
#ER unorder
ER_unorder <- matrix(c(0,1,1, 1,0,1, 1,1,0),3,3,byrow=TRUE,
                     dimnames=list(c("a","b","c"),c("a","b","c")))
#ER incorrect order
#only a to c  b to c
ER_incorder <- matrix(c(0,0,1, 0,0,1, 1,1,0),3,3,byrow=TRUE,
                      dimnames=list(c("a","b","c"),c("a","b","c")))
#only a to b  c to b
#ER_incorder2 <- matrix(c(0,1,0, 0,0,0, 0,1,0),3,3,byrow=TRUE,
#    dimnames=list(c("a","b","c"),c("a","b","c")))
#only b to a c to a
#ER_incorder3 <- matrix(c(0,0,0, 1,0,0, 1,0,0),3,3,byrow=TRUE,
#   dimnames=list(c("a","b","c"),c("a","b","c")))

ARD_order <- matrix(c(0,1,0, 2,0,3, 0,4,0),3,3,byrow=TRUE,
                    dimnames=list(c("a","b","c"),c("a","b","c")))

ARD_unorder <- matrix(c(0,1,2, 3,0,4, 5,6,0),3,3,byrow=TRUE,
                      dimnames=list(c("a","b","c"),c("a","b","c")))

ARD_incorder <- matrix(c(0,0,1, 0,0,2, 3,4,0),3,3,byrow=TRUE,
                       dimnames=list(c("a","b","c"),c("a","b","c")))

SYM_order <- matrix(c(0,1,0, 1,0,2, 0,2,0),3,3,byrow=TRUE,
                    dimnames=list(c("a","b","c"),c("a","b","c")))

SYM_unorder <- matrix(c(0,1,2, 1,0,3, 2,3,0),3,3,byrow=TRUE,
                      dimnames=list(c("a","b","c"),c("a","b","c")))

SYM_incorder <- matrix(c(0,0,1, 0,0,2, 1,2,0),3,3,byrow=TRUE,
                       dimnames=list(c("a","b","c"),c("a","b","c")))

#---------------------------------------------------------------------------------------
save(ER_order,ER_unorder,ER_incorder,ARD_order,ARD_unorder,ARD_incorder,SYM_order,SYM_unorder,SYM_incorder,file = 'Rdata/multi-state-model.Rdata')




