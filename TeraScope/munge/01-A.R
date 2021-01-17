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

## Converting the timestamp to seconds

tera_data = cbind(tera_data, read.table(text = as.character(tera_data$timestamp), sep = "T"))
tera_data = cbind(tera_data, read.table(text = as.character(tera_data$V2), sep = "."))
tera_data = tera_data[,-c(18,20)]
tera_data = cbind(tera_data, read.table(text = as.character(tera_data$V1.1), sep = ":"))
tera_data = tera_data[,-18]
tera_data$seconds = tera_data$V1.1*60*60+tera_data$V2*60+tera_data$V3
tera_data = tera_data[,-c(17,18,19,20)]
tera_data$seconds = as.numeric(tera_data$seconds)

## Fill the empty fields with the last occurred value for analysis

## fill the taskId's with the last occurred value
fill_tera_data = tera_data %>%
  mutate(to_fill = !is.na(zoo::na.locf(taskId, fromLast = TRUE, na.rm = FALSE)),
         filled_taskId = if_else(to_fill, zoo::na.locf(taskId, na.rm = FALSE),
                                 pmax(first(taskId), zoo::na.locf(taskId, na.rm = FALSE))), )

#fill the x coordinates with the last occurred value
fill_tera_data = fill_tera_data %>%
  mutate(to_fill = !is.na(zoo::na.locf(x, fromLast = TRUE, na.rm = FALSE)),
         filled_x = if_else(to_fill, zoo::na.locf(x, na.rm = FALSE),
                            pmax(first(x), zoo::na.locf(x, na.rm = FALSE))), )

#fill the y coordinates with the last occurred value
fill_tera_data = fill_tera_data %>%
  mutate(to_fill = !is.na(zoo::na.locf(y, fromLast = TRUE, na.rm = FALSE)),
         filled_y = if_else(to_fill, zoo::na.locf(y, na.rm = FALSE),
                            pmax(first(y), zoo::na.locf(y, na.rm = FALSE))), )

#fill the jobId's with the last occurred value
fill_tera_data = fill_tera_data %>%
  mutate(to_fill = !is.na(zoo::na.locf(jobId.x, fromLast = TRUE, na.rm = FALSE)),
         filled_jobId = if_else(to_fill, zoo::na.locf(jobId.x, na.rm = FALSE),
                                pmax(first(jobId.x), zoo::na.locf(jobId.x, na.rm = FALSE))), )
#fill the levels with the last occurred value
fill_tera_data = fill_tera_data %>%
  mutate(to_fill = !is.na(zoo::na.locf(level, fromLast = TRUE, na.rm = FALSE)),
         filled_level = if_else(to_fill, zoo::na.locf(level, na.rm = FALSE),
                                pmax(first(level), zoo::na.locf(level, na.rm = FALSE))), )
