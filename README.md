# description
a template for using lua with C. it should run right away. it includes the setup for
* embedding a lua interpreter into a C program
* using C functions in Lua scripts via pushing functions directly to lua state
* creating lua c-module which can be required by a lua script (so long as it's in the cpath)
* loading a library directly from C into the lua state
