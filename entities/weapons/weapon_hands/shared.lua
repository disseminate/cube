
--  Variables that are used on both client and server

SWEP.Author			= "Disseminate"
SWEP.Contact		= ""
SWEP.Purpose		= "Your opposable thumbs."
SWEP.Instructions	= ""
SWEP.Category		= "Cube"

SWEP.Base			= "weapon_base"
SWEP.HoldType			= "grenade"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= ""
SWEP.WorldModel			= ""

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"


--[[-------------------------------------------------------
	Initialize
---------------------------------------------------------]]
function SWEP:Initialize() 
	
	if SERVER then self:SetWeaponHoldType( self.HoldType ) end
	
end

 function SWEP:Precache()
 end

--[[-------------------------------------------------------
	Reload
---------------------------------------------------------]]
function SWEP:Reload()
end

--[[-------------------------------------------------------
	Think
---------------------------------------------------------]]
function SWEP:Think()
end

--[[-------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------]]
function SWEP:PrimaryAttack()
end

--[[-------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------]]
function SWEP:SecondaryAttack()
end

