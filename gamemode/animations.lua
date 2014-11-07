-- Fix for gmod 2008 by Botman.
------
-- NPC Animations
-- March 24, 2007
-- Rick Darkaliono
------

NPC_ANIMS_ENABLED = true

function HolsterToggle( ply )

	if( not NPC_ANIMS_ENABLED ) then return; end

	if( not ply:GetActiveWeapon():IsValid() ) then
		return;
	end

	if( ply:GetNWInt( "holstered" ) == 1 ) then	
		MakeAim( ply );
	else
		return;
	end

end
concommand.Add( "rp_toggleholster", HolsterToggle );
concommand.Add( "toggleholster", HolsterToggle );

function MakeAim( ply )
	
	ply:GetActiveWeapon():SetNWBool( "NPCAimed", true );
	ply:GetActiveWeapon():SetNextPrimaryFire( CurTime() );
	
	ply:SetNWInt( "holstered", 0 );

end

function MakeUnAim( ply )
	
	if( ply:GetActiveWeapon():IsValid() ) then
		ply:GetActiveWeapon():SetNWBool( "NPCAimed", false );
		
		if( ply:GetActiveWeapon():GetNWBool( "ironsights" ) ) then
			ply:GetActiveWeapon():ToggleIronsight();
		end
	end
	
	ply:SetNWInt( "holstered", 1 );

end

function NPCPlayerThink()

	if( not NPC_ANIMS_ENABLED ) then return; end

	for k, v in pairs( player.GetAll() ) do
	
		if( not v:GetTable().NPCLastWeapon or not v:GetActiveWeapon():IsValid() or v:GetTable().NPCLastWeapon ~= v:GetActiveWeapon():GetClass() ) then
	
			MakeUnAim( v );
			
			v:GetTable().NPCLastWeapon = "";
			
			if( v:GetActiveWeapon():IsValid() ) then
			
				v:GetTable().NPCLastWeapon = v:GetActiveWeapon():GetClass();
			
				if( not v:GetActiveWeapon():GetNWBool( "NPCAimed" ) ) then
					MakeAim( v );
				end
			
			end
			
		end
	
	end

end
hook.Add( "Think", "NPCPlayerThink", NPCPlayerThink );


NPCAnim = { }

NPCAnim.CitizenMaleAnim = { }
NPCAnim.CitizenMaleModels = 
{

	        "models/humans/group01/male_01.mdl",
              "models/humans/group01/male_02.mdl",
              "models/humans/group01/male_03.mdl",
              "models/humans/group01/male_04.mdl",
              "models/humans/group01/male_06.mdl",
              "models/humans/group01/male_07.mdl",
              "models/humans/group01/male_08.mdl",
              "models/humans/group01/male_09.mdl",
              "models/humans/group02/male_01.mdl",
              "models/humans/group02/male_02.mdl",
              "models/humans/group02/male_03.mdl",
              "models/humans/group02/male_04.mdl",
              "models/humans/group02/male_06.mdl",
              "models/humans/group02/male_07.mdl",
              "models/humans/group02/male_08.mdl",
              "models/humans/group02/male_09.mdl",
              "models/humans/group03/male_01.mdl",
              "models/humans/group03/male_02.mdl",
              "models/humans/group03/male_03.mdl",
              "models/humans/group03/male_04.mdl",
              "models/humans/group03/male_06.mdl",
              "models/humans/group03/male_07.mdl",
              "models/humans/group03/male_08.mdl",
              "models/humans/group03/male_09.mdl",
              "models/humans/group03m/male_01.mdl",
              "models/humans/group03m/male_02.mdl",
              "models/humans/group03m/male_03.mdl",
              "models/humans/group03m/male_04.mdl",
              "models/humans/group03m/male_06.mdl",
              "models/humans/group03m/male_07.mdl",
              "models/humans/group03m/male_08.mdl",
              "models/humans/group03m/male_09.mdl"
}



for k, v in pairs( NPCAnim.CitizenMaleModels ) do

	NPCAnim.CitizenMaleModels[k] = string.lower( v );

end


NPCAnim.CitizenMaleAnim["idle"] = 1
NPCAnim.CitizenMaleAnim["walk"] = 6
NPCAnim.CitizenMaleAnim["run"] = 10
NPCAnim.CitizenMaleAnim["glide"] = 27
NPCAnim.CitizenMaleAnim["sit"] = 0
NPCAnim.CitizenMaleAnim["crouch"] = 5
NPCAnim.CitizenMaleAnim["crouchwalk"] = 8
 
