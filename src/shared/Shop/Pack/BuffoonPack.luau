-- TODO implement bunch of joker cards here
local HighOrderFunctionsModule = require("../../Utils")
local Joker = require("../../Card/Joker/Joker")
local GreedyJoker = require("../../Card/Joker/GreedyJoker")

local LustyJoker = require("../../Card/Joker/LustyJoker")
local WrathfulJoker = require("../../Card/Joker/WrathfulJoker")
local GluttonousJoker = require("../../Card/Joker/GluttonousJoker")
local JollyJoker = require("../../Card/Joker/JollyJoker")
local ZanyJoker = require("../../Card/Joker/ZanyJoker")
local MadJoker = require("../../Card/Joker/MadJoker")
local CrazyJoker = require("../../Card/Joker/CrazyJoker")
local DrollJoker = require("../../Card/Joker/DrollJoker")
local SlyJoker = require("../../Card/Joker/SlyJoker")
local WilyJoker = require("../../Card/Joker/WilyJoker")
local CleverJoker = require("../../Card/Joker/CleverJoker")
local DeviousJoker = require("../../Card/Joker/DeviousJoker")
local CraftyJoker = require("../../Card/Joker/CraftyJoker")
local HalfJoker = require("../../Card/Joker/HalfJoker")

local BuffoonPack = {}
BuffoonPack.__index = BuffoonPack

function BuffoonPack.new(): BuffoonPack
    return setmetatable({
        jokersPool = {
            Joker,
            GreedyJoker,
            LustyJoker,
            WrathfulJoker,
            GluttonousJoker,   
            JollyJoker,       
            ZanyJoker,       
            MadJoker,       
            CrazyJoker,    
            DrollJoker,   
            SlyJoker,    
            WilyJoker,  
            CleverJoker,       
            DeviousJoker,     
            CraftyJoker,     
            HalfJoker,      
        }
    }, BuffoonPack)
end

function BuffoonPack.getBuffonPack(self: BuffoonPack, size: number)
    HighOrderFunctionsModule.inplaceRandomizeArray(self.jokersPool) 
    return HighOrderFunctionsModule.arraySlice(self.jokersPool, 1, size)
end


return BuffoonPack
