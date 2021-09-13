rm(list=ls())
load('featherRdata/barchart.Rdata')


#。2个态分开的，2个翼龙并排的，横着的barchart「2个图」
#再看一下0.33/0.99下的barchart【4个图】

all_model=c('pars_inc','pars_un','pars_order','ARD_inc','ARD_un','ARD_order','SYM_inc','SYM_un','SYM_order','ER_inc','ER_un','ER_order')
all_model=c('pars_order2','pars_un','pars_order','ARD_order2','ARD_un','ARD_order','SYM_order2','SYM_un','SYM_order','ER_order2','ER_un','ER_order')

#all_model_2=c('ER_order','ARD_order','par')
#介于过高过低都无法准确，所以在timesacle之后，0.33-0.66

m=as.matrix(t(multi_F_3))
opar = par(oma = c(0,1,0,1))
barplot(height = m,  # 绘图数据（矩阵）
        names.arg = all_model,  # 柱子名称
        col = c("#00AFBB", "#E7B800", "#FC4E07"),  # 填充颜色
        border = 'black',   # 轮廓颜色
        xlab = 'Ancestral_likelihoods',  # X轴名称
        #ylab = 'MODELS',  # Y轴名称
        main = 'Pterosauria_Filaments',  # 主标题
        horiz = TRUE,  # 是否为水平放置
        cex.axis = 1, cex.lab=1,las=1,cex.names = 0.7,
        ylim = c(0,20),# Y轴取值范围
        legend.text = c('Scales','Filaments','Feather'),
        args.legend = list(cex = 0.7,box.lty=0)# 图例文本
        )
  
m=as.matrix(t(multi_S_3))
opar = par(oma = c(0,1,0,1))
barplot(height = m,  # 绘图数据（矩阵）
        names.arg = all_model,  # 柱子名称
        col = c("#00AFBB", "#E7B800", "#FC4E07"),  # 填充颜色
        border = 'black',   # 轮廓颜色
        xlab = 'Ancestral_likelihoods',  # X轴名称
        #ylab = 'MODELS',  # Y轴名称
        main = 'Pterosauria_Scales',  # 主标题
        horiz = TRUE,  # 是否为水平放置
        cex.axis = 1, cex.lab=1,las=1,cex.names = 0.7,
        ylim = c(0,20),# Y轴取值范围
        legend.text = c('Scales','Filaments','Feather'),
        args.legend = list(cex = 0.7,box.lty=0)# 图例文本
)

