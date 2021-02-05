---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by kira1101.
--- DateTime: 2020/9/25 下午 09:23
---


local AceConfig = LibStub("AceConfig-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("PersonalBuff")
local media = LibStub("LibSharedMedia-3.0")

local mainOption,options

local function resetSpellSort()
    mainOption.args.iconOption.args.sort.args = {}
    insertSpellsSort()
end

local function getClassOption()
    mainOption = {
        type = "group",
        childGroups = "tab",
        name = L["option"],
        args = {
            iconOption = {
                order = 1,
                type = "group",
                name = L["general"],

                args = {
                    column = {
                        order = 1,
                        name = L["icons"],
                        type = "group",
                        args ={
                            font = {
                                order = 1,
                                type = "select",
                                style = "dropdown",
                                name = L["font"],
                                values = media:List("font"),
                                itemControl = "DDI-Font",
                                get = function(info)
                                    for i, v in next, media:List("font") do
                                        if v == aceDB.char.font then return i end
                                    end
                                end,
                                set = function(info,key)
                                    local list = media:List("font")
                                    local font = list[key]
                                    aceDB.char.font = font

                                    adjustmentFont()
                                end,
                            },
                            iconSize = {
                                order = 2,
                                type = "range",
                                name = L["iconSize"],
                                min = 12,
                                max = 45,
                                step = 1,
                                get = function(info)
                                    return aceDB.char.iconSize
                                end,
                                set = function(info, val)
                                    aceDB.char.iconSize = val
                                    adjustmentIconSize()
                                end,
                            },

                            fontSize = {
                                order = 3,
                                type = "range",
                                name = L["fontSize"],
                                min = 6,
                                max = 14,
                                step = 1,
                                get = function(info)
                                    return aceDB.char.fontSize
                                end,
                                set = function(info, val)
                                    aceDB.char.fontSize = val
                                    adjustmentFont()
                                end,
                            },
                            iconSpacing = {
                                order = 4,
                                type = "range",
                                name = L["iconSpacing"],
                                min = -10,
                                max = 10,
                                step = 1,
                                get = function(info)
                                    return aceDB.char.iconSpacing
                                end,
                                set = function(info, val)
                                    aceDB.char.iconSpacing = val
                                    adjustmentIconSpacing()
                                end,
                            },
                            XOffset = {
                                order = 5,
                                type = "range",
                                name = L["X offset"],
                                min = -50,
                                max = 50,
                                step = 1,
                                get = function(info)
                                    return aceDB.char.XOffset
                                end,
                                set = function(info, val)
                                    aceDB.char.XOffset = val
                                    setXOffset()
                                end,
                            },
                            YOffset = {
                                order = 5,
                                type = "range",
                                name = L["Y offset"],
                                min = -50,
                                max = 50,
                                step = 1,
                                get = function(info)
                                    return aceDB.char.YOffset
                                end,
                                set = function(info, val)
                                    aceDB.char.YOffset = val
                                    setYOffset()
                                end,
                            },
                            countFont = {
                                order = 6,
                                type = "select",
                                style = "dropdown",
                                name = L["count font"],
                                values = media:List("font"),
                                itemControl = "DDI-Font",
                                get = function(info)
                                    for i, v in next, media:List("font") do
                                        if v == aceDB.char.countFont then return i end
                                    end
                                end,
                                set = function(info,key)
                                    local list = media:List("font")
                                    local font = list[key]
                                    aceDB.char.countFont = font
                                    adjustmentCountFont()
                                end,
                            },
                            countFontSize = {
                                order = 7,
                                type = "range",
                                name = L["count font size"],
                                min = 4,
                                max = 18,
                                step = 1,
                                get = function(info)
                                    return aceDB.char.countFontSize
                                end,
                                set = function(info, val)
                                    aceDB.char.countFontSize = val
                                    adjustmentCountFont()
                                end,
                            },
                            customTexture = {
                                order = 8,
                                type = "toggle",
                                name = L["customTexture"],
                                confirm = function(info, v)
                                    if not v then
                                        return L["Disabling the texture will make them reset next time you reload, are you sure?"]
                                    end
                                end ,
                                get = function(info)
                                    return aceDB.char.customTexture
                                end,
                                set = function(info, val)
                                    aceDB.char.customTexture = val
                                end,
                            },
                            barTexture = {
                                order = 9,
                                type = "select",
                                style = "dropdown",
                                name = L["personalBarTexture"],
                                values = media:List("statusbar"),
                                itemControl = "DDI-Statusbar",
                                disabled = function ()
                                    return not(aceDB.char.customTexture)
                                end,
                                get = function(info)
                                    for i, v in next, media:List("statusbar") do
                                        if v == aceDB.char.barTexture then return i end
                                    end
                                end,
                                set = function(info,key)
                                    local list = media:List("statusbar")
                                    local texture = list[key]
                                    aceDB.char.barTexture = texture
                                end,
                            },
                        },

                    },
                    sort = {
                        order = 1,
                        name = L["Sort"],
                        type = "group",
                        args ={

                        }
                    },
                    resourceNumber = {
                        order = 2,
                        name = L["Resource Number"],
                        type = "group",
                        args ={
                            show = {
                                order = 1,
                                type = "toggle",
                                name = L["Show"],

                                get = function(info)
                                    return aceDB.char.resourceNumber
                                end,
                                set = function(info, val)
                                    aceDB.char.resourceNumber = val
                                end,
                            },
                            header =  {
                                order = 2,
                                type = "header",
                                name = "",
                            },
                            font = {
                                order = 3,
                                type = "select",
                                style = "dropdown",
                                name = L["font"],
                                values = media:List("font"),
                                itemControl = "DDI-Font",
                                get = function(info)
                                    for i, v in next, media:List("font") do
                                        if v == aceDB.char.resourceFont then return i end
                                    end
                                end,
                                set = function(info,key)
                                    local list = media:List("font")
                                    local font = list[key]
                                    aceDB.char.resourceFont = font
                                end,
                                disabled = function()
                                    return not aceDB.char.resourceNumber
                                end,
                            },
                            size = {
                                order = 4,
                                type = "range",
                                name = L["fontSize"],
                                min = 6,
                                max = 14,
                                step = 1,
                                get = function(info)
                                    return aceDB.char.resourceFontSize
                                end,
                                set = function(info, val)
                                    aceDB.char.resourceFontSize = val
                                end,
                                disabled = function()
                                    return not aceDB.char.resourceNumber
                                end,
                            },
                            alignment = {
                                order = 5,
                                type = "select",
                                style = "dropdown",
                                name = L["alignment"],
                                values = {
                                    LEFT = L["left"],
                                    CENTER = L["center"],
                                    RIGHT = L["right"],
                                },
                                get = function(info)
                                    return aceDB.char.resourceAlignment
                                end,
                                set = function(info, val)
                                    aceDB.char.resourceAlignment = val
                                end,
                                disabled = function()
                                    return not aceDB.char.resourceNumber
                                end,
                            }

                        }
                    }
                }

            },

            BuffOption = {
                order = 2,
                type = "group",
                name = L["Buffs"],

                args = {
                    Warrior = {
                        order = 1,
                        type = "group",
                        name = function() return format("|T%s:16|t %s", "Interface\\ICONS\\Classicon_warrior", GetClassInfo(1)) end,
                        args = {}
                    },
                    Paladin= {
                        order = 2,
                        type = "group",
                        name = function() return format("|T%s:16|t %s", "Interface\\ICONS\\Classicon_paladin", GetClassInfo(2)) end,
                        args = {}
                    },
                    Hunter = {
                        order = 3,
                        type = "group",
                        name = function() return format("|T%s:16|t %s", "Interface\\ICONS\\Classicon_hunter", GetClassInfo(3)) end,
                        args = {
                        }
                    },
                    Rogue = {
                        order = 4,
                        type = "group",
                        name = function() return format("|T%s:16|t %s", "Interface\\ICONS\\Classicon_rogue", GetClassInfo(4)) end,
                        args = {}
                    },
                    Priest = {
                        order = 5,
                        type = "group",
                        name = function() return format("|T%s:16|t %s", "Interface\\ICONS\\Classicon_priest", GetClassInfo(5)) end,
                        args = {}
                    },
                    DeathKnight = {
                        order = 6,
                        type = "group",
                        name = function() return format("|T%s:16|t %s", "Interface\\ICONS\\Classicon_deathknight", GetClassInfo(6)) end,
                        args = {}
                    },
                    Shaman = {
                        order = 7,
                        type = "group",
                        name = function() return format("|T%s:16|t %s", "Interface\\ICONS\\Classicon_shaman", GetClassInfo(7)) end,
                        args = {}
                    },
                    Mage = {
                        order = 8,
                        type = "group",
                        name = function() return format("|T%s:16|t %s", "Interface\\ICONS\\Classicon_mage", GetClassInfo(8)) end,
                        args = {}
                    },
                    Warlock = {
                        order = 9,
                        type = "group",
                        name = function() return format("|T%s:16|t %s", "Interface\\ICONS\\Classicon_warlock", GetClassInfo(9)) end,
                        args = {}
                    },
                    Monk = {
                        order = 10,
                        type = "group",
                        name = function() return format("|T%s:16|t %s", "Interface\\ICONS\\Classicon_monk", GetClassInfo(10)) end,
                        args = {}
                    },
                    Druid = {
                        order = 11,
                        type = "group",
                        name = function() return format("|T%s:16|t %s", "Interface\\ICONS\\Classicon_druid", GetClassInfo(11)) end,
                        args = {}
                    },
                    DemonHunter = {
                        order = 12,
                        type = "group",
                        name = function() return format("|T%s:16|t %s", "Interface\\ICONS\\Classicon_demonhunter", GetClassInfo(12)) end,
                        args = {}
                    },

                    Bloodlust = {
                        order = 13,
                        type = "group",
                        name = function() return format("|T%s:16|t %s", GetSpellTexture(2825), GetSpellInfo(2825)) end,
                        args = {}
                    },

                    customSpell = {
                        order = 13,
                        type = "group",
                        name = function() return format("|T%s:16|t %s", "Interface\\ICONS\\Trade_engineering", L["custom"]) end,
                        args = {
                            description = {
                                order = 0,
                                type = "description",
                                name = "Enter the spell 'ID'",
                                width = "full"
                            },
                            input = {
                                order = 1,
                                type = "input",
                                name = "",
                                width = "full",
                                set = function (info, v)
                                    table.insert(aceDB.char.customSpell,tonumber(v))
                                    addCustomSpell()
                                    resetBuffIconsFrame()
                                    resetSpellSort()
                                end,
                                validate = function(info, v)
                                    local check = true
                                    for i,k in ipairs(aceDB.char.customSpell) do
                                        if k == tonumber(v) then
                                            check = false
                                        end
                                    end

                                    if GetSpellInfo(v) == nil then
                                        return "please check spell id"
                                    elseif check == false then
                                        return "spell is already existed"
                                    else
                                        return true
                                    end
                                end ,
                                confirm = function(info, v)
                                    if GetSpellInfo(v) ~= nil then
                                        return format("|T%s:16|t %s", GetSpellTexture(v), GetSpellInfo(v))
                                    end
                                end ,
                            },
                        }
                    },
                }
            },
            --DebuffOption = {
            --    order = 3,
            --    type = "group",
            --    name = L["Debuffs"],
            --
            --    args = {
            --
            --    }
            --
            --},
        }
    }

end


local function getOptions()
    if not options then
        options = {
            type = "group",
            name = L["Personal Buff"],
            args = {
                mainOption = mainOption
            }
        }
    end

    return options
end


local function SetupOptions()
    optionsFrames = {}
    getClassOption()

    LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("Personal Buff", getOptions)
    optionsFrames.PersonalBuff = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Personal Buff", L["Personal Buff"], nil,"mainOption")
end

local function insertClassSpells(classname,spellTable)
    for i,k in ipairs(spellTable) do
        mainOption.args.BuffOption.args[classname].args[tostring(i)] = {
            type = "toggle",
            order = i,
            name = function() return format("|T%s:16|t %s", GetSpellTexture(k), GetSpellInfo(k)) end,
            desc = GetSpellDescription(k),
            get = function(info)
                return aceDB.char.enabledSpell[k]
            end,
            set = function(info, val)
                aceDB.char.enabledSpell[k] = val
            end,
        }

    end
end

function insertSpellsSort()
    local _,_,ID = UnitClass("player")
    local classSpells
    if ID == 1 then
        classSpells = WarriorSpells
    elseif ID == 2 then
        classSpells = PaladinSpells
    elseif ID == 3 then
        classSpells = HunterSpells
    elseif ID == 4 then
        classSpells = RogueSpells
    elseif ID == 5 then
        classSpells = PriestSpells
    elseif ID == 6 then
        classSpells = DeathKnightSpells
    elseif ID == 7 then
        classSpells = ShamanSpells
    elseif ID == 8 then
        classSpells = MageSpells
    elseif ID == 9 then
        classSpells = WarlockSpells
    elseif ID == 10 then
        classSpells = MonkSpells
    elseif ID == 11 then
        classSpells = DruidSpells
    elseif ID == 12 then
        classSpells = DemonHunterSpells
    end
    local index = 1
    for i,k in ipairs(classSpells) do
        mainOption.args.iconOption.args.sort.args[tostring(i)] = {
            order = i,
            type = "range",
            name = function() return format("|T%s:16|t %s", GetSpellTexture(k), GetSpellInfo(k)) end,
            desc = L["The higher the rank ordering more left"],
            max = 15,
            min = -15,
            step = 1,
            get = function(info)
                return aceDB.char.spellRank[k]
            end,
            set = function(info, val)
                aceDB.char.spellRank[k] = val
            end,
        }
        index = index + 1
    end
    for i,k in ipairs(aceDB.char.customSpell) do
        mainOption.args.iconOption.args.sort.args[tostring(index)] = {
            order = index,
            type = "range",
            name = function() return format("|T%s:16|t %s", GetSpellTexture(k), GetSpellInfo(k)) end,
            desc = L["The higher the rank ordering more left"],
            max = 15,
            min = -15,
            step = 1,
            get = function(info)
                return aceDB.char.spellRank[k]
            end,
            set = function(info, val)
                aceDB.char.spellRank[k] = val
            end,
        }
        index = index + 1
    end
    mainOption.args.iconOption.args.sort.args[tostring(index)] = {
        order = -1,
        type = "range",
        name = function() return format("|T%s:16|t %s", GetSpellTexture(2825), GetSpellInfo(2825)) end,
        desc = L["The higher the rank ordering more left"],
        max = 15,
        min = -15,
        step = 1,
        get = function(info)
            return aceDB.char.spellRank[2825]
        end,
        set = function(info, val)
            aceDB.char.spellRank[32182] = val
            aceDB.char.spellRank[2825] = val
            aceDB.char.spellRank[80353] = val
            aceDB.char.spellRank[264667] = val
            aceDB.char.spellRank[178207] = val
            aceDB.char.spellRank[230935] = val
            aceDB.char.spellRank[256740] = val
            aceDB.char.spellRank[292686] = val
            aceDB.char.spellRank[340880] = val
        end,
    }
end

function setDefaultCustomSpell()
    mainOption.args.BuffOption.args.customSpell.args = {
        description = {
            order = 0,
            type = "description",
            name = "Enter the spell 'ID'",
            width = "full"
        },
        input = {
            order = 1,
            type = "input",
            name = "",
            width = "full",
            set = function (info, v)
                table.insert(aceDB.char.customSpell,tonumber(v))
                addCustomSpell()
                resetBuffIconsFrame()
                resetSpellSort()
            end,
            validate = function(info, v)
                local check = true
                for i,k in ipairs(aceDB.char.customSpell) do
                    if k == tonumber(v) then
                        check = false
                    end
                end

                if GetSpellInfo(v) == nil then
                    return "please check spell id"
                elseif check == false then
                    return "spell is already existed"
                else
                    return true
                end
            end ,
            confirm = function(info, v)
                if GetSpellInfo(v) ~= nil then
                    return format("|T%s:16|t %s", GetSpellTexture(v), GetSpellInfo(v))
                end
            end ,
        },
    }
end

function resetCustomSpell()
    setDefaultCustomSpell()
    addCustomSpell()
    resetBuffIconsFrame()
    resetSpellSort()
end

function addCustomSpell()
    local index = 5
    for i,k in ipairs(aceDB.char.customSpell) do

        mainOption.args.BuffOption.args.customSpell.args[tostring(i+index)] = {
            order = i+index,
            type = "execute",
            name = "",
            image = "Interface\\AddOns\\PersonalBuff\\texture\\remove.blp",
            imageWidth = 20,
            imageHeight = 20,
            width = 0.1,
            hidden = function()
                if i ~= 1 then
                    return false
                else
                    return true
                end
            end,
            func = function()
                table.remove(aceDB.char.customSpell,i)
                resetCustomSpell()
            end
        }
        index = index + 1


        mainOption.args.BuffOption.args.customSpell.args[tostring(i+index)] = {
            type = "toggle",
            order = i+index,
            name = function() return format("|T%s:16|t %s", GetSpellTexture(k), GetSpellInfo(k)) end,
            desc = GetSpellDescription(k),
            width = 1.0,
            get = function(info)
                return aceDB.char.enabledSpell[k]
            end,
            set = function(info, val)
                aceDB.char.enabledSpell[k] = val
            end,
        }

    end
end

function setDBoptions()
    mainOption.args.iconOption.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(aceDB)
end

media:Register("font","BIG_BOLD",[[Interface\AddOns\PersonalBuff\font\BIG_BOLD.TTF]],255 )
media:Register("statusbar","Flat_N",[[Interface\AddOns\PersonalBuff\texture\nameplate.blp]],255 )
SetupOptions()

insertClassSpells("Warrior",WarriorSpells)
insertClassSpells("Paladin",PaladinSpells)
insertClassSpells("Hunter",HunterSpells)
insertClassSpells("Rogue",RogueSpells)
insertClassSpells("Priest",PriestSpells)
insertClassSpells("DeathKnight",DeathKnightSpells)
insertClassSpells("Shaman",ShamanSpells)
insertClassSpells("Mage",MageSpells)
insertClassSpells("Warlock",WarlockSpells)
insertClassSpells("Monk",MonkSpells)
insertClassSpells("Druid",DruidSpells)
insertClassSpells("DemonHunter",DemonHunterSpells)
insertClassSpells("Bloodlust",Bloodlust)


