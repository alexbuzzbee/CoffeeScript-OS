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

define [
  "../lib/local-storage/LocalStorage"
], (LocalStorage) ->
  class FileSystem # Implements a simple filesystem on top of LocalStorage.
    constructor: ->
      if not localStorage? # Make sure Web Storage is available.
        errMsg = "CoffeeScript OS requires Web Storage. Please try again using Chrome > 4.0, Safari > 4.0, IE > 8.0, Firefox > 3.5, or Opera > 11.5"
        alert errMsg + "."
        throw new Error errMsg
      @store = new LocalStorage { # Create an instance of LocalStorage for our own private use.
        idProperty: "loc"
      }
      @handles = []
      @dirExp = new RegExp "\.dir$"

    createFile: (dir, name, contents, acl) ->
      inDir = @store.query {
        loc: dir + ".dir"
      }
      if inDir[0]?
        if contents?
          type = typeof contents
          type = "array" if Array.isArray(contents)
        else
          type = "string" # Contents type defaults to string.
        @store.add {
          loc: dir + "/" + name # Absolute path as universal ID.
          dir: dir
          name: name
          contents: contents or "" # Contents default to "".
          meta: {
            acl: acl or { # ACL defaults to all permissions except Execute for the owner, only Read and See for the world.
              owner: ["Read", "Write", "Delete", "Move", "Copy", "See", "AlterAcl"]
              world: ["Read", "See"]
            },
            type: type
          }
        }, {
          id: @getNextId()
        }
        return [true]
      else
        return [false, "no such directory"]

    createDir: (dir, name) ->
      path = dir + "/" + name
      @store.add {
        loc: path + ".dir"
        dir: dir
        name: name + ".dir"
      }
      return [true]

    getDir: (dir) ->
      files = @store.query {
        dir: dir
      }
      contents = []
      contents.push {name: file.name, meta: file.meta} for file in files when not file.loc.match(@dirExp)?
      contents.push {name: dir.name, meta: {type: "dir"}} for dir in files when dir.loc.match(@dirExp)?
      return contents

    exists: (path) ->
      files = @store.query {
        loc: path
      }
      return true if files[0]?
      return false

    isDir: (path) ->
      @exists path + ".dir"

    open: (path) ->
      handle = makeUuid @node
      file = @store.query {
        loc: path
      }
      if file?
        @handles[handle] = file
        return handle
      else
        return null

    flush: (handle) ->
      return false if not @exists @handles[handle].loc # Don't throw when the file doesn't exist.
      try
        @store.put @handles[handle]
      catch
        return false
      return true

    close: (handle) ->
      @flush handle
      delete @handles[handle]

    read: (handle) ->
      return @handles[handle]

    write: (handle, data) ->
      @handles[handle] = data
      return null

  return FileSystem
