assert(juggy, "Juggy_Definitions.lua must be defined first.")

-- we define this function in SRB2 only for optimization purposes
juggy.GetCharColorFromVMAP = nil;

if MODID == juggy.SRB2 then -- SRB2
    juggy.GetCharColorFromVMAP = function(vmap)
        -- You'd really really think this should be a base game function but it isn't :ghost:
        if vmap == V_MAGENTAMAP then
            return "\x81"
        elseif vmap == V_YELLOWMAP then
            return "\x82"
        elseif vmap == V_GREENMAP then
            return "\x83"
        elseif vmap == V_BLUEMAP then
            return "\x84"
        elseif vmap == V_REDMAP then
            return "\x85"--
        elseif vmap == V_GRAYMAP then
            return "\x86"
        elseif vmap == V_ORANGEMAP then
            return "\x87"
        elseif vmap == V_SKYMAP then
            return "\x88"
        elseif vmap == V_PURPLEMAP then
            return "\x89"
        elseif vmap == V_AQUAMAP then
            return "\x8a"
        elseif vmap == V_PERIDOTMAP then
            return "\x8b"
        elseif vmap == V_AZUREMAP then
            return "\x8c"
        elseif vmap == V_BROWNMAP then
            return "\x8d"
        elseif vmap == V_ROSYMAP then
            return "\x8e"
        elseif vmap == V_INVERTMAP then
            return "\x8f"
        end

        return "\x80"

    end
end

juggy.chatColorsTable = {}
juggy.colorNamesTable = {}

