##Runtime analysis on each event name-----------------------------------------------------------------------------------------

#by total rendering time
total_rendering = master_tera_data %>% filter(eventName == "TotalRender")
total_rendering = total_rendering[,c(2,3,7,8,10,19)]
total_rendering = total_rendering %>% distinct()

list = sort(total_rendering$time_difference, index.return=TRUE, decreasing=TRUE)
lapply = lapply(list, `[`, list$x %in% head(unique(list$x),10))
total_rendering_i = lapply$ix
total_rendering_data = total_rendering[total_rendering_i,]

(plot_1 = ggplot(total_rendering, aes(y, -x)) + geom_tile(aes(fill = time_difference))+ 
    geom_point(data = total_rendering_data, aes(y,-x)))

#by render time
render = master_tera_data %>% filter(eventName == "Render")
render = render[,c(2,3,7,8,10,19)]
render = render %>% distinct()

list = sort(render$time_difference, index.return=TRUE, decreasing=TRUE)
lapply = lapply(list, `[`, list$x %in% head(unique(list$x),10))
render_i = lapply$ix
render_data = render[render_i,]

(plot_2 = ggplot(render, aes(y, -x)) + geom_tile(aes(fill = time_difference)) + 
    geom_point(data = render_data, aes(y,-x)))

#by Saving Config time
Saving_Config = master_tera_data %>% filter(eventName == "Saving Config")
Saving_Config = Saving_Config[,c(2,3,7,8,10,19)]
Saving_Config = Saving_Config %>% distinct()

list <- sort(Saving_Config$time_difference, index.return=TRUE, decreasing=TRUE)
lapply = lapply(list, `[`, list$x %in% head(unique(list$x),10))
Saving_Config_i = lapply$ix
Saving_Config_data = Saving_Config[Saving_Config_i,]

(plot_3 = ggplot(Saving_Config, aes(y, -x)) + geom_tile(aes(fill= time_difference))+
    geom_point(data = Saving_Config_data, aes(y,-x)))


#by Uploading time
Uploading = master_tera_data %>% filter(eventName == "Uploading")
Uploading = Uploading[,c(2,3,7,8,10,19)]
Uploading = Uploading %>% distinct()

list <- sort(Uploading$time_difference, index.return=TRUE, decreasing=TRUE)
lapply = lapply(list, `[`, list$x %in% head(unique(list$x),10))
Uploading_i = lapply$ix
Uploading_data = Uploading[Uploading_i,]

(plot_4 = ggplot(Uploading, aes(y, -x)) + geom_tile(aes(fill= time_difference))+
    geom_point(data = Uploading_data, aes(y,-x)))
