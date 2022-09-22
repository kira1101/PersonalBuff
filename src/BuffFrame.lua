---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by kira1101.
--- DateTime: 2021/2/5 上午 04:21
---
local BuffFrame = {}
local Masque, MSQ_Version = LibStub("Masque", true)
IconGroup = nil

local function CreateIcon(IconSetting)
    local frame = CreateFrame("Button", nil ,IconSetting.parent)
    frame:SetSize(IconSetting.iconSize, IconSetting.iconSize)
    frame:SetPoint("Center")

    local icon = frame:CreateTexture(nil, "BACKGROUND")
    icon:SetAllPoints()
    icon:SetTexture(GetSpellTexture(IconSetting.SpellID))
    frame.icon = icon

    local count = frame:CreateFontString(nil, "ARTWORK")
    count:SetFont(IconSetting.countFont, IconSetting.countFontSize, "OUTLINE")
    count:SetPoint("BOTTOMRIGHT", 0, 0)
    count:SetJustifyH("RIGHT")
    frame.count = count

    local text = frame:CreateFontString(nil, "OVERLAY")
    text:SetFont(IconSetting.font, IconSetting.fontSize, "OUTLINE")
    text:SetPoint("CENTER", 0, 0)
    frame.text = text

    frame:SetSize(IconSetting.iconSize, IconSetting.iconSize)
    frame:SetScale(1)

    local cooldown = CreateFrame("Cooldown", nil , frame, "CooldownFrameTemplate")
    cooldown:SetAllPoints()
    cooldown:SetSwipeColor(1, 1, 1, 0.8)
    cooldown:SetHideCountdownNumbers(true)
    cooldown:SetDrawEdge(false)
    cooldown:SetDrawSwipe(true)
    cooldown.noCooldownCount = true
    cooldown:SetHideCountdownNumbers(true)
    frame.cooldown = cooldown

    local cooldownCount = cooldown:CreateFontString(nil, "ARTWORK")
    cooldownCount:SetFont(IconSetting.countFont, IconSetting.countFontSize, "OUTLINE")
    cooldownCount:SetPoint("BOTTOMRIGHT", 0, 0)
    cooldownCount:SetJustifyH("RIGHT")
    frame.cooldownCount = cooldownCount

    local cooldownText = cooldown:CreateFontString(nil, "OVERLAY")
    cooldownText:SetFont(IconSetting.font, IconSetting.fontSize, "OUTLINE")
    cooldownText:SetPoint("CENTER", 0, 0)
    frame.cooldownText = cooldownText

    frame:SetSize(IconSetting.iconSize, IconSetting.iconSize)
    frame:SetScale(1)

    if IconSetting.group then
        IconSetting.group:AddButton(frame)
    end

    return frame
end


local function clearIcon(icon)
    icon:Hide()
    --icon.cooldown:Clear()
    --icon.count:SetText("")
    --icon.text:SetText(nil)
    --icon.cooldownCount:SetText("")
    --icon.cooldownText:SetText(nil)
end

local function setAuraTime(iconSetting)
    if iconSetting.time and iconSetting.time~=0 then
        local AuraTime = iconSetting.time - GetTime()
        if iconSetting.duration == 0 then
            if(AuraTime > 60) then
                BuffFrame.icons[iconSetting.spellID].text:SetText(math.floor(AuraTime / 60) .. "m")
            elseif (AuraTime > 3) then
                BuffFrame.icons[iconSetting.spellID].text:SetText(string.format("%.0f", AuraTime))
            elseif (AuraTime > 0) then
                BuffFrame.icons[iconSetting.spellID].text:SetText(string.format("%.1f", AuraTime))
            end
        else
            if(AuraTime > 60) then
                BuffFrame.icons[iconSetting.spellID].cooldownText:SetText(math.floor(AuraTime / 60) .. "m")
            elseif (AuraTime > 3) then
                BuffFrame.icons[iconSetting.spellID].cooldownText:SetText(string.format("%.0f", AuraTime))
            elseif (AuraTime > 0) then
                BuffFrame.icons[iconSetting.spellID].cooldownText:SetText(string.format("%.1f", AuraTime))
            end
        end

    else

    end
end

local function setStackCount(iconSetting)
    if iconSetting.count ~=0 then
        if iconSetting.duration == 0 and iconSetting.count ~=1 then
            BuffFrame.icons[iconSetting.spellID].count:SetText(iconSetting.count)
        else
            BuffFrame.icons[iconSetting.spellID].cooldownCount:SetText(iconSetting.count)
        end
    end
end

function BuffFrame:clear()
    for _,i in pairs(BuffFrame.icons) do
        clearIcon(i)
    end
end

