--[[
Shine SFX Plus Plugin - Server
]]

local Shine = Shine
local StringFormat = string.format
local IsType = Shine.IsType
local Clients = Shine.GameIDs
local Plugin = Plugin

local CAT_KILL       = "kill"
local CAT_ASSIST     = "assist"
local CAT_KILLSTREAK = "killstreak"
local CAT_STREAKSTOP = "streakstop"
local CAT_THUGKILL   = "thugkill"

Plugin.HasConfig = true
Plugin.ConfigName = "sfx_plus.json"
Plugin.CheckConfig = true
Plugin.DefaultConfig = {
    AlienColour = { 255, 125, 0 },
    MarineColour = { 0, 125, 255 },

    Enabled = {
        [CAT_KILL] = true,
        [CAT_ASSIST] = true,
        [CAT_KILLSTREAK] = true,
        [CAT_STREAKSTOP] = true,
        [CAT_THUGKILL] = true
    },

    LocaleSupported = {"zhCN", "enUS"},
    LocaleFallback = "enUS",
    LocaleFallbackChatNofity = "[SFX Plus] This server only support Chinese (Simplified) or English killing boradcast, your preferred locale has fellback to English.",

    KillStreak = {
        Desc = {
            [ 3 ] = {
                Text = {
                    zhCN = "%s is on a triple kill! zhCN",
                    enUS = "%s is on a triple kill!",
                },
                Broadcast = true,
                Sound = "Triplekill"
            },
            [ 5 ] = {
                Text = {
                    zhCN = "%s is on multikill! zhCN",
                    enUS = "%s is on multikill!",
                },
                Broadcast = true,
                Sound = "Multikill"
            },
            [ 6 ] = {
                Text = {
                    zhCN = "%s is on rampage! zhCN",
                    enUS = "%s is on rampage!",
                },
                Broadcast = true,
                Sound = "Rampage"
            },
            [ 7 ] = {
                Text = {
                    zhCN = "%s is on a killing spree! zhCN",
                    enUS = "%s is on a killing spree!",
                },
                Broadcast = true,
                Sound = "Killingspree"
            },
            [ 9 ] = {
                Text = {
                    zhCN = "%s is dominating! zhCN",
                    enUS = "%s is dominating!",
                },
                Broadcast = true,
                Sound = "Dominating"
            },
            [ 11 ] = {
                Text = {
                    zhCN = "%s is unstoppable! zhCN",
                    enUS = "%s is unstoppable!",
                },
                Broadcast = true,
                Sound = "Unstoppable"
            },
            [ 13 ] = {
                Text = {
                    zhCN = "%s made a mega kill! zhCN",
                    enUS = "%s made a mega kill!",
                },
                Broadcast = true,
                Sound = "Megakill"
            },
            [ 15 ] = {
                Text = {
                    zhCN = "%s made an ultra kill! zhCN",
                    enUS = "%s made an ultra kill!",
                },
                Broadcast = true,
                Sound = "Ultrakill"
            },
            [ 17 ] = {
                Text = {
                    zhCN = "%s owns! zhCN",
                    enUS = "%s owns!",
                },
                Broadcast = true,
                Sound = "Ownage"
            },
            [ 18 ] = {
                Text = {
                    zhCN = "%s made a ludicrouskill! zhCN",
                    enUS = "%s made a ludicrouskill!",
                },
                Broadcast = true,
                Sound = "Ludicrouskill"
            },
            [ 19 ] = {
                Text = {
                    zhCN = "%s is a head hunter! zhCN",
                    enUS = "%s is a head hunter!",
                },
                Broadcast = true,
                Sound = "Headhunter"
            },
            [ 20 ] = {
                Text = {
                    zhCN = "%s is whicked sick! zhCN",
                    enUS = "%s is whicked sick!",
                },
                Broadcast = true,
                Sound = "Whickedsick"
            },
            [ 21 ] = {
                Text = {
                    zhCN = "%s made a monster kill! zhCN",
                    enUS = "%s made a monster kill!",
                },
                Broadcast = true,
                Sound = "Monsterkill"
            },
            [ 23 ] = {
                Text = {
                    zhCN = "Holy Shit! %s got another one! zhCN",
                    enUS = "Holy Shit! %s got another one!",
                },
                Broadcast = true,
                Sound = "Holyshit"
            },
            [ 25 ] = {
                Text = {
                    zhCN = "%s is G o d L i k e !!! zhCN",
                    enUS = "%s is G o d L i k e !!!",
                },
                Broadcast = true,
                Sound = "Godlike"
            },
            [ 27 ] = 25,
            [ 30 ] = 25,
            [ 34 ] = 25,
            [ 40 ] = 25,
            [ 48 ] = 25,
            [ 58 ] = 25,
            [ 70 ] = 25,
            [ 80 ] = 25,
            [ 100 ] = 25
        }
    },
    StreakStop = {
        Desc = {
            {
                TriggerLevel = 6,
                Text = {
                    zhCN = "%s's Rampage has been stopped by %s zhCN", -- first victim then killer
                    enUS = "%s's Rampage has been stopped by %s ",        -- first victim then killer
                },
                Broadcast = true,
                Sound = "StreakStop"
            },
            {
                TriggerLevel = 9,
                Text = {
                    zhCN = "%s's Dominating has been stopped by %s zhCN", -- first victim then killer
                    enUS = "%s's Dominating has been stopped by %s ",        -- first victim then killer
                },
                Broadcast = true,
                Sound = "StreakStop"
            },
            {
                TriggerLevel = 11,
                Text = {
                    zhCN = "%s's Unstoppable has been stopped by %s zhCN", -- first victim then killer
                    enUS = "%s's Unstoppable has been stopped by %s ",        -- first victim then killer
                },
                Broadcast = true,
                Sound = "StreakStop"
            },
            {
                TriggerLevel = 17,
                Text = {
                    zhCN = "%s's Ownage has been stopped by %s zhCN", -- first victim then killer
                    enUS = "%s's Ownage has been stopped by %s ",        -- first victim then killer
                },
                Broadcast = true,
                Sound = "StreakStop"
            },
            {
                TriggerLevel = 25,
                Text = {
                    zhCN = "%s's Godlike has been stopped by %s zhCN", -- first victim then killer
                    enUS = "%s's Godlike has been stopped by %s ",        -- first victim then killer
                },
                Broadcast = true,
                Sound = "StreakStop"
            }
        }
    },
    ThugKill = {
        Desc = {
            [ 3 ] = { -- Weapon ID - Marine Rifle Butt
                Text = {
                    zhCN = "%s kills %s by Gun Punch! zhCN",        -- first killer then victim
                    enUS = "%s kills %s by Gun Punch!",        -- first killer then victim
                },
                Broadcast = true,
                Sound = "ThugKillRand"  -- Random sound
            },
            [ 5 ] = { -- Weapon ID - Marine Knife
                Text = {
                    zhCN = "%s kills %s by Axe! zhCN",        -- first killer then victim
                    enUS = "%s kills %s by Axe!",        -- first killer then victim
                },
                Broadcast = true,
                Sound = "ThugKillRand"  -- Random sound
            },
            [ 11 ] = { -- Weapon ID - Marine Welder
                Text = {
                    zhCN = "%s kills %s by Welder! zhCN",        -- first killer then victim
                    enUS = "%s kills %s by Welder!",        -- first killer then victim
                },
                Broadcast = true,
                Sound = "ThugKillRand"  -- Random sound
            },
            [ 14 ] = { -- Weapon ID - Groge's Heal Spray
                Text = {
                    zhCN = "%s kills %s by Heal Spray! zhCN",        -- first killer then victim
                    enUS = "%s kills %s by Heal Spray!",        -- first killer then victim
                },
                Broadcast = true,
                Sound = "ThugKillRand"  -- Random sound
            },
            [ 16 ] = { -- Weapon ID - Skulk's parasite
                Text = {
                    zhCN = "%s kills %s by Parasite! zhCN",        -- first killer then victim
                    enUS = "%s kills %s by Parasite!",        -- first killer then victim
                },
                Broadcast = true,
                Sound = "ThugKillRand"  -- Random sound
            },
            [ 21 ] = { -- Weapon ID - Groge's BileBomb
                Text = {
                    zhCN = "%s kills %s by BileBomb! zhCN",        -- first killer then victim
                    enUS = "%s kills %s by BileBomb!",        -- first killer then victim
                },
                Broadcast = true,
                Sound = "ThugKillRand"  -- Random sound
            }
        }
    },
    KillFeedback = {
        Desc = {
            Text = nil,
            Broadcast = false,
            Sound = "FeedbackKill"  -- Random sound
        }
    },
    AssistFeedback = {
        Desc = {
            Text = nil,
            Broadcast = false,
            Sound = "FeedbackAssist"  -- Random sound
        }
    }
}

