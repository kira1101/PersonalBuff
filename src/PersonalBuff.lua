---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by kira1101.
--- DateTime: 2020/9/10 下午 12:46
---

local BuffIcons,eventFrame
local enabledSpell
local updateTicker,updateTracker
local playerInfo = { }
local iconSize,iconSpacing
local media = LibStub("LibSharedMedia-3.0")
local XOffset = 0
local YOffset = 0
local enableAuraTable = {}
local showNameplateNumber
local buffFrame
local autoDetect = false


local function iconEnable(spellID)
    for _,i in ipairs(enabledSpell) do
        if i == spellID then
            return true
        end
    end
    return false
end

local function isNotExist (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return false
        end
    end
    return true
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
        aura.Rank = aceDB.char.spell[aura[10]][2]
        table.insert(enableAuraTable,aura)

    end
end

local function updateAura()
    enableAuraTable = {}
    enableAuraTable.alpha = 1

    if C_NamePlate.GetNamePlateForUnit("player", issecure()) ~= nil then
        enableAuraTable.alpha = C_NamePlate.GetNamePlateForUnit("player", issecure()):GetAlpha()
    end

    buffFrame:clear()

    for i=1,40 do
        local Buff = {UnitBuff("player",i)}
        if Buff[1] == nil then
            break
        end
        getEnableAuraTable(Buff)
        if autoDetect and isNotExist(CustomSpell,Buff[10]) == true then
            table.insert(CustomSpell,Buff[10])
        end
    end

    for i=1,40 do
        local Debuff = {UnitDebuff("player",i)}
        if Debuff[1] == nil then
            break
        end
        getEnableAuraTable(Debuff)
    end

    for i=1,40 do
        local petBuff = { UnitBuff("pet",i)}
        if petBuff[1] == nil then
            break
        end
        getEnableAuraTable(petBuff)
    end
    table.sort(enableAuraTable,RankCompare)

    local WildfireBombTalent = {GetTalentInfoByID(22301,1)}
    if WildfireBombTalent[5] == true then
        local WildfireBomb = { _,_,0,_,0,0,_,_,_,259495}
        getEnableAuraTable(WildfireBomb)
    end

    buffFrame:display(enableAuraTable)
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
            },
            spell = {
                ['*'] = { false , 0 } ,

                -- Common
                [340880] = { true , 15 },       --傲慢
                [10060] = { true , 15 },        --注入能量

                -- Bloodlust
                [32182] = { true , 14 },
                [2825] = { true , 14 },
                [80353] = { true , 14 },
                [264667] = { true , 14 },
                [309658] = { true , 14 },

                -- hunter
                [193530] = { true , 14 },       --野性守護
                [19574] = { true , 13 },        --狂野怒火
                [268877] = { true , -1 },       --獸劈斬
                [288613] = { true , 14 },       --強擊
                [260402] = { true , 1 },        --雙重射擊
                [193534] = { true , 13 },       --穩固集中
                [266779] = { true , 14 },       --聯手襲擊
                [259495] = { true , 13 },       --野火炸彈

                -- priest

                [586] = { false , 0 },          --漸隱術
                [111759] = { false , 0 },       --飄浮術
                [33206] = { true , 13 },        --痛苦鎮壓
                [47536] = { true , 13 },        --狂喜
                [81782] = { true , 14 },        --真言術壁
                [215769] = { true , 14 },       --救贖之靈
                [64844] = { true , 13 },        --神聖禮頌
                [64843] = { true , 13 },        --神聖禮頌
                [200183] = { true , 12 },       --神化
                [77489] = { false , 0 },        --光明迴響
                [194249] = { true , 14 },       --虛無型態
                [319952] = { true , 14 },       --獻身瘋狂
                [336267] = { true , 15 },       --快速專注

                -- Rogue
                [1784] = { true , 13 },         --潛行
                [315496] = { true , 12 },       --切割
                [2823] = { false , 0 },         --致命毒藥
                [3408] = { false , 0 },         --致殘毒藥
                [8679] = { false , 0 },         --致傷毒藥
                [315584] = { false , 0 },       --速效毒藥
                [108211] = { false , 0 },       --吸血毒藥
                [13750] = { true , 14 },        --能量刺激
                [13877] = { true , -1 },        --劍刃亂舞
                [121471] = { true , 14 },       --暗影之刃
                [185422] = { true , 13 },       --暗影之舞
                [340094] = { true , 15 },       --刺客大師印記

                -- DemonHunter
                [162264] = { true , 14 },       --惡魔化身
                [187827] = { true , 14 },       --惡魔化身
                [203981] = { true , 13 },       --靈魂碎片
                [203819] = { true , 12 },       --惡魔尖刺

                --Druid
                [61336] = { true , 14 },        --求生本能
                [192081] = { true , 13 },       --鋼鐵毛皮
                [194223] = { true , 14 },       --星芎連線
                [48517] = { true , 13 },        --日蝕
                [48518] = { true , 13 },        --月蝕
                [191034] = { true , 12 },       --星殞術
                [106951] = { true , 13 },       --狂暴
                [5217] = { true , 12 },         --猛虎之怒

                --Warlock
                [113860] = { true , 14 },       --黑暗之魂:悲慘
                [113858] = { true , 14 },       --黑暗之魂:易變
                [5697] = { false , 0 },         --魔息術

                --Shaman
                [546] = { false , 0 },          --水上行走
                [192106] = { false , 0 },       --閃電盾
                [974] = { false , 0 },          --大地之盾
                [52127] = { false , 0 },        --水之盾

                [344179] = { true , 14 },       --氣漩武器
                [224125] = { true , 13 },       --熔火狼
                [224126] = { true , 13 },       --冰霜狼
                [22412] = { true , 13 },        --閃電狼
                [333957] = { true , 13 },       --野性之魂
                [325174] = { true , 14 },       --靈魂連結圖騰

                --Monk
                [120954] = { true , 14 },       --石形絕釀
                [243435] = { true , 14 },       --石形絕釀
                [101643] = { false , 0 },       --超凡入聖
                [322507] = { true , 13 },       --天尊絕釀
                [115176] = { true , 12 },       --冥思禪功
                [137639] = { true , 13 },       --風火大地
                [152173] = { true , 13 },       --冰心訣

                --Mage
                [235450] = { false , 0 },       --稜彩屏障
                [235313] = { false , 0 },       --炙炎屏障
                [11426] = { false , 0 },        --寒冰護體
                [130] = { false , 0 },          --緩落術
                [12042] = { true , 14 },        --祕法強化
                [12051] = { true , 12 },        --喚醒
                [205025] = { true , 13 },       --氣定神閒
                [190319] = { true , 14 },       --燃灼
                [48107] = { true , 13 },        --升溫
                [48108] = { true , 13 },        --焦炎之痕
                [12472] = { true , 14 },        --冰寒脈動
                [44544] = { true , 13 },        --冰霜之指
                [190446] = { true , 13 },       --腦部凍結

                --DeathKnight
                [228579] = { false , 0 },       --擰心光環
                [228581] = { false , 0 },       --腐朽光環
                [228583] = { false , 0 },       --亡域光環
                [49039] = { true , 14 },        --巫妖之軀
                [55233] = { true , 14 },        --血族之裔
                [195181] = { true , 13 },       --骸骨之盾
                [81256] = { true , 12 },        --符文武器幻舞
                [47568] = { true , 14 },        --強力符文武器
                [51271] = { true , 13 },        --冰霜之柱

                --Paladin

                [31884] = { true , 14 },        --復仇之怒
                [231895] = { true , 14 },       --十字軍
                [132403] = { true , 12 },       --公正之盾
                [32223] = { false , 0 },        --十字軍光環
                [465] = { false , 0 },          --虔誠光環
                [183435] = { false , 0 },       --懲戒光環
                [31821] = { true , 13 },        --精通光環
                [86659] = { true , 13 },        --遠古諸王守護者
                [31850] = { true , 13 },        --忠誠防衛者

                --Warrior
                [107574] = { true , 13 },       --巨象化身
                [132404] = { true , 12 },       --盾牌格檔
                [190456] = { true , 11 },       --無視苦痛
                [118038] = { true , 12 },       --劍下亡魂
                [260708] = { true , -1 },       --橫掃攻擊
                [1719] = { true , 14 },         --魯莽
                [184362] = { true , 13 },       --狂怒
                [871] = { true , 14 },         --盾牆
                [12975] = { true , 13 },       --破釜沉舟
            },
            customSpell = {},
            resourceNumber = false,
            resourceNumberType = "Numerical",
            resourceFont = "BIG_BOLD",
            resourceFontSize = 8,
            resourceAlignment = "CENTER",
            changeHealthBarColor = false,
            autoDetect = false,
        }
    }
    aceDB = LibStub("AceDB-3.0"):New("PersonalBuffAceDB", defaultSettings)
    setDBoptions()

    CustomSpell = aceDB.char.customSpell
    autoDetect = aceDB.char.autoDetect
