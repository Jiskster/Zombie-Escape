freeslot("TOL_ZESCAPE",
"sfx_bstup", "sfx_bstdn","sfx_inf1", "sfx_inf2", "sfx_secret", "sfx_expl", "sfx_zatk1", 
"sfx_rstart","sfx_zszm1", "sfx_zszm2", "sfx_zszm3","sfx_swstt","sfx_wav1","sfx_wav2","sfx_wav3", "sfx_zsded",
"sfx_rscp",
"sfx_noface",
"sfx_ston",
"sfx_lkme",
"sfx_scpd",
"sfx_bh",
"sfx_amb1",
"sfx_amb2",
"sfx_amb3",
"sfx_amb4",
"sfx_amb5",
"sfx_amb6",
"sfx_amb7",
"sfx_amb8",
"sfx_amb9",
"sfx_scpdr",
"sfx_tesla1",
"sfx_samb1",
"sfx_samb2",
"sfx_samb3",
"sfx_samb4",
"sfx_samb5",
"sfx_salrm",
"sfx_srdio",
"sfx_elvr",
"MT_PROPWOOD","MT_MEGAHP",
"S_PROP1","S_PROP1_BREAK",
"SPR_WPRP"
)

mobjinfo[MT_PROPWOOD] = {
    sprite = SPR_WPRP,
	spawnstate = S_PROP1,
	painstate = S_PROP1,
	painsound = sfx_dmpain,
	deathstate = S_PROP1_BREAK,
	deathsound = sfx_wbreak,
	spawnhealth = 50,
	speed = 0,
	radius = 96*FRACUNIT,
	height = 138*FRACUNIT,
	flags = MF_SHOOTABLE|MF_SOLID,
}

states[S_PROP1] = {
	nextstate = S_PROP1,
	sprite = SPR_WPRP,
	frame = FF_FULLBRIGHT,
	tics = 2
}

states[S_PROP1_BREAK] = {
	nextstate = S_NULL,
	sprite = SPR_WPRP,
	action = A_Scream,
	frame = B,
	tics = 2
}

sfxinfo[sfx_zsded] = {
        flags = SF_X8AWAYSOUND|SF_X4AWAYSOUND|SF_X2AWAYSOUND
}