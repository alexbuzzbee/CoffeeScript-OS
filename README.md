# CoffeeScript OS
An 'operating system' written in CoffeeScript using Dojo.

## Concept
The idea for CoffeeScript OS came from various places, notably [windows93.net](http://www.windows93.net) and [Lucid Desktop](http://www.lucid-desktop.org). It is a web-based 'operating system' which allows the user to use applications, manage documents, and more, all in a modular Dojo-based system written in CoffeeScript. Applications, libraries, and even components of the core system are just Dojo AMD modules, written in CoffeeScript and compiled into JavaScript (or written directly in JavaScript, if you're boring).

## Design
CoffeeScript OS is organized into the 'system', 'applications', and 'libraries'. The system is the core functionality of CoffeeScript OS, and has control. Libraries are extra classes and modules which provide optional functionality. Applications are the main front-end component of CoffeeScript OS; they can open windows, display widgets using Dijit, communicate amongst themselves, manipulate the filesystem, and more.

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
┣━system/ # Contains the system.
┃ ┣━Kernel.coffee # The Kernel.
┃ ┣━FileSystem.coffee # The file system manager.
┃ ┗━*.js # Compiled versions of the above.
```

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

Phrase commit messages like you're giving orders to the codebase, without periods, and with proper capitalization, like `Add the system/Whatever class` or `Add a test for whatever in the system/Whatever constructor. Fixes #9.`.

### File naming

Name files based on the class they contain, like do:

```coffeescript
# In system/SomeExampleClass


define ["../lib/some-library/SomeClass"], ->
  class SomeExampleClass extends SomeSuperClass
    constructor: ->

  return SomeExampleClass
```

### Modules and classes

Always wrap single classes in single AMD modules (unless you have private classes), like the example above.