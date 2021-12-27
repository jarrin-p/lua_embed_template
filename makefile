OUT:=prog# output binary name

# Include Dirs
INCLUDEDIRS:=${LUAINCLUDE}

# External library names
EXTLIBS:=lua# name of the library in the lua include dir (in this case, it's "liblua", which is just -llua when linking)

# Get deps, targs
SRCS:=$(wildcard ./src/*.c)
SRCOBJS:=$(patsubst %.c,%.o,$(SRCS))

CC=gcc

# Get shared library deps, targs
LIBSRCS:=$(wildcard ./lib/*.c)
LIBS:=$(patsubst %.c,$(dir $(LIBSRCS))lib%.so,$(notdir $(LIBSRCS)))

CFLAGS=$(patsubst %,-I%,$(INCLUDEDIRS)) -Wall -Werror
LDFLAGS=$(patsubst %,-L%,$(INCLUDEDIRS)) $(patsubst %,-l%,$(EXTLIBS))

.PHONY: all build clean
all: clean build run

clean:
	-rm -r ./bin
	-mkdir bin
	-rm ./lib/*.so
	-rm ./src/*.o
build: $(LIBS) $(SRCOBJS) ./bin/$(OUT)

$(LIBS): $(LIBSRCS)
	$(CC) $(CFLAGS) $(LDFLAGS) -shared -fpic -o $(LIBS) $(LIBSRCS)

$(SRCOBJS): $(SRCS)
	$(CC) $(CFLAGS) -c -o $(SRCOBJS) $(SRCS)

./bin/$(OUT): LDFLAGS +=$(patsubst %,-L%,$(dir $(LIBS))) $(patsubst lib%.so,-l%,$(notdir $(LIBS)))
./bin/$(OUT): $(LIBS) $(SRCOBJS)
	$(CC) $(LDFLAGS) -o ./bin/$(OUT) $(SRCOBJS)

run: ./bin/$(OUT)
	./bin/$(OUT)