end

local function hideBlizzardAuras()
    if C_NamePlate.GetNamePlateForUnit("player", issecure()) ~= nil then
        C_NamePlate.GetNamePlateForUnit("player", issecure()).UnitFrame.BuffFrame:Hide()
    end
end

local function setBuffFramePoint()
    if C_NamePlate.GetNamePlateForUnit("player", issecure()) ~= nil then
        buffFrame:SetFramePoint(C_NamePlate.GetNamePlateForUnit("player", issecure()).UnitFrame.BuffFrame)
    end
end

function checkEnableSpell(spellID, val)
    if val == true then
        table.insert(enabledSpell,spellID)
    else
        for i,k in ipairs(enabledSpell) do
            if k == spellID then
                table.remove(enabledSpell,i)
            end
        end
    end
end


local function loadEnableSpell()
    enabledSpell = {}
    for _,i in ipairs(playerInfo.classSpells) do
        if aceDB.char.spell[i][1] == true then
            table.insert(enabledSpell,i)
        end
    end
    if CustomSpell ~= nil then
        for _,i in ipairs(CustomSpell) do
            if aceDB.char.spell[i][1] == true and isNotExist(playerInfo.classSpells, i)then
                table.insert(enabledSpell,i)
            end
        end
    end
end

local function addBloodlust()
    for _,i in pairs(Bloodlust) do
        table.insert(playerInfo.classSpells,i)
    end
