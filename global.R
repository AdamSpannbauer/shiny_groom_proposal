library(shiny)
library(shinyWidgets)
library(glue)
source('utils/sendmail.R')

keys_list = read_json('.keys')

Sys.setenv(mailgun_api_key = keys_list$mailgun_api_key_long, 
           mailgun_sandbox_id = keys_list$mailgun_sandbox_id)

booze_gif_paths = c(
  # 'ok_beer.gif',
  # 'dancin_champagne.gif',
  'wide_pbr_spill.gif'
)

groomsman_ids = c('kr', 'cpc', 'bw', 'imp')
