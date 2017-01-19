
#libraries
rm(list=ls())
setwd("~/Documents/GITProjects/kernelOnfuzzySetNoiseData")

library(dplyr,warn.conflicts = FALSE)
library(ggplot2)
library(lazyeval)
library(geometry)
library(openxlsx)
library(ggvis)
library(caret)
library(randomForest)
library(mlbench)
library(caretEnsemble)
library(rpart)
library(parallel)
library(doParallel)
library(glmnet)
require(gridExtra)
library(hydroGOF)


#DATASET
#-------------
#path<-"resultsPIMA.csv"
path<-"resultssonar.csv"
pathExperiments<-"../../output/experiments/"
data_set<-read.csv(path,head=TRUE,sep=",")
data_set<-tbl_df(data_set)

#################
# clean training - noise test
#################
# 5%
data_5=data_set[grep("-5an-cn", data_set$Dataset), ]

data_5<-data_5 %>%
  select(Dataset,fuzzyfication, kernelOption, AUC, AUC.1)  %>%
  filter(kernelOption != 31) %>%
  filter(kernelOption != 2)


# 10%
data_10=data_set[grep("-10an-cn", data_set$Dataset), ]

data_10<-data_10 %>%
  select(Dataset,fuzzyfication, kernelOption, AUC, AUC.1)  %>%
  filter(kernelOption != 31) %>%
  filter(kernelOption != 2)

# 15%
data_15=data_set[grep("-15an-cn", data_set$Dataset), ]

data_15<-data_15 %>%
  select(Dataset,fuzzyfication, kernelOption, AUC, AUC.1)  %>%
  filter(kernelOption != 31) %>%
  filter(kernelOption != 2)


# 20%
data_20=data_set[grep("-20an-cn", data_set$Dataset), ]

data_20<-data_20 %>%
  select(Dataset,fuzzyfication, kernelOption, AUC, AUC.1)  %>%
  filter(kernelOption != 31) %>%
  filter(kernelOption != 2)


############
#----------
#PLOT
#----------
############
library(ggvis)
df<-data_frame(data_5$AUC,data_10$AUC,data_15$AUC,data_20$AUC)
df<-data.frame(x=c(5,10,15,20),
               count_oil=unlist(df[1,]),
               count_gas=unlist(df[2,]),
               fuzz4=unlist(df[6,]),
               fuzz5=unlist(df[7,]),
               fuzz6=unlist(df[8,]),
               fuzz7=unlist(df[9,]),
               fuzz8=unlist(df[10,]),
               fuzz9=unlist(df[11,])
)


df %>% ggvis( ~x, ~count_oil) %>%
  layer_paths(strokeDash:=3)  %>% 
  layer_points()  %>% 
  layer_points(size := 50,fill="....... linear") %>%
  layer_paths( ~x, ~count_gas,strokeDash:=3) %>% 
  layer_points( ~x, ~count_gas,fill="....... Gaussian") %>% 
  layer_paths( ~x, ~fuzz4,strokeDash:=7) %>% 
  layer_points( ~x, ~fuzz4,fill="- - - - fuzzy linear - I") %>% 
  layer_paths( ~x, ~fuzz5,strokeDash:=7) %>% 
  layer_points( ~x, ~fuzz5,fill="- - - - fuzzy exp - I") %>% 
  layer_paths( ~x, ~fuzz6,strokeDash:=7) %>% 
  layer_points( ~x, ~fuzz6,fill="- - - - fuzzy Gaussian - I") %>% 
  layer_paths( ~x, ~fuzz7) %>% 
  layer_points( ~x, ~fuzz7,fill="____ fuzzy linear - II") %>% 
  layer_paths( ~x, ~fuzz8) %>% 
  layer_points( ~x, ~fuzz8,fill="____ fuzzy exp - II") %>% 
  layer_paths( ~x, ~fuzz9) %>% 
  layer_points( ~x, ~fuzz9,fill="____ fuzzy Gaussian - II") %>% 
  
  scale_numeric("y", domain = c(0.7,1)) %>%
  
  add_axis("y", 
           title = "AUC",
           title_offset = 50,
           subdivide = 3,
           properties = axis_props(labels = list(fontSize = 15),title = list(fontSize = 15)))  %>%
  add_axis("x",
           title = "Noise Level (%)",
           values = c(5,10,15,20),
           subdivide = 0,
           properties = axis_props(labels = list(fontSize = 15),title = list(fontSize = 15)))  %>%
  add_legend("fill", title = "Kernel")

