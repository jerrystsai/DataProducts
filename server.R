#
# server.R
#
# Simple algebra practice
#
# last update: 2015-02-22
#

library(shiny)

shinyServer(function(input, output) {

    ## Set possible values for x and y
    x_domain <- c(-5,-4,-3,-2,-1,1,2,3,4,5)
    y_domain <- c(-5,-4,-3,-2,-1,1,2,3,4,5)
    
    ## Set possible values for coefficients for x and y
    a_domain <- c(-5,-4,-3,-2,-1,1,2,3,4,5)
    b_domain <- c(-5,-4,-3,-2,-1,1,2,3,4,5)

    ## Draw random elements from the vectors
    x <- sample(x_domain, 1)    
    y <- sample(y_domain, 1)
    
    a <- sample(a_domain, 2)
    a1 <- a[1]    
    a2 <- a[2]
    
    b <- sample(b_domain, 2)
    b1 <- b[1]    
    b2 <- b[2]
            
    ## Construct equations as strings
    string1 <- paste0(a1, "x + ", b1, "y = ", a1 * x + b1 * y)
    string2 <- paste0(a2, "x + ", b2, "y = ", a2 * x + b2 * y)
    
    # Assign values for Equations 1 and 2
    output$Equation1 <- renderText(string1)    
    output$Equation2 <- renderText(string2)

    # Create function to check proposed answers against the true values
    checkAnswers <- function(xproposed, xtrue, yproposed, ytrue) {
        return ((xproposed == xtrue) && (yproposed == ytrue))
    }
    
    ## Initialize variable that determines whether the player has solved the problem
    solved <- FALSE

    ## Algorithm of play: allow up to 2 guesses, see if the user-submitted values are correct.
    
    output$message <- renderText( {
        if (input$submitButton == 0 ) {
            message <- ""
        }
        else if (input$submitButton == 1 ) {
            isolate({                
                solved <- checkAnswers(input$xvalue, x, input$yvalue, y)
                if (solved) message <- paste0("Great work! You're right! The answer is: x = ", x, " and y = ", y, ". Refresh the page to play again.")                
                else message <- paste0("You guessed x = ", input$xvalue, " and y = ", input$yvalue, ". That's wrong. You have 1 more try.")
            })    
        }
        else if (input$submitButton == 2 ) {
            isolate({
                if (solved) message <- "You already got the answer right. Refresh the page to play again."
                else {
                    solved <- checkAnswers(input$xvalue, x, input$yvalue, y)
                    if (solved) message <- paste0("Great work! You're right! The answer is: x = ", x, " and y = ", y, ". Refresh the page to play again.")
                    else message <- paste0("Wrong. The answer is: x = ", x, " and y = ", y, ". Refresh the page to play again.")
                }
            })
        }
        else if (input$submitButton > 2 ) {
                message <- "No more submissions, please. Refresh the page to try another problem."
        }
        
        isolate(message)
    } )
})