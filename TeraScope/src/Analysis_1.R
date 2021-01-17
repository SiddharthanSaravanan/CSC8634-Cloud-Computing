##Runtime analysis on each event name at level 12-----------------------------------------------------------------------------------------

#by total rendering time
total_rendering = master_tera_data %>% filter(eventName == "TotalRender")
total_rendering = total_rendering[,c(2,3,7,8,10,19)]
total_rendering = total_rendering %>% distinct()

list = sort(total_rendering$time_difference, index.return=TRUE, decreasing=TRUE)
c = lapply(list, `[`, list$x %in% head(unique(list$x),10))
total_rendering_i = lapply_render$ix
total_rendering_data = total_rendering[total_rendering_i,]

(plot_1 = ggplot(total_rendering, aes(y, -x)) + geom_tile(aes(fill = time_difference))+ 
    geom_point(data = total_rendering_data, aes(y,-x)))
