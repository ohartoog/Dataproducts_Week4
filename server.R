
library(shiny)
library(RColorBrewer)


# Define server logic 
shinyServer(function(input, output) {

# Set the color palette
  CL9 <- brewer.pal(9, "Dark2")
  
# Documentation
  output$doctext <- renderText({ 
    "This app will enable you to interactively K-means cluster the mtcars dataset, two dimensions at the time. <br> here is some instructions"
  })
  
# Select data based on the x and y variables  
  selectedData <- reactive({
    mtcars[, c(input$xcol, input$ycol)]
    }) 
  
# Do the Kmeans clustering
  clusters <- reactive({
    set.seed(input$kmseed)
    kmeans(selectedData(), input$clusters)
  })
  
# Construct the plot  
  output$plot1 <- renderPlot({
    plot(selectedData(),col = CL9[clusters()$cluster], pch = 20, cex = 3, main = "mtcars data clustered in two dimensions")
    points(clusters()$centers, pch = 4, cex=4)
    })

# Create the data set for the Elbow Plot
  wss <- reactive({
    k.max <- 9
    set.seed(input$kmseed)
    wss <- sapply(1:k.max, 
                  function(k){kmeans(selectedData(), 
                                     k, 
                                     nstart=50,
                                     iter.max = 15 
                                     )$tot.withinss}
                  )
  })

# Render the elbow plot  
  output$plot2 <- renderPlot({
    k.max <- 9
    plot(1:k.max, wss(),
         type="b", pch = 20, cex=3, 
         xlab="Number of clusters K",
         ylab="Total within-clusters sum of squares",
         main="Elbow plot for finding a good number of clusters")
    points(input$clusters,wss()[input$clusters], pch = 20, cex=5,col='red')
  })
  
  
})
