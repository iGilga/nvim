local setup = {
  prompt_title = '',
  initial_mode = 'normal',
  theme_conf = {
    borderchars = {
      prompt = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
      results = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
    },
  },
}

require('session-lens').setup(setup)