local debug_print = false

local function Dbg( ... )
    arg = {...}
    if debug_print then
        Log(unpack(arg))
    end
end

function Plugin:Initialise()
    self.Enabled = true

    self.ClientPreferredLocale = {}
    self.Killstreaks = {}

    Plugin:CreateCommands()

    table.sort(self.Config.StreakStop.Desc,
        function (a, b) return a.TriggerLevel < b.TriggerLevel end)

    -- self:SaveConfig()

    Dbg("[Shine] SFX-Plus: Server loaded.")

    return true
end


function Plugin:CreateCommands()
    local sh_sfxplus_en_handler = function ( Client, Cat, IsPlay )
        if not IsType(IsPlay, "boolean") then
            Shine:NotifyColour( Client, 255, 0, 0, StringFormat( "Error: Invalid parameter, check your command." ) )

            return
        end

        local lower_cat = string.lower( Cat )

        if self.Config.Enabled[lower_cat] then
            self:SendNetworkMessage( Client, "Command", { Name = "SetEnable", Category = lower_cat, Value = IsPlay and 1 or 0 } , true)
            Shine:NotifyColour( Client, 0, 255, 0, StringFormat( "Setting accepted: %s sound for '%s'", IsPlay and "Play" or "Mute", Cat ) )
            return
        else if self.Config.Enabled[lower_cat] == nil then
            Shine:NotifyColour( Client, 255, 0, 0, StringFormat( "Error: No category '%s', check your command.", Cat ) )
        else
            Shine:NotifyColour( Client, 255, 0, 0, StringFormat( "Error: Category '%s' is disabled on this server.", Cat ) )
        end
        end
    end
    local sh_sfxplus_vol_handler = function ( Client, Cat, Volume )
        if not ( IsType(Volume, "number") and (0 <= Volume) and (Volume <= 200) ) then
            Shine:NotifyColour( Client, 255, 0, 0, StringFormat( "Error: Invalid parameter, check your command." ) )

            return
        end

        local lower_cat = string.lower( Cat )

        if self.Config.Enabled[lower_cat] then
            self:SendNetworkMessage( Client, "Command", { Name = "SetVolume", Category = lower_cat, Value = Volume } , true)
            Shine:NotifyColour( Client, 0, 255, 0, StringFormat( "Setting accepted: The volume of '%s' is now %s", Cat, Volume ) )
            return
        else if self.Config.Enabled[lower_cat] == nil then
            Shine:NotifyColour( Client, 255, 0, 0, StringFormat( "Error: No category '%s', check your command.", Cat ) )
        else
            Shine:NotifyColour( Client, 255, 0, 0, StringFormat( "Error: Category '%s' is disabled on this server.", Cat ) )
        end
        end
    end

    local CmdPlay = self:BindCommand( "sh_sfxplus_en", "sfxplus_en", sh_sfxplus_en_handler, true, true )
    CmdPlay:AddParam{ Type = "string", MaxLength = 100, Help = "Category name" }
    CmdPlay:AddParam{ Type = "boolean", Help = "Enable" }
    CmdPlay:Help( "Set whether play certain category sound effect." )

    local CmdVolume = self:BindCommand( "sh_sfxplus_vol", "sfxplus_vol", sh_sfxplus_vol_handler, true, true )
    CmdVolume:AddParam{ Type = "string", MaxLength = 100, Help = "Category name" }
    CmdVolume:AddParam{ Type = "number", Min = 0, Max = 200, Error = "Please specify a number in range 0 ~ 200.", Help = "New volume" }
    CmdVolume:Help( "Set whether play certain category sound effect." )