#################
# noise training - noise test
#################
# 5%
data_5=data_set[grep("-5an-nn", data_set$Dataset), ]

data_5<-data_5 %>%
  select(Dataset,fuzzyfication, kernelOption, AUC, AUC.1)  %>%
  filter(kernelOption != 31) %>%
  filter(kernelOption != 2)


# 10%
data_10=data_set[grep("-10an-nn", data_set$Dataset), ]

data_10<-data_10 %>%
  select(Dataset,fuzzyfication, kernelOption, AUC, AUC.1)  %>%
  filter(kernelOption != 31) %>%
  filter(kernelOption != 2)

# 15%
data_15=data_set[grep("-15an-nn", data_set$Dataset), ]

data_15<-data_15 %>%
  select(Dataset,fuzzyfication, kernelOption, AUC, AUC.1)  %>%
  filter(kernelOption != 31) %>%
  filter(kernelOption != 2)


# 20%
data_20=data_set[grep("-20an-nn", data_set$Dataset), ]

data_20<-data_20 %>%
  select(Dataset,fuzzyfication, kernelOption, AUC, AUC.1)  %>%
  filter(kernelOption != 31) %>%
  filter(kernelOption != 2)


############
#----------
#PLOT
#----------
############
library(ggvis)
df<-data_frame(data_5$AUC,data_10$AUC,data_15$AUC,data_20$AUC)
df<-data.frame(x=c(5,10,15,20),
               count_oil=unlist(df[1,]),
               count_gas=unlist(df[2,]),
               fuzz4=unlist(df[6,]),
               fuzz5=unlist(df[7,]),
               fuzz6=unlist(df[8,]),
               fuzz7=unlist(df[9,]),
               fuzz8=unlist(df[10,]),
               fuzz9=unlist(df[11,])
)


df %>% ggvis( ~x, ~count_oil) %>%
  layer_paths(strokeDash:=3)  %>% 
  layer_points()  %>% 
  layer_points(size := 50,fill="....... linear") %>%
  layer_paths( ~x, ~count_gas,strokeDash:=3) %>% 
  layer_points( ~x, ~count_gas,fill="....... Gaussian") %>% 
  layer_paths( ~x, ~fuzz4,strokeDash:=7) %>% 
  layer_points( ~x, ~fuzz4,fill="- - - - fuzzy linear - I") %>% 
  layer_paths( ~x, ~fuzz5,strokeDash:=7) %>% 
  layer_points( ~x, ~fuzz5,fill="- - - - fuzzy exp - I") %>% 
  layer_paths( ~x, ~fuzz6,strokeDash:=7) %>% 
  layer_points( ~x, ~fuzz6,fill="- - - - fuzzy Gaussian - I") %>% 
  layer_paths( ~x, ~fuzz7) %>% 
  layer_points( ~x, ~fuzz7,fill="____ fuzzy linear - II") %>% 
  layer_paths( ~x, ~fuzz8) %>% 
  layer_points( ~x, ~fuzz8,fill="____ fuzzy exp - II") %>% 
  layer_paths( ~x, ~fuzz9) %>% 
  layer_points( ~x, ~fuzz9,fill="____ fuzzy Gaussian - II") %>% 
  
  scale_numeric("y", domain = c(0.7,1)) %>%
  
  add_axis("y", 
           title = "AUC",
           title_offset = 50,
           subdivide = 3,
           properties = axis_props(labels = list(fontSize = 15),title = list(fontSize = 15)))  %>%
  add_axis("x",
           title = "Noise Level (%)",
           values = c(5,10,15,20),
           subdivide = 0,
           properties = axis_props(labels = list(fontSize = 15),title = list(fontSize = 15)))  %>%
  add_legend("fill", title = "Kernel")
