#
# Ethan Mick
# 2015
#
'use strict'

Hapi = require 'hapi'
SocketIO = require 'socket.io'
Q = require 'q'
config = require './config/config'
PORT = process.env.PORT or 4439

class Server

  constructor: ->
    server = new Hapi.Server()
    server.connection(port: 4439)
    @io = SocketIO.listen(server.listener)


  addSockets: (@handler)->
    @io.sockets.on 'connection', @handler


  addRoutes: (routes)->
    server.route(routes)


  start: ->
    console.log 'Attempting to start Hapi server.'
    deferred = Q.defer()
    server.start ->
      console.log 'Server started at: ', server.info.uri
      deferred.resolve()
    deferred.promise

module.exports = Server
