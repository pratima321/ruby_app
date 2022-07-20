# README

Write a ruby script that:

a. Receives a log as argument (webserver.log is provided)
e.g.: ./parser.rb webserver.log

b. Returns the following:

> list of webpages with most page views ordered from most pages views to less page views
e.g.:
/home 90 visits /index 80 visits etc... 

> list of webpages with most
unique page views also ordered
e.g.:
/about/2 8 unique views
/index 5 unique views etc...

* How to run log parser

>rails r ./parser.rb webserver.log


* How to run the test suite

>bundle exec rspec ./spec/lib/log_processor_spec.rb 
