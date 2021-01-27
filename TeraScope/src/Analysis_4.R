#Finding top 10 task id's based on GPU variables:
outliers_total_power_drawn_top10 = as.data.frame(tail(outliers_total_power_drawn[order(outliers_total_power_drawn$total_power_drawnW),],10))

outliers_average_gpu_temp_top10 = as.data.frame(tail(outliers_average_gpu_temp[order(outliers_average_gpu_temp$average_gpu_tempC),],10))

outliers_average_gpu_util_top10 = as.data.frame(tail(outliers_average_gpu_util[order(outliers_average_gpu_util$average_gpu_utilP),],10))

outliers_average_gpu_memory_util_top10 = as.data.frame(tail(outliers_average_gpu_memory_util[order(outliers_average_gpu_memory_util$average_gpu_memory_utilP),],10))

outliers_total_power_drawn_top10$category = "Total_power_drawn"
outliers_average_gpu_temp_top10$category = "Average_GPU_Temp"
outliers_average_gpu_util_top10$category = "Average_GPU_Util"
outliers_average_gpu_memory_util_top10$category = "Average_GPU_Memory_Util"

top_10_outliers_gpu = rbind(outliers_total_power_drawn_top10, outliers_average_gpu_temp_top10, outliers_average_gpu_util_top10,
                                outliers_average_gpu_memory_util_top10)



#Finding top 10 Hostnames based on GPU variables:

outliers_gpu_total_power_top10 = as.data.frame(tail(outliers_final_host_gpu_performance_1[order(outliers_final_host_gpu_performance_1$total_power_drawnW),],10))
outliers_gpu_gpu_temp_top10 = as.data.frame(tail(outliers_final_host_gpu_performance_2[order(outliers_final_host_gpu_performance_2$average_gpu_tempC),],10))
outliers_gpu_gpu_util_top10 = as.data.frame(tail(outliers_final_host_gpu_performance_3[order(outliers_final_host_gpu_performance_3$average_gpu_utilP),],10))
outliers_gpu_gpu_memory_util_top10 = as.data.frame(tail(outliers_final_host_gpu_performance_4[order(outliers_final_host_gpu_performance_4$average_gpu_memory_utilP),],10))

outliers_gpu_total_power_top10$category = "Total_power_drawn"
outliers_gpu_gpu_temp_top10$category = "Average_GPU_Temp"
outliers_gpu_gpu_util_top10$category = "Average_GPU_Util"
outliers_gpu_gpu_memory_util_top10$category = "Average_GPU_Memory_Util"

outliers_gpu_total_power_top10 = outliers_gpu_total_power_top10[,-c(3)]
outliers_gpu_gpu_temp_top10 = outliers_gpu_gpu_temp_top10[,-c(3)]
outliers_gpu_gpu_util_top10 = outliers_gpu_gpu_util_top10[,-c(3)]
outliers_gpu_gpu_memory_util_top10 = outliers_gpu_gpu_memory_util_top10[,-c(3)]

top_10_outliers_host_gpu = full_join(outliers_gpu_total_power_top10, outliers_gpu_gpu_temp_top10, outliers_gpu_gpu_util_top10,
                                 outliers_gpu_gpu_memory_util_top10, by = "hostname")

top_10_power_temp = full_join(outliers_gpu_total_power_top10, outliers_gpu_gpu_temp_top10, by = "hostname")
top_10_gpu_util_mem = full_join(outliers_gpu_gpu_util_top10, outliers_gpu_gpu_memory_util_top10, by = "hostname")

top_10_outliers_host_gpu = full_join(top_10_power_temp, top_10_gpu_util_mem, by = "hostname")