NPCAnim.CitizenMaleAnim["pistolidle"] = 1
NPCAnim.CitizenMaleAnim["pistolwalk"] = 6
NPCAnim.CitizenMaleAnim["pistolrun"] = 10
NPCAnim.CitizenMaleAnim["pistolcrouchwalk"] = 8
NPCAnim.CitizenMaleAnim["pistolcrouch"] = 5
NPCAnim.CitizenMaleAnim["pistolaimidle"] = 317
NPCAnim.CitizenMaleAnim["pistolaimwalk"] = 340
NPCAnim.CitizenMaleAnim["pistolaimrun"] = 319
NPCAnim.CitizenMaleAnim["pistolaimcrouch"] = 5
NPCAnim.CitizenMaleAnim["pistolaimcrouchwalk"] = 342
NPCAnim.CitizenMaleAnim["pistolreload"] = 359
NPCAnim.CitizenMaleAnim["pistolfire"] = 285
 
NPCAnim.CitizenMaleAnim["smgidle"] = 311
NPCAnim.CitizenMaleAnim["smgrun"] = 338
NPCAnim.CitizenMaleAnim["smgwalk"] = 337
NPCAnim.CitizenMaleAnim["smgaimidle"] = 317
NPCAnim.CitizenMaleAnim["smgaimwalk"] = 340
NPCAnim.CitizenMaleAnim["smgcrouchwalk"] = 8
NPCAnim.CitizenMaleAnim["smgcrouch"] = 5
NPCAnim.CitizenMaleAnim["smgaimcrouch"] = 5
NPCAnim.CitizenMaleAnim["smgaimcrouchwalk"] = 342
NPCAnim.CitizenMaleAnim["smgaimrun"] = 319
NPCAnim.CitizenMaleAnim["smgreload"] = 359
NPCAnim.CitizenMaleAnim["smgfire"] = 289
 
NPCAnim.CitizenMaleAnim["ar2idle"] = 301
NPCAnim.CitizenMaleAnim["ar2walk"] = 339
NPCAnim.CitizenMaleAnim["ar2run"] = 343
NPCAnim.CitizenMaleAnim["ar2aimidle"] = 317
NPCAnim.CitizenMaleAnim["ar2aimwalk"] = 340
NPCAnim.CitizenMaleAnim["ar2aimrun"] = 319
NPCAnim.CitizenMaleAnim["ar2crouchwalk"] = 8
NPCAnim.CitizenMaleAnim["ar2crouch"] = 5
NPCAnim.CitizenMaleAnim["ar2aimcrouch"] = 5
NPCAnim.CitizenMaleAnim["ar2aimcrouchwalk"] = 342
NPCAnim.CitizenMaleAnim["ar2reload"] = 359
NPCAnim.CitizenMaleAnim["ar2fire"] = 281
 
NPCAnim.CitizenMaleAnim["shotgunidle"] = 311
NPCAnim.CitizenMaleAnim["shotgunwalk"] = 337
NPCAnim.CitizenMaleAnim["shotgunrun"] = 338
NPCAnim.CitizenMaleAnim["shotgunaimidle"] = 317
NPCAnim.CitizenMaleAnim["shotgunaimwalk"] = 340
NPCAnim.CitizenMaleAnim["shotgunaimrun"] = 319
NPCAnim.CitizenMaleAnim["shotguncrouchwalk"] = 8
NPCAnim.CitizenMaleAnim["shotguncrouch"] = 5
NPCAnim.CitizenMaleAnim["shotgunaimcrouch"] = 5
NPCAnim.CitizenMaleAnim["shotgunaimcrouchwalk"] = 342
NPCAnim.CitizenMaleAnim["shotgunreload"] = 361
NPCAnim.CitizenMaleAnim["shotgunfire"] = 288
 
