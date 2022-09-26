---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by kira1101.
--- DateTime: 2021/5/14 下午 10:18
---
local L = LibStub("AceLocale-3.0"):GetLocale("PersonalBuff")

local ClassID = 3
HunterSpells = {
    186257,     --獵豹守護
    186258,     --獵豹守護
    186265,     --巨龜守護
    5384,       --假死
    199483,     --偽裝
    231390,     --追獵高手
    324156,     --剝皮者印記
}

BeastMasterySpells = {
    193530,     --野性守護
    19574,      --狂野怒火
    268877,     --獸劈斬
    257946,     --獵殺快感
    272790,     --狂暴
    281036,     --凶暴野獸
}

MarksmanshipSpells = {
    288613,     --強擊
    257622,     --花式射擊
    260242,     --精準射擊
    260402,     --雙重射擊
    193534,     --穩固集中
    194594,     --蓄勢待發
}

SurvivalSpells = {
    266779,     --聯手襲擊
    186289,     --神鷹守護
    259388,     --貓狂怒
    259495,     --野火炸彈
    260286,     --野火炸彈
}

HunterPVPSpells = {
    204205,     --狂野守護獸
    212704,     --獸心
    53480,      --犧牲咆嘯
    202748,     --求生戰術
    203155,     --狙擊射擊
    212640,     --癒合繃帶
}

HunterLegendary = {
	336892,
}

function insertHunterConfig(configRoot)
    local _,BeastMastery,_,BeastMasteryIcon = GetSpecializationInfoForClassID(ClassID, 1)
    local _,Marksmanship,_,MarksmanshipIcon = GetSpecializationInfoForClassID(ClassID, 2)
    local _,Survival,_,SurvivalIcon = GetSpecializationInfoForClassID(ClassID, 3)
    configRoot.args.BuffOption.args = {
        Hunter = {
            order = 1,
            type = "group",
            name = function() return format("|cffABD473|T%s:16|t %s", "Interface\\ICONS\\Classicon_hunter", GetClassInfo(ClassID)) end,
            args = {
            }
        },
        BeastMastery = {
            order = 2,
            type = "group",
            name = function() return format("|cffABD473|T%s:16|t %s", BeastMasteryIcon, BeastMastery) end,
            args = {
            }
        },
        Marksmanship = {
            order = 3,
            type = "group",
            name = function() return format("|cffABD473|T%s:16|t %s", MarksmanshipIcon, Marksmanship) end,
            args = {
            }
        },
        Survival = {
            order = 4,
            type = "group",
            name = function() return format("|cffABD473|T%s:16|t %s", SurvivalIcon, Survival) end,
            args = {
            }
        },
        PVP = {
            order = 5,
            type = "group",
            name = function() return format("|cff8A2BE2|T%s:16|t %s", "Interface\\ICONS\\ability_pvp_gladiatormedallion", "PVP") end,
            args = {
            }
        },
        Legendary= {
            order = 6,
            type = "group",
            name = function() return format("|cffFF8000|T%s:16|t %s", "Interface\\ICONS\\inv_antorus_turquoise", L["Legendary"]) end,
            args = {
            }
        },
        Bloodlust= {
            order = 7,
            type = "group",
            name = function() return format("|cffFF8000|T%s:16|t %s", GetSpellTexture(2825), GetSpellInfo(2825)) end,
            args = {
            }
        },
        Common = {
            order = 8,
            type = "group",
            name = function() return format("|T%s:16|t %s", "Interface\\ICONS\\Trade_engineering", L["Common"]) end,
            args = {}
        },
        Custom = {
            order = 9,
            type = "group",
            name = function() return format("|T%s:16|t %s", "Interface\\ICONS\\Trade_engineering", L["custom"]) end,
            args = {}
        },
    }


end