end

function Plugin:Cleanup()

    self.BaseClass.Cleanup( self )

    self.ClientPreferredLocale = nil
    self.Killstreaks = nil

    self.Enabled = false
end

function Plugin:ReceiveClientMsg( Client, Message )
    local Name = Message.Name
    local Value = Message.Value

    MsgHandler = {
        ["PreferredLocale"] = function ( Client, Value )
            for i = 1, #self.Config.LocaleSupported do
                if Value == self.Config.LocaleSupported[i] then
                    self.ClientPreferredLocale[ Client ] = Value
                    Dbg("Updated client preferred locale: %s, %s", Client, Value)
                    return
                end

                self.ClientPreferredLocale[ Client ] = self.Config.LocaleFallback
                Shine:NotifyColour( Client, 255, 0, 0, StringFormat( self.Config.LocaleFallbackChatNofity ) )
                Dbg("Updated client preferred locale: %s, %s (fallback)", Client, self.Config.LocaleFallback )
            end
        end,
        ["ChatEcho"] = function ( Client, Value )
            Shine:NotifyColour( Client, 255, 255, 255, Value )
        end,
        ["ChatEchoRandColor"] = function ( Client, Value )
            Shine:NotifyColour( Client, math.random(0, 255), math.random(0, 255), math.random(0, 255), Value )
        end
    }

    if MsgHandler[ Message.Name ] and Message.Value then
        MsgHandler[ Message.Name ]( Client, Message.Value )
    end
