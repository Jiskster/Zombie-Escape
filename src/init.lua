for _, filename in ipairs{
-- Funny init

	--first thing to load
	"2-ZECore/1-Init/int_spawnobject.lua",
	"2-ZECore/1-Init/int_showhitbox.lua",
	"2-ZECore/1-Init/int_freeslot.lua",
	"2-ZECore/1-Init/int_global.lua",
	"2-ZECore/1-Init/int_ZE_RSNEO.lua",


	--cmds and etc
	"2-ZECore/2-Console/con_timer.lua",
	"2-ZECore/2-Console/con_cvars.lua",
	"2-ZECore/2-Console/con_cmds.lua",
	"2-ZECore/2-Console/con_local.lua",
	
	--main ze code	
	"2-ZECore/3-Library/main.lua",
	"2-ZECore/3-Library/colors.lua",
	"2-ZECore/3-Library/inputfeatures.lua",
	"2-ZECore/3-Library/rhealth.lua",
	"2-ZECore/3-Library/rhealth_dmg.lua",
	"2-ZECore/3-Library/playerstats.lua",
	"2-ZECore/3-Library/player.lua",
	"2-ZECore/3-Library/name_tags.lua",
	"2-ZECore/3-Library/mapload.lua",
	"2-ZECore/3-Library/netvars.lua",
	"2-ZECore/3-Library/mobjcollide.lua",
	"2-ZECore/3-Library/propspawn.lua",
	"2-ZECore/3-Library/radar.lua",
	"2-ZECore/3-Library/ability_milne.lua",
	"2-ZECore/3-Library/rhealth_extra.lua",
	"2-ZECore/3-Library/revenger.lua",
	"2-ZECore/3-Library/antibounce.lua",
	"2-ZECore/3-Library/unlock.lua",

	"2-ZECore/4-Execute/Exec_ZE_Player.lua",
	"2-ZECore/4-Execute/Exec_ZE_Main.lua",
	"2-ZECore/4-Execute/Exec_ZE_HUD.lua",
	"2-ZECore/4-Execute/Exec_ZE_ExtraChars.lua",

	--mapvote stuff
	"3-ServerCore/1-MapVote/1_Rawset.lua",
	"3-ServerCore/1-MapVote/2_Console.lua",
	"3-ServerCore/1-MapVote/3_DebugFunctions.lua",
	"3-ServerCore/1-MapVote/4_Functions.lua",
	"3-ServerCore/1-MapVote/5_HUD.lua",
	"3-ServerCore/1-MapVote/6_Main.lua",
	"3-ServerCore/1-MapVote/7_GametypeRegistry.lua",

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
	
	"4-ZEMov/Mov_ZE_mobj.lua",
	
	--ze server base
	"3-ServerCore/2-ServerUtil/discord.lua",
	"3-ServerCore/2-ServerUtil/VL_IntermissionLock-v1.lua",
	"3-ServerCore/2-ServerUtil/admintools.lua",
	"3-ServerCore/2-ServerUtil/SaveMap.lua",
	"3-ServerCore/2-ServerUtil/LUA_MOTD",
	"3-ServerCore/2-ServerUtil/L_StuffAccounts_1.3f.lua",
	
	
	"5-Maps/corruptedvoid.lua",
	"5-Maps/minecraftv1.lua",
	"5-Maps/scp.lua",
	"5-Maps/secretlab2.lua",
	"5-Maps/specialstage.lua",
	"5-Maps/stonewood.lua",
	"5-Maps/undertalept1.lua",
} do
    dofile(filename)
end