-- luacheck: globals KuiNameplates KuiNameplatesCore

local addon = KuiNameplates
local core = KuiNameplatesCore

local mod = addon:NewPlugin("TargetBorder", 105, 5)
if not mod then
    return
end

-- Function to create and update the border for the target frame
local function UpdateTargetBorder(f)
    if f.unit and UnitIsUnit("target", f.unit) then
        -- Create border textures if they don't already exist
        if not f.targetBorder then
            f.targetBorder = {}

            -- Create top border
            f.targetBorder.top = f:CreateTexture(nil, "OVERLAY", nil, 7)
            f.targetBorder.top:SetTexture("Interface\\Buttons\\WHITE8x8")
            f.targetBorder.top:SetHeight(2)

            -- Create bottom border
            f.targetBorder.bottom = f:CreateTexture(nil, "OVERLAY", nil, 7)
            f.targetBorder.bottom:SetTexture("Interface\\Buttons\\WHITE8x8")
            f.targetBorder.bottom:SetHeight(2)

            -- Create left border
            f.targetBorder.left = f:CreateTexture(nil, "OVERLAY", nil, 7)
            f.targetBorder.left:SetTexture("Interface\\Buttons\\WHITE8x8")
            f.targetBorder.left:SetWidth(2)

            -- Create right border
            f.targetBorder.right = f:CreateTexture(nil, "OVERLAY", nil, 7)
            f.targetBorder.right:SetTexture("Interface\\Buttons\\WHITE8x8")
            f.targetBorder.right:SetWidth(2)
        end

        -- Update positions and visibility
        local width, height = f:GetSize()

        -- Top border
        f.targetBorder.top:SetPoint("TOPLEFT", f, "TOPLEFT", -2, 2)
        f.targetBorder.top:SetPoint("TOPRIGHT", f, "TOPRIGHT", 2, 2)

        -- Bottom border
        f.targetBorder.bottom:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", -2, -2)
        f.targetBorder.bottom:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 2, -2)

        -- Left border
        f.targetBorder.left:SetPoint("TOPLEFT", f, "TOPLEFT", -2, 2)
        f.targetBorder.left:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", -2, -2)

        -- Right border
        f.targetBorder.right:SetPoint("TOPRIGHT", f, "TOPRIGHT", 2, 2)
        f.targetBorder.right:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 2, -2)

        -- Set the color for all borders
        for _, border in pairs(f.targetBorder) do
            border:SetVertexColor(1, 1, 1, 1) -- White color with full opacity
            border:Show()
        end
    elseif f.targetBorder then
        -- Hide the border if this frame is not the target
        for _, border in pairs(f.targetBorder) do
            border:Hide()
        end
    end
end

-- Function to update all frames
local function UpdateAllFrames()
    for _, f in addon:Frames() do
        UpdateTargetBorder(f)
    end
end

function mod:TargetChanged()
    UpdateAllFrames()
end

function mod:Create(f)
    -- Ensure border updates when a frame is created
    UpdateTargetBorder(f)
end

function mod:OnEnable()
    -- Update existing nameplates
    UpdateAllFrames()

    -- Hook into events for target changes
    self:RegisterMessage("Create")
    self:RegisterEvent("PLAYER_TARGET_CHANGED", "TargetChanged")
end
