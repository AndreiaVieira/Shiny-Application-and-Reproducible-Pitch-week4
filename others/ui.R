#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(plotly)
library(ggplot2)
library(shiny)
library(shinylogs)
library(dplyr)
library(RColorBrewer)
library(varhandle)

ui <- shinyUI(fluidPage(
    
    # UI
    use_tracking(),
    titlePanel (h1("Evaluation of COVID19 in Manaus/AM  02/07/2020", align = "center")),
    tabsetPanel(
        tabPanel("Upload File",
                 titlePanel
                 (h1(" Your file must be in csv format to upload",
                     style = "font-family: 'Helvetica Neue';
                        font-size: 15px; font-weight: 100; line-height: 1.1;"),
                     windowTitle = "Uploading Files"
                 ),
                 sidebarPanel(
                     width = 3,
                     fileInput('target_upload', 'Choose file to upload',
                               accept = c(
                                   'text/csv',
                                   'text/comma-separated-values',
                                   '.csv'
                               )),
                     radioButtons("separator","Separator: ",choices = c(";",",",":"), selected=";",inline=TRUE),
                     DT::dataTableOutput("sample_table")
                 ),
                 mainPanel()
        ),
        tabPanel("Plot",
                 titlePanel
                 (h1("Graficos da Covid em Manaus",
                     style = "font-family: 'Helvetica Neue';
                  font-size: 15px; font-weight: 100; line-height: 1.1;"),
                     windowTitle = "Uploading Files"
                 ),
                 sidebarPanel(
                     width = 3,
                     selectInput('var1','X Variable', choices = "", width = "80%"),
                     selectInput('var2','Y Variable', choices = "", width = "80%"),
                     selectInput('var3','z Variable', choices = "", width = "80%"),
                     actionButton(inputId = "update", label = "Update plot"),
                 ),
                 mainPanel(
                     
                     plotlyOutput(outputId = "plot"),
                 )
        )
        
    )  
    
 
))
