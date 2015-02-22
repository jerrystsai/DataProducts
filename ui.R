#
# ui.R
#
# Simple algebra practice
#
# last update: 2015-02-22
#

library(shiny)

shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("Simple Algebra Practice"),
    
    # Sidebar with inputs
    sidebarPanel(
        h4("Solve for x and y using the equations on the right."),
        h5("You can guess up to two times."),
        
        # Take two numeric inputs (x and y) and a "Submit" button
        numericInput("xvalue", "x", 0),
        numericInput("yvalue", "y", 0),
        actionButton("submitButton", "Submit answers")
    ),
    
    # Display equations and message(s)
    mainPanel(
        h3("Your equations: "),
        textOutput("Equation1"),        
        textOutput("Equation2"),
        textOutput("message")
    )
))