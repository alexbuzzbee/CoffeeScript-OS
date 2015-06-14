# This file is part of CoffeeScript OS.
#
# CoffeeScript OS is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# CoffeeScript OS is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with CoffeeScript OS.  If not, see <http://www.gnu.org/licenses/>.

define ["./Application"], (Application) ->
  class ApplicationManager
    constructor: () ->
      @apps = []
      @services = []

    launch: (main) ->
      app = new Application main

      @apps.push app

      return @apps.length

    kill: (id) ->
      return @apps[id].terminate() if @apps[id].terminate?

    addService: (owner, name, object) ->
      return false if @services[name]? or typeof object isnt "object"
      @apps[owner].onKill removeService.bind this, name # When the owner is terminated, remove the service.
      @services[name] =
        owner: owner
        object: object
      return true

    removeService: (service) ->
      @services[service].die() if @services[service]? @services[service].die?
      delete @services[service] if @services[service]?

    sendMessage: (service, message, args...) ->
      return [false] if (not @services[service]?) or (not @services[service].object[message])
      result = @services[service].object[message](args...)
      return [true, result]

  return new ApplicationManager()
