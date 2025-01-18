local addon = KuiNameplates
local core = KuiNameplatesCore

local mod = addon:NewPlugin("FriendlyNameplateAdjuster", 105, 5)
if not mod then
    return
end

local ignoreSizeChange = false

local function SetSize()
    ignoreSizeChange = true
    C_NamePlate.SetNamePlateFriendlySize(0.01, 0.01)
    ignoreSizeChange = false
end

local function UpdateBasePlateSize()
    if ignoreSizeChange then return end
    if InCombatLockdown() then
        mod.outcombatUpdate:RegisterEvent('PLAYER_REGEN_ENABLED')
    else
        SetSize()
    end
end

local function InitializePlugin()
    if C_NamePlate.GetNamePlateFriendlySize() then
        mod.outcombatUpdate = CreateFrame('Frame')
        mod.outcombatUpdate:SetScript('OnEvent', function(self, event)
            SetSize()
            self:UnregisterEvent(event)
        end)

        hooksecurefunc(C_NamePlate, 'SetNamePlateFriendlySize', UpdateBasePlateSize)
        hooksecurefunc(C_NamePlate, 'SetNamePlateEnemySize', UpdateBasePlateSize)
        hooksecurefunc(C_NamePlate, 'SetNamePlateSelfSize', UpdateBasePlateSize)

        SetSize()
    end
end

function mod:Initialise()
    InitializePlugin()
end