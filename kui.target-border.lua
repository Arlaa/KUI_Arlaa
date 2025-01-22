-- luacheck: globals KuiNameplates KuiNameplatesCore

local addon = KuiNameplates
local core = KuiNameplatesCore

local mod = addon:NewPlugin("DynamicTargetBorder", 105, 5)
if not mod then
    return
end

-- Create and update the target border
local function UpdateTargetBorder(f)
    if f.unit and UnitIsUnit("target", f.unit) then
        -- Create the border textures if they don't already exist
        if not f.targetBorder then
            f.targetBorder = {}

            -- Create top border
            f.targetBorder.top = f:CreateTexture(nil, "OVERLAY", nil, 7)
            f.targetBorder.top:SetTexture("Interface\\Buttons\\WHITE8x8")
            f.targetBorder.top:SetHeight(1)

            -- Create bottom border
            f.targetBorder.bottom = f:CreateTexture(nil, "OVERLAY", nil, 7)
            f.targetBorder.bottom:SetTexture("Interface\\Buttons\\WHITE8x8")
            f.targetBorder.bottom:SetHeight(1)

            -- Create left border
            f.targetBorder.left = f:CreateTexture(nil, "OVERLAY", nil, 7)
            f.targetBorder.left:SetTexture("Interface\\Buttons\\WHITE8x8")
            f.targetBorder.left:SetWidth(1)

            -- Create right border
            f.targetBorder.right = f:CreateTexture(nil, "OVERLAY", nil, 7)
            f.targetBorder.right:SetTexture("Interface\\Buttons\\WHITE8x8")
            f.targetBorder.right:SetWidth(1)
        end

        -- Determine if the castbar is visible and adjust border height
        local includeCastBar = f.CastBar and f.CastBar:IsShown()
        local castBarHeight = includeCastBar and (f.CastBar:GetHeight() + 2) or 0 -- Add 2 for padding
        local bottomExtraPixel = includeCastBar and -1 or 0 -- Decrease bottom border by 1 pixel when casting

        -- Update positions
        local width, height = f.HealthBar:GetWidth(), f.HealthBar:GetHeight()

        -- Top border
        f.targetBorder.top:SetPoint("BOTTOMLEFT", f.HealthBar, "TOPLEFT", -1, 0)
        f.targetBorder.top:SetPoint("BOTTOMRIGHT", f.HealthBar, "TOPRIGHT", 1, 0)

        -- Bottom border
        f.targetBorder.bottom:SetPoint("TOPLEFT", f.HealthBar, "BOTTOMLEFT", -1, -castBarHeight + bottomExtraPixel)
        f.targetBorder.bottom:SetPoint("TOPRIGHT", f.HealthBar, "BOTTOMRIGHT", 1, -castBarHeight + bottomExtraPixel)

        -- Left border
        f.targetBorder.left:SetPoint("TOPLEFT", f.HealthBar, "TOPLEFT", -1, 0)
        f.targetBorder.left:SetPoint("BOTTOMLEFT", f.HealthBar, "BOTTOMLEFT", -1, -castBarHeight + bottomExtraPixel)

        -- Right border
        f.targetBorder.right:SetPoint("TOPRIGHT", f.HealthBar, "TOPRIGHT", 1, 0)
        f.targetBorder.right:SetPoint("BOTTOMRIGHT", f.HealthBar, "BOTTOMRIGHT", 1, -castBarHeight + bottomExtraPixel)

        -- Set color and show borders
        for _, border in pairs(f.targetBorder) do
            border:SetVertexColor(1, 1, 1, 1) -- White color with full opacity
            border:Show()
        end
    elseif f.targetBorder then
        -- Hide the border if the frame is not the target
        for _, border in pairs(f.targetBorder) do
            border:Hide()
        end
    end
end

-- Hook function to monitor castbar visibility changes
local function OnCastbarShowOrHide(f)
    if UnitIsUnit("target", f.unit) then
        UpdateTargetBorder(f)
    end
end

-- Update all frames dynamically
local function UpdateAllFrames()
    for _, f in addon:Frames() do
        UpdateTargetBorder(f)
    end
end

-- Plugin event handlers
function mod:TargetChanged()
    UpdateAllFrames()
end

function mod:Create(f)
    -- Ensure the border updates when a frame is created
    UpdateTargetBorder(f)

    -- Hook castbar show/hide events
    if f.CastBar then
        f.CastBar:HookScript("OnShow", function() OnCastbarShowOrHide(f) end)
        f.CastBar:HookScript("OnHide", function() OnCastbarShowOrHide(f) end)
    end
end

function mod:OnEnable()
    -- Update existing nameplates
    UpdateAllFrames()

    -- Hook into events for target changes
    self:RegisterMessage("Create")
    self:RegisterEvent("PLAYER_TARGET_CHANGED", "TargetChanged")
end
