# Install packages 
install.packages("pacman")
pacman::p_load(tidyverse, statebins, readxl, viridis, gganimate, magick)

# Load the data from path to my Excel file
bagel_data <- read_excel('/Users/wangyushuo/Desktop/1Columbia/Data Journalism/Algorithm/In-One-Chart/American Bagel Preference.xlsx', sheet = "Bagels Eaten Per Year")

# Rename columns 
bagel_data <- bagel_data %>% 
  rename("state" = "State", "value" = "Bagels Eaten Per Year")

# Categorize the bagel consumption into ranges
bagel_data <- bagel_data %>%
  mutate(share = cut(value, breaks = c(0, 25, 50, 75), 
                     labels = c("0-25", "25-50", "50-75")))

# Define custom colors for each category
bagel_colors <- c("0-25" = "#F1E0A6",  
                  "25-50" = "#B87C4A",  
                  "50-75" = "#7F2A1A")

# Create the statebin chart using both ggplot2_scale_function and scale_fill_manual
statebins(state_data = bagel_data, 
          state_col = "state", 
          value_col = "share", # indicates the "share" column contains the values to be visualized (in discrete categories)
          round = TRUE,
          ggplot2_scale_function = scale_fill_manual, # scale_fill_manual for discrete variables
          values=bagel_colors)  +  
  theme_statebins(legend_position = "bottom") +  # Position the legend at the bottom
  theme(legend.position = "bottom",  # Position the labels at the bottom
        legend.justification = "center"  # Center the labels horizontally
  ) + 
  labs(title = "Northeastern States Lead the Bagel Fanbase, Except for Georgia", 
       subtitle = "Americans' annual bagel consumption across states",
       fill = "Bagel Consumption Ranges",
       caption = "Alaska, Montana, North Dakota, South Dakota, Vermont and Wyoming are not included in the visualization due to a small number of survey respondents.
       \nSource: Shane Co. — American Bagel Preferences Survey 2022") + # Add footnotes
  theme(plot.title = element_text(hjust = 0.5)) + 
  theme(plot.caption = element_text(hjust = 0.5)) # Center the title and footnotes