end

local function addCommonSpells()
    for _,i in pairs(CommonSpells) do
        table.insert(playerInfo.classSpells,i)
    end
end

local function addCustomSpellToTable()
    for _,i in pairs(aceDB.char.customSpell) do
        table.insert(playerInfo.classSpells,i)
    end
end



local function getPlayerInfo()
    local _,_,ID = UnitClass("player")
    if ID == 1 then
        playerInfo.classSpells = shallowcopy(WarriorSpells)
        addClassSpells(ArmsSpells)
        addClassSpells(FurySpells)
        addClassSpells(WarriorProtectionSpells)
        addClassSpells(WarriorPVPSpells)
        addClassSpells(WarriorLegendary)
    elseif ID == 2 then
        playerInfo.classSpells = shallowcopy(PaladinSpells)
        addClassSpells(PaladinHolySpells)
        addClassSpells(PaladinProtectionSpells)
        addClassSpells(RetributionSpells)
        addClassSpells(PaladinPVPSpells)
        addClassSpells(PaladinLegendary)
    elseif ID == 3 then
        playerInfo.classSpells = shallowcopy(HunterSpells)
        addClassSpells(BeastMasterySpells)
        addClassSpells(MarksmanshipSpells)
        addClassSpells(SurvivalSpells)
        addClassSpells(HunterPVPSpells)
        addClassSpells(HunterLegendary)
    elseif ID == 4 then
        playerInfo.classSpells = shallowcopy(RogueSpells)
        addClassSpells(AssassinationSpells)
        addClassSpells(OutlawSpells)
        addClassSpells(SubtletySpells)
        addClassSpells(RoguePVPSpells)
        addClassSpells(RogueLegendary)

    elseif ID == 5 then
        playerInfo.classSpells = shallowcopy(PriestSpells)
        addClassSpells(DisciplineSpells)
        addClassSpells(PriestHolySpells)
        addClassSpells(ShadowSpells)
        addClassSpells(PriestPVPSpells)
        addClassSpells(PriestLegendary)

    elseif ID == 6 then
        playerInfo.classSpells = shallowcopy(DeathKnightSpells)
        addClassSpells(BloodSpells)
        addClassSpells(DeathKnightFrostSpells)
        addClassSpells(UnholySpells)
        addClassSpells(DeathKnightPVPSpells)
        addClassSpells(DeathKnightLegendary)
    elseif ID == 7 then
        playerInfo.classSpells = shallowcopy(ShamanSpells)
        addClassSpells(ElementalSpells)
        addClassSpells(EnhancementSpells)
        addClassSpells(ShamanRestorationSpells)
        addClassSpells(ShamanPVPSpells)
        addClassSpells(ShamanLegendary)
    elseif ID == 8 then
        playerInfo.classSpells = shallowcopy(MageSpells)
        addClassSpells(ArcaneSpells)
        addClassSpells(FireSpells)
        addClassSpells(MageFrostSpells)
        addClassSpells(MagePVPSpells)
        addClassSpells(MageLegendary)
    elseif ID == 9 then
        playerInfo.classSpells = shallowcopy(WarlockSpells)
        addClassSpells(AfflictionSpells)
        addClassSpells(DemonologySpells)
        addClassSpells(DestructionSpells)
        addClassSpells(WarlockPVPSpells)
        addClassSpells(WarlockLegendary)
    elseif ID == 10 then
        playerInfo.classSpells = shallowcopy(MonkSpells)
        addClassSpells(BrewmasterSpells)
        addClassSpells(MistweaverSpells)
        addClassSpells(WindwalkerSpells)
        addClassSpells(MonkPVPSpells)
        addClassSpells(MonkLegendary)
    elseif ID == 11 then
        playerInfo.classSpells = shallowcopy(DruidSpells)
        addClassSpells(BalanceSpells)
        addClassSpells(FeralSpells)
        addClassSpells(DruidRestorationSpells)
        addClassSpells(GuardianSpells)
        addClassSpells(DruidPVPSpells)
        addClassSpells(DruidLegendary)
    elseif ID == 12 then
        playerInfo.classSpells = shallowcopy(DemonHunterSpells)
        addClassSpells(HavocSpells)
        addClassSpells(VengeanceSpells)
        addClassSpells(DemonHunterPVPSpells)
        addClassSpells(DemonHunterLegendary)
    end
    addCommonSpells()
    addBloodlust()
    --addCustomSpellToTable()
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
            if nameplate.driverFrame and nameplate.driverFrame.classNamePlatePowerBar then
                nameplate.driverFrame.classNamePlatePowerBar.Texture:SetTexture(media.MediaTable.statusbar[barTexture])
            end
            nameplate.UnitFrame.healthBar.barTexture:SetTexture(media.MediaTable.statusbar[barTexture])
        end
    end
