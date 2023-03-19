local MV = MapVote
local rg = MV.RegisterGametype

--Vanilla modes
rg(GT_COOP,			"Co-Op",		0,	0,	TOL_COOP)
rg(GT_COMPETITION,	"Competition",	0,	0,	TOL_COMPETITION)
rg(GT_RACE,			"Race",			0,	0,	TOL_RACE)
rg(GT_MATCH,		"Match",		0,	0,	TOL_MATCH)
rg(GT_TEAMMATCH,	"Team Match",	0,	0,	TOL_MATCH)
rg(GT_TAG,			"Tag",			0,	0,	TOL_MATCH)
rg(GT_HIDEANDSEEK,	"Hide & Seek",	0,	0,	TOL_MATCH)
rg(GT_CTF,			"CTF",			0,	0,	TOL_CTF)

--These gametypes will auto-register themselves once a custom gametype is added.
addHook("ThinkFrame", do
	rg(GT_ARENA,			"Arena",			0,	0,	TOL_MATCH,	TOL_ARENA)
	rg(GT_TEAMARENA,		"Team Arena",		0,	0,	TOL_MATCH,	TOL_ARENA)
	rg(GT_SURVIVAL,			"Survival",			0,	8,	TOL_SURVIVAL)
	rg(GT_TEAMSURVIVAL,		"Team Survival",	0,	12,	TOL_SURVIVAL)
	rg(GT_CP,				"CP",				0,	0,	TOL_MATCH,	TOL_CP)
	rg(GT_TEAMCP,			"Team CP",			0,	0,	TOL_MATCH,	TOL_CP)
	rg(GT_DIAMOND,			"Diamond",			0,	0,	TOL_MATCH,	TOL_DIAMOND)
	rg(GT_TEAMDIAMOND,		"Team Diamond",		0,	0,	TOL_MATCH,	TOL_DIAMOND)
	rg(GT_BATTLECTF,		"Battle CTF",		0,	0,	TOL_CTF,	TOL_BATTLECTF)
	rg(GT_CHAOS,			"Chaos",			0,	0,	TOL_CHAOS)
	rg(GT_EGGROBOTAG,		"Egg Robo Tag",		0,	0,	TOL_TAG,	TOL_EGGROBOTAG)
	rg(GT_TRON,				"Tron",				0,	0,	TOL_TRON,	TOL_MATCH)
	rg(GT_KOTH,				"KOTH",				0,	0,	TOL_KOTH)//propane (haha get it)
	rg(GT_ROLLOUT_STOCK,	"Rollout Stock",	0,	0,	TOL_ROLLOUT)
	rg(GT_ROLLOUT_TIME,		"Rollout Time",		0,	0,	TOL_ROLLOUT)
	rg(GT_PROPHUNT,			"Prop Hunt",		0,	0,	TOL_PROPHUNT)
	rg(GT_ZESCAPE,			"Zombie Escape",	0,	0,	TOL_ZESCAPE)
end)
	//rg(GT_ZSWARM,			"Zombie Swarm",		0,	0,	TOL_ZSWARM)