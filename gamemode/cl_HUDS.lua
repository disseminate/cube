include('shared.lua')

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function hidehud(name)
	for k, v in pairs{"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"} do 
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "hidehud", hidehud) 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function DrawPlayerInfo()

	local tr = util.TraceLine(util.GetPlayerTrace(LocalPlayer()))
	
	if (tr.Entity:IsValid() and tr.Entity:IsPlayer()) then
		local PlayerName = tostring( tr.Entity:Nick() );
		local PlayerHealth = tostring( "Health: " .. tr.Entity:Health() );
		local PlayerBoots = tostring( "Boots: " .. tr.Entity:GetAmmoCount( "gravity" ) );
		
		draw.SimpleText(PlayerName, "Default", ScrW()/2, ScrH()/2 - 75, Color(255,255,255,255),1,1)
		draw.SimpleText(PlayerHealth, "Default", ScrW()/2, ScrH()/2 - 60, Color(255,255,255,255),1,1)
		draw.SimpleText(PlayerBoots, "Default", ScrW()/2, ScrH()/2 - 45, Color(255,255,255,255),1,1)
	end
	
end

function DrawDmgDisplay()
	
	if( ValidEntity( LocalPlayer() ) ) then
	
		if( not LocalPlayer():Alive() ) then return; end

		if( LocalPlayer():Health() <= 70 ) then
			
			DrawMotionBlur( .425, 1.0, 0 );
			
			if( LocalPlayer():Health() <= 40 ) then
		
				local blurmul = 0;
				local cutoff = 50;
			
				if( LocalPlayer():Health() <= 30 ) then
					cutoff = 120;
				end
			
				if( LocalPlayer():Health() <= 20 ) then
					cutoff = 200;
				end	
			
				blurmul = 1 - math.Clamp( LocalPlayer():Health() / cutoff, 0, 1 );
				DrawMotionBlur( .149 * blurmul, .955 * blurmul, .068 * blurmul );
			
			end
			
			surface.SetDrawColor( 135, 0, 0, 160 * ( 1 - math.Clamp( LocalPlayer():Health() / 50, 0, 1 ) ) );
			surface.DrawRect( 0, 0, ScrW(), ScrH() );
		
		end
		
	end
	
end

function DrawCinematics()
	
	if( CurTime() - LocalPlayer():GetNWInt( "JoinTime" ) <= 1 ) then -- Fading black
		
		local n = CurTime() - LocalPlayer():GetNWInt( "JoinTime" );
		
		n = n * 255;
		n = n * -1;
		n = n + 255;
		n = math.Clamp( n, 0, 255 );
		surface.SetDrawColor( 0, 0, 0, n );
		
		surface.DrawRect( 0, 0, ScrW(), ScrH() );
		
	end
	
	if( CurTime() - LocalPlayer():GetNWInt( "JoinTime" ) <= 3 ) then -- Initial spawn black lines
		
		surface.SetDrawColor( 0, 0, 0, 255 );
		
		surface.DrawRect( 0, 0, ScrW(), ScrH() / 10 );
		surface.DrawRect( 0, ScrH() - ScrH() / 10, ScrW(), ScrH() / 10 );
		
	elseif( CurTime() - LocalPlayer():GetNWInt( "JoinTime" ) <= 5 ) then -- Black lines scroll offscreen
	
		local n = CurTime() - LocalPlayer():GetNWInt( "JoinTime" ) - 3;
		local m = ScrH()/10; -- Just a value to be caught by math.Clamp
		n = n * m;
		n = n * -1;
		n = n + 200;
		n = math.Clamp( n, 1, ScrH()/10 );
		
		surface.SetDrawColor( 0, 0, 0, 255 );
		
		surface.DrawRect( 0, 0, ScrW(), n );
		surface.DrawRect( 0, ScrH() - n, ScrW(), n );
		
	end
	
	if( LocalPlayer():GetNWInt( "ModCinematic" ) == 1 or LocalPlayer():Alive() == false ) then -- Other black lines
	    
		surface.SetDrawColor( 0, 0, 0, 255 );
		
		surface.DrawRect( 0, 0, ScrW(), ScrH() / 10 );
		surface.DrawRect( 0, ScrH() - ScrH() / 10, ScrW(), ScrH() / 10 );
		
	end
	
end

function DrawFilmGrain()
	
	if( LocalPlayer():GetNWInt( "ModCinematic" ) == 1 ) then
	
		local Grains = {}
		for _, filename in pairs(file.Find("../materials/filmgrain/filmgrain?.vtf")) do
			table.insert(Grains, surface.GetTextureID("filmgrain/"..string.sub(filename, 1, -5)))
		end
		
		surface.SetTexture(Grains[math.random(1, #Grains)]);
		surface.SetDrawColor(225, 225, 225, 2.25)
		
		for x=0, ScrW(), 1024 do
			for y=0, ScrH(), 512 do
				surface.DrawTexturedRect(x, y, 1024, 512);
			end
		end
		
	end
	
end

function GM:HUDPaint()

	DrawPlayerInfo();	
	DrawDmgDisplay();
	DrawCinematics();
	DrawFilmGrain();
	
end
