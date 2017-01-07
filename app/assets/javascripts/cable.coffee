# Action Cable provides the framework to deal with WebSockets in Rails.
# You can generate new channels where WebSocket features live using the rails generate channel command.
#
#= require action_cable
#= require_self
#= require_tree ./channels

# This creates the consumer and established the connection to the cable server.
# If we keep it like this, we are creating always a connection.
@App ||= {}
$ ->
  if $(".js--new-message").length
    App.cable = ActionCable.createConsumer()