NPCAnim.CitizenMaleAnim["crossbowidle"] = 311
NPCAnim.CitizenMaleAnim["crossbowwalk"] = 337
NPCAnim.CitizenMaleAnim["crossbowrun"] = 338
NPCAnim.CitizenMaleAnim["crossbowaimidle"] = 317
NPCAnim.CitizenMaleAnim["crossbowaimwalk"] = 340
NPCAnim.CitizenMaleAnim["crossbowaimrun"] = 319
NPCAnim.CitizenMaleAnim["crossbowcrouchwalk"] = 8
NPCAnim.CitizenMaleAnim["crossbowcrouch"] = 5
NPCAnim.CitizenMaleAnim["crossbowaimcrouch"] = 328
NPCAnim.CitizenMaleAnim["crossbowaimcrouchwalk"] = 342
NPCAnim.CitizenMaleAnim["crossbowreload"] = 359
NPCAnim.CitizenMaleAnim["crossbowfire"] = 288
 
NPCAnim.CitizenMaleAnim["meleeidle"] = 1
NPCAnim.CitizenMaleAnim["meleewalk"] = 6
NPCAnim.CitizenMaleAnim["meleerun"] = 10
NPCAnim.CitizenMaleAnim["meleeaimidle"] = 328
NPCAnim.CitizenMaleAnim["meleeaimcrouchwalk"] = 8
NPCAnim.CitizenMaleAnim["meleeaimcrouch"] = 5
NPCAnim.CitizenMaleAnim["meleecrouchwalk"] = 8
NPCAnim.CitizenMaleAnim["meleecrouch"] = 5
NPCAnim.CitizenMaleAnim["meleeaimwalk"] = 6
NPCAnim.CitizenMaleAnim["meleeaimrun"] = 10
NPCAnim.CitizenMaleAnim["meleefire"] = 277
 
NPCAnim.CitizenMaleAnim["rpgidle"] = 311
NPCAnim.CitizenMaleAnim["rpgwalk"] = 337
NPCAnim.CitizenMaleAnim["rpgrun"] = 338
NPCAnim.CitizenMaleAnim["rpgaimidle"] = 317
NPCAnim.CitizenMaleAnim["rpgaimwalk"] = 340
NPCAnim.CitizenMaleAnim["rpgaimrun"] = 319
NPCAnim.CitizenMaleAnim["rpgcrouchwalk"] = 8
NPCAnim.CitizenMaleAnim["rpgcrouch"] = 5
NPCAnim.CitizenMaleAnim["rpgaimcrouch"] = 328
NPCAnim.CitizenMaleAnim["rpgaimcrouchwalk"] = 342
NPCAnim.CitizenMaleAnim["rpgfire"] = 272
 
NPCAnim.CitizenMaleAnim["grenadeidle"] = 1
NPCAnim.CitizenMaleAnim["grenadewalk"] = 6
NPCAnim.CitizenMaleAnim["grenaderun"] = 10
NPCAnim.CitizenMaleAnim["grenadeaimidle"] = 1
NPCAnim.CitizenMaleAnim["grenadeaimcrouchwalk"] = 8
NPCAnim.CitizenMaleAnim["grenadeaimcrouch"] = 5
NPCAnim.CitizenMaleAnim["grenadecrouchwalk"] = 8
NPCAnim.CitizenMaleAnim["grenadecrouch"] = 5
NPCAnim.CitizenMaleAnim["grenadeaimwalk"] = 6
NPCAnim.CitizenMaleAnim["grenadeaimrun"] = 10
NPCAnim.CitizenMaleAnim["grenadefire"] = 273
 
NPCAnim.CitizenMaleAnim["slamidle"] = 1
NPCAnim.CitizenMaleAnim["slamwalk"] = 6
NPCAnim.CitizenMaleAnim["slamrun"] = 10
NPCAnim.CitizenMaleAnim["slamaimidle"] = 1
NPCAnim.CitizenMaleAnim["slamaimcrouchwalk"] = 8
NPCAnim.CitizenMaleAnim["slamaimcrouch"] = 5
NPCAnim.CitizenMaleAnim["slamcrouchwalk"] = 8
NPCAnim.CitizenMaleAnim["slamcrouch"] = 5
NPCAnim.CitizenMaleAnim["slamaimwalk"] = 6
NPCAnim.CitizenMaleAnim["slamaimrun"] = 10
NPCAnim.CitizenMaleAnim["slamfire"] = 273
 
NPCAnim.CitizenMaleAnim["physgunidle"] = 311
NPCAnim.CitizenMaleAnim["physgunwalk"] = 337
NPCAnim.CitizenMaleAnim["physgunrun"] = 338
NPCAnim.CitizenMaleAnim["physgunaimidle"] = 317
NPCAnim.CitizenMaleAnim["physgunaimwalk"] = 340
NPCAnim.CitizenMaleAnim["physgunaimrun"] = 340
NPCAnim.CitizenMaleAnim["physgunaimcrouchwalk"] = 5
NPCAnim.CitizenMaleAnim["physgunaimcrouch"] = 328

