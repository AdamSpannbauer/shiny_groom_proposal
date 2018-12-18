library(shiny)
library(shinyWidgets)
library(glue)
source('utils/sendmail.R')

keys_list = read_json('.keys')

Sys.setenv(mailgun_api_key = keys_list$mailgun_api_key_long, 
           mailgun_sandbox_id = keys_list$mailgun_sandbox_id)

groomsman_ids = c('kr', 'cpc', 'bw', 'imp', 'jlvp2')

unknown_id_response = 
  div(
    br(), br(), br(), br(),
    p("uhhh... you don't belong here...", 
      align='center',
      style="color:white")
  )
