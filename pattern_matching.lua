-- Usage:
-- lua pattern_matching.lua
-- Lua contains some pattern matching related functions:
-- string.find
-- string.match
-- string.gsub
-- string.gmatch

local s = "hello world from Lua"
for w in string.gmatch(s, "%a+") do
    print(w)
end

local t = {}
s = "from=world, to=Lua"
for k, v in string.gmatch(s, "(%w+)=(%w+)") do
    t[k]=v
end
for k, v in pairs(t) do
    print(k, v)
end

print("---------string.match is not string.gmatch-------------------------------------------------")
local res = string.match(s, "o")
print(res)

local res = string.gmatch(s, "(%w+)=(%w+)")
print(type(res), " : ", res)

print(string.gsub("hello world", "(%w+)", "%1 %1"))
print(string.gsub("hello Lua", "(%w+)%s*(%w+)", "%2 %1"))

string.gsub("hello world", "%w+", print)

local lookupTable = {["hello"] = "hola", ["world"] = "mundo"}
local rr = string.gsub("hello world", "(%w+)", lookupTable)
print(type(rr), " : ", rr)
