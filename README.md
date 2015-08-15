# CoffeeScript OS

***WE HAVE MOVED TO GITLAB <https://gitlab.com/alexbuzzbee/CoffeeScript-OS>***

An 'operating system' written in CoffeeScript using Dojo.

## Concept
The idea for CoffeeScript OS came from various places, notably [windows93.net](http://www.windows93.net) and [Lucid Desktop](http://www.lucid-desktop.org). It is a web-based 'operating system' which allows the user to use applications, manage documents, and more, all in a modular Dojo-based system written in CoffeeScript. Applications, libraries, and even components of the core system are just Dojo AMD modules, written in CoffeeScript and compiled into JavaScript (or written directly in JavaScript, if you're boring).

## Design
CoffeeScript OS is organized into the 'system', 'applications', and 'libraries'. The system is the core functionality of CoffeeScript OS, and has control. Libraries are extra classes and modules which provide optional functionality. Applications are the main front-end component of CoffeeScript OS; they can open windows, display widgets using Dijit or jQuery UI, communicate amongst themselves, manipulate the filesystem, and more.

## Installation instructions

1. Unpack the CoffeeScript OS archive to any directory on your web server.
2. Open `index.html` in any text editor.
3. Find the line which says `baseUrl: "/csos/",` and change it to say `baseUrl: "/url/to/CoffeeScript/OS/installation/directory",` (e.g, if you installed at the root of your web server, make it `baseUrl: "/",`).
4. Visit the location of the new installation in your web browser.

## License

CoffeeScript OS is licensed under the GNU Affero General Public License (GPL).

```
CoffeeScript OS development build, simple menu-based interface for UNIX systems.
Copyright (C) 2014  Alex Martin

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
```

## Directory structure

```
/ # The root installation directory.
┃
┣━index.html # The HTML page that everything happens on.
┣━Makefile # The Makefile, used to build CoffeeScript OS.
┣━README.md # This README file.
┣━lib/ # Libraries used by the system and applications.
┃ ┣━dojo/ # Dojo core and base.
┃ ┣━dojox/ # DojoX.
┃ ┣━dijit/ # Dijit.
┃ ┗━local-storage/ # A library used to access Web Storage.
┣━apps/ # Contains applications.
┗━system/ # Contains the system.
  ┣━Kernel.coffee # The Kernel.
  ┣━FileSystem.coffee # The file system manager.
  ┣━Config.coffee # The configuration manager.
  ┗━*.js # Compiled versions of the above.
```

## Contributing

1. Come up with something useful and acceptable to do.
2. Fork the repository.
3. Make your changes, adhering to the style guide below when reasonable.
4. Submit a pull request (make sure you explain your changes).
5. Wait for the pull request to be reviewed.
6. Make any necessary changes to your patch.
7. Goto step 5 until patch is acceptable.
8. Congratulations! Your patch will be merged once acceptable, so long as you've followed the procedure.

## Style guide

### Function, method, and variable naming

Use camelCase, like:

```coffeescript
someExampleFunction = -> doSomething()
```
and

```coffeescript
someExampleMethod: -> doSomething()
```

and

```coffeescript
someExampleVariable = 2
```

### Function calls

Use the parenthises-less syntax whenever possible, like:

```coffeescript
doSomethingWith someValue, someOtherValue
```

### Class naming

Use PascalCase, like:

```coffeescript
class SomeExampleClass extends SomeSuperClass
  constructor: ->

someInstance = new SomeExampleClass()
```

### Comments

Use a beginning space, proper capitalization, and a period at the end, like so:

```coffeescript
doSomething() # Do something.
```

For sections, use dashes at the start and end, like so:

```coffeescript
doSomething()
# -- A section --
doSomethingElse()
```

### Commit messages

Phrase commit messages like you're giving orders to the codebase, without periods, and with proper capitalization, like `Add the system/Whatever class` or `Add a test for whatever in the system/Whatever constructor; fixes #9`.

### File naming

Name files based on the class they contain, like so:

```coffeescript
# In system/SomeExampleClass


define ["../lib/some-library/SomeClass"], ->
  class SomeExampleClass extends SomeSuperClass
    constructor: ->

  return SomeExampleClass
```

### Modules and classes

Always wrap single classes in single AMD modules (unless you have private classes), like the example above.
