library(jsonlite)
library(glue)
library(httr)


send_email = function(to_address = "spannbaueradam@gmail.com",
                      subject = "Mailgun from R",
                      message_text = "Mailgun from R") {
  #' Send email with mailgun api + sandbox
  #' 
  #' @param to_address email address to send message to
  #' @param subject email subject to use in message sent
  #' @param message_text email body to be sent
  #' 
  #' @details set mailgun_api_key & mailgun_sandbox_id as environment variables
  #' with Sys.setenv prior to using function
  #' 
  #' @return TRUE; if POST to mailgun fails function will stop
  #' 
  #' @examples 
  #' Sys.setenv(mailgun_api_key = 'XXXXXXXX', mailgun_sandbox_id = 'ZZZZZZZZ')
  #' send_email()
  
  mailgun_api_key = Sys.getenv("mailgun_api_key")
  mailgun_sandbox_id = Sys.getenv("mailgun_sandbox_id")
  
  stopifnot(mailgun_api_key != "", mailgun_sandbox_id != "")
  
  mailgun_post_url =
    glue::glue("https://api.mailgun.net/v3/{mailgun_sandbox_id}.mailgun.org/messages")
  
  email_body =
    list(
      from =
        glue::glue("Mailgun Sandbox <postmaster@{mailgun_sandbox_id}.mailgun.org>"),
      to = to_address,
      subject = subject,
      text = message_text
    )
  
  response = httr::POST(
    mailgun_post_url,
    httr::authenticate("api", mailgun_api_key),
    encode = "form",
    body = email_body
  )
  
  httr::stop_for_status(req)
  
  return(TRUE)
}