end

function Plugin:ClientDisconnect( Client )
    self.ClientPreferredLocale[ Client ] = nil
    Dbg("Released client preferred locale: %s.", Client)
end


function Plugin.GetRealDamageDealer( DamageDealer )
    local RealKiller = DamageDealer

    if DamageDealear and not DamageDealer:isa( "Player" ) then
        RealKiller = DamageDealer.GetOwner and DamageDealer:GetOwner() or nil
        if RealKiller and not RealKiller:isa( "Player" ) then
            --noinspection UnusedDef
            RealKiller = nil
        end
    end

    return DamageDealer
end

local function GenerateProperMsg( PreferredLocale, TextData, ... )
    local arg = {...}
    local PatternMsg = PreferredLocale and ( TextData and TextData[PreferredLocale] or nil ) or nil
    local FinalMsg = nil
    if PatternMsg then
        if #arg ~= 0 then
            FinalMsg = StringFormat( PatternMsg, unpack(arg) )
        else
            FinalMsg = PatternMsg
        end
    end
    return FinalMsg
end

function Plugin:DispatchDesc( TriggerClient, Desc, Cat, Colour, ... )
    local arg = {...}

    if not Desc then return end

    if not self.Config.Enabled[Cat] then
        Dbg("DispatchDesc: Cat '%s' disabled, return", Cat)
        return
    end

    if Desc.Broadcast then
        local CachedLocalMsg = {}
        local Msg = nil

        if Desc.Text then
            for i = 1, #self.Config.LocaleSupported do
                local currLocale = self.Config.LocaleSupported[i]
                CachedLocalMsg[currLocale] = GenerateProperMsg( currLocale, Desc.Text, unpack(arg) )
            end

            for Client in Clients:Iterate() do
                Msg = CachedLocalMsg[ self.ClientPreferredLocale[Client] ]

                if not Msg then
                    Msg = CachedLocalMsg[ self.Config.LocaleFallback ]
                end

                Shine:NotifyColour( Client, Colour[ 1 ], Colour[ 2 ], Colour[ 3 ], Msg )
            end
        end

        if Desc.Sound then
            self:SendNetworkMessage( nil, "PlaySound", { Name = Desc.Sound, Category = Cat } , true)
        end

        Msg = CachedLocalMsg[ self.Config.LocaleFallback ]
        Dbg("DispatchDesc: Broadcasted Desc, Cat/%s, Msg/%s, Sound/%s",
            Cat,
            Msg and Msg or "None",
            Desc.Sound and Desc.Sound or "None")
    else
        if not TriggerClient then return end

        local Msg = nil
        if Desc.Text then
            Msg = GenerateProperMsg( self.ClientPreferredLocale[TriggerClient], Desc.Text, unpack(arg) )
            if not Msg then
                Msg = GenerateProperMsg( self.Config.LocaleFallback, Desc.Text, unpack(arg) )
            end

            Shine:NotifyColour( TriggerClient, Colour[ 1 ], Colour[ 2 ], Colour[ 3 ], Msg )
        end

        if Desc.Sound then
            self:SendNetworkMessage( TriggerClient, "PlaySound", { Name = Desc.Sound, Category = Cat } , true)
        end

        Msg = GenerateProperMsg( self.Config.LocaleFallback, Desc.Text, unpack(arg) )
        Dbg("DispatchDesc: Unicasted Desc, To/%s, Cat/%s, Msg/%s, Sound/%s",
            TriggerClient,
            Cat,
            Msg and Msg or "None",
            Desc.Sound and Desc.Sound or "None")
    end
