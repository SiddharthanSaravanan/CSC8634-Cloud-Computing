##Runtime analysis on each event name at level 12-----------------------------------------------------------------------------------------

#by total rendering time
total_rendering = master_tera_data %>% filter(eventName == "TotalRender")
total_rendering = total_rendering[,c(2,3,7,8,10,19)]
total_rendering = total_rendering %>% distinct()
