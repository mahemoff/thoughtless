#!/usr/bin/env coffee
global[lib] = require lib for lib in "http,fs".split ','
_ = require('lodash')

fs.readFile 'index.html', 'utf8', (err,data) ->
  return console.log(err) if err
  scriptTags = data.match(/<script.*?x-cdn=(.*?)><\/script>/g)
  console.log(scriptTags)
  cdnURLs = _.map scriptTags, (scriptTag) ->
    scriptTag.replace /.*x-cdn="(.*?)".*/, "$1"
  _(cdnURLs).each (url) -> download(url)

download = (url) ->
  file = fs.createWriteStream "webcache/#{encodeURIComponent(url)}"
  request = http.get "http://im.glogster.com/media/2/5/24/10/5241033.png", (response) ->
    response.pipe(file)
