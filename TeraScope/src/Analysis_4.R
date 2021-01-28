#Finding top 10 task id's based on GPU variables:
outliers_total_power_drawn_top10 = as.data.frame(tail(outliers_total_power_drawn[order(outliers_total_power_drawn$total_power_drawnW),],10))

outliers_average_gpu_temp_top10 = as.data.frame(tail(outliers_average_gpu_temp[order(outliers_average_gpu_temp$average_gpu_tempC),],10))

outliers_average_gpu_util_top10 = as.data.frame(tail(outliers_average_gpu_util[order(outliers_average_gpu_util$average_gpu_utilP),],10))

outliers_average_gpu_memory_util_top10 = as.data.frame(tail(outliers_average_gpu_memory_util[order(outliers_average_gpu_memory_util$average_gpu_memory_utilP),],10))

outliers_total_power_drawn_top10$category = "Total_power_drawn"
outliers_average_gpu_temp_top10$category = "Average_GPU_Temp"
outliers_average_gpu_util_top10$category = "Average_GPU_Util"
outliers_average_gpu_memory_util_top10$category = "Average_GPU_Memory_Util"

outliers_total_power_drawn_top10 = outliers_total_power_drawn_top10[order(desc(outliers_total_power_drawn_top10$total_power_drawnW)),]
outliers_average_gpu_temp_top10 = outliers_average_gpu_temp_top10[order(desc(outliers_average_gpu_temp_top10$average_gpu_tempC)),]
outliers_average_gpu_util_top10 = outliers_average_gpu_util_top10[order(desc(outliers_average_gpu_util_top10$average_gpu_utilP)),]
outliers_average_gpu_memory_util_top10 = outliers_average_gpu_memory_util_top10[order(desc(outliers_average_gpu_memory_util_top10$average_gpu_memory_utilP)),]


outliers_total_power_drawn_top10$rank = seq(1:nrow(outliers_total_power_drawn_top10))
outliers_average_gpu_temp_top10$rank = seq(1:nrow(outliers_average_gpu_temp_top10))
outliers_average_gpu_util_top10$rank = seq(1:nrow(outliers_average_gpu_util_top10))
outliers_average_gpu_memory_util_top10$rank = seq(1:nrow(outliers_average_gpu_memory_util_top10))


top_10_outliers_gpu = rbind(outliers_total_power_drawn_top10, outliers_average_gpu_temp_top10, outliers_average_gpu_util_top10,
                                outliers_average_gpu_memory_util_top10)

top_10_outliers_gpu = top_10_outliers_gpu[,-c(3:11)]

top_10_outliers_gpu = top_10_outliers_gpu[, c(2,3,4,1)]

#---------------------------------------------------------------------------------------------------------------------------------------------
#Finding top 10 Hostnames based on GPU variables:

outliers_gpu_total_power_top10 = as.data.frame(tail(outliers_final_host_gpu_performance_1[order(outliers_final_host_gpu_performance_1$total_power_drawnW),],10))
outliers_gpu_gpu_temp_top10 = as.data.frame(tail(outliers_final_host_gpu_performance_2[order(outliers_final_host_gpu_performance_2$average_gpu_tempC),],10))
outliers_gpu_gpu_util_top10 = as.data.frame(tail(outliers_final_host_gpu_performance_3[order(outliers_final_host_gpu_performance_3$average_gpu_utilP),],10))
outliers_gpu_gpu_memory_util_top10 = as.data.frame(tail(outliers_final_host_gpu_performance_4[order(outliers_final_host_gpu_performance_4$average_gpu_memory_utilP),],10))


outliers_gpu_total_power_top10$category = "Total_power_drawn"
outliers_gpu_gpu_temp_top10$category = "Average_GPU_Temp"
outliers_gpu_gpu_util_top10$category = "Average_GPU_Util"
outliers_gpu_gpu_memory_util_top10$category = "Average_GPU_Memory_Util"

outliers_gpu_total_power_top10 = outliers_gpu_total_power_top10[order(desc(outliers_gpu_total_power_top10$total_power_drawnW)),]
outliers_gpu_gpu_temp_top10 = outliers_gpu_gpu_temp_top10[order(desc(outliers_gpu_gpu_temp_top10$average_gpu_tempC)),]
outliers_gpu_gpu_util_top10 = outliers_gpu_gpu_util_top10[order(desc(outliers_gpu_gpu_util_top10$average_gpu_utilP)),]
outliers_gpu_gpu_memory_util_top10 = outliers_gpu_gpu_memory_util_top10[order(desc(outliers_gpu_gpu_memory_util_top10$average_gpu_memory_utilP)),]


outliers_gpu_total_power_top10$rank = seq(1:nrow(outliers_gpu_total_power_top10))
outliers_gpu_gpu_temp_top10$rank = seq(1:nrow(outliers_gpu_gpu_temp_top10))
outliers_gpu_gpu_util_top10$rank = seq(1:nrow(outliers_gpu_gpu_util_top10))
outliers_gpu_gpu_memory_util_top10$rank = seq(1:nrow(outliers_gpu_gpu_memory_util_top10))



outliers_gpu_total_power_top10 = outliers_gpu_total_power_top10[,-c(2,3)]
outliers_gpu_gpu_temp_top10 = outliers_gpu_gpu_temp_top10[,-c(2,3)]
outliers_gpu_gpu_util_top10 = outliers_gpu_gpu_util_top10[,-c(2,3)]
outliers_gpu_gpu_memory_util_top10 = outliers_gpu_gpu_memory_util_top10[,-c(2,3)]




top_10_outliers_host_gpu = rbind(outliers_gpu_total_power_top10, outliers_gpu_gpu_temp_top10, outliers_gpu_gpu_util_top10,
                outliers_gpu_gpu_memory_util_top10)


#-------------------------------------------------------------------------------------------------------------------------

# Analysis to find poor performance of the GPU:

gpu_nonidle_data = master_tera_data %>% filter(master_tera_data$gpuUtilPerc > 10 & master_tera_data$gpuMemUtilPerc > 10)

gpu_nonidle_data = gpu_nonidle_data %>% group_by(hostname) %>% summarise(totalPowerDraw = sum(powerDrawWatt))

total_render_data = total_rendering %>% group_by(hostname) %>% summarise(total_runtime=sum(time_difference))

power_drawn_render_time = full_join(total_render_data, gpu_nonidle_data, by="hostname")

power_drawn_render_time$power_per_second = round(power_drawn_render_time$totalPowerDraw / power_drawn_render_time$total_runtime,2)

poor_performance_gpu = tail(power_drawn_render_time[order(power_drawn_render_time$power_per_second),], 5)

poor_performance_gpu = left_join(poor_performance_gpu, master_tera_data, by = "hostname")

poor_performance_gpu = poor_performance_gpu[,c(1,3,4,14,15)]

poor_performance_gpu = drop_na(poor_performance_gpu %>% distinct())
poor_performance_gpu = poor_performance_gpu %>% distinct()
poor_performance_gpu = na.omit(poor_performance_gpu)  

  