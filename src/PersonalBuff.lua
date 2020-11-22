---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by kira1101.
--- DateTime: 2020/9/10 下午 12:46
---
local iconFrameTable = {}
local BuffIcons,eventFrame
local enabledSpell
local updateTicker,updateTracker
local playerInfo = { }
local iconSize,iconSpacing
local media = LibStub("LibSharedMedia-3.0")
local XOffset = 0
local YOffset = 0
local enableAuraTable = {}

local function setAuraTime(time,order,duration)
    if time and time~=0 then
        local AuraTime = time - GetTime()
        if duration == 0 then
            if(AuraTime > 60) then
                iconFrameTable[order].timeText1:SetText(math.floor(AuraTime / 60) .. "m")
            elseif (AuraTime > 3) then
                iconFrameTable[order].timeText1:SetText(string.format("%.0f", AuraTime))
            elseif (AuraTime > 0) then
                iconFrameTable[order].timeText1:SetText(string.format("%.1f", AuraTime))
            end
        else
            if(AuraTime > 60) then
                iconFrameTable[order].timeText2:SetText(math.floor(AuraTime / 60) .. "m")
            elseif (AuraTime > 3) then
                iconFrameTable[order].timeText2:SetText(string.format("%.0f", AuraTime))
            elseif (AuraTime > 0) then
                iconFrameTable[order].timeText2:SetText(string.format("%.1f", AuraTime))
            end
        end

    else

    end
end
local function setStackCount(count,sepllID,duration)
    if count ~=0 then
        if duration == 0 and count ~=1 then
            iconFrameTable[sepllID].countText1:SetText(count)
        else
            iconFrameTable[sepllID].countText2:SetText(count)
        end
    end
end

local function iconEnable(spellID)
    for _,i in ipairs(enabledSpell) do
        if i == spellID then
            return true
        end
    end
    return false
end


local function setAuraIcon(spellID,time,parent,order,duration,count,alpha)
    if iconEnable(spellID) then
        iconFrameTable[spellID]:Show()
        iconFrameTable[spellID]:SetAlpha(alpha)
        iconFrameTable[spellID]:SetPoint("BOTTOMLEFT", order * iconSize + (order - 1) * iconSpacing ,0)
        iconFrameTable[spellID].coolDown:SetCooldown(time - duration,duration)
        setAuraTime(time,spellID,duration)
        setStackCount(count,spellID,duration)
        return true
    else
        return false
    end
end

local function freeIconFrame()

    for _,i in ipairs(enabledSpell) do
        iconFrameTable[i]:Hide()
        iconFrameTable[i].coolDown:Clear()
        iconFrameTable[i].timeText1:SetText(nil)
        iconFrameTable[i].countText1:SetText("")
        iconFrameTable[i].timeText2:SetText(nil)
        iconFrameTable[i].countText2:SetText("")
    end
end

function RankCompare(a,b)
    return a.Rank > b.Rank
end

local function getEnableAuraTable(aura)
    if iconEnable(aura[10]) then
        for _,i in ipairs(enableAuraTable) do
            if i[10] == aura[10] then
                return
            end
        end
        aura.Rank = aceDB.char.spellRank[aura[10]]
        table.insert(enableAuraTable,aura)
    end
end

local function updateAura()
    local alpha = C_NamePlate.GetNamePlateForUnit("player", issecure()):GetAlpha()

    enableAuraTable = {}
    freeIconFrame()

    for i=1,40 do
        local aura = {UnitBuff("player",i)}
        getEnableAuraTable(aura)
    end

    for i=1,40 do
        local aura = {UnitBuff("pet",i)}
        getEnableAuraTable(aura)
    end
    table.sort(enableAuraTable,RankCompare)

    for i,k in ipairs(enableAuraTable) do
        setAuraIcon(k[10],k[6], BuffIcons,i,k[5],k[3],alpha)
    end

end

local function InitializeDB()
    local defaultSettings = {
        char = {
            font = "BIG_BOLD",
            iconSize = 20,
            fontSize = 8,
            countFont = "BIG_BOLD",
            countFontSize = 6,
            iconSpacing = 0,
            XOffset = 0,
            YOffset = 0,
            customTexture = true,
            barTexture = "Flat_N",
            enabledSpell = {
                ['*'] = true,
                [32223] = false,
                [465] = false,
                [183435] = false,
                [210391] = false,
                [315584] = false,
                [3408] = false,
                [108211] = false,
                [2823] = false,
                [8679] = false,
                [48018] = false,
                [333889] = false,
                [5697] = false,
                [196099] = false,
                [145629] = false,
                [3714] = false,
                [546] = false,
                [292106] = false,
                [974] = false,
                [130] = false,
                [110960] = false,
                [342246] = false,
                [48107] = false,
                [48108] = false,
                [205473] = false,
                [69369] = false,
                [135700] = false,
                [93622] = false,
                [33763] = false,
                [48438] = false,
                [774] = false,
                [16870] = false,
                [48438] = false,
            },
            spellRank = {
                ['*'] = 0,
                [32182] = 15,
                [2825] = 15,
                [80353] = 15,
                [264667] = 15,
                [178207] = 15,
                [230935] = 15,
                [256740] = 15,
                [292686] = 15,
            }
        }
    }
    aceDB = LibStub("AceDB-3.0"):New("PersonalBuffAceDB", defaultSettings)
    setDBoptions()