end

local function setHealthBarClassColor()
    local nameplate = C_NamePlate.GetNamePlateForUnit("player", issecure())
    local changeHealthBarColor = aceDB.char.changeHealthBarColor
    if changeHealthBarColor~=false and nameplate then
        local _,classFilename = UnitClass("player")
        local r,g,b,a = GetClassColor(classFilename)
        nameplate.UnitFrame.healthBar:SetStatusBarColor(r,g,b,a)
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


local function setNameplateNumber()
    local nameplate = C_NamePlate.GetNamePlateForUnit("player", issecure())
    if showNameplateNumber and nameplate then
        local alpha = nameplate:GetAlpha()
        if healthFrame == nil then
            InitializeHealthNumber(nameplate.UnitFrame.healthBar:GetSize())
        end
        healthFrame:SetAllPoints(nameplate.UnitFrame.healthBar)
        healthFrame:SetAlpha(alpha)
        healthFrame.update()

        if nameplate.driverFrame and nameplate.driverFrame.classNamePlatePowerBar then

            if powerFrame == nil then
                InitializePowerNumber(nameplate.driverFrame.classNamePlatePowerBar:GetSize())
            end

            powerFrame:SetAllPoints(nameplate.driverFrame.classNamePlatePowerBar)
            powerFrame:SetAlpha(alpha)
            powerFrame.update()
        end
    end
end

local function OnUpdate()
    if InCinematic() ~= true or IsInCinematic() ~= true then
        hideBlizzardAuras()
        setBuffFramePoint()
        updateAura()
        setNameplateNumber()
    else
        buffFrame:clear()
        healthFrame = nil
        powerFrame = nil
    end

end

local playerNameplateToken
local function getPlayerNameplateToken()
    playerNameplateToken = C_NamePlate.GetNamePlateForUnit("player", issecure()).namePlateUnitToken
end

local function checkResourceNumber()
    showNameplateNumber = aceDB.char.resourceNumber
end

local function namePlateUpdate()

    if  C_NamePlate.GetNamePlateForUnit("player", issecure()) ~= nil and updateTracker == false then
        hideBlizzardAuras()
        getPlayerNameplateToken()
        loadEnableSpell()
        setNameplateBarTexture()
        setHealthBarClassColor()
        checkResourceNumber()
        updateTracker = true
        updateTicker = C_Timer.NewTicker(0.1,OnUpdate)
    end
