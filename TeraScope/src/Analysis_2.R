## based on x,y, and each gpu performance variable----------------------------------------------------

(plot_6 = ggplot(gpu_total_render, aes(y, -x)) + geom_tile(aes(fill = total_power_drawnW)))

(plot_7 = ggplot(gpu_total_render, aes(y, -x)) + geom_tile(aes(fill = average_gpu_tempC)))

(plot_8 = ggplot(gpu_total_render, aes(y, -x)) + geom_tile(aes(fill = average_gpu_utilP)))

(plot_9 = ggplot(gpu_total_render, aes(y, -x)) + geom_tile(aes(fill = average_gpu_memory_utilP)))



(group_plot_2 = ggarrange(plot_6, plot_7, plot_8, plot_9, labels = c("A", "B", "C","D"),
                                     ncol = 2, nrow = 2)) %>% ggexport(filename = "graphs/Heat Map based on GPU performance.png",width = 1500,height = 1500)
