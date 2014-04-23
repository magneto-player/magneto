
spacePen = require 'space-pen'
Subscriber = require('emissary').Subscriber

class View extends spacePen.View
  Subscriber.includeInto @

module.exports = View
