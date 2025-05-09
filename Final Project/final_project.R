library(shiny)
library(shinydashboard)
library(leaflet)
library(tidyverse)
library(base64enc)

ui <- dashboardPage(
  dashboardHeader(title = "Aquidneck Island Analysis"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("About Aquidneck Island", tabName = "about", icon = icon("info-circle")),
      menuItem("Map of Aquidneck Island", tabName = "map", icon = icon("map")),
      menuItem("Regional Map", tabName = "regional_map", icon = icon("globe")),
      menuItem("Demographics", tabName = "age_and_race", icon = icon("users")),
      menuItem("Economics of the Sea", tabName = "economics", icon = icon("chart-line")),
      menuItem("See the Sights", tabName = "images", icon = icon("camera")),
      menuItem("Bibliography", tabName = "bibliography", icon = icon("book"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "about",
              h2("About Aquidneck Island"),
              uiOutput("breakersImage"),
              p("Aquidneck Island, located in Narragansett Bay, is the largest island in the state of Rhode Island. 
                Spanning approximately 37.8 square miles, it is home to a diverse community and plays a central role in the cultural and historical identity of the region. 
                With a combined population of just over 60,000, the island offers a unique blend of natural beauty, historic architecture, and coastal charm."),
              p("The island is divided into three towns: Newport, Middletown, and Portsmouth. 
                Newport, at the southern end, is world-renowned for its Gilded Age mansions, sailing culture, and as a former summer retreat for America's elite. 
                Middletown, situated in the center of the island, balances residential neighborhoods with retail and farmland. 
                Portsmouth, to the north, is the oldest of the three and retains a strong agricultural and maritime character. 
                Together, these towns create a vibrant and historically rich community on Aquidneck Island."),
      ),
      tabItem(tabName = "map",
              h2("Map of Aquidneck Island"),
              p(""),
              leafletOutput("aquidneckMap", height = 600)
      ),
      tabItem(tabName = "regional_map",
              h2("Regional Map"),
              p("This map shows the geographic context of Aquidneck Island within Rhode Island, 
                including key locations such as Newport, Middletown, and Portsmouth."),
              leafletOutput("riMap", height = 600)
      ),
      tabItem(tabName = "age_and_race", h2("Demographics"),
              p("The following tables show the separate distributions of age and race for Aquidneck Island households.
                A stacked bar chart illustrates how these groups are represented by age."),
              h4("Age Distribution"),
              tableOutput("ageDist"),
              h4("Race Distribution"),
              tableOutput("raceDist"),
              plotOutput("demographicsPlot")
      ),
      tabItem(tabName = "economics", h2("Economics of the Sea")),
      tabItem(tabName = "images", h2("See the Sights")),
      tabItem(tabName = "bibliography", h2("Bibliography"))
    )
  )
)

server <- function(input, output, session) {
  
  #import and clean our data. We need to set the race codes that the dataset provides in its documentation.
  demographics <- read.csv("Demographics_RI.csv")
  demographics <- demographics |>
    filter(COUNTYICP == 70) |>
    select(-RACED.)

  demographics$RACE <- factor(demographics$RACE,
                              levels = 1:9,
                              labels = c(
                                "White",
                                "Black/African American",
                                "American Indian or Alaska Native",
                                "Chinese",
                                "Japanese",
                                "Other Asian or Pacific Islander",
                                "Other race, nec",
                                "Two major races",
                                "Three or more major races"
                              ))
  
  output$breakersImage <- renderUI({
    img_path <- "Breakers.jpg"
    img_data <- base64enc::dataURI(file = img_path, mime = "image/jpeg")
    tags$img(src = img_data, style = "width: 100%; height: auto; display: block; margin-bottom: 20px;")
  })

  output$ageDist <- renderTable({
    demographics %>%
      mutate(AgeGroup = cut(AGE, breaks = seq(0, 100, by = 10), right = FALSE, include.lowest = TRUE)) %>%
      count(AgeGroup, name = "Count") %>%
      arrange(AgeGroup)
  })
  
  output$raceDist <- renderTable({
    demographics %>%
      count(RACE, name = "Count") %>%
      arrange(RACE)
  })
  
  output$demographicsPlot <- renderPlot({
    summary_table <- demographics %>%
      group_by(AGE, RACE) %>%
      summarise(Count = n(), .groups = 'drop')
    
    ggplot(summary_table, aes(x = AGE, y = Count, fill = RACE)) +
      geom_col(position = "stack") +
      labs(title = "Age and Race Distribution on Aquidneck Island",
           x = "Age",
           y = "Count") +
      theme_minimal()
  })

  output$aquidneckMap <- renderLeaflet({
    leaflet() |>
      addTiles() |>
      setView(lng = -71.3, lat = 41.54, zoom = 12) |>
      addMarkers(lng = -71.3128, lat = 41.4901, popup = "Newport") |>
      addMarkers(lng = -71.2839, lat = 41.5456, popup = "Middletown") |>
      addMarkers(lng = -71.2502, lat = 41.6023, popup = "Portsmouth")
  })
  
  output$riMap <- renderLeaflet({
    leaflet() |>
      addTiles() |>
      setView(lng = -71.5, lat = 41.6, zoom = 9) |>
      addMarkers(lng = -71.3128, lat = 41.4901, popup = "Newport") |>
      addMarkers(lng = -71.2839, lat = 41.5456, popup = "Middletown") |>
      addMarkers(lng = -71.2502, lat = 41.6023, popup = "Portsmouth")
  })
}

shinyApp(ui, server)



