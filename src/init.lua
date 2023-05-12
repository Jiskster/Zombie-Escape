for _, filename in ipairs{
-- Funny init

	--first thing to load
	"2-ZECore/init/int_spawnobject.lua",
	"2-ZECore/init/int_showhitbox.lua",
	"2-ZECore/init/int_freeslot.lua",
	"2-ZECore/init/int_global.lua",
	"2-ZECore/init/int_ZE_RSNEO.lua",


	--cmds and etc
	"2-ZECore/console/con_timer.lua",
	"2-ZECore/console/con_cvars.lua",
	"2-ZECore/console/con_cmds.lua",
	"2-ZECore/console/con_local.lua",
	
	--main ze code	
	"2-ZECore/maingame/main.lua",
	"2-ZECore/3-Library/colors.lua",
	"2-ZECore/3-Library/inputfeatures.lua",
	"2-ZECore/3-Library/rhealth.lua",
	"2-ZECore/3-Library/rhealth_dmg.lua",
	"2-ZECore/3-Library/playerstats.lua",
	"2-ZECore/3-Library/player.lua",
	"2-ZECore/3-Library/name_tags.lua",
	"2-ZECore/maingame/mapload.lua",
	"2-ZECore/maingame/netvars.lua",
	"2-ZECore/maingame/mobjcollide.lua",
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
	"4-CoreServer/1-MapVote/1_Rawset.lua",
	"4-CoreServer/1-MapVote/2_Console.lua",
	"4-CoreServer/1-MapVote/3_DebugFunctions.lua",
	"4-CoreServer/1-MapVote/4_Functions.lua",
	"4-CoreServer/1-MapVote/5_HUD.lua",
	"4-CoreServer/1-MapVote/6_Main.lua",
	"4-CoreServer/1-MapVote/7_GametypeRegistry.lua",

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
	"4-CoreServer/2-ServerUtil/discord.lua",
	"4-CoreServer/2-ServerUtil/VL_IntermissionLock-v1.lua",
	"4-CoreServer/2-ServerUtil/admintools.lua",
	"4-CoreServer/2-ServerUtil/SaveMap.lua",
	"4-CoreServer/2-ServerUtil/LUA_MOTD",
	"4-CoreServer/2-ServerUtil/L_StuffAccounts_1.3f.lua",
	
	
	"3-Maps/corruptedvoid.lua",
	"3-Maps/minecraftv1.lua",
	"3-Maps/scp.lua",
	"3-Maps/secretlab2.lua",
	"3-Maps/specialstage.lua",
	"3-Maps/stonewood.lua",
	"3-Maps/undertalept1.lua",
} do
    dofile(filename)
end