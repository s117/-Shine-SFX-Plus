--[[
Shine Kill SFX Plugin - Shared
]]

local Plugin = {}
Plugin.Version = "1.0"

function Plugin:SetupDataTable()
    local Command ={
        Name = "string(255)",
        Category = "string(15)",
        Value = "integer (0 to 200)"
    }
    self:AddNetworkMessage( "Command", Command, "Client" )

    local Sound = {
        Name = "string(255)",
        Category = "string(15)"
    }
    self:AddNetworkMessage( "PlaySound", Sound, "Client" )

    local CMsg = {
        Name = "string (255)",
        Value = "string (255)"
    }
    self:AddNetworkMessage( "ClientMsg", CMsg, "Server" )
end

Shine:RegisterExtension( "sfx_plus", Plugin )
