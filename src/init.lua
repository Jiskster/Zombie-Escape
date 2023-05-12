for _, filename in ipairs{
-- Funny init

	--first thing to load
	"2-Core/init/int_spawnobject.lua",
	"2-Core/init/int_showhitbox.lua",
	"2-Core/init/int_freeslot.lua",
	"2-Core/init/int_global.lua",
	"2-Core/init/int_ZE_RSNEO.lua",


	--cmds and etc
	"2-Core/console/con_timer.lua",
	"2-Core/console/con_cvars.lua",
	"2-Core/console/con_cmds.lua",
	"2-Core/console/con_local.lua",
	
	--main ze code	
	"2-Core/maingame/main.lua",
	
	"2-Core/healthsystem/rhealth.lua",
	"2-Core/healthsystem/rhealth_dmg.lua",
	"2-Core/healthsystem/rhealth_extra.lua",
	"2-Core/maingame/extrafeatures/name_tags.lua",
	"2-Core/maingame/mapload.lua",
	"2-Core/maingame/netvars.lua",
	"2-Core/maingame/mobjcollide.lua",
	"2-Core/maingame/extrafeatures/radar.lua",
	
	"2-Core/player/playerstats.lua",
	"2-Core/player/player.lua",
	"2-Core/player/propspawn.lua",
	"2-Core/player/misc/ability_milne.lua",
	"2-Core/player/misc/revenger.lua",
	"2-Core/player/misc/unlock.lua",
	"2-Core/player/misc/colors.lua",
	"2-Core/player/misc/inputfeatures.lua",

	"2-Core/hooks/hook_player.lua",
	"2-Core/hooks/hook_main.lua",
	"2-Core/hooks/hook_hud.lua",
	"2-Core/hooks/hook_extrachars.lua",
	"2-Core/hooks/hook_collidehooks.lua",
	

	--mapvote stuff
	"4-CoreServer/1-MapVote/1_Rawset.lua",
	"4-CoreServer/1-MapVote/2_Console.lua",
	"4-CoreServer/1-MapVote/3_DebugFunctions.lua",
	"4-CoreServer/1-MapVote/4_Functions.lua",
	"4-CoreServer/1-MapVote/5_HUD.lua",
	"4-CoreServer/1-MapVote/6_Main.lua",
	"4-CoreServer/1-MapVote/7_GametypeRegistry.lua",

	--Ringslinger neo base
    "1-RingslingerNeo/Rawset.lua",
	"1-RingslingerNeo/Console.lua",
	"1-RingslingerNeo/Sounds.lua",
	"1-RingslingerNeo/WeaponMobjs.lua",
	"1-RingslingerNeo/WeaponHooks.lua",
	"1-RingslingerNeo/WeaponHooks.lua",
	"1-RingslingerNeo/Weapons.lua",
	"1-RingslingerNeo/PowerupMobjs.lua",
	"1-RingslingerNeo/Powerups.lua",
	"1-RingslingerNeo/AmmoRingMobj.lua",
	"1-RingslingerNeo/AmmoRingHooks.lua",
	"1-RingslingerNeo/Skins.lua",
	"1-RingslingerNeo/HUDHooks.lua",
	"1-RingslingerNeo/PlayerHooks.lua",
	"1-RingslingerNeo/HurtMsgHooks.lua",
	"1-RingslingerNeo/NewRingExplode.lua",
	"1-RingslingerNeo/RocketForce.lua",
	
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