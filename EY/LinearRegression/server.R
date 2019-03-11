library(shiny)
library(UsingR)
library(ggplot2)
library(ggpmisc)
data(diamond)

fit <- lm(price ~ carat, data = diamond) #Y = m(Carat) + C, m = carat est under summary

shinyServer(
    function(input, output) {
        priceSG <- reactive(coef(fit)[1] + coef(fit)[2] * input$carat)
        output$inputValue <- renderText({input$carat})
        output$priceSG <- renderText({paste("$",round(priceSG(), 2))}) #to display the prices
        output$table <- renderPrint(summary(fit))
        output$table1 <- renderPrint(diamond)
        output$plot1 <- renderPlot({
          ggplot(diamond, aes(x=carat, y = price)) + 
            geom_point() + 
            geom_smooth(method='lm', formula = y~x, se = F) + 
            stat_poly_eq(formula = y~x,
                         eq.with.lhs = "italic(price)~`=`~",
                         eq.x.rhs = "~italic(carat)",
                         aes(label = ..eq.label..), 
                         coef.digits = 5,
                         rr.digits = 5,
                         parse = TRUE) + 
            theme_bw()})
    }
)

