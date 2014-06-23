library(shiny)

m <- data.frame(mpg=mtcars$mpg,
                cyl=factor(mtcars$cyl),
                disp=mtcars$disp,
                hp=mtcars$hp,
                drat=mtcars$drat,
                wt=mtcars$wt,
                qsec=mtcars$qsec,
                vs=factor(mtcars$vs),
                am=factor(mtcars$am, c(0, 1), c("automatic", "manual")),
                gear=factor(mtcars$gear),
                carb=factor(mtcars$carb),
                row.names=row.names(mtcars))

shinyServer(
  function(input, output) {
    family <- reactive({
      if(class(m[[input$outcome]]) == "factor" &
           length(attr(m[[input$outcome]], "levels")) == 2)
        "binomial" else "gaussian"
    })
    form <- reactive({
      vars <- input$vars[input$vars != input$outcome]
      if(length(vars) == 0) vars = "am"
      paste(input$outcome, "~", paste(vars, collapse="+"), sep="")
    })
    output$call <- renderText({
      paste("glm(", form(), ", '", family(), "', ", "m)", sep="")
    })
    fit <- reactive({
      formula <- formula(form())
      glm(formula, family(), data=m)
      })
    output$coef <- renderTable({
      summary(fit())$coefficients
    })
    output$fit1 <- renderPlot({
      plot(fit(), which=1)
    })
    output$fit2 <- renderPlot({
      plot(fit(), which=2)
    })
    output$fit3 <- renderPlot({
      plot(fit(), which=3)
    })
    output$fit5 <- renderPlot({
      plot(fit(), which=5)
    })
  }
)