new_posts = 0;

App.new_post = App.cable.subscriptions.create "NewPostChannel",
  connected: ->
    console.log 'connected to newpost channel'

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if document.hidden
      new_posts++
      document.title = 'SoloKill(' + new_posts + ')';
    if $('#posts').length
      $('#posts').prepend data['post']
    else
      $('#replies').append data['post']

$(window).focus (e) ->
  new_posts = 0
  document.title = 'SoloKill'
