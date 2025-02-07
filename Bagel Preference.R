# Load the data from the Excel file
bagel_preference_data <- read_excel('/Users/wangyushuo/Desktop/1Columbia/Data Journalism/Algorithm/In-One-Chart/American Bagel Preference.xlsx', sheet = "Bagel Preference")

# Rename columns
bagel_preference_data <- bagel_preference_data %>% 
  rename("state" = "State", "preference" = "Bagel Preference")

# Define custom colors for each bagel preference
bagel_preference_colors <- c(
  "Asiago Cheese" = "#FFD700", 
  "Blueberry" = "#4B0082", 
  "Cinnamon Raisin" = "#D2691E", 
  "Everything" = "#8B0000", 
  "Plain" = "#F3D1B2"
)

# Create the statebin chart for bagel preferences
statebins(state_data = bagel_preference_data, 
          state_col = "state", 
          value_col = "preference", # Use the "preference" column for visualization
          round = TRUE,
          ggplot2_scale_function = scale_fill_manual, # Use scale_fill_manual for discrete variables
          values = bagel_preference_colors) +  
  theme_statebins(legend_position = "bottom") +  # Position the legend at the bottom
  theme(legend.position = "bottom",  # Position the labels at the bottom
        legend.justification = "center"  # Center the labels horizontally
  ) + 
  labs(title = "Everything Bagel Wins Most Americans' Appetites", 
       subtitle = "Bagel Preferences Across U.S. States",
       fill = "Bagel Preference",
       caption = "Alaska, Montana, North Dakota, South Dakota, Vermont and Wyoming are not included in the visualization due to a small number of survey respondents.
       \nSource: Shane Co. — American Bagel Preferences Survey 2022") + # Add footnotes
  theme(plot.title = element_text(hjust = 0.5)) + 
  theme(plot.caption = element_text(hjust = 0.5)) # Center the title and footnotes