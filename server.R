shinyServer(function(input, output, session) {
  groomsman_id = reactive({
    query = parseQueryString(session$clientData$url_search)
    gm_id = query[['gm_id']]
    
    if (is.null(gm_id)) gm_id = FALSE
    if (!(gm_id %in% groomsman_ids)) gm_id = FALSE
    
    gm_id = 'kr'
    
    return(gm_id)
  })
  
  output$booze_gif = renderUI({
    if (groomsman_id() == FALSE) {
      div(
        br(), br(), br(), br(),
        p("uhhh... you don't belong here...", 
          align='center',
          style="color:white")
      )
    } else {
      booze_gif_path = sample(booze_gif_paths)
      p(align='center', {
        img(src='wide_pbr_spill.gif', width='40%')
      })
    }
  })
  
  output$groomposal_gif = renderUI({
    req(groomsman_id())
    
    groomposal_gif_path = glue('{groomsman_id()}_groomposal.gif')
    
    p(align='center', {
      img(src=groomposal_gif_path, width='50%')
    })
  })
})





