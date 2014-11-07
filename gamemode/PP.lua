AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

function GM:PlayerSpawnedProp(pl, mdl, ent)
	return false
end

function GM:PlayerDisconnected(pl)
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint(pl:Nick().." has left the game.")
	end
end

function GM:PlayerSpawnNPC( pl, npc, swep )
	return pl:IsAdmin() or LocalPlayer():IsSuperAdmin()
end

function GM:PlayerSpawnSENT( pl, sent )
	return pl:IsAdmin() or LocalPlayer():IsSuperAdmin()
end

function GM:PlayerSpawnSWEP( pl, swep )
	return pl:IsAdmin() or LocalPlayer():IsSuperAdmin()
end

function GM:PlayerGiveSWEP( pl, class, swep )
	return pl:IsAdmin() or LocalPlayer():IsSuperAdmin()
end

function GM:PlayerSpawnEffect( pl, mdl )
	return pl:IsAdmin() or LocalPlayer():IsSuperAdmin()
end

function GM:PlayerSpawnVehicle( pl, propid )
	return pl:IsAdmin() or LocalPlayer():IsSuperAdmin()
end

function GM:PlayerSpawnProp(pl, mdl)
	return pl:IsAdmin() or LocalPlayer():IsSuperAdmin()
end