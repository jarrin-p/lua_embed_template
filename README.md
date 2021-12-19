# description
this is a template for using lua with C. it should run right away. it includes the setup for
* embedding lua into a C program (via including the lua library interpreter)
* using C functions in Lua scripts (via shared object .so files)
* creates .so object as a lua module which can be required by a lua script so long as it's in the cpath
