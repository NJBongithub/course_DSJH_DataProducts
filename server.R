library(ggplot2)
library(plyr)

inferenceRule <- function(value, criterion) {
  if(value < criterion) {
    output <- "The current sample is pristine"
  }
  if(value >= criterion) {
    output <- "The current sample is polluted"
  }
  output
}

#generate 2 distributions of sample means
x<-seq(0.0,0.1699,0.0001) 
Null<-data.frame(pop=rep("Null",length(x)), sample_mean=x, count=dnorm(x,0.06,0.02))
Alt<-data.frame(pop=rep("Alt", length(x)), sample_mean=x, count=dnorm(x,0.10,0.02))
df<-rbind(Null, Alt)

shinyServer(
  function(input, output) {    
    output$decison_and_error_plot <- renderPlot({
      crit <- input$criterion;
      TypeI <- subset(df, sample_mean > crit & sample_mean < 12.5 & pop == "Null")
      TypeI <- rbind(TypeI[1, ], TypeI, TypeI[1, ])
      TypeI[1, "sample_mean"] = crit;
      TypeI[1, "count"] = 0;
      TypeI[nrow(TypeI), "sample_mean"] = 0.125;
      TypeI[nrow(TypeI), "count"] = 0;
      p <- qplot(x=sample_mean, y=count, data=df, geom="line", col=pop) 
      p <- p+geom_segment(aes(x=crit,y=-1,xend=crit,yend=21), col='black')
      p <- p+geom_polygon(data = TypeI, aes(TypeI$sample_mean, TypeI$count))      
      plot(p)    
    })
    output$prediction <- renderPrint({inferenceRule(input$t_observed, input$criterion)})
  }
)