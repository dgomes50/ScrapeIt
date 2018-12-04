# library(rvest)
# 
# url <- "http://apps.webofknowledge.com/summary.do?product=WOS&parentProduct=WOS&search_mode=AdvancedSearch&parentQid=&qid=1&SID=5ENlQKioapPTJ4rZuYC&&update_back2search_link_param=yes&page=1"
# 
# #Reading the HTML code from the website
# webpage <- read_html(url)
# 
# #Using CSS selectors to scrape the 'pages' section
# find_pages <- html_nodes(webpage,'value')
# 
# #Converting the data to text
# pages <- html_text(find_pages)
# 
# pages

library(dplyr)

### AB

filenames <- dir(path="AB_1918_2018", all.files = TRUE, recursive=TRUE)


out <- read.delim(paste0("AB_1918_2018/",filenames[1]), header=TRUE, sep="\t", row.names=NULL)

for(i in 2:length(filenames)){
  print(filenames[i])
  df<-read.delim(paste0("AB_1918_2018/",filenames[i]), header=TRUE, sep="\t", row.names=NULL) ### Read each file one at a time in for loop
  
  out <- rbind(out, df[-1,])
}

AB<-select(out, PT, Z2, Z3, MA, BP, SU, PD)  ### Gets rid of excess columns that are unecessary 

colnames(AB)<-c("AU", "TI", "SO","BP", "EP", "DATE", "YR")

View(AB)

sort(unique(AB$YR))
length(unique(AB$YR))

str(AB)

AB$BP<-as.integer(as.character(AB$BP))
AB$EP<-as.integer(as.character(AB$EP))
AB$Page<-AB$EP-AB$BP

sort(unique(AB$Page))

AB<-AB[which(AB$Page>0),]


plot((AB$Page)~AB$YR, main="Animal Behaviour: slope=-0.03 p<0.001", ylab="Page Numbers", xlab="Year")

m1<-lm(AB$Page~AB$YR)
summary(m1)
abline(m1, lwd=3)

plot(log(AB$Page+1)~AB$YR, main="Animal Behaviour: slope=-0.03 p<0.001", ylab="Page Numbers", xlab="Year")

m1<-glm(AB$Page~AB$YR, family=poisson(link="log"))
summary(m1)
abline(m1, lwd=3)

### Ecology
filenames <- dir(path="EC_1918_2018", all.files = TRUE, recursive=TRUE)


out <- read.delim(paste0("EC_1918_2018/",filenames[1]), header=TRUE, row.names=NULL, quote = "")

for(i in 2:length(filenames)){
  print(filenames[i])
  df<-read.delim(paste0("EC_1918_2018/",filenames[i]), header=TRUE, sep="\t", row.names=NULL, quote = "") ### Read each file one at a time in for loop
  
  out <- rbind(out, df)
}

EC<-select(out, PT, Z2, Z3, MA, BP, SU, PD)  ### Gets rid of excess columns that are unecessary 

colnames(EC)<-c("AU", "TI", "SO","BP", "EP", "DATE", "YR")

View(EC)

sort(unique(EC$YR))
length(unique(EC$YR))

str(EC)

EC$BP<-as.integer(as.character(EC$BP))
EC$EP<-as.integer(as.character(EC$EP))
EC$Page<-EC$EP-EC$BP

sort(unique(EC$Page))

EC<-EC[which(EC$Page>0),]


plot((EC$Page)~EC$YR, main="Ecology: slope=0.007 p<0.001", ylEC="Page Numbers", xlab="Year")

m1<-lm(EC$Page~EC$YR)
summary(m1)
abline(m1, lwd=3)

plot(log1p(EC$Page)~EC$YR, main="Ecology: slope=0.007 p<0.001", ylEC="Page Numbers", xlab="Year")

m1<-glm(EC$Page~EC$YR, family=poisson(link="log"))
summary(m1)
abline(m1, lwd=3)




## Check to see that loop worked
  df1<-read.delim(paste0("EC_1918_2018/",filenames[1]), header=TRUE, sep="\t", row.names=NULL, quote = "")
  df2<-read.delim(paste0("EC_1918_2018/",filenames[2]), header=TRUE, sep="\t", row.names=NULL)
  df3<-read.delim(paste0("EC_1918_2018/",filenames[3]), header=TRUE, sep="\t", row.names=NULL,quote = "")

df4<-rbind(df1, df2)
df5<-rbind(df4, df3)
View(df5)
identical(df5,out)
