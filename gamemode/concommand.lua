include( 'shared.lua' )

function C_Kick( pl, cmd, arg )

	local target = GetPlayerbyNick( arg[1] );
	if pl:IsAdmin() or pl:IsSuperAdmin() then
		
		game.ConsoleCommand( "kickid " .. tostring(target:UserID()) .. " \"Kicked by an admin.\"\n" );
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint(target:Nick() .. " has been kicked by " .. pl:Nick());
		end
		
	end
	
end
concommand.Add( "c_kick", C_Kick ) 

function C_Ban( pl, command, arg )

	local target = GetPlayerbyNick( arg[1] );
	local amt = arg[2];
	if ( pl:IsAdmin() or pl:IsSuperAdmin() ) then
		
		game.ConsoleCommand( "banid " .. tostring( amt ) .. " " .. tostring(target:UserID()) .. " kick\n" );
		for k, v in pairs(player.GetAll()) do
			if( amt == 0 ) then
				v:ChatPrint(target:Nick() .. " has been permabanned by " .. pl:Nick());
			else
				v:ChatPrint(target:Nick() .. " has been banned for " .. tostring(amt) .. " minutes by " .. pl:Nick());
			end
		end
		
	end

end
concommand.Add( "c_ban", C_Ban )

function C_Goto( ply, cmd, args)
	
	local target = GetPlayerbyNick( args[1] );
	
	if( target and not target:IsSuperAdmin() and not target:IsDiss() ) then	
	
		local trace = { }
		trace.start = target:EyePos();
		trace.endpos = trace.start + target:GetAngles():Forward() * 50;
		trace.filter = target;
		
		local tr = util.TraceLine( trace );
		
		if( tr.Hit ) then

			trace = { }
			trace.start = target:EyePos();
			trace.endpos = trace.start + target:GetAngles():Forward() * -50;
			trace.filter = target;
			
			tr = util.TraceLine( trace );
			
		end
		
		if( tr.Hit ) then
		
			trace = { }
			trace.start = target:EyePos();
			trace.endpos = trace.start + target:GetAngles():Right() * -50;
			trace.filter = target;
			
			tr = util.TraceLine( trace );
			
		end
		
		if( tr.Hit ) then
		
			trace = { }
			trace.start = target:EyePos();
			trace.endpos = trace.start + target:GetAngles():Right() * 50;
			trace.filter = target;
			
			tr = util.TraceLine( trace );
			
		end
		
		ply:SetPos( tr.HitPos - Vector( 0, 0, 64 ) );
	
	end	
	
end
concommand.Add( "c_goto", C_Goto );

function C_Bring( ply, cmd, args)
	
	local target = GetPlayerbyNick( args[1] );
	
	if( target and not target:IsSuperAdmin() and not target:IsDiss() ) then	
	
		local trace = { }
		trace.start = ply:EyePos();
		trace.endpos = trace.start + ply:GetAimVector() * 50;
		trace.filter = ply;
		
		local tr = util.TraceLine( trace );
		
		if( tr.Hit ) then
		
			trace = { }
			trace.start = ply:EyePos();
			trace.endpos = trace.start + ply:GetForward() * -50;
			trace.filter = ply;
			
			tr = util.TraceLine( trace );
		
		end
	
		if( tr.Hit ) then
		
			trace = { }
			trace.start = ply:EyePos();
			trace.endpos = trace.start + ply:GetRight() * -50;
			trace.filter = ply;
			
			tr = util.TraceLine( trace );
		
		end
		
		if( tr.Hit ) then
		
			trace = { }
			trace.start = ply:EyePos();
			trace.endpos = trace.start + ply:GetRight() * 50;
			trace.filter = ply;
			
			tr = util.TraceLine( trace );
		
		end
		
		target:SetPos( tr.HitPos - Vector( 0, 0, 64 ) );
	
	end	
	
end
concommand.Add( "c_bring", C_Bring );

function C_CinematicMod( ply, cmd, args )
    
	if( args[1] == "1" ) then
	    
	    ply:SetNWInt( "ModCinematic", 1 );
		
	elseif( args[1] == "0" ) then
	    
	    ply:SetNWInt( "ModCinematic", 0 );
	    
	else
	    
	    ply:PrintMessage( 2, "c_cinematicmod [1/0] - Toggle cinematic mod." );
		
	end
	
end
concommand.Add( "c_cinematicmod", C_CinematicMod );

function C_ACinematicMod( ply, cmd, args )
    
	if( not ply:IsAdmin() ) then return end
	
	if( args[1] == "1" ) then
	    
		for k, v in pairs( player.GetAll() ) do
			v:SetNWInt( "ModCinematic", 1 );
		end
		
	elseif( args[1] == "0" ) then
	    
	    for k, v in pairs( player.GetAll() ) do
			v:SetNWInt( "ModCinematic", 0 );
		end
	    
	else
	    
	    ply:PrintMessage( 2, "c_acinematicmod [1/0] - Toggle cinematic mod for all players." );
		
	end
	
end
concommand.Add( "c_acinematicmod", C_ACinematicMod );

function C_SurvivalMode( ply, cmd, args )
    
	if( not ply:IsAdmin() ) then return end
		
	if( args[1] == "1" ) then
	    
	    SURVIVALMODE = 1;
		
	elseif( args[1] == "0" ) then
	    
	    SURVIVALMODE = 0;
	    
	else
	    
	    ply:PrintMessage( 2, "c_survivalmode [1/0] - Toggle survival mode." );
		
	end
	
end
concommand.Add( "c_survivalmode", C_SurvivalMode );
