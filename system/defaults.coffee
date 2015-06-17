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

# Default configuration for CoffeeScript OS System.

define ->
  defaults =
    atBoot: `[]` # Default system modules to load at boot (as opposed to on-demand).
    bootApps: # Default apps to start at boot.
      always: `[]`
      text: `["apps/shell/main.js"]` # apps/shell is the command-line shell.
      windowing: `["apps/gshell/main.js"]` # apps/gshell is the graphical shell (AKA desktop envrionment).
    enableWindowSystem: false
    systemVersion: 0.1
  return defaults
