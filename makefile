OUT:=test# output binary name

# Include Dirs
INCLUDEDIRS:=${LUAINCLUDE}

# External library names
EXTLIBS:=lua# name of the library in the lua include dir (in this case, it's "liblua", which is just -llua when linking)

# Get deps, targs
SRCS:=$(wildcard ./src/*.c)
SRCOBJS:=$(patsubst %.c,%.o,$(SRCS))

# Get shared library deps, targs
LIBSRCS:=$(wildcard ./lib/*.c)
LIBS:=$(patsubst %.c,$(dir $(LIBSRCS))lib%.so,$(notdir $(LIBSRCS)))

#ERRORFLAGS:=-Wall -Werror
ERRORFLAGS:=

CC:=gcc $(patsubst %,-I%,$(INCLUDEDIRS)) $(patsubst %,-L%,$(INCLUDEDIRS)) $(patsubst %,-l%,$(EXTLIBS)) $(ERRORFLAGS)

.PHONY: all build clean
all: clean build run
clean:
	-rm -r ./bin 
	-mkdir bin 
	-rm ./lib/*.so
build: $(LIBS) $(SRCOBJS) ./bin/$(OUT)
$(LIBS): CC:=gcc $(patsubst %,-I%,$(INCLUDEDIRS)) $(patsubst %,-L%,$(INCLUDEDIRS)) $(patsubst %,-l%,$(EXTLIBS)) $(ERRORFLAGS)
$(LIBS): $(LIBSRCS)
	#$(CC) -shared -fpic -o $(LIBS) $(LIBSRCS)
$(SRCOBJS): CC:=gcc $(patsubst %,-I%,$(INCLUDEDIRS)) $(patsubst %,-L%,$(INCLUDEDIRS)) $(patsubst %,-l%,$(EXTLIBS)) $(ERRORFLAGS)
$(SRCOBJS): $(SRCS)
	#$(CC) -o $<.o $<.c
./bin/$(OUT): CC:=gcc $(patsubst %,-I%,$(INCLUDEDIRS)) $(patsubst %,-L%,$(INCLUDEDIRS)) $(patsubst %,-l%,$(EXTLIBS)) $(ERRORFLAGS)\
	$(patsubst %,-L%,$(dir $(LIBS))) $(patsubst lib%.so,-l%,$(notdir $(LIBS)))
./bin/$(OUT): $(LIBS) $(SRCOBJS)
	#$(CC) -o ./bin/$(OUT) $(SRCOBJS)
run: ./bin/$(OUT)
	#./bin/$(OUT)
