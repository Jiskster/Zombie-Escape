freeslot(
"MT_RS_AMMO",
"S_RS_AMMO"
)

mobjinfo[MT_RS_AMMO] = {
	spawnstate = S_RS_AMMO,
	deathstate = S_SPRK1,
	radius = 16*FRACUNIT,
	height = 24*FRACUNIT,
	flags = MF_SPECIAL|MF_NOGRAVITY|MF_NOCLIPHEIGHT
}
states[S_RS_AMMO] = {
	sprite = SPR_TRNG,
	frame = A|FF_ANIMATE|FF_FULLBRIGHT,
	var1 = 23,
	var2 = 1,
	tics = -1
}