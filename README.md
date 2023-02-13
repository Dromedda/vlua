# VLUA

## WIP - Like seriously!

vlua is my attempt at fixing my gripes with lua

## Usage:
run the vlua.lua file with lua, and provide the .vlua file as the first argument, and the build target as the second

## Spec: 

all valid lua code is valid vlua.
So far vlua is not that different from lua the only changes as of right now are: 

Keyword Changes: 
```
fn = function
let = local
!= = ~= 
import = require
```

## Todo:
- [ ] allow the user to pass a directory as the path argument
- [ ] if no target is provided, it should automatically create a build folder, and put everything in there
