
spacePen = require 'space-pen'
{Subscriber} = require 'emissary'

class View extends spacePen.View
  Subscriber.includeInto @

module.exports = View
