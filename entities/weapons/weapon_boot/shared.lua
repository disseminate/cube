
--  Variables that are used on both client and server

SWEP.Author			= "Cube"
SWEP.Contact		= ""
SWEP.Purpose		= "It's a boot."
SWEP.Instructions	= "Primary Fire to throw. Use to pick up."
SWEP.Category		= "Cube"

SWEP.Base			= "weapon_base"
SWEP.HoldType			= "grenade"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/v_boot.mdl"
SWEP.WorldModel			= "models/w_boot.mdl"

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 2
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "gravity"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"


--[[-------------------------------------------------------
	Initialize
---------------------------------------------------------]]
function SWEP:Initialize() 
	--self.Weapon:SetNetworkedBool( "Ironsights", false )
	if CLIENT then language.Add("Gravity_ammo", "Boot") end
	if SERVER then self:SetWeaponHoldType( self.HoldType ) end
	
end

 function SWEP:Precache()
 util.PrecacheModel("models/v_boot.mdl")
 util.PrecacheModel("models/w_boot.mdl")
 end

--[[-------------------------------------------------------
	Reload
---------------------------------------------------------]]
function SWEP:Reload()

  	if ( self.Weapon:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then 
		self:TakePrimaryAmmo( 1 )
 		self.Weapon:SetClip1( 1 )
		self.Weapon:SendWeaponAnim( ACT_VM_DRAW ) 
	end
end

--[[-------------------------------------------------------
	Think
---------------------------------------------------------]]
function SWEP:Think()
	
	if( self.Owner:KeyDown( IN_USE ) ) then
		
		if SERVER then
			
			local pos = self.Owner:GetShootPos() 
			local ang = self.Owner:GetAimVector() 
			local tracedata = {} 
			tracedata.start = pos 
			tracedata.endpos = pos+(ang*80) 
			tracedata.filter = self.Owner 
			local trace = util.TraceLine(tracedata) 
			if trace.Entity and trace.Entity:IsValid() then
				local bootent = trace.Entity
				if (bootent:GetModel() == "models/props_junk/shoe001a.mdl") then
					bootent:Remove()
					self.Owner:GiveAmmo( 1, self.Weapon:GetPrimaryAmmoType() )
				end
			end  
		end
		
	end

end

--[[-------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------]]
function SWEP:PrimaryAttack()	
	if not self:CanPrimaryAttack() then return end

	if SERVER then
		local boot=ents.Create("prop_physics") 
		local vec=Vector(0,0,8)
		boot:SetModel("models/props_junk/shoe001a.mdl")
		if self.Owner:Crouching() then vec=Vector(0,0,4) end
		boot:SetPos((self.Owner:EyePos() - vec) + (self.Owner:GetForward() * 16)) 
		boot:SetAngles(self.Owner:EyeAngles())
		boot:Spawn()
		local bootphys = boot:GetPhysicsObject()
		bootphys:Wake()
		bootphys:ApplyForceCenter(self.Owner:GetAimVector():GetNormalized() * 15)
		self:TakePrimaryAmmo( 1 )
		self.Weapon:SendWeaponAnim( ACT_VM_THROW )
		local function EraseBoot()
		
			boot:Remove();
			
		end
		timer.Simple( 60, EraseBoot );		
	end
	return true
end

--[[-------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------]]
function SWEP:SecondaryAttack()

	if SERVER then

		local pos = self.Owner:GetShootPos() 
		local ang = self.Owner:GetAimVector() 
		local tracedata = {} 
		tracedata.start = pos 
		tracedata.endpos = pos+(ang*80) 
		tracedata.filter = self.Owner 
		local trace = util.TraceLine(tracedata) 
		if trace.Entity and trace.Entity:IsValid() then
			local bootent = trace.Entity
			if (bootent:GetModel() == "models/props_junk/shoe001a.mdl") then
				bootent:Remove()
				self.Owner:GiveAmmo( 1, self.Weapon:GetPrimaryAmmoType() )
			end
		end  
	end

end

