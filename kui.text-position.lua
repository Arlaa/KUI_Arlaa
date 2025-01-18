-- luacheck: globals KuiNameplates KuiNameplatesCore

local addon = KuiNameplates
local core = KuiNameplatesCore

local mod = addon:NewPlugin("texty", 105, 5)
if not mod then
    return
end

-- Function to shorten unit name to last name
local function ShortenToLastName(name)
    if not name then return nil end
    local lastName = name:match("%s([^%s]+)$")
    return lastName or name
end

-- Function to reposition name and cast text
local function UpdateTextPositions(f)
    -- Only apply changes to hostile or attackable units
    if not f.state or (f.state.reaction and (f.state.reaction > 4 or f.state.reaction == 4) and not f.state.attackable) then
        return
    end

    if f.NameText then
        local shortenedName = ShortenToLastName(f.state.name)
        f.NameText:SetText(shortenedName)
        f.NameText:ClearAllPoints()
        if f.IN_NAMEONLY then
            f.NameText:SetJustifyH("LEFT")
            f.NameText:SetPoint("BOTTOMLEFT", f.HealthBar, "BOTTOMLEFT", 5, core.profile.name_vertical_offset)
        else
            f.NameText:SetJustifyH("LEFT")
            f.NameText:SetPoint("BOTTOMLEFT", f.HealthBar, "BOTTOMLEFT", 5, core.profile.name_vertical_offset)
        end
    end

    if f.SpellName then
        f.SpellName:ClearAllPoints()
        if f.IN_NAMEONLY then
            f.SpellName:SetJustifyH("LEFT")
            f.SpellName:SetPoint("BOTTOMLEFT", f.NameText, "BOTTOMLEFT", 5, core.profile.castbar_name_vertical_offset)
        else
            f.SpellName:SetJustifyH("LEFT")
            f.SpellName:SetPoint("BOTTOMLEFT", f.CastBar, "BOTTOMLEFT", 5, core.profile.castbar_name_vertical_offset)
        end
    end
end

-- Override unit name positioning
local function UpdateNameTextPosition(f, ...)
    UpdateTextPositions(f)
end

-- Override spell name positioning
local function UpdateSpellNamePosition(f, ...)
    UpdateTextPositions(f)
end

-- Apply changes to nameplates
function mod:Create(f)
    if f.NameText and not f.texty_UpdateNameTextPosition then
        f.texty_UpdateNameTextPosition = f.UpdateNameTextPosition
        f.UpdateNameTextPosition = UpdateNameTextPosition
        f:UpdateNameTextPosition()
    end

    if f.SpellName and not f.texty_UpdateSpellNamePosition then
        f.texty_UpdateSpellNamePosition = f.UpdateSpellNamePosition
        f.UpdateSpellNamePosition = UpdateSpellNamePosition
        f:UpdateSpellNamePosition()
    end
end

function mod:OnEnable()
    self:RegisterMessage("Create")

    -- Apply changes to existing nameplates
    for _, f in addon:Frames() do
        mod:Create(f)
    end
end
