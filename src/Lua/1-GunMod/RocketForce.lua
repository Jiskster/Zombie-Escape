RingSlinger.RocketForce = function(mo, strength)
	for player in players.iterate
		if player.playerstate != PST_LIVE or not (player.mo and player.mo.valid)
			return
		end
		local pmo = player.mo
		local diffx = pmo.x - mo.x
		local diffy = pmo.y - mo.y
		local diffz = (pmo.z + pmo.height/2) - mo.z
		local distxy = R_PointToDist2(0, 0, diffx, diffy)
		local xyang = R_PointToAngle2(0, 0, diffx, diffy)
		local zang = R_PointToAngle2(0, 0, distxy, diffz)
		local dist = R_PointToDist2(0, 0, distxy, diffz)
		local maxdist = 192*FRACUNIT
		if dist <= maxdist and mo.target == player.mo
			S_StartSound(pmo, sfx_rs_rj)
			local force = FixedMul(mo.scale, min(FRACUNIT, FRACUNIT*8/7 - (dist/192))) * strength
			local thrustxy = P_ReturnThrustX(nil, zang, force)
			local thrustz = P_ReturnThrustY(nil, zang, force) * 3/4
			P_Thrust(pmo, xyang, thrustxy)
			pmo.momz = $ + thrustz
		end
	end
end