NPCAnim.CitizenFemaleAnim = { }
NPCAnim.CitizenFemaleModels = 
{
	
              "models/Humans/Group01/Female_01.mdl",
              "models/Humans/Group01/Female_02.mdl",
              "models/Humans/Group01/Female_03.mdl",
              "models/Humans/Group01/Female_04.mdl",
              "models/Humans/Group01/Female_06.mdl",
              "models/Humans/Group01/Female_07.mdl",
              "models/Humans/Group02/Female_01.mdl",
              "models/Humans/Group02/Female_02.mdl",
              "models/Humans/Group02/Female_03.mdl",
              "models/Humans/Group02/Female_04.mdl",
              "models/Humans/Group02/Female_06.mdl",
              "models/Humans/Group02/Female_07.mdl",
              "models/Humans/Group03/Female_01.mdl",
              "models/Humans/Group03/Female_02.mdl",
              "models/Humans/Group03/Female_03.mdl",
              "models/Humans/Group03/Female_04.mdl",
              "models/Humans/Group03/Female_06.mdl",
              "models/Humans/Group03/Female_07.mdl",
              "models/Humans/Group03m/Female_01.mdl",
              "models/Humans/Group03m/Female_02.mdl",
              "models/Humans/Group03m/Female_03.mdl",
              "models/Humans/Group03m/Female_04.mdl",
              "models/Humans/Group03m/Female_06.mdl",
              "models/Humans/Group03m/Female_07.mdl"	  
}

for k, v in pairs( NPCAnim.CitizenFemaleModels ) do

	NPCAnim.CitizenFemaleModels[k] = string.lower( v );

end

NPCAnim.CitizenFemaleAnim["idle"] = 1
NPCAnim.CitizenFemaleAnim["walk"] = 6
NPCAnim.CitizenFemaleAnim["run"] = 10
NPCAnim.CitizenFemaleAnim["glide"] = 27
NPCAnim.CitizenFemaleAnim["sit"] = 0
NPCAnim.CitizenFemaleAnim["crouch"] = 5
NPCAnim.CitizenFemaleAnim["crouchwalk"] = 8

NPCAnim.CitizenFemaleAnim["pistolidle"] = 1
NPCAnim.CitizenFemaleAnim["pistolwalk"] = 6
NPCAnim.CitizenFemaleAnim["pistolrun"] = 10
NPCAnim.CitizenFemaleAnim["pistolcrouchwalk"] = 8
NPCAnim.CitizenFemaleAnim["pistolcrouch"] = 60
NPCAnim.CitizenFemaleAnim["pistolaimidle"] = 304
NPCAnim.CitizenFemaleAnim["pistolaimwalk"] = 352
NPCAnim.CitizenFemaleAnim["pistolaimrun"] = 353
NPCAnim.CitizenFemaleAnim["pistolaimcrouch"] = 60
NPCAnim.CitizenFemaleAnim["pistolaimcrouchwalk"] = 8
NPCAnim.CitizenFemaleAnim["pistolreload"] = 359
NPCAnim.CitizenFemaleAnim["pistolfire"] = 285

NPCAnim.CitizenFemaleAnim["smgidle"] = 311
NPCAnim.CitizenFemaleAnim["smgrun"] = 338
NPCAnim.CitizenFemaleAnim["smgwalk"] = 337
NPCAnim.CitizenFemaleAnim["smgaimidle"] = 317
NPCAnim.CitizenFemaleAnim["smgaimwalk"] = 340
NPCAnim.CitizenFemaleAnim["smgcrouchwalk"] = 8
NPCAnim.CitizenFemaleAnim["smgcrouch"] = 5
NPCAnim.CitizenFemaleAnim["smgaimcrouch"] = 5
NPCAnim.CitizenFemaleAnim["smgaimcrouchwalk"] = 342
NPCAnim.CitizenFemaleAnim["smgaimrun"] = 334
NPCAnim.CitizenFemaleAnim["smgreload"] = 359
NPCAnim.CitizenFemaleAnim["smgfire"] = 289

