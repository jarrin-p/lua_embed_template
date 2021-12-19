#ifndef Z_SHARED_H__
#define Z_SHARED_H__

#include <stdio.h>

#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

// Function headers
extern void sayHello(void);
extern int l_testputs(lua_State *L);
extern int luaopen_libshared(lua_State *L);

#endif
