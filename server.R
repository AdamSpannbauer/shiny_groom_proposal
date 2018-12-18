shinyServer(function(input, output, session) {
  
  # get groomsman id from url query (returns FALSE if invalid/missing)
  groomsman_id = reactive({
    query = parseQueryString(session$clientData$url_search)
    gm_id = query[['gm_id']]
    
    if (is.null(gm_id)) gm_id = FALSE
    if (!(gm_id %in% groomsman_ids)) gm_id = FALSE
    
    gm_id
  })
  
  # if valid groomsman id display beer gif, response buttons, & groomposal gif
  # if invalid groomsman id display message to go away
  output$beer_gif = renderUI({
    if (groomsman_id() == FALSE) return(unknown_id_response)
    
    p(
      img(src='wide_pbr_spill.gif', width='40%')
    )
  })
  
  output$goomposal_gif = renderUI({
    req(groomsman_id(),
        sum(input$yes_button, input$no_button) == 0)
    
    p(
      img(src=glue('groomposal_gifs/{groomsman_id()}_groomposal.gif'), width='50%')
    )
  })
  
  output$response_buttons = renderUI({
    req(groomsman_id(), 
        sum(input$yes_button, input$no_button) == 0)
    
    p(
      actionGroupButtons(inputIds = c('yes_button', 'no_button'),
                         labels = c('yes', 'no'), 
                         direction = 'horizontal',
                         status='danger')
    )
  })
  
  output$button_press_response = renderUI({
    req(groomsman_id(), 
        sum(input$yes_button, input$no_button) > 0)
    
    email_subject = glue('{groomsman_id()} groomposal response')
    
    if (input$yes_button > 0) {
      send_email(subject = email_subject,
                 message_text = 'yes',
                 stop_on_fail = FALSE)
      
      response_gif = img(src='reaction_gifs/happy_michael_scott.gif', width='40%')
    } else {
      send_email(subject = email_subject,
                 message_text = 'no',
                 stop_on_fail = FALSE)
     
      response_gif = img(src='reaction_gifs/bummed_michael_scott.gif', width='30%')
    }
    
    p(response_gif)
  })
})
