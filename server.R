#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

server <- shinyServer(function(input, output,session) {
    
    # server
    track_usage(storage_mode = store_json(path = "logs/"))
    df_products_upload <- reactive({
        inFile <- input$target_upload
        if (is.null(inFile))
            return(NULL)
        df <- read.csv(inFile$datapath, header = TRUE,sep = input$separator)
        
        for(i in seq_along(df)){
            df[,i] <- as.factor(df[,i])
        }
        
        updateSelectInput(session, inputId = "var1", label = "Neighborhoods",
                          choices = names(df[1:2]), selected = names(df))
        
        updateSelectInput(session, inputId = "var2", label = "Housing or Population",
                          choices = names(df[5:6]), selected = names(df[5]))
        
        updateSelectInput(session, inputId = "var3", label = "Covid-19 class or tate",
                          choices = names(df[7:8]), selected = names(df))
        
        return(df)
            
       
    })
    
    output$sample_table<- DT::renderDataTable({
        df <- df_products_upload()
        DT::datatable(df)
    })
    
    x <- reactive({
        df<-df_products_upload()
        x<-df[,input$var1]
       
    })
    
    y <- reactive({
        df<-df_products_upload()
        y<-df[,input$var2]
        
    })
    
    
    z <- reactive({
        df<-df_products_upload()
        z<-df[,input$var3]
        
    })
    
    observeEvent(input$update, {
        
        if(!is.null(input$target_upload))({
            
            
            
           t <- list(
                family = "Arial",
                size = 7,
                color = 'black')
           
           df<-df_products_upload()
           plot<- plot_ly( x = x(),
                           y = y(), 
                           color=z(),
                           marker = list(size = 10),
                           type = 'scatter',
                           mode = 'markers')
           
           plot <- plot %>% layout(title="COVID-19 MANAUS-AM EM 02/07/2020", font=t,  
           xaxis=list(title = input$var1, categoryarray = input$var3, categoryorder = "array"),
           yaxis=(list(title=input$var2)),
           width=800,height=400, autosize=T,automargin = TRUE,showticklabels = TRUE, legend=list(title=list(text='<br>CLASSE COVID-19 </br>
                <br> cases/100.000 hab. </br>
             <b> * k = 1000 </b>')))
           
            output$plot <- renderPlotly(plot)  
           
       })
        
     })
    
            
    
}
)