NPCAnim.CitizenFemaleAnim["ar2idle"] = 301
NPCAnim.CitizenFemaleAnim["ar2walk"] = 339
NPCAnim.CitizenFemaleAnim["ar2run"] = 343
NPCAnim.CitizenFemaleAnim["ar2aimidle"] = 317
NPCAnim.CitizenFemaleAnim["ar2aimwalk"] = 340
NPCAnim.CitizenFemaleAnim["ar2aimrun"] = 319
NPCAnim.CitizenFemaleAnim["ar2crouchwalk"] = 8
NPCAnim.CitizenFemaleAnim["ar2crouch"] = 5
NPCAnim.CitizenFemaleAnim["ar2aimcrouch"] = 5
NPCAnim.CitizenFemaleAnim["ar2aimcrouchwalk"] = 342
NPCAnim.CitizenFemaleAnim["ar2reload"] = 359
NPCAnim.CitizenFemaleAnim["ar2fire"] = 281

NPCAnim.CitizenFemaleAnim["shotgunidle"] = 311
NPCAnim.CitizenFemaleAnim["shotgunwalk"] = 333
NPCAnim.CitizenFemaleAnim["shotgunrun"] = 340
NPCAnim.CitizenFemaleAnim["shotgunaimidle"] = 317
NPCAnim.CitizenFemaleAnim["shotgunaimwalk"] = 340
NPCAnim.CitizenFemaleAnim["shotgunaimrun"] = 319
NPCAnim.CitizenFemaleAnim["shotguncrouchwalk"] = 8
NPCAnim.CitizenFemaleAnim["shotguncrouch"] = 5
NPCAnim.CitizenFemaleAnim["shotgunaimcrouch"] = 5
NPCAnim.CitizenFemaleAnim["shotgunaimcrouchwalk"] = 8
NPCAnim.CitizenFemaleAnim["shotgunreload"] = 361
NPCAnim.CitizenFemaleAnim["shotgunfire"] = 288

NPCAnim.CitizenFemaleAnim["crossbowidle"] = 311
NPCAnim.CitizenFemaleAnim["crossbowwalk"] = 333
NPCAnim.CitizenFemaleAnim["crossbowrun"] = 343
NPCAnim.CitizenFemaleAnim["crossbowaimidle"] = 317
NPCAnim.CitizenFemaleAnim["crossbowaimwalk"] = 340
NPCAnim.CitizenFemaleAnim["crossbowaimrun"] = 319
NPCAnim.CitizenFemaleAnim["crossbowcrouchwalk"] = 8
NPCAnim.CitizenFemaleAnim["crossbowcrouch"] = 5
NPCAnim.CitizenFemaleAnim["crossbowaimcrouch"] = 5
NPCAnim.CitizenFemaleAnim["crossbowaimcrouchwalk"] = 8
NPCAnim.CitizenFemaleAnim["crossbowreload"] = 359
NPCAnim.CitizenFemaleAnim["crossbowfire"] = 288

NPCAnim.CitizenFemaleAnim["meleeidle"] = 1
NPCAnim.CitizenFemaleAnim["meleewalk"] = 6
NPCAnim.CitizenFemaleAnim["meleerun"] = 10
NPCAnim.CitizenFemaleAnim["meleeaimidle"] = 329
NPCAnim.CitizenFemaleAnim["meleeaimcrouchwalk"] = 8
NPCAnim.CitizenFemaleAnim["meleeaimcrouch"] = 5
NPCAnim.CitizenFemaleAnim["meleecrouchwalk"] = 8
NPCAnim.CitizenFemaleAnim["meleecrouch"] = 5
NPCAnim.CitizenFemaleAnim["meleeaimwalk"] = 6
NPCAnim.CitizenFemaleAnim["meleeaimrun"] = 10
NPCAnim.CitizenFemaleAnim["meleefire"] = 277

NPCAnim.CitizenFemaleAnim["rpgidle"] = 311
NPCAnim.CitizenFemaleAnim["rpgwalk"] = 333
NPCAnim.CitizenFemaleAnim["rpgrun"] = 343
NPCAnim.CitizenFemaleAnim["rpgaimidle"] = 317
NPCAnim.CitizenFemaleAnim["rpgaimwalk"] = 340
NPCAnim.CitizenFemaleAnim["rpgaimrun"] = 319
NPCAnim.CitizenFemaleAnim["rpgcrouchwalk"] = 8
NPCAnim.CitizenFemaleAnim["rpgcrouch"] = 5
NPCAnim.CitizenFemaleAnim["rpgaimcrouch"] = 5
NPCAnim.CitizenFemaleAnim["rpgaimcrouchwalk"] = 8
NPCAnim.CitizenFemaleAnim["rpgfire"] = 272

