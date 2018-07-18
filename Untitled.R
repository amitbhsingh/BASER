---
   title: "SVM"
author: "Amit"
date: "7/18/2018"
output: html_document
---
   
   ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:
   
   ```{r cars}
data(iris)
str(iris)
library(ggplot2)
qplot(Petal.Length,Petal.Width,data=iris,color=Species)
```

```{r}
library(e1071)
classificationmymode<-svm(Species~.,data=iris)
linearmymode<-svm(Species~.,data=iris,kernal="linear")
logisticmode<-svm(Species~.,data=iris,kernal="logistic")
tanhmode<-svm(Species~.,data=iris,kernal="tanh")
summary(tanhmode)
summary(logisticmode)
summary(classificationmymode)
summary(linearmymode)
plot(tanhmode,data=iris,Petal.Width~Petal.Length,slice=list(Sepal.Width=3,Sepal.Length=4))
```

```{r}
#confusion matrix
pred<-predict(tanhmode,iris)
tab<-table(Predicted=pred,Actual=iris$Species)
tab
1-sum(diag(tab))/sum(tab)
```

```{r}
#Tuning
set.seed(123)
tmodel<-tune(svm,Species~.,data=iris,ranges = list(epsilon=seq(0,1,0.1),cost=2^(2:9)))
plot(tmodel)
summary(tmodel)
#best model
permodel<-tmodel$best.model
summary(permodel)
plot(permodel,data=iris,Petal.Width~Petal.Length,slice=list(Sepal.Width=3,Sepal.Length=4))
```

```{r}
#Misclassification error is only 2
pre<-predict(permodel,iris)
tab<-table(Predicted=pre,Actual=iris$Species)
tab
1-sum(diag(tab))/sum(tab)

```

## Including Plots

You can also embed plots, for example:
   
   ```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
