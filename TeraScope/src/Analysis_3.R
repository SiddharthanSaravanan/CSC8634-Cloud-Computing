## eda on hostnames

# adding a series to hostname-----------------------------------------------------------------------------------------------

final_host_gpu_performance = final_host_gpu_performance[order(final_host_gpu_performance$hostname),]
rownames(final_host_gpu_performance) = 1:nrow(final_host_gpu_performance)
final_host_gpu_performance$index = seq(1:nrow(final_host_gpu_performance))

## plot of gpu power drawn with series

(plot_14 = ggplot(final_host_gpu_performance, aes(index, total_power_drawnW/1000))+ geom_line()+ylim(100,130)+
    labs(y = "total power drawn in kilowatt"))
ggsave(file.path('graphs', 'Power drawn by gpu nodes in series.png'))
##----------------------------------------------------------------------------------------------------------------------------------

## barplot outliers of hostnames based on all gpu performance variables and stack them beside each other -----------------------------------------------

## top and bottom outliers of variables 1 - total power drawn
#top
lst <- sort(final_host_gpu_performance$total_power_drawnW, index.return=TRUE, decreasing=TRUE)
lapply = lapply(lst, `[`, lst$x %in% head(unique(lst$x),10))
final_host_gpu_performance_i_top_1 = lapply$ix


#bottom
lst <- sort(final_host_gpu_performance$total_power_drawnW, index.return=TRUE, decreasing=TRUE)
lapply = lapply(lst, `[`, lst$x %in% tail(unique(lst$x),10))
final_host_gpu_performance_i_bottom_1 = lapply$ix

final_host_gpu_performance_i_1 = c(final_host_gpu_performance_i_top_1,final_host_gpu_performance_i_bottom_1)
outliers_final_host_gpu_performance_1 = final_host_gpu_performance[final_host_gpu_performance_i_1,c(1,2,6)]
outliers_final_host_gpu_performance_1$index = as.character(outliers_final_host_gpu_performance_1$index)

(plot_15 = ggplot(outliers_final_host_gpu_performance_1,aes(x = reorder(index, desc(-total_power_drawnW/1000)),total_power_drawnW/1000))+ 
    geom_col(aes(fill = total_power_drawnW/1000))+theme(axis.text.x=element_blank())+
    labs(x = "", y = "total power drawn in kilo watt"))


## top and bottom outliers of variables 2 - average_gpu_temp
#top
lst <- sort(final_host_gpu_performance$average_gpu_tempC, index.return=TRUE, decreasing=TRUE)
lapply = lapply(lst, `[`, lst$x %in% head(unique(lst$x),10))
final_host_gpu_performance_i_top_2 = lapply$ix
#bottom
lst <- sort(final_host_gpu_performance$average_gpu_tempC, index.return=TRUE, decreasing=TRUE)
lapply = lapply(lst, `[`, lst$x %in% tail(unique(lst$x),10))
final_host_gpu_performance_i_bottom_2 = lapply$ix

final_host_gpu_performance_i_2 = c(final_host_gpu_performance_i_top_2,final_host_gpu_performance_i_bottom_2)
outliers_final_host_gpu_performance_2 = final_host_gpu_performance[final_host_gpu_performance_i_2,c(1,3,6)]
outliers_final_host_gpu_performance_2$index = as.character(outliers_final_host_gpu_performance_2$index)

(plot_16 = ggplot(outliers_final_host_gpu_performance_2,aes(x = reorder(index, desc(-average_gpu_tempC)),average_gpu_tempC))+ 
    geom_col(aes(fill = average_gpu_tempC))+theme(axis.text.x=element_blank())+
    labs(x = "", y = "average_gpu_temp"))



## top and bottom outliers of variables 3 - average_gpu_util
#top
lst <- sort(final_host_gpu_performance$average_gpu_utilP, index.return=TRUE, decreasing=TRUE)
lapply = lapply(lst, `[`, lst$x %in% head(unique(lst$x),10))
final_host_gpu_performance_i_top_3 = lapply$ix
#bottom
lst <- sort(final_host_gpu_performance$average_gpu_utilP, index.return=TRUE, decreasing=TRUE)
lapply = lapply(lst, `[`, lst$x %in% tail(unique(lst$x),10))
final_host_gpu_performance_i_bottom_3 = lapply$ix

final_host_gpu_performance_i_3 = c(final_host_gpu_performance_i_top_3,final_host_gpu_performance_i_bottom_3)
outliers_final_host_gpu_performance_3 = final_host_gpu_performance[final_host_gpu_performance_i_3,c(1,4,6)]
outliers_final_host_gpu_performance_3$index = as.character(outliers_final_host_gpu_performance_3$index)

(plot_17 = ggplot(outliers_final_host_gpu_performance_3,aes(x = reorder(index, desc(-average_gpu_utilP)),average_gpu_utilP))+ 
    geom_col(aes(fill = average_gpu_utilP))+theme(axis.text.x=element_blank())+
    labs(x = "", y = "average_gpu_util"))





## top and bottom outliers of variables 4 - average_gpu_memory_util
#top
lst <- sort(final_host_gpu_performance$average_gpu_memory_utilP, index.return=TRUE, decreasing=TRUE)
lapply = lapply(lst, `[`, lst$x %in% head(unique(lst$x),10))
final_host_gpu_performance_i_top_4 = lapply$ix
#bottom
lst <- sort(final_host_gpu_performance$average_gpu_memory_utilP, index.return=TRUE, decreasing=TRUE)
lapply = lapply(lst, `[`, lst$x %in% tail(unique(lst$x),10))
final_host_gpu_performance_i_bottom_4 = lapply$ix

final_host_gpu_performance_i_4 = c(final_host_gpu_performance_i_top_4,final_host_gpu_performance_i_bottom_4)
outliers_final_host_gpu_performance_4 = final_host_gpu_performance[final_host_gpu_performance_i_4,c(1,5,6)]
outliers_final_host_gpu_performance_4$index = as.character(outliers_final_host_gpu_performance_4$index)

(plot_18 = ggplot(outliers_final_host_gpu_performance_4,aes(x = reorder(index, desc(-average_gpu_memory_utilP)),average_gpu_memory_utilP))+ 
    geom_col(aes(fill = average_gpu_memory_utilP))+theme(axis.text.x=element_blank())+
    labs(x = "", y = "average_gpu_memory_util"))




(group_plot_3 = ggarrange(plot_15, plot_16, plot_17, plot_18, 
          labels = c("A", "B", "C","D"),
          ncol = 2, nrow = 2)) %>% ggexport(filename = "graphs/head -tail values of gpu performance variables of gpu hosts.png",
                                           width = 1500,height = 1500)

##------------------------------------------------------------------------------------------------------------------------------------------------------