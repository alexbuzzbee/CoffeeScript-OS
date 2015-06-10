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
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with CoffeeScript OS.  If not, see <http://www.gnu.org/licenses/>.

define ["./FileSystem"], (FileSystem) -> # Provides a simplified configuration interface.
  class Config
    constructor: (owner) ->
      @dir = "/config/" + owner
      @fs = new FileSystem()

    get: (key) ->
      handle = @fs.open @dir + "/" + key
      value = @fs.read handle
      @fs.close handle
      return value

    set: (key, value) ->
      handle = @fs.open @dir + "/" + key
      @fs.write value
      @fs.close handle
      return value

  return Config
