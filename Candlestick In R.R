install.packages("plotly")
library(plotly)
g <- ggplot(faithful, aes(x = eruptions, y = waiting)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon") + 
  xlim(1, 6) + ylim(40, 100)
ggplotly(g)

install.packages("quantmod")
install.packages("magrittr")
install.packages("XLConnect")
library(quantmod)
library(magrittr)
library(XLConnect)
library(dplyr)
library(ggplot2)
library(devtools)
library(plotly)





# Get data
stock <- getSymbols("MSFT", auto.assign = F)
dts <- index(stock)
df <- data.frame(stock, row.names = NULL)
df$dates <- dts
names(df) <- c("Open", "High", "Low", "Close", "Volume", "Adjusted", "dates")

# Subset to after Jan 2016
df <- subset(df, dates > "2016-01-01")

# Color or volume bars
barcols <- c()
for (i in 1:length(df$dates)) {
  
  if (i == 1) {barcols[i] <- "#F95959"}
  
  if (i > 1) {
    x <- ifelse(df$Close[i] > df$Close[i - 1], "#455D7A", "#F95959")
    barcols[i] <- x
  }
}

# Moving Avg line
MA <- runMean(df$Close)

# Range selector
rangeselectorlist = list(
  x = 0, y = 0.9,
  bgcolor = "#0099cc",
  font = list(color = "white"),
  
  buttons = list(
    list(count = 1, label = "reset", step = "all"),
    list(count = 1, label = "1yr", step = "year", stepmode = "backward"),
    list(count = 3, label = "3 mo", step = "month", stepmode = "backward"),
    list(count = 1, label = "1 mo", step = "month", stepmode = "backward"),
    list(step = "all")
  )
)

#step 2

plot_ly(df, type = "candlestick",
        x = ~dates,
        open = ~Open, high = ~High, low = ~Low, close = ~Close,
        yaxis = "y",
        increasing = list(line = list(color = "#455D7A")),
        decreasing = list(line = list(color = "#F95959")),
        name = "Price",
        height = 600, width = 1024) %>%
  
  add_bars(data = df, x = ~dates, y = ~Volume,
           marker = list(color = barcols),
           yaxis = "y2", inherit = F, name = "Vol") %>%
  
  add_lines(x = df$dates, y = MA,
            line = list(width = 3, dash = "5px", color = "#33bbff"),
            inherit = F, name = "Mov Avg") %>%
  
  layout(
    plot_bgcolor = "rgb(250,250,250)",
    xaxis = list(title = "", domain = c(0,0.95),
                 
                 rangeslider = list(visible = F),
                 
                 rangeselector = rangeselectorlist),
    yaxis = list(domain = c(0.22, 0.9)),
    yaxis2 = list(domain = c(0, 0.18), side = "right"),
    
    showlegend = F,
    
    annotations = list(
      list(x = 0, y = 1, xanchor = "left", yanchor = "top",
           xref = "paper", yref = "paper",
           text = paste0("<b>Microsoft</b>"),
           font = list(size = 30, family = "serif"),
           showarrow = FALSE),
      
      list(x = 0.8, y = 0.95, xanchor = "left", yanchor = "top",
           xref = "paper", yref = "paper",
           text = paste0("[", paste(range(df$dates),collapse = " / "), "]"),
           font = list(size = 15, family = "serif"),
           showarrow = FALSE),
      
      list(x = 0, y = 0.18, xanchor = "left", yanchor = "top",
           xref = "paper", yref = "paper",
           text = paste0("<b>Volume</b>"),
           font = list(size = 15, family = "serif"),
           showarrow = FALSE)
    )
  )

