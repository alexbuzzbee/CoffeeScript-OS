SOURCES = $(wildcard system/*.coffee)
COMPILED = ${SOURCES:.coffee=.js}

build: build-production

build-production: pack

build-dev: compile

pack: CoffeeScript-OS.tar.gz

CoffeeScript-OS.tar.gz: ${COMPILED} index.html
	tar -czf CoffeeScript-OS.tar.gz ${COMPILED} lib/ index.html

compile: ${COMPILED}

clean:
	rm ${COMPILED} CoffeeScript-OS.tar.gz

%.js: %.coffee # Generic CoffeeScript compile rule.
	coffee -c $^
