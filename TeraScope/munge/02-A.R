# gpu performance preprocessing step

task_gpu_performance = final_pivot_tera_data[,c(2,13,14,15,16)]
task_gpu_performance = na.omit(task_gpu_performance)
rownames(task_gpu_performance) <- 1:nrow(task_gpu_performance)
task_gpu_performance = task_gpu_performance %>% filter(gpuUtilPerc>0 & gpuMemUtilPerc>0)



## final_task_gpu_performace = generating by summarizing the values

final_task_gpu_performance = task_gpu_performance
final_task_gpu_performance = final_task_gpu_performance %>% 
  group_by(final_task_gpu_performance$taskId) %>%   summarise(total_power_drawnW = sum(powerDrawWatt), average_gpu_tempC = mean(gpuTempC),
                                                         average_gpu_utilP = mean(gpuUtilPerc),average_gpu_memory_utilP = mean(gpuMemUtilPerc))
names(final_task_gpu_performance)[1] = "taskId"


master_tera_data = full_join(final_pivot_tera_data, final_task_gpu_performance, by = c("taskId"))

## GPU performance data based on Total Render

gpu_total_render = master_tera_data %>% filter(eventName == "TotalRender" & eventType == "STOP")
gpu_total_render = gpu_total_render[,c(2,3,7,8,10,6,19,20,21,22,23)]


#----------------------------------------------------------------------------------
## gpu performance for each hostname which are not in idle state

host_gpu_performance = final_pivot_tera_data[,c(3,13,14,15,16)]
host_gpu_performance = na.omit(host_gpu_performance)
rownames(host_gpu_performance) <- 1:nrow(host_gpu_performance)
host_gpu_performance = host_gpu_performance %>% filter(gpuUtilPerc>0 & gpuMemUtilPerc>0)



## final_host_gpu_performace = generating by summarizing the values

final_host_gpu_performance = host_gpu_performance
final_host_gpu_performance = final_host_gpu_performance %>% 
  group_by(final_host_gpu_performance$hostname) %>%   summarise(total_power_drawnW = sum(powerDrawWatt), average_gpu_tempC = mean(gpuTempC),
                                                                average_gpu_utilP = mean(gpuUtilPerc),average_gpu_memory_utilP = mean(gpuMemUtilPerc))


names(final_host_gpu_performance)[1] = "hostname"
