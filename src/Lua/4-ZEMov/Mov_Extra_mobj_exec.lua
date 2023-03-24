local ZE = RV_ZESCAPE

addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_RS_THROWNSCATTER)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_RS_THROWNEXPLOSION)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_RS_THROWNAUTOMATIC)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_RS_THROWNBOUNCE)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_REDRING)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_RS_THROWNSEEKER)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_RS_THROWNSPLASH)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_RS_THROWNACCEL)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_RS_THROWNWAVE)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_RS_FLASHSHOT)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_RS_THROWNSTONE)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_RS_THROWNBURST)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_RS_THROWNFLAME)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_RS_THROWNINFINITY)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_RS_SHOT)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_RS_MINISHOT)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_RS_MEGASHOT)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_RS_RAILSHOT)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_CORK)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsProjectileCollide(mo, pmo) end, MT_RS_HS_SHOT)
addHook("MobjMoveCollide", function(mo, pmo) return ZE.ExtraCharsHearthMobjMoveCollide(mo, pmo) end, MT_LHRT)



addHook("MobjCollide", function(mo, pmo) return ZE.ExtraCharsPropMobjCollide(mo, pmo) end, MT_PROPWOOD)
addHook("MobjCollide", function(mo, pmo) return ZE.ExtraCharsPropMobjCollide(mo, pmo) end, MT_PITY_BOX)
addHook("MobjCollide", function(mo, mobj) return ZE.ExtraPropProjectileCollide(mo, mobj) end, MT_PROPWOOD)