-- ditto but for kart
if MODID == juggy.SRB2KART then -- SRB2Kart
    juggy.chatColorsTable =
    {
        -- SRB2Kart does not have a skincolors table, so we have to rely
        -- on a very epic table to figure these out. COOL
        -- Shoutouts to Amper and Tyron for this.
        [SKINCOLOR_WHITE] = "\x80",
        [SKINCOLOR_SILVER] = "\x80",
        [SKINCOLOR_SLATE] = "\x80",	
        [SKINCOLOR_ULTRAVIOLET] = "\x81",
        [SKINCOLOR_PURPLE] = "\x81",
        [SKINCOLOR_FUCHSIA] = "\x81",
        [SKINCOLOR_POPCORN] = "\x82",
        [SKINCOLOR_QUARRY] = "\x82",
        [SKINCOLOR_YELLOW] = "\x82",
        [SKINCOLOR_MUSTARD] = "\x82",
        [SKINCOLOR_CROCODILE] = "\x82",
        [SKINCOLOR_OLIVE] = "\x82",
        [SKINCOLOR_LIME] = "\x83",
        [SKINCOLOR_HANDHELD] = "\x83",
        [SKINCOLOR_MOSS] = "\x83",
        [SKINCOLOR_CAMOUFLAGE] = "\x83",
        [SKINCOLOR_ROBOHOOD] = "\x83",
        [SKINCOLOR_MINT] = "\x83",
        [SKINCOLOR_GREEN] = "\x83",
        [SKINCOLOR_PINETREE] = "\x83",
        [SKINCOLOR_ALGAE] = "\x83",
        [SKINCOLOR_PLAGUE] = "\x83",
        [SKINCOLOR_EMERALD] = "\x83",
        [SKINCOLOR_SWAMP] = "\x83",
        [SKINCOLOR_DREAM] = "\x83",	
        [SKINCOLOR_PERIWINKLE] = "\x84",
        [SKINCOLOR_BLUE] = "\x84",
        [SKINCOLOR_BLUEBERRY] = "\x84",
        [SKINCOLOR_NOVA] = "\x84",	
        [SKINCOLOR_CINNAMON] = "\x85",
        [SKINCOLOR_RUBY] = "\x85",
        [SKINCOLOR_RASPBERRY] = "\x85",
        [SKINCOLOR_CHERRY] = "\x85",
        [SKINCOLOR_RED] = "\x85",
        [SKINCOLOR_CRIMSON] = "\x85",
        [SKINCOLOR_MAROON] = "\x85",
        [SKINCOLOR_FLAME] = "\x85",
        [SKINCOLOR_SCARLET] = "\x85",
        [SKINCOLOR_KETCHUP] = "\x85",
        [SKINCOLOR_GREY] = "\x86",
        [SKINCOLOR_NICKEL] = "\x86",
        [SKINCOLOR_BLACK] = "\x86",
        [SKINCOLOR_SKUNK] = "\x86",
        [SKINCOLOR_JET] = "\x86",	
        [SKINCOLOR_DAWN] = "\x87",
        [SKINCOLOR_SUNSET] = "\x87",
        [SKINCOLOR_CREAMSICLE] = "\x87",
        [SKINCOLOR_ORANGE] = "\x87",
        [SKINCOLOR_PUMPKIN] = "\x87",
        [SKINCOLOR_ROSEWOOD] = "\x87",
        [SKINCOLOR_BURGUNDY] = "\x87",
        [SKINCOLOR_TANGERINE] = "\x87",	
        [SKINCOLOR_CARIBBEAN] = "\x88",
        [SKINCOLOR_AZURE] = "\x88",
        [SKINCOLOR_AQUA] = "\x88",
        [SKINCOLOR_TEAL] = "\x88",
        [SKINCOLOR_CYAN] = "\x88",
        [SKINCOLOR_JAWZ] = "\x88",
        [SKINCOLOR_CERULEAN] = "\x88",
        [SKINCOLOR_NAVY] = "\x88",
        [SKINCOLOR_SAPPHIRE] = "\x88",
        [SKINCOLOR_PASTEL] = "\x89",
        [SKINCOLOR_MOONSLAM] = "\x89",
        [SKINCOLOR_DUSK] = "\x89",
        [SKINCOLOR_TOXIC] = "\x89",
        [SKINCOLOR_MAUVE] = "\x89",
        [SKINCOLOR_LAVENDER] = "\x89",
        [SKINCOLOR_BYZANTIUM] = "\x89",
        [SKINCOLOR_POMEGRANATE] = "\x89",
        [SKINCOLOR_GOLD] = "\x8A",
        [SKINCOLOR_ROYAL] = "\x8A",
        [SKINCOLOR_BRONZE] = "\x8A",
        [SKINCOLOR_COPPER] = "\x8A",
        [SKINCOLOR_THUNDER] = "\x8A",
        [SKINCOLOR_ARTICHOKE] = "\x8B",
        [SKINCOLOR_VOMIT] = "\x8B",
        [SKINCOLOR_GARDEN] = "\x8B",
        [SKINCOLOR_TEA] = "\x8B",
        [SKINCOLOR_PISTACHIO] = "\x8B",	
        [SKINCOLOR_PIGEON] = "\x8C",
        [SKINCOLOR_PLATINUM] = "\x8C",
        [SKINCOLOR_STEEL] = "\x8C",	
        [SKINCOLOR_FAIRY] = "\x8D",
        [SKINCOLOR_SALMON] = "\x8D",
        [SKINCOLOR_PINK] = "\x8D",
        [SKINCOLOR_ROSE] = "\x8D",
        [SKINCOLOR_BRICK] = "\x8D",
        [SKINCOLOR_LEMONADE] = "\x8D",
        [SKINCOLOR_BUBBLEGUM] = "\x8D",
        [SKINCOLOR_LILAC] = "\x8D",	
        [SKINCOLOR_SEPIA] = "\x8E",	
        [SKINCOLOR_BEIGE] = "\x8E",	
        [SKINCOLOR_WALNUT] = "\x8E",
        [SKINCOLOR_BROWN] = "\x8E",	
        [SKINCOLOR_LEATHER] = "\x8E",
        [SKINCOLOR_RUST] = "\x8E",
        [SKINCOLOR_WRISTWATCH] = "\x8E",
        [SKINCOLOR_PEACH] = "\x8F",
        [SKINCOLOR_CARAMEL] = "\x8F",
        [SKINCOLOR_CREAM] = "\x8F",
    }

    juggy.colorNamesTable =
    {
        -- Have I mentioned there is zero color support in Kart?
        ["white"] = SKINCOLOR_WHITE,
        ["silver"] = SKINCOLOR_SILVER,
        ["slate"] = SKINCOLOR_SLATE,	
        ["ultraviolet"] = SKINCOLOR_ULTRAVIOLET,
        ["purple"] = SKINCOLOR_PURPLE,
        ["fuchsia"] = SKINCOLOR_FUCHSIA,
        ["popcorn"] = SKINCOLOR_POPCORN,
        ["quarry"] = SKINCOLOR_QUARRY,
        ["yellow"] = SKINCOLOR_YELLOW,
        ["mustard"] = SKINCOLOR_MUSTARD,
        ["crocodile"] = SKINCOLOR_CROCODILE,
        ["olive"] = SKINCOLOR_OLIVE,
        ["lime"] = SKINCOLOR_LIME,
        ["handheld"] = SKINCOLOR_HANDHELD,
        ["moss"] = SKINCOLOR_MOSS,
        ["camouflage"] = SKINCOLOR_CAMOUFLAGE,
        ["robohood"] = SKINCOLOR_ROBOHOOD,
        ["mint"] = SKINCOLOR_MINT,
        ["green"] = SKINCOLOR_GREEN,
        ["pinetree"] = SKINCOLOR_PINETREE,
        ["algae"] = SKINCOLOR_ALGAE,
        ["plague"] = SKINCOLOR_PLAGUE,
        ["emerald"] = SKINCOLOR_EMERALD,
        ["swamp"] = SKINCOLOR_SWAMP,
        ["dream"] = SKINCOLOR_DREAM,	
        ["periwinkle"] = SKINCOLOR_PERIWINKLE,
        ["blue"] = SKINCOLOR_BLUE,
        ["blueberry"] = SKINCOLOR_BLUEBERRY,
        ["nova"] = SKINCOLOR_NOVA,	
        ["cinnamon"] = SKINCOLOR_CINNAMON,
        ["ruby"] = SKINCOLOR_RUBY,
        ["raspberry"] = SKINCOLOR_RASPBERRY,
        ["cherry"] = SKINCOLOR_CHERRY,
        ["red"] = SKINCOLOR_RED,
        ["crimson"] = SKINCOLOR_CRIMSON,
        ["maroon"] = SKINCOLOR_MAROON,
        ["flame"] = SKINCOLOR_FLAME,
        ["scarlet"] = SKINCOLOR_SCARLET,
        ["ketchup"] = SKINCOLOR_KETCHUP,
        ["grey"] = SKINCOLOR_GREY,
        ["nickel"] = SKINCOLOR_NICKEL,
        ["black"] = SKINCOLOR_BLACK,
        ["skunk"] = SKINCOLOR_SKUNK,
        ["jet"] = SKINCOLOR_JET,	
        ["dawn"] = SKINCOLOR_DAWN,
        ["sunset"] = SKINCOLOR_SUNSET,
        ["creamsicle"] = SKINCOLOR_CREAMSICLE,
        ["orange"] = SKINCOLOR_ORANGE,
        ["pumpkin"] = SKINCOLOR_PUMPKIN,
        ["rosewood"] = SKINCOLOR_ROSEWOOD,
        ["burgundy"] = SKINCOLOR_BURGUNDY,
        ["tangerine"] = SKINCOLOR_TANGERINE,	
        ["caribbean"] = SKINCOLOR_CARIBBEAN,
        ["azure"] = SKINCOLOR_AZURE,
        ["aqua"] = SKINCOLOR_AQUA,
        ["teal"] = SKINCOLOR_TEAL,
        ["cyan"] = SKINCOLOR_CYAN,
        ["jawz"] = SKINCOLOR_JAWZ,
        ["cerulean"] = SKINCOLOR_CERULEAN,
        ["navy"] = SKINCOLOR_NAVY,
        ["sapphire"] = SKINCOLOR_SAPPHIRE,
        ["pastel"] = SKINCOLOR_PASTEL,
        ["moonslam"] = SKINCOLOR_MOONSLAM,
        ["dusk"] = SKINCOLOR_DUSK,
        ["toxic"] = SKINCOLOR_TOXIC,
        ["mauve"] = SKINCOLOR_MAUVE,
        ["lavender"] = SKINCOLOR_LAVENDER,
        ["byzantium"] = SKINCOLOR_BYZANTIUM,
        ["pomegranate"] = SKINCOLOR_POMEGRANATE,
        ["gold"] = SKINCOLOR_GOLD,
        ["royal"] = SKINCOLOR_ROYAL,
        ["bronze"] = SKINCOLOR_BRONZE,
        ["copper"] = SKINCOLOR_COPPER,
        ["thunder"] = SKINCOLOR_THUNDER,
        ["artichoke"] = SKINCOLOR_ARTICHOKE,
        ["vomit"] = SKINCOLOR_VOMIT,
        ["garden"] = SKINCOLOR_GARDEN,
        ["tea"] = SKINCOLOR_TEA,
        ["pistachio"] = SKINCOLOR_PISTACHIO,	
        ["pigeon"] = SKINCOLOR_PIGEON,
        ["platinum"] = SKINCOLOR_PLATINUM,
        ["steel"] = SKINCOLOR_STEEL,
        ["fairy"] = SKINCOLOR_FAIRY,
        ["salmon"] = SKINCOLOR_SALMON,
        ["pink"] = SKINCOLOR_PINK,
        ["rose"] = SKINCOLOR_ROSE,
        ["brink"] = SKINCOLOR_BRICK,
        ["lemonade"] = SKINCOLOR_LEMONADE,
        ["bubblegum"] = SKINCOLOR_BUBBLEGUM,
        ["lilac"] = SKINCOLOR_LILAC,	
        ["sepia"] = SKINCOLOR_SEPIA,	
        ["beige"] = SKINCOLOR_BEIGE,	
        ["walnut"] = SKINCOLOR_WALNUT,
        ["brown"] = SKINCOLOR_BROWN,	
        ["leather"] = SKINCOLOR_LEATHER,
        ["rust"] = SKINCOLOR_RUST,
        ["wristwatch"] = SKINCOLOR_WRISTWATCH,
        ["peach"] = SKINCOLOR_PEACH,
        ["caramel"] = SKINCOLOR_CARAMEL,
        ["cream"] = SKINCOLOR_CREAM,
    }
end

juggy.GetChatColorFromSkinColor = function(skincolor)

    if skincolor == nil then return "\x80" end
    
    if MODID == juggy.SRB2 then -- SRB2
        return juggy.GetCharColorFromVMAP(skincolors[skincolor].chatcolor) or "\x80"
    else -- SRB2Kart
        return juggy.chatColorsTable[skincolor]
    end

    -- return 
end