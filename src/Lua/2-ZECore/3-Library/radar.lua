local test = 0

//Colors
local c_white = 0
local c_silver = 6
local c_black = 31
local c_blue = 149
local c_darkblue = 154
local c_red = 34
local c_darkred = 40
local c_yellow = 72
local c_orange = 56
local c_green = 102
local c_purple = 180
local c_darkpurple = 184
local c_border = 27 //Color for radar borders
local color = c_white //Currently selected color
local bo = 2 //border offset

local function hudstuff(v, user, cam)
	if not(multiplayer)
	    or user.ctfteam == 2
		or maptol&TOL_NIGHTS
		or (gametype == GT_HIDEANDSEEK and user.pflags&PF_TAGIT)
		then return
	end
	if (gametype ~= GT_ZESCAPE) return end //easy way though this is gonna make me copy this again for the radar in sp but i don't really care
	local umo = user.mo
	if umo == nil 
		then return
	end	
-- 	local test = user.rings
	//Setup radar
	local xscale = v.dupx()
	local yscale = v.dupx()
-- 	local unit = user.mo.scale
	local unit = FRACUNIT
	local radius = 152*24
	local fullsight = 152*64
	local radarsize = 64*xscale
	if gametype <= GT_COOP then
-- 		radius = 128*16
-- 		fullsight = 128*32
		radarsize = $*2/3
-- 		if splitscreen then return nil end
	end
	local hradius = radius
	if splitscreen then radarsize = $*2/3 end
	local center = radarsize/2
	
	//Alignment
-- 	local xpos = 8 //Left corner
-- 	local xpos = v.width()/v.dupx()-radarsize-16 //Right corner
	local xpos = v.width()-radarsize-8*xscale //Right corner
	local ypos = 8*yscale //Top corner
-- 	local ypos = 8 //Top corner
-- 	local ypos = v.height()/yscale-radarsize-32 //Bottom corner
	if splitscreen then //2-Player offsets
		ypos = $/2
		if user == secondarydisplayplayer then
			ypos = $+v.height()/2
		end
	end
	local xpos2 = xpos+radarsize-xscale
	local ypos2 = ypos+radarsize-yscale
	//Draw radar box
-- 	v.drawFill(xpos,ypos,radarsize,radarsize,c_black)
	v.drawFill(xpos,ypos,radarsize,radarsize,c_black|V_NOSCALESTART)
	//Draw borders
	v.drawFill(xpos+xscale,ypos+yscale,radarsize-xscale*2,yscale,c_border|V_NOSCALESTART) //Top border
	v.drawFill(xpos+xscale,ypos2-yscale,radarsize-xscale*2,yscale,c_border|V_NOSCALESTART) //Bottom border
	v.drawFill(xpos+xscale,ypos+yscale,xscale,radarsize-yscale*2,c_border|V_NOSCALESTART) //Left border
	v.drawFill(xpos2-xscale,ypos+yscale,xscale,radarsize-yscale*2,c_border|V_NOSCALESTART) //Right border
	
	if gametype > GT_RACE then
	//Search mobj and draw coordinates
		searchBlockmap("objects",function (umo,mo)
			if mo == nil or not(mo.health) then return nil end 
			local dist = R_PointToDist2(umo.x,umo.y,mo.x,mo.y)
			local zdist = abs(mo.z-umo.z)
			local flash1 = not(leveltime&15)
			local flash2 = not(leveltime&4)
			local size = xscale*2
			if splitscreen then 
				size = $*2/3
			end
			//Distance check
			if dist > fullsight*unit then return nil
			//Players
			elseif mo.type == MT_PLAYER then
				if mo.player.spectator then return nil end
				if gametype == GT_ZESCAPE
					local it = mo.player.ctfteam == 1
					local notmyteam = mo.player.ctfteam == 1
					if notmyteam and flash2 then
						color = c_yellow
					elseif it then
						color = c_red
					else
						color = c_blue
					end
				end
			//Badniks and bosses
			/*
			elseif mo.flags&MF_ENEMY
				then color = c_darkred
			elseif mo.flags&MF_BOSS
				then
				size = $*3/2
				color = c_darkred
			*/
			//Item pickups
	-- 		elseif (mo.flags&MF_MONITOR) and mo.health and not(mo.type == MT_RING_BOX) then color = c_green
			elseif (mo.type >= MT_BOUNCEPICKUP and mo.type <= MT_GRENADEPICKUP) then
				color = c_green
-- 				size = $*2/3
			elseif (mo.type == MT_TOKEN or (mo.type <= MT_EMERHUNT and mo.type >= MT_EMERALD1))
				if not(flash1) then color = c_orange
				else color = c_yellow
				end
-- 				size = $*2/3
			/*
			//Starpost
			elseif (mo.type == MT_STARPOST) then 
				if not(flash1) then color = c_purple
				else color = c_yellow
				end
			//Goalsign
			elseif (mo.type == MT_SIGN) then 
				if not(flash2) then color = c_purple
				else color = c_yellow
				end
			*/
			//CTF Flags
			elseif mo.type == MT_REDFLAG then
				if not(flash1) and not(mo.fuse and flash2) then
					color = c_darkred
				else 
					color = c_yellow
				end
-- 				size = $*2/3
			elseif mo.type == MT_BLUEFLAG then
				if not(flash1) and not(mo.fuse and flash2) then
					color = c_darkblue
				else
					color = c_yellow
				end
-- 				size = $*2/3
			else return nil
			end
	 		if zdist > hradius*unit then size = $*2/3 end
			local angle = umo.angle-R_PointToAngle2(umo.x,umo.y,mo.x,mo.y)+ANGLE_270
			local x = P_ReturnThrustX(nil,angle,dist)/unit*center/radius
			local y = P_ReturnThrustY(nil,angle,dist)/unit*center/radius
			local pushr = bo*xscale
			local pushl = bo*xscale
			if x <= -center+pushr or x >= center-pushl or y <= -center+pushr or y >= center-pushl then
				size = $/2
				x = max(pushr-center,min($,center-pushl))
				y = max(pushr-center,min($,center-pushl))
			end
			v.drawFill(xpos+x+center-size/2,ypos+y+center-size/2,size,size,color|V_NOSCALESTART)
	-- 		print(color)
			return nil
		end,umo,umo.x-fullsight*unit,umo.x+fullsight*unit,umo.y-fullsight*unit,umo.y+fullsight*unit)
	else
		for player in players.iterate
			local mo = player.mo
			if mo == nil or mo == umo or player.spectator or not(mo.health)
				then continue
			else color = c_blue
			end
			local size = xscale*2
			local dist = R_PointToDist2(umo.x,umo.y,mo.x,mo.y)
			local angle = umo.angle-R_PointToAngle2(umo.x,umo.y,mo.x,mo.y)+ANGLE_270
			local x = P_ReturnThrustX(nil,angle,dist)/unit*center/radius
			local y = P_ReturnThrustY(nil,angle,dist)/unit*center/radius
			local pushr = bo*xscale
			local pushl = bo*xscale
			if x <= -center+pushr or x >= center-pushl or y <= -center+pushr or y >= center-pushl then
				size = $/2
				x = max(pushr-center,min($,center-pushl))
				y = max(pushr-center,min($,center-pushl))
			end
			v.drawFill(xpos+x+center-size/2,ypos+y+center-size/2,size,size,color|V_NOSCALESTART)
		end
	end
	//Draw self coordinates
	v.drawFill(xpos+center-xscale/2,ypos+center-yscale/2,xscale,yscale,c_white|V_NOSCALESTART)
end
hud.add(hudstuff, player)