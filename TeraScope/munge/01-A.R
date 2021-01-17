# Preprocessing script 1
## Reading the file from the data folder
tasks_data = task.x.y
gpu_data = gpu
checkpoints_data = application.checkpoints

## Removing duplicate records
checkpoints_data = checkpoints_data %>% distinct()
gpu_data = gpu_data %>% distinct()

## Combine the datasets and order based on hostname and timestamp variables
checkpoints_tasks_data = merge(x = checkpoints_data, y = tasks_data, by = "taskId", all = TRUE)
tera_data = full_join(checkpoints_tasks_data,gpu_data,by = c("timestamp", "hostname"))
tera_data = tera_data[order(tera_data$hostname, tera_data$timestamp),]