end

local function hideBlizzardAuras()
    if C_NamePlate.GetNamePlateForUnit("player", issecure()) ~= nil then
        C_NamePlate.GetNamePlateForUnit("player", issecure()).UnitFrame.BuffFrame:Hide()
    end
end

local function setBuffFramePoint()
    if C_NamePlate.GetNamePlateForUnit("player", issecure()) ~= nil then
        BuffIcons:SetPoint("LEFT",C_NamePlate.GetNamePlateForUnit("player", issecure()).UnitFrame.BuffFrame,"LEFT",-(iconSize) + XOffset,((iconSize-20)/3)+2 + YOffset)
    end
end

local function loadEnableSpell()
    enabledSpell = {}
    for _,i in ipairs(playerInfo.classSpells) do
        if aceDB.char.enabledSpell[i] == true then
            table.insert(enabledSpell,i)
        end
    end
end

local function addBloodlust()
    for _,i in pairs(Bloodlust) do
        table.insert(playerInfo.classSpells,i)
    end
end

local function getPlayerInfo()
    local _,_,ID = UnitClass("player")
    if ID == 1 then
        playerInfo.classSpells = WarriorSpells
    elseif ID == 2 then
        playerInfo.classSpells = PaladinSpells
    elseif ID == 3 then
        playerInfo.classSpells = HunterSpells
    elseif ID == 4 then
        playerInfo.classSpells = RogueSpells
    elseif ID == 5 then
        playerInfo.classSpells = PriestSpells
    elseif ID == 6 then
        playerInfo.classSpells = DeathKnightSpells
    elseif ID == 7 then
        playerInfo.classSpells = ShamanSpells
    elseif ID == 8 then
        playerInfo.classSpells = MageSpells
    elseif ID == 9 then
        playerInfo.classSpells = WarlockSpells
    elseif ID == 10 then
        playerInfo.classSpells = MonkSpells
    elseif ID == 11 then
        playerInfo.classSpells = DruidSpells
    elseif ID == 12 then
        playerInfo.classSpells = DemonHunterSpells
    end

    addBloodlust()
end
local original
local function setNameplateBarTexture()
    if aceDB.char.customTexture then
        local barTexture = aceDB.char.barTexture
        local nameplate = C_NamePlate.GetNamePlateForUnit("player", issecure())
        if nameplate then
            if original == nil then
                original = nameplate.UnitFrame.healthBar.barTexture:GetTexture()
            end
            nameplate.driverFrame.classNamePlatePowerBar.Texture:SetTexture(media.MediaTable.statusbar[barTexture])
            nameplate.UnitFrame.healthBar.barTexture:SetTexture(media.MediaTable.statusbar[barTexture])
        end
    end
end

local function healthBarReset(nameplateToken)
    local playerNameplate = C_NamePlate.GetNamePlateForUnit("player", issecure())
    if playerNameplate ~=nil and playerNameplate.namePlateUnitToken == nameplateToken then
    elseif original ~= nil then
        local nameplate = C_NamePlate.GetNamePlateForUnit(nameplateToken, issecure())
        nameplate.UnitFrame.healthBar.barTexture:SetTexture(original)
    end
end

local function OnUpdate()
    hideBlizzardAuras()
    setBuffFramePoint()
    updateAura()
end

local playerNameplateToken
local function getPlayerNameplateToken()
    playerNameplateToken = C_NamePlate.GetNamePlateForUnit("player", issecure()).namePlateUnitToken
end

local function namePlateUpdate()

    if  C_NamePlate.GetNamePlateForUnit("player", issecure()) ~= nil and updateTracker == false then
        hideBlizzardAuras()
        getPlayerNameplateToken()
        loadEnableSpell()
        setNameplateBarTexture()
        updateTracker = true
        updateTicker = C_Timer.NewTicker(0.1,OnUpdate)
    end
end

