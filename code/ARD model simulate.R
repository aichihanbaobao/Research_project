rm(list = ls())
library(phangorn)
library(phytools)

#parallel
library(foreach)
library(doParallel)
detectCores()#12
cl <- makeCluster(getOption("cl.cores", 10))
registerDoParallel(cl)


#load all data
load('Rdata/multi-state-model.Rdata')
load('Rdata/funct.Rdata')
load('Rdata/tree.Rdata')
alltree <- c(t32_sym,t32_asym,t64_sym,t64_asym,t128_sym,t128_asym,t256_sym,t256_asym,t512_sym,t512_asym)
all_tree_tips <- c('32','32','64','64','128','128','256','256','512','512')
all_tree_types <- c('sym','asym','sym','asym','sym','asym','sym','asym','sym','asym')



#define function for parallel
func <- function(tree,y,z){
  n <- 0
  m <- matrix(nrow=0,ncol=14)
  
  ##Calculate the accuracy of each ASR model by compare node_states
  accuracy <- function(x){
    acc <- 0
    for (i in 1:nrow(x)) {
      acc <- acc + x[i,node_states[i]]
    }
    acc <- acc/nrow(x)
  }
  
  #repeat 200 times 
  while(n<200){
    Q <- get_random_mk_transition_matrix(3, rate_model=ARD_order, min_rate=0.8, max_rate=1)
    E <- simulate_mk_model(tree, Q)
    tip_states <- E$tip_states
    node_states <- E$node_states
    
    #如果缺少某一个state或者min的值小于0.1
    filt_1 <- min(table(tip_states)/length(tip_states))
    filt_2 <- dim(table(tip_states))
    if (filt_1 <0.05 | filt_2 < 3)
      next
    n <- n+1
    
    #ASR
    results_ER_order <-  asr_mk_model(tree, tip_states, 3, rate_model=ER_order, Ntrials=2)
    results_ER_unorder <-  asr_mk_model(tree, tip_states, 3, rate_model=ER_unorder, Ntrials=2)
    results_ER_incorder <-  asr_mk_model(tree, tip_states, 3, rate_model=ER_incorder, Ntrials=2)
    results_pars_order <- asr_max_parsimony(tree, tip_states, 3, transition_costs = ER_order)
    results_pars_unorder <- asr_max_parsimony(tree, tip_states, 3,transition_costs = ER_unorder)
    results_pars_incorder <- asr_max_parsimony(tree, tip_states, 3, transition_costs = ER_incorder)
    results_ARD_order <-  asr_mk_model(tree, tip_states, 3, rate_model=ARD_order, Ntrials=2)
    results_ARD_unorder <-  asr_mk_model(tree, tip_states, 3, rate_model=ARD_unorder, Ntrials=2)
    results_ARD_incorder <-  asr_mk_model(tree, tip_states, 3, rate_model=ARD_incorder, Ntrials=2)
    results_SYM_order <-  asr_mk_model(tree, tip_states, 3, rate_model=SYM_order, Ntrials=2)
    results_SYM_unorder <-  asr_mk_model(tree, tip_states, 3, rate_model=SYM_unorder, Ntrials=2)
    results_SYM_incorder <-  asr_mk_model(tree, tip_states, 3, rate_model=SYM_incorder, Ntrials=2)
    
    #accurate ASR
    acc_ER_order <- accuracy(results_ER_order$ancestral_likelihoods)
    acc_ER_unorder <- accuracy(results_ER_unorder$ancestral_likelihoods)
    acc_ER_incorder <- accuracy(results_ER_incorder$ancestral_likelihoods)
    acc_pars_order <- accuracy(results_pars_order$ancestral_likelihoods)
    acc_pars_unorder <- accuracy(results_pars_unorder$ancestral_likelihoods)
    acc_pars_incorder <- accuracy(results_pars_incorder$ancestral_likelihoods)
    acc_ARD_order <- accuracy(results_ARD_order$ancestral_likelihoods)
    acc_ARD_unorder <- accuracy(results_ARD_unorder$ancestral_likelihoods)
    acc_ARD_incorder <- accuracy(results_ARD_incorder$ancestral_likelihoods)
    acc_SYM_order <- accuracy(results_SYM_order$ancestral_likelihoods)
    acc_SYM_unorder <- accuracy(results_SYM_unorder$ancestral_likelihoods)
    acc_SYM_incorder <- accuracy(results_SYM_incorder$ancestral_likelihoods)
    
    
    x <-c(acc_ER_order, acc_ER_unorder, acc_ER_incorder, acc_pars_order, acc_pars_unorder, acc_pars_incorder,acc_ARD_order, acc_ARD_unorder, acc_ARD_incorder,acc_SYM_order, acc_SYM_unorder, acc_SYM_incorder,y,z)
    m <- rbind(m,x)
  }
  return(m)
}


#begin parallel
system.time({data <- foreach(tree=alltree,y=all_tree_tips,z=all_tree_types,.combine='rbind',.packages = "castor") %dopar% func(tree,y,z);})
colnames(data)=c('ER_order','ER_un','ER_inc','pars_order','pars_un','pars_inc','ARD_order','ARD_un','ARD_inc','SYM_order','SYM_un','SYM_inc','tree_tips','tree_type')
save(data,file = 'Rdata/ARD_Simulate_0.80_1.00.Rdata')
stopCluster(cl)