#################
# noise training - clean test
#################
# 5%
data_5=data_set[grep("-5an-nc", data_set$Dataset), ]

data_5<-data_5 %>%
  select(Dataset,fuzzyfication, kernelOption, AUC, AUC.1)  %>%
  filter(kernelOption != 31) %>%
  filter(kernelOption != 2)


# 10%
data_10=data_set[grep("-10an-nc", data_set$Dataset), ]

data_10<-data_10 %>%
  select(Dataset,fuzzyfication, kernelOption, AUC, AUC.1)  %>%
  filter(kernelOption != 31) %>%
  filter(kernelOption != 2)

# 15%
data_15=data_set[grep("-15an-nc", data_set$Dataset), ]

data_15<-data_15 %>%
  select(Dataset,fuzzyfication, kernelOption, AUC, AUC.1)  %>%
  filter(kernelOption != 31) %>%
  filter(kernelOption != 2)


# 20%
data_20=data_set[grep("-20an-nc", data_set$Dataset), ]

data_20<-data_20 %>%
  select(Dataset,fuzzyfication, kernelOption, AUC, AUC.1)  %>%
  filter(kernelOption != 31) %>%
  filter(kernelOption != 2)


############
#----------
#PLOT
#----------
############
library(ggvis)
df<-data_frame(data_5$AUC,data_10$AUC,data_15$AUC,data_20$AUC)
df<-data.frame(x=c(5,10,15,20),
               count_oil=unlist(df[1,]),
               count_gas=unlist(df[2,]),
               fuzz4=unlist(df[6,]),
               fuzz5=unlist(df[7,]),
               fuzz6=unlist(df[8,]),
               fuzz7=unlist(df[9,]),
               fuzz8=unlist(df[10,]),
               fuzz9=unlist(df[11,])
)


df %>% ggvis( ~x, ~count_oil) %>%
  layer_paths(strokeDash:=3)  %>% 
  layer_points()  %>% 
  layer_points(size := 50,fill="....... linear") %>%
  layer_paths( ~x, ~count_gas,strokeDash:=3) %>% 
  layer_points( ~x, ~count_gas,fill="....... Gaussian") %>% 
  layer_paths( ~x, ~fuzz4,strokeDash:=7) %>% 
  layer_points( ~x, ~fuzz4,fill="- - - - fuzzy linear - I") %>% 
  layer_paths( ~x, ~fuzz5,strokeDash:=7) %>% 
  layer_points( ~x, ~fuzz5,fill="- - - - fuzzy exp - I") %>% 
  layer_paths( ~x, ~fuzz6,strokeDash:=7) %>% 
  layer_points( ~x, ~fuzz6,fill="- - - - fuzzy Gaussian - I") %>% 
  layer_paths( ~x, ~fuzz7) %>% 
  layer_points( ~x, ~fuzz7,fill="____ fuzzy linear - II") %>% 
  layer_paths( ~x, ~fuzz8) %>% 
  layer_points( ~x, ~fuzz8,fill="____ fuzzy exp - II") %>% 
  layer_paths( ~x, ~fuzz9) %>% 
  layer_points( ~x, ~fuzz9,fill="____ fuzzy Gaussian - II") %>% 
  
  scale_numeric("y", domain = c(0.7,1)) %>%
  
  add_axis("y", 
           title = "AUC",
           title_offset = 50,
           subdivide = 3,
           properties = axis_props(labels = list(fontSize = 15),title = list(fontSize = 15)))  %>%
  add_axis("x",
           title = "Noise Level (%)",
           values = c(5,10,15,20),
           subdivide = 0,
           properties = axis_props(labels = list(fontSize = 15),title = list(fontSize = 15)))  %>%
  add_legend("fill", title = "Kernel")