function BuffFrame:SetFont()
    for _,i in pairs(BuffFrame.icons) do
        i.cooldownText:SetFont(BuffFrame.FrameSetting.IconSetting.font, BuffFrame.FrameSetting.IconSetting.fontSize, "OUTLINE")
        i.text:SetFont(BuffFrame.FrameSetting.IconSetting.font, BuffFrame.FrameSetting.IconSetting.fontSize, "OUTLINE")
    end
end

function BuffFrame:SetCountFont()
    for _,i in pairs(BuffFrame.icons) do
        i.cooldownCount:SetFont(BuffFrame.FrameSetting.IconSetting.countFont, BuffFrame.FrameSetting.IconSetting.countFontSize, "OUTLINE")
        i.count:SetFont(BuffFrame.FrameSetting.IconSetting.countFont, BuffFrame.FrameSetting.IconSetting.countFontSize, "OUTLINE")
    end
end

function BuffFrame:SetIconSize()
    BuffFrame.Frame:SetSize(BuffFrame.FrameSetting.IconSetting.iconSize * 10, BuffFrame.FrameSetting.IconSetting.iconSize)

    for _,i in pairs(BuffFrame.icons) do
        i:SetSize(BuffFrame.FrameSetting.IconSetting.iconSize,BuffFrame.FrameSetting.IconSetting.iconSize)
        --i.icon:SetSize(BuffFrame.FrameSetting.IconSetting.iconSize,BuffFrame.FrameSetting.IconSetting.iconSize)
        --i.cooldown:SetSize(BuffFrame.FrameSetting.IconSetting.iconSize,BuffFrame.FrameSetting.IconSetting.iconSize)
        i.icon:SetAllPoints()
        i.cooldown:SetAllPoints()
    end

    if BuffFrame.FrameSetting.IconSetting.group then
        BuffFrame.FrameSetting.IconSetting.group:ReSkin(true)
    end
end

local function displayIcon(iconSetting,last)
    BuffFrame.icons[iconSetting.spellID]:Show()
    BuffFrame.icons[iconSetting.spellID]:SetAlpha(1)

    BuffFrame.icons[iconSetting.spellID]:ClearAllPoints()
    BuffFrame.icons[iconSetting.spellID]:SetScale(1)


    if last == nil then
        BuffFrame.icons[iconSetting.spellID]:SetPoint("BOTTOMLEFT", BuffFrame.FrameSetting.IconSetting.XOffset + BuffFrame.FrameSetting.IconSetting.iconSize , BuffFrame.FrameSetting.IconSetting.YOffset)
    else
        BuffFrame.icons[iconSetting.spellID]:SetPoint("RIGHT", last, "RIGHT", BuffFrame.FrameSetting.IconSetting.iconSize + BuffFrame.FrameSetting.IconSetting.iconSpacing + 1, 0)
    end

    BuffFrame.icons[iconSetting.spellID].cooldown:SetCooldown(iconSetting.time - iconSetting.duration , iconSetting.duration)

    return BuffFrame.icons[iconSetting.spellID]
end


local function reloadTexture(SpellID)
    BuffFrame.icons[SpellID].icon:SetTexture(GetSpellTexture(SpellID))
end

function BuffFrame:display(enableAuraTable)
    local last
    for i,k in ipairs(enableAuraTable) do
        local iconSetting = {}
        iconSetting.spellID = k[10]
        iconSetting.time = k[6]
        iconSetting.order = i
        iconSetting.duration = k[5]
        iconSetting.count = k[3]
        iconSetting.alpha = enableAuraTable.alpha

        if k[10] == 259495 then
            reloadTexture(259495)
        end
        last = displayIcon(iconSetting,last)
        setAuraTime(iconSetting)
        setStackCount(iconSetting)
    end
end

function BuffFrame:SetFramePoint(parent)
    BuffFrame.Frame:SetPoint("LEFT", parent ,"LEFT",-( BuffFrame.FrameSetting.IconSetting.iconSize ),
            ((BuffFrame.FrameSetting.IconSetting.iconSize - 20) / 3) + 2)
    BuffFrame.Frame:SetParent(C_NamePlate.GetNamePlateForUnit("player", issecure()))
end

function CreateBuffFrame(FrameSetting)
    BuffFrame.Frame = CreateFrame("Frame",nil, nil)
    BuffFrame.Frame:SetSize(FrameSetting.Width,FrameSetting.Height)
    FrameSetting.IconSetting.parent = BuffFrame.Frame
    BuffFrame.icons = {}

    if Masque then
        IconGroup = Masque:Group("PersonalBuff", "IconGroup")
    end

    for _,i in ipairs(FrameSetting.Spells) do
        FrameSetting.IconSetting.group = IconGroup
        FrameSetting.IconSetting.SpellID = i
        BuffFrame.icons[i] = CreateIcon(FrameSetting.IconSetting)
    end
    BuffFrame.FrameSetting = FrameSetting
    return BuffFrame
end