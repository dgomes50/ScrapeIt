library(rvest)

url <- "http://apps.webofknowledge.com/summary.do?product=WOS&parentProduct=WOS&search_mode=AdvancedSearch&parentQid=&qid=1&SID=5ENlQKioapPTJ4rZuYC&&update_back2search_link_param=yes&page=1"

#Reading the HTML code from the website
webpage <- read_html(url)

#Using CSS selectors to scrape the 'pages' section
find_pages <- html_nodes(webpage,'value')

#Converting the data to text
pages <- html_text(find_pages)

pages
