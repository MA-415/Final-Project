library(shiny)
library(shinydashboard)
library(leaflet)
library(tidyverse)
library(base64enc)
library(rsconnect)

ui <- dashboardPage(
  dashboardHeader(title = "Aquidneck Island"),
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
              p("For me personally, I grew up and went to school in Portsmouth and have known the Island my whole life. The majority of people from outside Rhode Island only know of Aquidneck Island as being Newport.
                The vast majority of tourists come to Newport for attractions such as the Breakers mansion shown in the picutre above. They seldom visit the other parts of Aquidneck Island. This website will show you where each town is on the Island, the demographics
                of the Island, some of the economic industries, and the best sights to see if you visit!")
      ),
      tabItem(tabName = "map",
              h2("Map of Aquidneck Island"),
              leafletOutput("aquidneckMap", height = 600)
      ),
      tabItem(tabName = "regional_map",
              h2("Regional Map"),
              p("This map shows the geographic context of Aquidneck Island within Rhode Island, 
                including key locations such as Newport, Middletown, and Portsmouth."),
              leafletOutput("riMap", height = 600)
      ),
      tabItem(tabName = "age_and_race", h2("Demographics"),
              p("The following tables show the separate distributions of age and race for Aquidneck Island households."),
              fluidRow(
                column(6,
                       h4("Age Distribution"),
                       div(style = "height:300px; overflow-y:scroll;",
                           tableOutput("ageDist"))
                ),
                column(6,
                       h4("Race Distribution"),
                       div(style = "height:300px; overflow-y:scroll;",
                           tableOutput("raceDist"))
                )
              ),
              p(),
              p("A stacked bar chart illustrates how these groups are represented by age. The chart shows that the population is relatively uniform, with modes around 20 and 62.
                This makes sense as Aquidneck Island boasts a large retired community as well as a lively youth population."),
              plotOutput("demographicsPlot")
      ),
      tabItem(tabName = "economics", 
              h2("Economics of the Sea"),
              p("Each graph below shows wages, GDP, and real GDP over time for one of the three key marine sectors on Aquidneck Island."),
              plotOutput("shipPlot"),
              p("As the plot shows, ship building ballooned around 2017, with a significant increase in wages and this sector's contribution to GDP.
                However, when Covid hit in 2020, the industry was destroyed, and it did not see the sharp increase in 2021 that other sectors enjoyed.
                Ship building has been an important part of Aquidneck Island, going back to the 1850's where Rhode Island had one of the largest whaling operations in the world.
                Today, this industry has died off, leaving room for other economic opportunities."),
              plotOutput("tourismPlot"),
              p("Tourism plays a huge role in the economy of Aquidneck Island. Newport draws large crowds in the summer due to its beaches, mansions, and historical charm.
                Looking at the graph, tourism has had a steady increase between 2005 and 2019, with a significant dip in 2020 due to Covid. 
                However, the industry surged in 2021 and more than recouped its loses from the previous year."),
              p(),
              p("Additionally, the graph below shows the economic outlook of all sectors during this time. The chart illistrates how important tourism is, and how closely the two graphs follow from one another.
                In 2021, the GDP of Aquidneck Island reached just over 860 million dollars. The Island may not be large, but it certainly has a thriving economy."),
              plotOutput("allSectorsPlot")),
              tabItem(tabName = "images", 
                      h2("See the Sights"),
                      uiOutput("OceandrImage"),
                      p("Journey down the scenic Ocean Drive at Aquidneck Islands southern tip. This road has beautiful views of the ocean, historial buildings, and the many mansions of wealthy americans (including Jay-Z!)"),
                      uiOutput("wharfImage"),
                      p("Visit Bowen's Wharf, with a cool salty breeze and tours of the historic Newport harbor. Newport has over 150 wharves, with plenty of night life and seafood restaurants, these are some of the most popular places for tourists to come."),
                      uiOutput("marbleImage"),
                      p("Take a tour through one of Newport's many Gilded Age mansions. Show above is the Marble House, built in 1892 by the Vanderbilt family."),
      ),
      tabItem(tabName = "bibliography", 
              h2("Bibliography"),
              p("Here are the links to the resources I used to make the project:"),
              tags$ul(
                tags$li(
              tags$a(href = "https://en.wikipedia.org/wiki/Marble_House", "Marble House Info")),
              tags$li(
              tags$a(href = "https://en.wikipedia.org/wiki/Aquidneck_Island", "Aquidneck Island Info")),
              tags$li(
              tags$a(href = "https://usa.ipums.org/usa/index.shtml", "Race and Age Data")),
              tags$li(
              tags$a(href = "https://catalog.data.gov/dataset/time-series-data-on-the-ocean-and-great-lakes-economy-for-counties-states-and-the-nation-betwee1", "Ocean Sectors Data")),
              tags$li(
              tags$a(href = "https://www.shinyapps.io/", "Publishing the App")),
              tags$li(
              tags$a(href = "https://shiny.posit.co/r/layouts/", "App Layout")),
              tags$li(
                tags$a(href = "https://www.gettyimages.com/photos/newport-rhode-island", "Images")),
              tags$li(
              tags$a(href = "https://stackoverflow.com/questions/70713506/how-to-render-an-image-in-shiny-box-and-fix-the-width-and-height-r", "Help with Images in Shiny")),
              )
              )
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
  
  #import and clean the second dataset
  
  enow <- read.csv("ENOW_Sectors_2005_2021.csv")
  enow_filtered <- enow |>
    filter(GeoName == "Newport, RI",
           OceanSector %in% c("Ship and Boat Building", "Tourism and Recreation", "All Ocean Sectors"))
  
  
  #images
  output$wharfImage <- renderUI({
    img_path <- "wharf.jpg"
    img_data <- base64enc::dataURI(file = img_path, mime = "image/jpeg")
    tags$img(src = img_data, style = "width: 100%; height: auto; display: block; margin-bottom: 20px;")
  })
  
  output$OceandrImage <- renderUI({
    img_path <- "Ocean_dr.jpg"
    img_data <- base64enc::dataURI(file = img_path, mime = "image/jpeg")
    tags$img(src = img_data, style = "width: 100%; height: auto; display: block; margin-bottom: 20px;")
  })
  
  output$marbleImage <- renderUI({
    img_path <- "marble_house.jpg"
    img_data <- base64enc::dataURI(file = img_path, mime = "image/jpeg")
    tags$img(src = img_data, style = "width: 100%; height: auto; display: block; margin-bottom: 20px;")
  })
  
  output$breakersImage <- renderUI({
    img_path <- "Breakers.jpg"
    img_data <- base64enc::dataURI(file = img_path, mime = "image/jpeg")
    tags$img(src = img_data, style = "width: 100%; height: auto; display: block; margin-bottom: 20px;")
  })

  
  #tables and graphs
  output$ageDist <- renderTable({
    demographics |>
      mutate(AgeGroup = cut(AGE, breaks = seq(0, 100, by = 10), right = FALSE, include.lowest = TRUE)) |>
      count(AgeGroup, name = "Count") |>
      arrange(AgeGroup)
  })
  
  output$raceDist <- renderTable({
    demographics |>
      count(RACE, name = "Count") |>
      arrange(RACE)
  })
  
  output$demographicsPlot <- renderPlot({
    summary_table <- demographics |>
      group_by(AGE, RACE) |>
      summarise(Count = n(), .groups = 'drop')
    
    ggplot(summary_table, aes(x = AGE, y = Count, fill = RACE)) +
      geom_col(position = "stack") +
      labs(title = "Age and Race Distribution on Aquidneck Island",
           x = "Age",
           y = "Count") +
      theme_minimal()
  })
  
  output$shipPlot <- renderPlot({
    ggplot(enow_filtered |> filter(OceanSector == "Ship and Boat Building"), aes(x = Year)) +
      geom_line(aes(y = Wages, color = "Wages"), size = 1.2) +
      geom_line(aes(y = GDP, color = "GDP"), size = 1.2) +
      geom_line(aes(y = RealGDP, color = "Real GDP"), size = 1.2) +
      labs(title = "Ship and Boat Building Sector", x = "Year", y = "USD", color = "Metric") +
      theme_minimal()
  })
  
  output$tourismPlot <- renderPlot({
    ggplot(enow_filtered |> filter(OceanSector == "Tourism and Recreation"), aes(x = Year)) +
      geom_line(aes(y = Wages, color = "Wages"), size = 1.2) +
      geom_line(aes(y = GDP, color = "GDP"), size = 1.2) +
      geom_line(aes(y = RealGDP, color = "Real GDP"), size = 1.2) +
      labs(title = "Tourism and Recreation Sector", x = "Year", y = "USD", color = "Metric") +
      theme_minimal()
  })
  
  output$allSectorsPlot <- renderPlot({
    ggplot(enow_filtered |> filter(OceanSector == "All Ocean Sectors"), aes(x = Year)) +
      geom_line(aes(y = Wages, color = "Wages"), size = 1.2) +
      geom_line(aes(y = GDP, color = "GDP"), size = 1.2) +
      geom_line(aes(y = RealGDP, color = "Real GDP"), size = 1.2) +
      labs(title = "All Ocean Sectors", x = "Year", y = "USD", color = "Metric") +
      theme_minimal()
  })
  

  
  #Maps
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



