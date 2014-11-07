include('shared.lua')

function HelpWindow( um )

	local model_final = "";
	
	local CharCreatePanel = vgui.Create( "DFrame" );
	
	local xs = 300;
	local ys = 400;
	
	CharCreatePanel:SetPos( ( ScrW() - xs ) / 2, ( ScrH() - ys ) / 2 );
	CharCreatePanel:SetSize( xs, ys );
	CharCreatePanel:SetTitle( "Cube Help" );
	CharCreatePanel:MakePopup();
	
	local lines = {
	
		"Cube was a movie made in 1997. 6 strangers",
		"wake up in a 14ft^3 cube together. Nobody",
		"remembers how they got there, why they",
		"were put there, nor who put them there.",
		"",
		"You've just woken up in the Cube. You",
		"have one simple goal: Escape. The only",
		"method you have come up with to test rooms in",
		"is throwing boots into the open rooms. A wrong",
		"move will have you end up dead. There is an",
		"exit, however, the cube will not allow you",
		"to leave THAT easy...",
		"",
		"=========",
		"Console Commands",
		"=========",
		"c_cinematicmod [1/0] - Toggle cinematic effect.",
		"",
		"=========",
		"Admin Commands",
		"=========",
		"c_kick [name] - Kick a player",
		"c_ban [name] [amount] - Ban a player for a specified",
		"          amount of time. 0 is infinite.",
		"c_goto [name] - Teleport to a player.",
		"c_bring [name] - Teleport a player to you.",
		"c_survivalmode [1/0] - Set survival mode on/off.",
		"c_acinematicmod [1/0] - Cinematics for all players."
		
	}
	
	for k, v in pairs( lines ) do
	
		local t = vgui.Create( "DLabel" );
		t:SetParent( CharCreatePanel );
		t:SetPos( 8, 15 + ( k * 12 ) );
		t:SetWide( 10000 );
		t:SetText( v );
		
	end
	
end
usermessage.Hook("OpenHelp", HelpWindow)