local function createBuffIconsFrame()
    iconSize = aceDB.char.iconSize
    iconSpacing = aceDB.char.iconSpacing
    local font = aceDB.char.font
    local fontSize = aceDB.char.fontSize
    local countFont = aceDB.char.font
    local countFontSize = aceDB.char.countFontSize
    BuffIcons = CreateFrame("Frame",nil,nil)
    BuffIcons:SetSize(iconSize*10,iconSize)

    for _,i in ipairs(playerInfo.classSpells) do
        iconFrameTable[i] = CreateFrame("Frame",nil,BuffIcons)
        iconFrameTable[i]:SetSize(iconSize,iconSize)

        iconFrameTable[i].spellID = i


        local Texture = iconFrameTable[i]:CreateTexture(nil,"ARTWORK")
        Texture:SetPoint("CENTER")
        Texture:SetSize(iconSize,iconSize)
        Texture:SetTexture(GetSpellTexture(i))
        iconFrameTable[i].texture = Texture

        local coolDown = CreateFrame("CoolDown", nil, iconFrameTable[i], "CooldownFrameTemplate")
        coolDown:SetAllPoints(Texture)
        coolDown.noCooldownCount = true
        iconFrameTable[i].coolDown = coolDown

        local timeText1 = iconFrameTable[i]:CreateFontString(nil, "OVERLAY")
        timeText1:SetFont(media.MediaTable.font[font], fontSize, "OUTLINE")
        timeText1:SetPoint("CENTER", 0, 0)
        iconFrameTable[i].timeText1 = timeText1

        local countText1 = iconFrameTable[i]:CreateFontString(nil, "OVERLAY")
        countText1:SetFont(media.MediaTable.font[countFont], countFontSize, "OUTLINE")
        countText1:SetPoint("BOTTOMRIGHT", 0, 0)
        iconFrameTable[i].countText1 = countText1

        local timeText2 = coolDown:CreateFontString(nil, "OVERLAY")
        timeText2:SetFont(media.MediaTable.font[font], fontSize, "OUTLINE")
        timeText2:SetPoint("CENTER", 0, 0)
        iconFrameTable[i].timeText2 = timeText2

        local countText2 = coolDown:CreateFontString(nil, "OVERLAY")
        countText2:SetFont(media.MediaTable.font[countFont], countFontSize, "OUTLINE")
        countText2:SetPoint("BOTTOMRIGHT", 0, 0)
        iconFrameTable[i].countText2 = countText2
    end
end

function adjustmentFont()
    local size = aceDB.char.fontSize
    local font = aceDB.char.font
    for _,i in pairs(iconFrameTable) do
        iconFrameTable[i.spellID].timeText1:SetFont(media.MediaTable.font[font], size, "OUTLINE")
        iconFrameTable[i.spellID].timeText2:SetFont(media.MediaTable.font[font], size, "OUTLINE")
    end
end

function adjustmentCountFont()
    local size = aceDB.char.countFontSize
    local font = aceDB.char.countFont
    for _,i in pairs(iconFrameTable) do
        iconFrameTable[i.spellID].countText1:SetFont(media.MediaTable.font[font], size, "OUTLINE")
        iconFrameTable[i.spellID].countText2:SetFont(media.MediaTable.font[font], size, "OUTLINE")
    end
end

function adjustmentIconSize()
    iconSize = aceDB.char.iconSize
    BuffIcons:SetSize(iconSize*10,iconSize)

    for _,i in pairs(iconFrameTable) do
        iconFrameTable[i.spellID]:SetSize(iconSize,iconSize)
        iconFrameTable[i.spellID].texture:SetSize(iconSize,iconSize)
    end
end

function adjustmentIconSpacing()
    iconSpacing = aceDB.char.iconSpacing
end

function setXOffset(offset)
    XOffset = offset
end

function setYOffset(offset)
    YOffset = offset
end

local function EventHandler(self, event,...)
    if event == "PLAYER_ENTERING_WORLD" then
        InitializeDB()
        getPlayerInfo()
        loadEnableSpell()
        createBuffIconsFrame()

    elseif event == "NAME_PLATE_UNIT_REMOVED" then
        if  playerNameplateToken == ... then
            freeIconFrame()
            updateTracker = false
            updateTicker:Cancel()
            playerNameplateToken = nil
        end
    elseif event == "NAME_PLATE_UNIT_ADDED" then
        healthBarReset(...)
        namePlateUpdate()
    else
        namePlateUpdate()
    end
end

local function registerAuraEvent()
    eventFrame = CreateFrame("Frame")
    eventFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
    eventFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
    eventFrame:RegisterEvent("UNIT_AURA")
    eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    eventFrame:SetScript("OnEvent", EventHandler)
end

registerAuraEvent()
updateTracker = false

