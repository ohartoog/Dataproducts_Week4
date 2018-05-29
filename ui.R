

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Interactive two-dimensional K-means clustering and the Elbow Method"),
#  headerPanel("title"", windowTitle = title)
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel( 
      textInput('kmseed', "Set a seed to be able to reproduce your results", value = "123"),
      
      selectInput('xcol', 'Variable one', names(mtcars),  
                  selected = names(mtcars)[[4]]), 
      selectInput('ycol', 'Variable two', names(mtcars), 
                  selected = names(mtcars)[[7]]), 
      sliderInput('clusters', 'Number of clusters', min = 1, max = 9, 
                  value = 3, ticks = TRUE,  
                  animate = TRUE, round = TRUE) 
    ), 
    
   mainPanel(
     tabsetPanel(
       tabPanel("Documentation", HTML("This app will enable you to interactively K-means cluster the mtcars dataset, 
                                      two dimensions at the time. <br> <br> Below you'll find instructions for the use of 
                                      the app and the interpretation of what is shown.<br> <br>
                                      In the <strong>input bar</strong> on the left your can select two dimensions of the mtcars dataset, as
                                      well as a randomisation seed. The app will run a K-means clustering algorithm on the 
                                      dataset with just the two selected variables, initialized with the selected seed. The K-means algorithm 
                                      is not deteministic by nature. This means that. especially with many clusters, the results 
                                      can be different with a different initialization. Preserving the seed enables you to reproduce the 
                                      exact same values in two different runs. <br> <br>
                                      In the <strong>Results</strong> tab of this app you'll find a graphical representation of the results of the clustering. <br>
                                      The first plot shows a plot the data with the two selected variables on the x and y axes. The
                                      center positions of the clusters are indicated with big X's. The data points that belong to 
                                      the same cluster share the same color. <br>
                                      The second plot is the so-called Elbow plot, which helps to select the right number of clusters for the
                                      data selection at hand. The current number of clusters is indicated with a big red dot. The plots shows 
                                      the total within-clusters sum of squares against the number of clusters. This number is decreasing with
                                      number of clusters, but at some point, the gain is not 'worth' the increased complexity of the model anymore. This 
                                      is where the plot shows an angle, or 'elbow', indicating the ideal number of clusters. As you can see, for most variable 
                                      combinations in this data set the ideal number of clusters is 2 or 3.")), 
       tabPanel("Results", plotOutput("plot1"), plotOutput("plot2"))
     )
   )
    
  )
))