NPCAnim.CitizenFemaleAnim["grenadeidle"] = 1
NPCAnim.CitizenFemaleAnim["grenadewalk"] = 6
NPCAnim.CitizenFemaleAnim["grenaderun"] = 10
NPCAnim.CitizenFemaleAnim["grenadeaimidle"] = 1
NPCAnim.CitizenFemaleAnim["grenadeaimcrouchwalk"] = 8
NPCAnim.CitizenFemaleAnim["grenadeaimcrouch"] = 5
NPCAnim.CitizenFemaleAnim["grenadecrouchwalk"] = 8
NPCAnim.CitizenFemaleAnim["grenadecrouch"] = 5
NPCAnim.CitizenFemaleAnim["grenadeaimwalk"] = 6
NPCAnim.CitizenFemaleAnim["grenadeaimrun"] = 10
NPCAnim.CitizenFemaleAnim["grenadefire"] = 273

NPCAnim.CitizenFemaleAnim["slamidle"] = 1
NPCAnim.CitizenFemaleAnim["slamwalk"] = 6
NPCAnim.CitizenFemaleAnim["slamrun"] = 10
NPCAnim.CitizenFemaleAnim["slamaimidle"] = 1
NPCAnim.CitizenFemaleAnim["slamaimcrouchwalk"] = 8
NPCAnim.CitizenFemaleAnim["slamaimcrouch"] = 5
NPCAnim.CitizenFemaleAnim["slamcrouchwalk"] = 8
NPCAnim.CitizenFemaleAnim["slamcrouch"] = 5
NPCAnim.CitizenFemaleAnim["slamaimwalk"] = 6
NPCAnim.CitizenFemaleAnim["slamaimrun"] = 10
NPCAnim.CitizenFemaleAnim["slamfire"] = 273

NPCAnim.CitizenFemaleAnim["physgunidle"] = 311
NPCAnim.CitizenFemaleAnim["physgunwalk"] = 333
NPCAnim.CitizenFemaleAnim["physgunrun"] = 343
NPCAnim.CitizenFemaleAnim["physgunaimidle"] = 317
NPCAnim.CitizenFemaleAnim["physgunaimwalk"] = 340
NPCAnim.CitizenFemaleAnim["physgunaimrun"] = 340
NPCAnim.CitizenFemaleAnim["physgunaimcrouchwalk"] = 5
NPCAnim.CitizenFemaleAnim["physgunaimcrouch"] = 5

WeapActivityTranslate = { }

WeapActivityTranslate[ACT_HL2MP_IDLE_PISTOL] = "pistol";
WeapActivityTranslate[ACT_HL2MP_IDLE_SMG1] = "smg";
WeapActivityTranslate[ACT_HL2MP_IDLE_AR2] = "ar2";
WeapActivityTranslate[ACT_HL2MP_IDLE_RPG] = "rpg";
WeapActivityTranslate[ACT_HL2MP_IDLE_GRENADE] = "grenade";
WeapActivityTranslate[ACT_HL2MP_IDLE_SHOTGUN] = "shotgun";
WeapActivityTranslate[ACT_HL2MP_IDLE_PHYSGUN] = "physgun";
WeapActivityTranslate[ACT_HL2MP_IDLE_CROSSBOW] = "crossbow";
WeapActivityTranslate[ACT_HL2MP_IDLE_SLAM] = "slam";
WeapActivityTranslate[ACT_HL2MP_IDLE_MELEE] = "melee";
WeapActivityTranslate[ACT_HL2MP_IDLE] = "";
WeapActivityTranslate["weapon_pistol"] = "pistol";
WeapActivityTranslate["weapon_357"] = "pistol";
WeapActivityTranslate["gmod_tool"] = "pistol";
WeapActivityTranslate["weapon_smg1"] = "smg";
WeapActivityTranslate["weapon_ar2"] = "ar2";
WeapActivityTranslate["weapon_rpg"] = "rpg";
WeapActivityTranslate["weapon_frag"] = "grenade";
WeapActivityTranslate["weapon_slam"] = "slam";
WeapActivityTranslate["weapon_physgun"] = "physgun";
WeapActivityTranslate["weapon_physcannon"] = "physgun";
WeapActivityTranslate["weapon_crossbow"] = "crossbow";
WeapActivityTranslate["weapon_shotgun"] = "shotgun";
WeapActivityTranslate["weapon_crowbar"] = "melee";
WeapActivityTranslate["weapon_stunstick"] = "melee";

