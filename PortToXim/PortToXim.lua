PortToXim = PortToXim or {}
PortToXim.Name = "PortToXim"
PortToXim.Version = "1.0"
PortToXim.Author = "|cDAFF21DonjaZero|r"
PTX = PortToXim

PTX.Debug = false

PTX.Xim = "@XimTheBard"
PTX.SlashcommandText = "/ptx"
PTX.KeybindGuildText = "As guildie"
PTX.KeybindFriendText = "As friend"
PTX.KeybindGroupText = "As group member"

local function ptx_OnAddOnLoaded(event, addonName)
    if (addonName ~= PTX.Name) then
        return
    end

    EVENT_MANAGER:UnregisterForEvent(PTX.Name, EVENT_ADD_ON_LOADED)

    local PTX = PTX

    PTX.ptxSlashCommand = ptxSlashCommand
    SLASH_COMMANDS[PTX.SlashcommandText] = ptxSlashCommand

    ZO_CreateStringId("SI_BINDING_NAME_PORT_TO_XIM_GUILD", PTX.KeybindGuildText)
    ZO_CreateStringId("SI_BINDING_NAME_PORT_TO_XIM_FRIEND", PTX.KeybindFriendText)
    ZO_CreateStringId("SI_BINDING_NAME_PORT_TO_XIM_GROUP", PTX.KeybindGroupText)
end

EVENT_MANAGER:RegisterForEvent(PTX.Name, EVENT_ADD_ON_LOADED, ptx_OnAddOnLoaded)

function ptxSlashCommand(ptxSlashOption)
    if (PTX.Debug and ptxSlashOption == "") then
        d("PTX: Slash command " .. PTX.SlashcommandText .. " used with guild (default)")
   else
       d("PTX: Slash command " .. PTX.SlashcommandText .. " used with " .. ptxSlashOption)
   end

    local relationship = "guild" -- default

    if (ptxSlashOption == "group") then
        relationship = "group"
    elseif (ptxSlashOption == "friend") then
        relationship = "friend"
    end

    ptxPortToXim(relationship)
end

function PTX.ptxKeypress(relationship)
    if (relationship == "") then
        if PTX.Debug then
            d("PTX: Keybind used, relationship = guild (default)")
        end
    elseif PTX.Debug then
        d("PTX: Keybind used, relationship = " .. relationship)
    end
    ptxPortToXim(relationship)
end

function ptxPortToXim(relationship)
    if (relationship == "group") then
        if PTX.Debug then
            d("PTX: Attempting JumpToGroupMember()")
        end
        JumpToGroupMember(PTX.Xim)
        return true
    elseif (relationship == "friend") then
        if PTX.Debug then
            d("PTX: Attempting JumpToFriend()")
        end
     JumpToFriend(PTX.Xim)
     return true
end

    -- default
    if PTX.Debug then
        d("PTX: Attempting JumpToGuildMember()")
    end
    JumpToGuildMember(PTX.Xim)
    return true
end
