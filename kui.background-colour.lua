-- luacheck: globals KuiNameplates KuiNameplatesCore

local addon = KuiNameplates
local core = KuiNameplatesCore

local mod = addon:NewPlugin("ArlaaBG", 104, 5)
if not mod then
    return
end

-- Function to update the cast bar background
local function UpdateCastBarBackground(f)
    if f.CastBar and f.CastBar.bg then
        f.CastBar.bg:SetVertexColor(0, 0, 0, 1) -- Adjust RGBA as desired
    end
end

-- Function to update fill texture alpha
local function AdjustFillTexture(f)
    if f.HealthBar and f.HealthBar.fill then
        f.HealthBar.fill:SetAlpha(0) -- Set alpha to 0 to disable the overlay
    end
    if f.CastBar and f.CastBar.fill then
        f.CastBar.fill:SetAlpha(0) -- Disable overlay on cast bar
    end
end

-- Function to override the background color
local function UpdateBackgroundColor(f)
    if f.bg then
        f.bg:SetVertexColor(0, 0, 0, 1) -- Change this to your desired color (RGBA)
    end
    AdjustFillTexture(f) -- Adjust the fill texture after updating the background
    UpdateCastBarBackground(f) -- Apply the cast bar background change
end

function mod:Create(f)
    -- Ensure we override only once per frame
    if f.bg and not f.arlaa_UpdateBackground then
        f.arlaa_UpdateBackground = true
        UpdateBackgroundColor(f)
    end
end

function mod:OnEnable()
    -- Apply to new frames
    self:RegisterMessage("Create")

    -- Apply to already existing nameplates
    for _, f in addon:Frames() do
        mod:Create(f)
    end
end

