for _, filename in ipairs{
-- Funny init

	--first thing to load
	"2-ZECore/1-Init/int_freeslot.lua",
	"2-ZECore/1-Init/int_global.lua",
	"2-ZECore/1-Init/int_ZE_RSNEO.lua",


	--cmds and etc
	"2-ZECore/2-Console/con_timer.lua",
	"2-ZECore/2-Console/con_rhealth.lua",
	"2-ZECore/2-Console/con_cmds.lua",
	
	--main ze code	
	"2-ZECore/3-Library/lib_ZE_main.lua",
	"2-ZECore/3-Library/lib_ZE_rhealth.lua",
	"2-ZECore/3-Library/lib_ZE_rhealth_dmg.lua",
	"2-ZECore/3-Library/lib_ZE_player_cfg.lua",
	"2-ZECore/3-Library/lib_ZE_player_rhealth.lua",
	"2-ZECore/3-Library/lib_ZE_player_misc.lua",
	"2-ZECore/3-Library/lib_ZE_mapload.lua",
	"2-ZECore/3-Library/lib_ZE_netvars.lua",
	"2-ZECore/3-Library/lib_ZE_MobjCollide.lua",
	"2-ZECore/3-Library/lib_ZE_propspawn.lua",
	"2-ZECore/3-Library/lib_ZE_radar.lua",
	"2-ZECore/3-Library/lib_ZE_ExtraChars.lua",
	"2-ZECore/3-Library/lib_ZE_Ability_Milne.lua",
	"2-ZECore/3-Library/lib_ZE_ExtraChars_exec.lua",
	"2-ZECore/3-Library/lib_ZE_rhealth_Extra.lua",
	"2-ZECore/3-Library/lib_ZE_Revenger.lua",
	"2-ZECore/3-Library/lib_ZE_swarmhud.lua",
	"2-ZECore/3-Library/lib_ZE_antibounce.lua",

	"2-ZECore/4-Execute/Exec_ZE_Player.lua",
	"2-ZECore/4-Execute/Exec_ZE_Main.lua",
	"2-ZECore/4-Execute/Exec_ZE_HUD.lua",

	--mapvote stuff
	"4-ServerCore/1-MapVote/1_Rawset.lua",
	"4-ServerCore/1-MapVote/2_Console.lua",
	"4-ServerCore/1-MapVote/3_DebugFunctions.lua",
	"4-ServerCore/1-MapVote/4_Functions.lua",
	"4-ServerCore/1-MapVote/5_HUD.lua",
	"4-ServerCore/1-MapVote/6_Main.lua",
	"4-ServerCore/1-MapVote/7_GametypeRegistry.lua",

	--Ringslinger neo base
    "1-GunMod/Rawset.lua",
	"1-GunMod/Console.lua",
	"1-GunMod/Sounds.lua",
	"1-GunMod/WeaponMobjs.lua",
	"1-GunMod/WeaponHooks.lua",
	"1-GunMod/WeaponHooks.lua",
	"1-GunMod/Weapons.lua",
	"1-GunMod/PowerupMobjs.lua",
	"1-GunMod/Powerups.lua",
	"1-GunMod/AmmoRingMobj.lua",
	"1-GunMod/AmmoRingHooks.lua",
	"1-GunMod/Skins.lua",
	"1-GunMod/HUDHooks.lua",
	"1-GunMod/PlayerHooks.lua",
	"1-GunMod/HurtMsgHooks.lua",
	"1-GunMod/NewRingExplode.lua",
	"1-GunMod/RocketForce.lua",
	
	--ze server base
	"4-ServerCore/2-ServerUtil/discord.lua",
	"4-ServerCore/2-ServerUtil/VL_IntermissionLock-v1.lua",
	"4-ServerCore/2-ServerUtil/admintools.lua",
	"4-ServerCore/2-ServerUtil/SaveMap.lua",
	"4-ServerCore/2-ServerUtil/LUA_MOTD",
	"4-ServerCore/2-ServerUtil/L_StuffAccounts_1.3f.lua",
} do
    dofile(filename)
end