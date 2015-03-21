shinyUI(pageWithSidebar(
  headerPanel("Deciding to Reject a Null Hypothesis"),
  sidebarPanel(
    p('You measure the mean amount of Substance X per gram of soil for several soil samples.'),
    h4('Your Observation'),
    numericInput('t_observed', 'Enter current sample mean.', 0.06, min=0, max=0.20, step=0.01),
    h4('Your Decision boundary'),
    p('You label as poluted any sample with a value above a certain number (your decision boundary) and as pristine any sample with a value below that number. Adjust this decision boundary using the lever below.'),
    sliderInput('criterion','Set the decision boundary', value=0.06, min = 0, max = 0.12, step = 0.01,),
    p('In the graph, the distribution of means for all possible pristine and polluted soil samples is shown respectively in 
      red and in blue. Every sample with a mean to the right of the verticle line is labeled polluted. Notice 
      that the vertical line in the graph changes to reflect your selection of a decision boundary.')
  ),
  mainPanel(
    plotOutput('decison_and_error_plot'),
    h4('Your Inference'),
    verbatimTextOutput('prediction'),
    h4('Type I errors'),
    p('The black area of the figure shows you a group of pristine soil samples that you will eventually 
      incorrectly label as polluted.')
  )
))