end

local function initialBuffFrame()
    local IconSetting = {}
    IconSetting.iconSize = aceDB.char.iconSize
    IconSetting.iconSpacing =aceDB.char.iconSpacing
    IconSetting.countFont = media.MediaTable.font[aceDB.char.countFont]
    IconSetting.countFontSize = aceDB.char.countFontSize
    IconSetting.font = media.MediaTable.font[aceDB.char.font]
    IconSetting.fontSize = aceDB.char.fontSize
    IconSetting.XOffset = aceDB.char.XOffset
    IconSetting.YOffset = aceDB.char.YOffset
    local FrameSetting = {}
    FrameSetting.Width = aceDB.char.iconSize * 10
    FrameSetting.Height = aceDB.char.iconSize
    FrameSetting.Spells = playerInfo.classSpells
    FrameSetting.IconSetting = IconSetting

    return CreateBuffFrame(FrameSetting)
end

function adjustmentFont()
    buffFrame.FrameSetting.IconSetting.font = media.MediaTable.font[aceDB.char.font]
    buffFrame.FrameSetting.IconSetting.fontSize = aceDB.char.fontSize
    buffFrame:SetFont()
end

function adjustmentCountFont()
    buffFrame.FrameSetting.IconSetting.countFont = media.MediaTable.font[aceDB.char.countFont]
    buffFrame.FrameSetting.IconSetting.countFontSize = aceDB.char.countFontSize
    buffFrame:SetCountFont()
end

function adjustmentIconSize()
    buffFrame.FrameSetting.IconSetting.iconSize = aceDB.char.iconSize
    buffFrame:SetIconSize()
end

function adjustmentIconSpacing()
    buffFrame.FrameSetting.IconSetting.iconSpacing = aceDB.char.iconSpacing
end

function setXOffset()
    buffFrame.FrameSetting.IconSetting.XOffset = aceDB.char.XOffset
end

function setYOffset()
    buffFrame.FrameSetting.IconSetting.YOffset = aceDB.char.YOffset
end

local function clearResourceNumberFrame()
    if healthFrame ~= nil then
        healthFrame:Hide()
        healthFrame = nil
    end
    if powerFrame ~= nil then
        powerFrame:Hide()
        powerFrame = nil
    end
end

local function newCustomSpellIcon()
    if CustomSpell ~= nil then
        for _,i in ipairs(CustomSpell) do
            if aceDB.char.spell[i][1] == true and isNotExist(playerInfo.classSpells, i)then
                addCustomIcon(i)
            end
        end
    end
end


local function EventHandler(self, event,...)
    if event == "PLAYER_ENTERING_WORLD" then
        InitializeDB()
        getPlayerInfo()
        loadEnableSpell()
        buffFrame = initialBuffFrame()
        newCustomSpellIcon()
        updateCustomSpellConfig()

    elseif event == "NAME_PLATE_UNIT_REMOVED" then
        if  playerNameplateToken == ... then
            buffFrame:clear()
            updateTracker = false
            updateTicker:Cancel()
            playerNameplateToken = nil
            clearResourceNumberFrame()
        end
    elseif event == "NAME_PLATE_UNIT_ADDED" then
        healthBarReset(...)
        namePlateUpdate()
    elseif event == "PLAYER_LEAVE_COMBAT" then
        aceDB.char.CustomSpell = CustomSpell
        updateCustomSpellConfig()

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
    eventFrame:RegisterEvent("PLAYER_LEAVE_COMBAT")
    eventFrame:SetScript("OnEvent", EventHandler)
end

function resetBuffFrame()
    buffFrame:clear()
    buffFrame = nil
    getPlayerInfo()
    buffFrame = initialBuffFrame()
end



function shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end


function addClassSpells(SpellTable)
    if SpellTable ~= nil then
        for _,i in pairs(SpellTable) do
            local isExist = false
            for _,e in ipairs(playerInfo.classSpells) do
                if i == e then
                    isExist = true
                    break
                end
            end
            if isExist == false then
                table.insert(playerInfo.classSpells,i)
            end

        end
    end
end



function CustomSpellList()
    local enableTable = {}

    for _,i in ipairs(CustomSpell) do
        if isNotExist(playerInfo.classSpells, i) then
            table.insert(enableTable,i)
        end
    end

    return enableTable
end

function setAutoDetect(val)
    autoDetect = val
end


registerAuraEvent()
updateTracker = false