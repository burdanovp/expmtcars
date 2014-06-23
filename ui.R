library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("mtcars exploration"),
  sidebarPanel(
    selectInput("outcome", "Outcome",
                c("mpg", "disp", "hp", "drat", "wt", "qsec", "vs", "am")),
    checkboxGroupInput('vars', 'Predictors',
                       c("mpg", "cyl", "disp", "hp", "drat",
                         "wt", "qsec", "vs", "am", "gear", "carb"),
                       selected=c("cyl", "hp", "wt", "am")),
    h4("Notes"),
    helpText("Qualitative variables are converted to factors"),
    helpText("If the outcome is qualitative, logistic regression is used"),
    helpText("Internet Explorer users may experience strange visual glitches,",
             "if no graphs, try to move mouse at random")
  ),
  mainPanel(
    h4("Call"),
    textOutput("call"),
    h4("Coefficients"),
    uiOutput("coef"),
    tabsetPanel(
      tabPanel("Residuals vs Fitted", plotOutput("fit1")),
      tabPanel("Normal Q-Q", plotOutput("fit2")),
      tabPanel("Scale-Location", plotOutput("fit3")),
      tabPanel("Residuals vs Leverage", plotOutput("fit5"))
    )
  )
))