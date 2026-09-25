-- TODO implement bunch of joker cards here
local HighOrderFunctionsModule = require(script.Parent.Parent.Parent:FindFirstChild("Utils"))
local Joker = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("Joker"))
local GreedyJoker = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("GreedyJoker"))

local LustyJoker = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("LustyJoker"))
local WrathfulJoker = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("WrathfulJoker"))
local GluttonousJoker = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("GluttonousJoker"))
local JollyJoker = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("JollyJoker"))
local ZanyJoker = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("ZanyJoker"))
local MadJoker = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("MadJoker"))
local CrazyJoker = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("CrazyJoker"))
local DrollJoker = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("DrollJoker"))
local SlyJoker = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("SlyJoker"))
local WilyJoker = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("WilyJoker"))
local CleverJoker = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("CleverJoker"))
local DeviousJoker = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("DeviousJoker"))
local CraftyJoker = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("CraftyJoker"))
local HalfJoker = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("HalfJoker"))
local Fibonacci = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("Fibonacci"))
local ScaryFace = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("ScaryFace"))
local EvenSteven = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("EvenSteven"))
local OddTodd = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("OddTodd"))
local Scholar = require(script.Parent.Parent.Parent.Card.Joker:FindFirstChild("Scholar"))

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
            Fibonacci,
            ScaryFace,
            EvenSteven,
            OddTodd,
            Scholar,
        }
    }, BuffoonPack)
end

function BuffoonPack.getBuffonPack(self: BuffoonPack, size: number)
    HighOrderFunctionsModule.inplaceRandomizeArray(self.jokersPool) 
    return HighOrderFunctionsModule.arraySlice(self.jokersPool, 1, size)
end


return BuffoonPack
