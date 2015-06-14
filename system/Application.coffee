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

define ["require"], (require) ->
  class Application
    constructor: (main) ->
      @mod = require main
      throw "main module does not exist" if @mod is 3 # Dojo require returns 3 to indicate no such module.
      @obj = new @mod() # Create an instance of the application.
      @killHandlers = []
      throw "#{main} is not an application main module" if not @mod.initApp?
      @obj.initApp() # Initialize the application.

    kill: () ->
      @obj.terminate()
      handler() for handler in @killHandlers # Run the kill handlers.
      delete @obj
      delete @mod

    onKill: (handler) ->
      @killHandlers.push(handler)

  return Application
