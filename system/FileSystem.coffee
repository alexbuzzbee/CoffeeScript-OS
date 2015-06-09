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
# along with Foobar.  If not, see <http://www.gnu.org/licenses/>.

define [
  "../lib/local-storage/LocalStorage",
  "../lib/dojox/uuid/generateTimeBasedUuid"
], (LocalStorage, makeUuid) ->
  class FileSystem
    constructor: ->
      if not localStorage?
        errMsg = "CoffeeScript OS requires Web Storage. Please try again using Chrome > 4.0, Safari > 4.0, IE > 8.0, Firefox > 3.5, or Opera > 11.5"
        alert errMsg
        throw new Error errMsg + "."
      @store = new LocalStorage {
        idProperty: "loc"
      }
      @handles = []
      @dirExp = new RegExp "\.dir$"

    getNextId = ->
      id = @store.get(0).contents
      id = 1 if not id?
      @store.put {contents: id, loc: "/.nextInode"}
      return id

    createFile: (dir, name, contents, acl) ->
      inDir = @store.query {
        dir: dir
      }
      if inDir[0]?
        if contents?
          type = typeof contents
          type = "array" if Array.isArray(contents)
        else
          type = "string" # Contents type defaults to string.
        @store.add {
          loc: dir + "/" + name
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
        loc: path + "/.dirExists"
        dir: path
        name: ".dirExists"
      }
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
      contents.push {name: file.name, meta: file.meta} for file in files when file.name isnt ".dirExists" and not file.name.matches(@dirExp)?
      contents.push {name: dir.name, meta: {type: "dir"}} for dir in files when dir.name.matches(@dirExp)?
      return contents

    open: (dir, name) ->
      handle = makeUuid @node
      file = @store.query {
        path: dir + "/" + name
        dir: dir
        name: name
      }
      if file?
        handles[handle] = file
        return handle
      else
        return null

    flush: (handle) ->
      @store.put handles[handle]

    close: (handle) ->
      flush handle
      delete handles[handle]

  return FileSystem
