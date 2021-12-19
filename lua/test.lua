require 'io'

--[[ libshared.so is also compiled as a C module. It has a function luaopen_libshared
    which enables it to look for an open the library when required from lua.
    In the template, the library is being opened directly from C. However it can
    simply be included by using require --]]
--package.cpath = './lib/?.so;' .. package.cpath
--io.write(package.cpath, '\n')
--local libshared = require 'libshared'

print('Testing print from test.lua')
io.write('Checking from test.lua using io.write', '\n')

attempt_puts("C function puts, but like, from Lua")

libshared.testputs("C function testing, but like, from requiring a C module")