end

function Plugin:GetTeamColour( Gamer )
    local Colour = { 255, 0, 0 }
    local team = Gamer:GetTeamNumber()

    if team == 1 then --noinspection UnusedDef
        Colour = self.Config.MarineColour
    elseif team == 2 then
        Colour = self.Config.AlienColour
    end

    return Colour
end

function Plugin:ProcessKillAndAssistFeedback( Attacker, Victim )
    local Attacker = self.GetRealDamageDealer( Attacker )

    if not Attacker or not Victim then return end

    if Victim:isa( "Player" ) then
        Dbg( "KA Feedback: Sending kill feedback to %s", Attacker:GetName() )
        self:DispatchDesc(
            Attacker:GetClient(),
            self.Config.KillFeedback.Desc,
            CAT_KILL,
            self:GetTeamColour(Attacker)
        )

        local VictimDamagePoints = Victim.damagePoints
        if not VictimDamagePoints then
            Dbg( "KA Feedback: The victim has no damagePoints member, skip assist feedback.")
            return
        end

        for attackerId, damageDone in pairs(VictimDamagePoints) do
            local currentAttacker = self.GetRealDamageDealer( Shared.GetEntity(attackerId) )

            if currentAttacker then
                if currentAttacker ~= Attacker then
                    Dbg( "KA Feedback: Sending kill feedback to %s", currentAttacker:GetName() )
                    self:DispatchDesc(
                        currentAttacker:GetClient(),
                        self.Config.AssistFeedback.Desc,
                        CAT_ASSIST,
                        self:GetTeamColour(Attacker)
                    )
                end
            end
        end
    end
end

function Plugin:GetStreakDesc( Streak )
    local Desc = self.Config.KillStreak.Desc[ tostring(Streak) ]

    if not Desc then return end

    if IsType(Desc, "number") then
        return self:GetStreakDesc( Desc )
    end

    return Desc
end

