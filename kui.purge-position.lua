-- luacheck: globals KuiNameplates KuiNameplatesCore

local addon = KuiNameplates
local core = KuiNameplatesCore

local mod = addon:NewPlugin("RightPurgeAuras", 105, 5)
if not mod then
    return
end

-- Function to reposition purge auras to the right side of the nameplate/bar
local function UpdatePurgeAuraPosition(f)
    if not f.Auras or not f.Auras.frames or not f.Auras.frames.core_purge then return end

    local purgeFrame = f.Auras.frames.core_purge
    purgeFrame:ClearAllPoints()
    purgeFrame:SetPoint("LEFT", f.HealthBar, "RIGHT", 5, 0)
end

-- Override function to update purge aura position
local function UpdateAuras(f, ...)
    if f.right_UpdateAuras then
        f.right_UpdateAuras(f, ...)
    end
    UpdatePurgeAuraPosition(f)
end

-- Apply changes to nameplates
function mod:Create(f)
    if f.Auras and not f.right_UpdateAuras then
        f.right_UpdateAuras = f.UpdateAuras
        f.UpdateAuras = UpdateAuras
        f:UpdateAuras()
    end
end

function mod:OnEnable()
    self:RegisterMessage("Create")

    -- Apply changes to existing nameplates
    for _, f in addon:Frames() do
        mod:Create(f)
    end
end
