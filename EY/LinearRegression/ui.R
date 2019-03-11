library(shiny)

sidebarPanel2 <- function (..., out = NULL, width = 4) 
{
  div(class = paste0("col-sm-", width), 
      tags$form(class = "well", ...),
      out
  )
}

library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
  # Application title
  titlePanel("Predicing Diamond Price"),
  br(),
  br(),
  sidebarLayout(
    sidebarPanel2(fluid = FALSE,
      p(strong("About")),
      p("This Shiny application helps to estimate the price of diamond based on the size in carats"),
      p("The price - in SG dollar - is calculated on the basis of a linear model built upon the dataframe",
        code('Diamond'), "from the library", code('UsingR')),
      code('Price = m(Carat) + C'),
      br(),
      hr(),
      p("Developed on", a("Shiny from RStudio", href="https://shiny.rstudio.com/")),
      out = p("Created for Internal EY SG Usage", align = 'center')
    ),  
    
    mainPanel(
      tabsetPanel(
        tabPanel("Calculation", 
                 br(),
                 numericInput('carat', 'Enter the size of diamond in carats', 0.25, min = 0.05, max = 6.0, step = 0.01),
                 submitButton('Submit'),
                 br(),
                 h4('Estimated Prices'),
                 h5('In Singapore Dollar '),
                 verbatimTextOutput("priceSG"),
                 plotOutput("plot1")),
        tabPanel("Data",
                 h3(strong('Dataset Used')),
                 verbatimTextOutput('table1')),
        tabPanel("Linear Regression Summary", 
                 h3(strong('Summary of Linear Regression')),
                 verbatimTextOutput('table'),
                 h4(strong('Residuals')),
                 p("This is a 5 point summary. The idea is to give a quick summary of the distribution. It should be roughly symmetrical about mean, the median should be close to 0, the 1Q and 3Q values should ideally be roughly similar values"),
                 h4(strong('Coefficients')),
                 p("For each variable and the intercept, a weight is produced and that weight has other attributes like the standard error, a t-test value and significance."),
                 strong('Estimate'),
                 p("This is the weight given to the variable. The model predicts that for every one carat increase, the model predicts an increase of $3721."),
                 strong('Std. Error'),
                 p("Tells you how precisely was the estimate measured. Its used in the calculation of t-vaue"),
                 strong('t-value and Pr(>[t])'),
                 p("The t-value is calculated by taking the coefficient divided by the Std. Error.  It is then used to test whether or not the coefficient is significantly different from zero.  If it isn't significant, then the coefficient really isn't adding anything to the model and could be dropped or investigated further.  Pr(>|t|) is the significance level."),
                 h4(strong('Performance Measures')),
                 p('3 sets of measurements are provided'),
                 strong('Residual Standard Error'),
                 p('This is the standard deviation of the residuals. Smaller the better'),
                 strong('Mutiple/Adjusted R^2'),
                 p("For one variable, the distinction doesn't really matter.  R-squared shows the amount of variance explained by the model.  Adjusted R-Square takes into account the number of variables and is most useful for multiple-regression. In essence, 100% indicates that the model explains all the variability of the response data around its mean. In general, the higher the R-squared, the better the model fits your data. However, this doesnt mean that all low R-squared value is bad. If your R-squared value is low but you have statistically significant predictors, you can still draw important conclusions about how changes in the predictor values are associated with changes in the response value. Regardless of the R-squared, the significant coefficients still represent the mean change in the response for one unit of change in the predictor while holding other predictors in the model constant. Obviously, this type of information can be extremely valuable."),
                 strong("F-Statistic"),
                 p("The F-test checks if at least one variable's weight is significantly different than zero.  This is a global test to help asses a model.  If the p-value is not significant, e.g. greater than 0.05, then your model is essentially not doing anything.")
        ),
        tabPanel("About",
                 h3(strong("References")),
                 p("1.", a("Linear Regression in R", href="http://r-statistics.co/Linear-Regression.html")),
                 p("2.", a("Linear Regression Examples", href="http://www.stat.yale.edu/Courses/1997-98/101/linreg.htm")),
                 h3(strong("Questions?")),
                 p("Email me:", a("javier.ng@sg.ey.com", href="mailto: javier.ng@sg.ey.com")))
        )
    )
  )
)
)