function Plugin:GetThugKillDesc( WeaponID )
    local Desc = self.Config.ThugKill.Desc[ tostring( WeaponID ) ]

    if not Desc then return end

    if IsType(Desc, "number") then
        return self:GetThugKillDesc( Desc )
    end

    return Desc
end

function Plugin:ProcessKillStreakAndStreakStop( Attacker, Victim )
    Dbg("Streak and Stop: Entering ...")
    Attacker = self.GetRealDamageDealer( Attacker )
    if not Attacker or not Victim or not Victim:isa( "Player" ) then return end
    Dbg("Streak and Stop: Valid Attacker and Victim")

    local VictimClient = Victim:GetClient()
    if not VictimClient then return end
    Dbg("Streak and Stop: Valid Victim.Client")

    if self.Killstreaks[ VictimClient ] then -- Check streak stop
        Dbg("Streak and Stop: Checking StreakStop...")
        local StreakNum = self.Killstreaks[ VictimClient ]
        local StreakStopDesc = nil

        for i = 1, #self.Config.StreakStop.Desc do
            -- The array Config.StreakStop.Desc is sorted during initializing based on the value of TriggerLevel
            if StreakNum < self.Config.StreakStop.Desc[i].TriggerLevel then
                break
            end
            StreakStopDesc = self.Config.StreakStop.Desc[i]
        end

        if StreakStopDesc then
            Dbg("Streak and Stop: Triggered StreakStop, TriggerLevel/%s", StreakStopDesc.TriggerLevel)
            self:DispatchDesc(
                Attacker:GetClient(),
                StreakStopDesc,
                CAT_STREAKSTOP,
                self:GetTeamColour(Victim),
                Victim:GetName(),
                Attacker:GetName()
            )
        end
        self.Killstreaks[ VictimClient ] = nil
    end

    local AttackerClient = Attacker:GetClient()
    if not AttackerClient then return end
    Dbg("Streak and Stop: Valid Attacker and Victim")

    if not self.Killstreaks[ AttackerClient ] then self.Killstreaks[ AttackerClient ] = 1
    else self.Killstreaks[ AttackerClient ] = self.Killstreaks[ AttackerClient ] + 1 end

    Dbg("Streak and Stop: Checking KillStreak...")
    local StreakDesc = self:GetStreakDesc( self.Killstreaks[AttackerClient] )

    if StreakDesc then
        Dbg("Streak and Stop: Triggered KillStreak, Streak/%s", self.Killstreaks[AttackerClient])
        self:DispatchDesc(
            AttackerClient,
            StreakDesc,
            CAT_KILLSTREAK,
            self:GetTeamColour(Attacker),
            Attacker:GetName()
        )
    end
end

function Plugin:ProcessThugKill( Attacker, Victim, WeaponID )
    Dbg("Streak and Stop: Entering ...")
    Attacker = self.GetRealDamageDealer( Attacker )
    if not Attacker or not Victim or not Victim:isa( "Player" ) then return end
    Dbg("Streak and Stop: Valid Attacker and Victim")

    Dbg("Streak and Stop: Checking ThugKill...")
    local ThugDesc = self:GetThugKillDesc( WeaponID )

    if ThugDesc then
        Dbg("Streak and Stop: ThugKill triggered, WeaponID/%s", WeaponID)
        self:DispatchDesc(
            Attacker:GetClient(),
            ThugDesc,
            CAT_THUGKILL,
            self:GetTeamColour(Attacker),
            Attacker:GetName(),
            Victim:GetName()
        )
    end
end

function Plugin:OnEntityKilled( Gamerules, Victim, Attacker, Inflictor, Point, Direction )
    self:ProcessKillAndAssistFeedback( Attacker, Victim )

    self:ProcessKillStreakAndStreakStop(Attacker, Victim)

    if Inflictor then
        self:ProcessThugKill(Attacker, Victim, Inflictor:GetDeathIconIndex())
    end
end
