#include "../include/shared.h"

void sayHello(void) {
    puts("Hello from a shared library object.");
}

int l_testputs(lua_State *L) {
    const char *str = lua_tostring(L, 1); // index of passed parameter in lua
    printf("%s\n", str);
    lua_pushstring(L, str); // Ends up returning the passed in string, just for testing
    return 1; // C function called from lua returns number of pushed items from stack
}

static const struct luaL_Reg libshared[] = {
    { "testputs", l_testputs },
    { NULL, NULL }
};

int luaopen_libshared(lua_State *L) {
    luaL_newlib(L, libshared);
    return 1;
}
