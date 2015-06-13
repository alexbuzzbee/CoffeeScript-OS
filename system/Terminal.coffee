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

define ["dijit/form/SimpleTextarea"], (SimpleTextarea) ->
  class Terminal # A simple, always-echo terminal.
    constructor: (elementId, width, height) ->
      width = 80 if not width?
      height = 20 if not height?
      @ta = new SimpleTextarea {
        name: elementId,
        cols: width,
        rows: height,
        style: "width: auto; overflow: hidden; color: white; background-color: black;"
      }, elementId
      @ta.on "keypress", @keyDown
      @keyBuffer = ""

    print: (text) ->
      @ta.set "value", @ta.get("value") + text # Append the text to the terminal's contents.

    clear: ->
      @ta.value = ""

    onKey: (e) ->
      @keyBuffer += e.char

    read: -> # Pull all characters out of the key buffer.
      retval = @keyBuffer
      @keyBuffer = ""
      return retval

    readLine: -> # Pull characters up to, but not including, the next newline character out of the key buffer.
      line = ""
      lineSize = 0
      for char, index in @keyBuffer.split ""
        break if char is "\n"
        line += char
        lineSize++
      @keyBuffer = @keyBuffer.substr(lineSize + 1)
      return line
