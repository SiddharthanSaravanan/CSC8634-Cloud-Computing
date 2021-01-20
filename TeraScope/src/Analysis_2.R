## based on x,y, and each gpu performance variable----------------------------------------------------

(plot_6 = ggplot(gpu_total_render, aes(y, -x)) + geom_tile(aes(fill = total_power_drawnW)))

(plot_7 = ggplot(gpu_total_render, aes(y, -x)) + geom_tile(aes(fill = average_gpu_tempC)))

(plot_8 = ggplot(gpu_total_render, aes(y, -x)) + geom_tile(aes(fill = average_gpu_utilP)))

(plot_9 = ggplot(gpu_total_render, aes(y, -x)) + geom_tile(aes(fill = average_gpu_memory_utilP)))



(group_plot_2 = ggarrange(plot_6, plot_7, plot_8, plot_9, labels = c("A", "B", "C","D"),
                                     ncol = 2, nrow = 2)) %>% ggexport(filename = "graphs/Heat Map based on GPU performance.png",width = 1500,height = 1500)

## outliers on heat map based on total power drawn---------------------------------
list <- sort(gpu_total_render$total_power_drawnW, index.return=TRUE, decreasing=TRUE)
lapply = lapply(list, `[`, list$x %in% head(unique(list$x),10))
gpu_i_top = lapply$ix

lapply = lapply(list, `[`, list$x %in% tail(unique(list$x),10))
gpu_i_bottom = lapply$ix

gpu_i = c(gpu_i_top, gpu_i_bottom)

outliers_total_power_drawn = gpu_total_render[gpu_i,]

(plot_10 = ggplot(gpu_total_render, aes(y, -x)) +geom_tile(aes(fill = average_gpu_memory_utilP))+
    geom_point(data = outliers_total_power_drawn,aes(y,-x, color = total_power_drawnW))+
    scale_color_gradient(low = "green", high = "red"))


##--------------------------------------------------------------------------------


## outliers on heat map based on average_gpu_temp---------------------------------
list <- sort(gpu_total_render$average_gpu_tempC, index.return=TRUE, decreasing=TRUE)
lapply = lapply(list, `[`, list$x %in% head(unique(list$x),10))
gpu_i_top = lapply$ix

lapply = lapply(list, `[`, list$x %in% tail(unique(list$x),10))
gpu_i_bottom = lapply$ix

gpu_i = c(gpu_i_top, gpu_i_bottom)

outliers_average_gpu_temp = gpu_total_render[gpu_i,]

(plot_11 = ggplot(gpu_total_render, aes(y, -x)) +geom_tile(aes(fill = average_gpu_memory_utilP))+
    geom_point(data = outliers_average_gpu_temp,aes(y,-x, color = average_gpu_tempC))+
    scale_color_gradient(low = "green", high = "red"))


##--------------------------------------------------------------------------------


## outliers on heat map based on average_gpu_util---------------------------------
list <- sort(gpu_total_render$average_gpu_utilP, index.return=TRUE, decreasing=TRUE)
lapply = lapply(list, `[`, list$x %in% head(unique(list$x),10))
gpu_i_top = lapply$ix

lapply = lapply(list, `[`, list$x %in% tail(unique(list$x),10))
gpu_i_bottom = lapply$ix

gpu_i = c(gpu_i_top, gpu_i_bottom)

outliers_average_gpu_util = gpu_total_render[gpu_i,]

(plot_12 = ggplot(gpu_total_render, aes(y, -x)) +geom_tile(aes(fill = average_gpu_memory_utilP))+
    geom_point(data = outliers_average_gpu_util,aes(y,-x, color = average_gpu_utilP))+
    scale_color_gradient(low = "green", high = "red"))


##--------------------------------------------------------------------------------


## outliers on heat map based on average_gpu_memory_util---------------------------------
list <- sort(gpu_total_render$average_gpu_memory_utilP, index.return=TRUE, decreasing=TRUE)
lapply = lapply(list, `[`, list$x %in% head(unique(list$x),10))
gpu_i_top = lapply$ix

lapply = lapply(list, `[`, list$x %in% tail(unique(list$x),10))
gpu_i_bottom = lapply$ix

gpu_i = c(gpu_i_top, gpu_i_bottom)

outliers_average_gpu_memory_util = gpu_total_render[gpu_i,]

(plot_13 = ggplot(gpu_total_render, aes(y, -x)) +geom_tile(aes(fill = average_gpu_memory_utilP))+
    geom_point(data = outliers_average_gpu_memory_util,aes(y,-x, color = average_gpu_memory_utilP))+
    scale_color_gradient(low = "green", high = "red"))

##--------------------------------------------------------------------------------
(group_plot_3 = ggarrange(plot_10, plot_11, plot_12, plot_13, 
                    labels = c("Outlier based on Power Drawn", "Outlier based on Average Temp", "Outlier based on Average GPU util",
                               "Outlier based on Average GPU Memory Util"),
                    ncol = 2, nrow = 2)) %>% ggexport(filename = "graphs/Outliers of gpu performance.png",
                                                      width = 1500,height = 1500)

####-----------------------------------------------------------------------------------------------------------------------