local function GetWeaponAct( ply, act )

	local weap = ply:GetActiveWeapon();
	
	if( weap == NULL or not weap:IsValid() ) then
		return "";
	end

	local class = weap:GetClass();
	
	local trans = "";
	local posttrans = "";
	
	if( weap:GetNWBool( "NPCAimed" ) ) then
		posttrans = "aim";	
	else
		
		if( weap:GetTable().NotHolsterAnim ) then
		
			act = weap:GetTable().NotHolsterAnim;
		
		end
	
	end

	if( act ~= -1 ) then
		trans = WeapActivityTranslate[act];
	else
		trans = WeapActivityTranslate[class];
	end
	
	return trans .. posttrans or "";

end



local function GetAnimTable( ply )

	local model = string.lower( ply:GetModel() );

	if( table.HasValue( NPCAnim.CitizenMaleModels, model ) ) then return NPCAnim.CitizenMaleAnim; end
	if( table.HasValue( NPCAnim.CitizenFemaleModels, model ) ) then return NPCAnim.CitizenFemaleAnim; end
	
	return NPCAnim.CitizenMaleAnim;

end

function NPCAnim.SetPlayerAnimation( ply, weapanim )

	if( not NPC_ANIMS_ENABLED ) then return; end
	
	local weap = ply:GetActiveWeapon();
	local animname = "";
	
	if( weap:IsValid() ) then
		animname = GetWeaponAct( ply, ply:Weapon_TranslateActivity( ACT_HL2MP_IDLE ) or -1 );
	end
	local seqname = animname;
	local crouch = "";

	if( ply:OnGround() and ply:KeyDown( IN_DUCK ) ) then
		crouch = "crouch";
	end
	
	if( ply:GetVelocity():Length() >= 120 and ply:KeyDown( IN_SPEED )) then

		seqname = seqname .. crouch .. "run";
	
	elseif( ply:GetVelocity():Length() >= 1 ) then
	
		seqname = seqname .. crouch .. "walk";
	
	else
		
		if( crouch == "crouch" ) then
			seqname = seqname .. crouch;
		else
			seqname = seqname .. crouch .. "idle";
		end
		
	end

	local AnimTable = GetAnimTable( ply );
	
	if( ( weapanim == PLAYER_ATTACK1 or weapanim == PLAYER_RELOAD ) and weap:IsValid() ) then

		local act = nil;
	
		if( weapanim == PLAYER_RELOAD ) then

			local actname = string.gsub( seqname, "aim", "" ) .. "reload";
			actname = string.gsub( actname, "idle", "" );
		
			local act = tonumber( AnimTable[actname] );
			
			if( act == nil ) then
				return;
			end

			ply:RestartGesture( act );
		
			return true;
			
		else
		
			if( string.find( seqname, "melee" ) or string.find( seqname, "grenade" ) or string.find( seqname, "slam" ) ) then
			
				local actname = string.gsub( seqname, "aim", "" ) .. "fire";
				actname = string.gsub( actname, "idle", "" );
			
				local act = tonumber( AnimTable[actname] );
				
				if( act == nil ) then
					return;
				end

				ply:RestartGesture( act );
				ply:Weapon_SetActivity( act, 0 );
				
				return true;
				
			end
		
			return;
			
		end
	
	end

	if ( ( not ply:OnGround() or ply:WaterLevel() > 4 ) and 
		   not ply:InVehicle() ) then
		seqname = "glide";
	end
 

	local actid = AnimTable[seqname];
	local seq = nil;

	if( actid == nil or actid == -1 ) then
		seq = ply:GetSequence();
	else
		seq = ply:SelectWeightedSequence( actid );
	end

	if ( ply:GetSequence() == seq ) then return true; end

	ply:SetPlaybackRate( 1 );
	ply:ResetSequence( seq );
	ply:SetCycle( 1 );
	
	return true;

end
hook.Add( "SetPlayerAnimation", "NPCAnim.SetPlayerAnimation", NPCAnim.SetPlayerAnimation );