local meta = FindMetaTable( "Player" );

function GM:ShowHelp(pl)
	umsg.Start( "OpenHelp", pl );
	umsg.End();
end


function GM:PlayerSay( ply, text, toall )
	
	return text;
	
end


function GM:PlayerInitialSpawn(pl)
	
	pl:SetNWInt( "JoinTime", CurTime() );
	pl:SetNWInt( "ModCinematic", 0 );
	pl:SetNWInt( "lastreplacechat", 0 );
	pl:StripWeapons()
	pl:RemoveAllAmmo()
	pl:Give( "weapon_hands" );
	pl:Give( "weapon_boot" );
	pl:Give( "weapon_suicidegun" );
	if( pl:IsAdmin() or pl:IsSuperAdmin() or pl:IsDiss() ) then
		pl:Give( "weapon_physgun" );
		pl:Give( "weapon_physcannon" );
	end
	pl:SelectWeapon( "weapon_hands" );
	
	timer.Create( "AutoRegen" .. tostring(pl:UserID()), 2, 0, function() pl:SetHealth( math.Clamp( pl:Health() + 2, 0, 100 ) ) end );
	
	local sex = math.random( 1, 2 );
	if( sex == 1 ) then
		pl:SetModel( "models/Humans/Group01/male_0" .. tostring( math.random( 1, 9 ) ) .. ".mdl" );
	else
		local num = math.random( 1, 7 );
		if( num == 5 ) then num = 4 end
		pl:SetModel( "models/Humans/Group01/female_0" .. tostring( num ) .. ".mdl" );
	end
	
end

function GM:PlayerSpawn(pl)

	pl:StripWeapons()
	pl:RemoveAllAmmo()
	pl:Give( "weapon_hands" );
	pl:Give( "weapon_boot" );
	pl:Give( "weapon_suicidegun" );
	if( pl:IsAdmin() or pl:IsSuperAdmin() or pl:IsDiss() ) then
		pl:Give( "weapon_physgun" );
		pl:Give( "weapon_physcannon" );
	end
	pl:SelectWeapon( "weapon_hands" );
	
	local sex = math.random( 1, 2 );
	if( sex == 1 ) then
		pl:SetModel( "models/Humans/Group01/male_0" .. tostring( math.random( 1, 9 ) ) .. ".mdl" );
	else
		local num = math.random( 1, 7 );
		if( num == 5 ) then num = 4 end
		pl:SetModel( "models/Humans/Group01/female_0" .. tostring( num ) .. ".mdl" );
	end
	
	local SpawnPoints = {
	
		Vector( 7731.843750, 848.062500, -3567.968750 ),
		Vector( 7729.781250, 696.750000, -3567.968750 ),
		Vector( 7440.031250, 563.812500, -3567.968750 ),
		Vector( 7444.500000, 850.281250, -3567.968750 ),
		Vector( 7160.812500, 986.906250, -3567.968750 ),
		Vector( 7297.125000, 552.343750, -3567.968750 ),
		Vector( 7306.781250, 861.937500, -3567.968750 ),
		Vector( 7613.781250, 679.500000, -3567.968750 ),
		Vector( 7593.250000, 839.125000, -3567.968750 ),
		Vector( 6739.000000, 688.468750, -3567.968750 ),
		Vector( 7725.187500, 973.187500, -3567.968750 )
		
	}
	
	pl:SetPos( SpawnPoints[ math.random( 1, #SpawnPoints) ] );
	
end

function ReplaceChat( ply, text )
	
	if( CurTime() > ply:GetNWInt( "lastreplacechat" ) + 5 ) then
	
	if( string.find( text, "overhere" ) or string.find( text, "over here" ) ) then
		ply:EmitSound( Sound("vo/npc/male01/overhere01.wav") );
		return "";
	elseif( string.find( text, "help" ) or string.find( text, "alert" ) ) then
		ply:EmitSound( Sound("vo/npc/male01/help01.wav") );
		return "";
	end
	ply:SetNWInt( "lastreplacechat", CurTime() );
	
	end
	
end
hook.Add( "PlayerSay", "ReplaceChat", ReplaceChat );

function GM:PlayerSpray( ply )
    return true; -- no cheating, cheaters
end

function ShiftCubes()

	util.ScreenShake(Vector(7218.156250,74.906250,-3831.625000), math.random(100,1000), math.random(100,200), math.random(5,12), 2300); -- Shake everywhere (people within 2300 of cube center) between 5 and 12 s
	for k, v in pairs( player.GetAll() ) do
		for n, m in pairs( ents.FindInSphere( Vector(7218.156250,74.906250,-3831.625000), 2300 ) ) do
			if( v == m ) then
				local shift = Sound( "cubeshift.mp3" );
				v:ConCommand( "play " .. shift .. "\n" );
				v:SetVelocity( Vector( math.random(-300,300), math.random(-300,300), math.random(-300,300) ) ); -- WWWHEEEEEEEE
			end
		end
	end
	
end
timer.Create( "ShiftCubes", 90, 0, ShiftCubes );

function RemoveFallDamage( ent, inflictor, attacker, amount, dmginfo )
	
	if ( ent:IsPlayer() and dmginfo:IsFallDamage() ) then
		
		if( amount == 10 ) then -- one cube
		
			dmginfo:SetDamage( 0 );
			
		end
		
	end
	
end
hook.Add( "EntityTakeDamage", "RemoveFallDamage", RemoveFallDamage )

function GetPlayerbyNick( name )

	local ply = nil;
	local count = 0;
	
	for k, v in pairs(player.GetAll()) do
	
		if(string.find(v:Nick(), name) != nil) then
			
				ply = v;
				
		end
			
	end
	
	return ply;
	
end


function GM:PlayerNoClip(pl)
	return pl:IsSuperAdmin() or pl:IsDiss()
end

SURVIVALMODE = 0;
function GM:PlayerDeathThink(pl)
	
	pl:Spectate( OBS_MODE_IN_EYE );
	
	if ( pl:KeyPressed( IN_ATTACK ) || pl:KeyPressed( IN_ATTACK2 ) || pl:KeyPressed( IN_JUMP ) ) then
		
		if( SURVIVALMODE == 0 ) then
			pl:Spawn()
			pl:UnSpectate();
		else
			local target = player.GetAll()[math.random( 1, #player.GetAll() )];
			pl:SpectateEntity( target );
		end
		
	end
	
end

function GM:PhysgunPickup( ply, ent )
	return true; -- They've got physgun, thus they are admin and can do anything with
end

function meta:IsDiss()

	if( self:SteamID() == "STEAM_0:0:17359435" ) then
		return true;
	end
	return false;
	
end
