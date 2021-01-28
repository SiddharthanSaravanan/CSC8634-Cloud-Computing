#Key image analysis of Poor performing GPU's:


(plot_19 = ggplot(gpu_total_render, aes(y, -x)) +geom_tile(aes(fill = average_gpu_memory_utilP))+ 
  geom_point(data = outliers_total_power_drawn,aes(y,-x, size = total_power_drawnW)) +
  geom_point(data = poor_performance_gpu,aes(y,-x, color = hostname)))


ggsave(file.path('graphs', 'GPU nodes with poor performance.png'))