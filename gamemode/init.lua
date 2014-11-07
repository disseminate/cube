
AddCSLuaFile("shared.lua")
include( 'shared.lua' )
include( 'Players.lua' )
include( "client_resources.lua" )
include( "animations.lua" );
include( "concommand.lua" );
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_HUDS.lua")
AddCSLuaFile("cl_Score.lua")
AddCSLuaFile("cl_help.lua")

DeriveGamemode( "base" );
GM.Name = "Cube 1.11";

/*---------------------------------------------------------
   Name: gamemode:Initialize( )
   Desc: Called immediately after starting the gamemode 
---------------------------------------------------------*/
function GM:Initialize( )

	GAMEMODE.Name = "Cube 1.11";

end


/*---------------------------------------------------------
   Name: gamemode:InitPostEntity( )
   Desc: Called as soon as all map entities have been spawned
---------------------------------------------------------*/
function GM:InitPostEntity( )	
end


/*---------------------------------------------------------
   Name: gamemode:Think( )
   Desc: Called every frame
---------------------------------------------------------*/
function GM:Think( )
end


/*---------------------------------------------------------
   Name: gamemode:ShutDown( )
   Desc: Called when the Lua system is about to shut down
---------------------------------------------------------*/
function GM:ShutDown( )
end

/*---------------------------------------------------------
   Name: gamemode:DoPlayerDeath( )
   Desc: Carries out actions when the player dies 		 
---------------------------------------------------------*/
function GM:DoPlayerDeath( ply, attacker, dmginfo )
	
	if( attacker:IsPlayer() ) then
		
		ply:CreateRagdoll();
		
	else
		
		local gore = {
			
			"models/props_junk/watermelon01_chunk02a.mdl",
			"models/props_junk/watermelon01_chunk01b.mdl"
			
		}
		
		local pos = ply:GetPos();
		local amt = math.random( 7, 11 );
		for i = 1 , amt do
		
			local k = ents.Create( "prop_physics" );
			k:SetModel( gore[ math.random( 1, #gore ) ] );
			k:SetPos( Vector( pos.x + math.random( -10, 10 ), pos.y + math.random( -10, 10 ), pos.z + math.random( -10, 10 ) ) );
			k:SetMaterial( "models/flesh" );
			k:Spawn();
			k:SetCollisionGroup( COLLISION_GROUP_DEBRIS ) -- no more glitch
			local function RemoveGore()
				if( k ) then
					k:Remove();
				end
			end
			timer.Simple( 60, RemoveGore );
			
		end
		
	end
	
end


/*---------------------------------------------------------
   Name: gamemode:EntityTakeDamage( entity, inflictor, attacker, amount, dmginfo )
   Desc: The entity has received damage	 
---------------------------------------------------------*/
function GM:EntityTakeDamage( ent, inflictor, attacker, amount, dmginfo )
end


/*---------------------------------------------------------
   Name: gamemode:CreateEntityRagdoll( entity, ragdoll )
   Desc: A ragdoll of an entity has been created
---------------------------------------------------------*/
function GM:CreateEntityRagdoll( entity, ragdoll )
end


// Set the ServerName every 2 seconds in case it changes..
local function HostnameThink()

	SetGlobalString( "ServerName", GetConVarString( "hostname" ) )

end

timer.Create( "HostnameThink", 2, 0, HostnameThink )

/*---------------------------------------------------------
	Show the default team selection screen
---------------------------------------------------------*/
function GM:ShowTeam( ply )

	if (!self.TeamBased) then return end
	
	// For clientside see cl_pickteam.lua
	ply:SendLua( "GAMEMODE:ShowTeam()" )

end
