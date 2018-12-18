shinyUI(
  fluidPage(
    setBackgroundColor('black'),
    br(),
    div(align='center',
        uiOutput('beer_gif'),
        uiOutput('button_press_response'),
        uiOutput('response_buttons'),
        uiOutput('goomposal_gif')
    )  # div
  )  # fluidPage
)  # shinyUI
