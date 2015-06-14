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

define [
  "./FileSystem"
  "./Config"
  "./defaults"
  "./Terminal"
  "./ApplicationManager"
  "dijit/registry"
  "dijit/layout/ContentPane"
  "require"
], (fs, Config, defaults, Terminal, ApplicationManager, dijitRegistry, ContentPane, require) ->
  class Kernel
    constructor: () ->
      @cfg = new Config("system")

    getSysConf: (key, type) ->
      value = @cfg.get key
      return value if typeof value is type
      return defaults[key] if typeof defaults[key] is type # Try fetching it from the defaults.
      return null

    ready: ->
      # -- Initialize console --
      @content = new ContentPane({}, "contentRect")
      @content.set "content", "<textarea id='systemConsole'></textarea>"
      @console = new Terminal "systemConsole"

      @console.print("System initializing...\n")

      # -- Load atBoot modules --
      @console.print("Loading boot modules...\n")
      mods = @getSysConf("atBoot", "object")
      for module in mods
        @console.print "system/#{module}\n"
        require "system/#{module}", -> null

      # -- Launch bootApps --
      bootApps = @getSysConf "bootApps", "object"
      ApplicationManager.launch app for app in bootApps.always
      ApplicationManager.launch app for app in bootApps.text if not @getSysConf "enableWindowSystem", "bool"
      ApplicationManager.launch app for app in bootApps.windowing if @getSysConf "enableWindowSystem", "bool"
      return null

  return new Kernel()
