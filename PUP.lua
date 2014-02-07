-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(2, 9)
	elseif player.sub_job == 'NIN' then
		set_macro_page(3, 9)
	elseif player.sub_job == 'THF' then
		set_macro_page(4, 9)
	else
		set_macro_page(1, 9)
	end
	

	-- List of pet weaponskills to check for
	petWeaponskills = S{"Slapstick", "Knockout", "Magic Mortar",
		"Chimera Ripper", "String Clipper",  "Cannibal Blade", "Bone Crusher", "String Shredder",
		"Arcuballista", "Daze", "Armor Piercer", "Armor Shatterer"}
	
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc'}
	options.DefenseModes = {'Normal', 'DT'}
	options.WeaponskillModes = {'Normal', 'Att', 'Mod'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT', 'Evasion'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'
	

	petModes = {
		['Harlequin Head'] = 'Melee',
		['Sharpshot Head'] = 'Ranged',
		['Valoredge Head'] = 'Tank',
		['Stormwaker Head'] = 'Magic',
		['Soulsoother Head'] = 'Heal',
		['Spiritreaver Head'] = 'Nuke'
		}

	magicPetModes = S{'Nuke','Heal','Magic'}
	
	state.PetMode = get_pet_mode()
	
	-- Default maneuvers 1, 2, 3 and 4 for each pet mode.
	defaultManeuvers = {
		['Melee'] = {'Fire Maneuver', 'Thunder Maneuver', 'Wind Maneuver', 'Light Maneuver'},
		['Ranged'] = {'Wind Maneuver', 'Fire Maneuver', 'Thunder Maneuver', 'Light Maneuver'},
		['Tank'] = {'Earth Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Wind Maneuver'},
		['Magic'] = {'Ice Maneuver', 'Light Maneuver', 'Dark Maneuver', 'Earth Maneuver'},
		['Heal'] = {'Light Maneuver', 'Dark Maneuver', 'Water Maneuver', 'Earth Maneuver'},
		['Nuke'] = {'Ice Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Earth Maneuver'}
	}
	
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {head="Haruspex Hat",ear2="Loquacious Earring",hands="Thaumas Gloves"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	
	-- Precast sets to enhance JAs
	sets.precast.JA['Tactical Switch'] = {feet="Cirque Scarpe +2"}
	
	sets.precast.JA['Repair'] = {feet="Foire Babouches"}

	sets.precast.Maneuver = {neck="Buffoon's Collar",body="Cirque Farsetto +2",hands="Foire Dastanas"}



	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Whirlpool Mask",ear1="Roundel Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Spiral Ring",
		back="Iximulew Cape",legs="Nahtirah Trousers",feet="Thurandaut Boots +1"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Pantin Cape",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Manibozho Boots"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS, {neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring",
		ring1="Spiral Ring",waist="Soil Belt"})
	sets.precast.WS['Stringing Pummel'].Mod = set_combine(sets.precast.WS['Stringing Pummel'], {legs="Nahtirah Trousers"})

	sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring",
		waist="Thunder Belt"})
	sets.precast.WS['Victory Smite'].Mod = set_combine(sets.precast.WS['Victory Smite'], {waist="Soil Belt"})

	sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {neck="Light Gorget",waist="Light Belt"})

	
	-- Midcast Sets

	sets.midcast.FastRecast = {
		head="Whirlpool Mask",ear2="Loquacious Earring",
		body="Otronif Harness",hands="Thaumas Gloves",
		waist="Twilight Belt",legs="Manibozho Brais",feet="Otronif Boots"}
		
	-- Specific spells
	sets.midcast.Utsusemi = {
		head="Whirlpool Mask",ear2="Loquacious Earring",
		body="Otronif Harness",hands="Thaumas Gloves",
		waist="Hurch'lan Sash",legs="Nahtirah Trousers",legs="Manibozho Brais",feet="Otronif Boots"}


	-- Midcast sets for pet actions
	sets.midcast.Pet.Cure = {legs="Foire Churidars"}

	sets.midcast.Pet.Weaponskill = {head="Cirque Capello +2"}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {head="Foire Taj",neck="Wiglen Gorget",
		ring1="Sheltered Ring",ring2="Paguroidea Ring"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle.Town = {main="Oatixur",range="Eminent Animator",
		head="Foire Taj",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Foire Tobe",hands="Regimen Mittens",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Hurch'lan Sash",legs="Foire Churidars",feet="Hermes' Sandals"}
	
	sets.idle.Field = {
		head="Foire Taj",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Cirque Earring",
		body="Foire Tobe",hands="Regimen Mittens",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Hurch'lan Sash",legs="Foire Churidars",feet="Hermes' Sandals"}

	sets.idle.Weak = {
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Regimen Mittens",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Hurch'lan Sash",legs="Foire Churidars",feet="Hermes' Sandals"}
	
	-- Idle sets to wear while pet is engaged
	sets.idle.Field.Pet = {
		head="Foire Taj",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Cirque Earring",
		body="Foire Tobe",hands="Regimen Mittens",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Pantin Cape",waist="Hurch'lan Sash",legs="Foire Churidars",feet="Hermes' Sandals"}

	sets.idle.Field.Pet.Tank = {
		head="Foire Taj",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Cirque Earring",
		body="Foire Tobe",hands="Regimen Mittens",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Pantin Cape",waist="Hurch'lan Sash",legs="Foire Churidars",feet="Hermes' Sandals"}

	sets.idle.Field.Pet.Melee = {
		head="Foire Taj",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Cirque Earring",
		body="Foire Tobe",hands="Regimen Mittens",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Pantin Cape",waist="Hurch'lan Sash",legs="Foire Churidars",feet="Hermes' Sandals"}

	sets.idle.Field.Pet.Ranged = {
		head="Foire Taj",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Cirque Earring",
		body="Foire Tobe",hands="Cirque Guanti +2",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Pantin Cape",waist="Hurch'lan Sash",legs="Cirque Pantaloni +2",feet="Hermes' Sandals"}

	sets.idle.Field.Pet.Heal = {
		head="Foire Taj",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Cirque Earring",
		body="Foire Tobe",hands="Regimen Mittens",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Hurch'lan Sash",legs="Foire Churidars",feet="Hermes' Sandals"}

	sets.idle.Field.Pet.Nuke = {
		head="Foire Taj",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Cirque Earring",
		body="Foire Tobe",hands="Regimen Mittens",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Hurch'lan Sash",legs="Cirque Pantaloni +2",feet="Cirque Scarpe +2"}

	sets.idle.Field.Pet.Magic = {
		head="Foire Taj",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Cirque Earring",
		body="Foire Tobe",hands="Regimen Mittens",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Hurch'lan Sash",legs="Foire Churidars",feet="Cirque Scarpe +2"}


	-- Defense sets

	sets.defense.Evasion = {
		head="Whirlpool Mask",neck="Twilight Torque",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Dark Ring",
		back="Ik Cape",waist="Hurch'lan Sash",legs="Nahtirah Trousers",feet="Otronif Boots"}

	sets.defense.PDT = {
		head="Whirlpool Mask",neck="Twilight Torque",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Dark Ring",
		back="Shadow Mantle",waist="Hurch'lan Sash",legs="Nahtirah Trousers",feet="Otronif Boots"}

	sets.defense.MDT = {
		head="Whirlpool Mask",neck="Twilight Torque",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Shadow Ring",
		back="Tuilha Cape",waist="Hurch'lan Sash",legs="Nahtirah Trousers",feet="Otronif Boots"}

	sets.Kiting = {feet="Hermes' Sandals"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Pantin Cape",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.Acc = {
		head="Whirlpool Mask",neck="Peacock Charm",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Pantin Cape",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.DT = {
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Regimen Mittens",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.Acc.DT = {
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Regimen Mittens",ring1="Dark Ring",ring2="Beeline Ring",
		back="Iximulew Cape",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Otronif Boots"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Called when player is about to perform an action
function job_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'Waltz' then
		refine_waltz(spell, action, spellMap, eventArgs)
	end
end

-- Called when pet is about to perform an action
function job_pet_midcast(spell, action, spellMap, eventArgs)
	if petWeaponskills:contains(spell.english) then
		classes.CustomClass = "Weaponskill"
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == 'Wind Maneuver' then
		adjust_gear_sets_for_pet()
		handle_equipping_gear(player.status)
	end
end


-- Called when a player gains or loses a pet.
-- pet == pet gained or lost
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(pet, gain)
	state.PetMode = get_pet_mode()
end


-- Called when the pet's status changes.
function job_pet_status_change(newStatus, oldStatus)
	adjust_gear_sets_for_pet()

	if newStatus == 'Engaged' then
		display_pet_status()
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
	if cmdParams[1] == 'maneuver' then
		if pet.isvalid then
			local man = defaultManeuvers[state.PetMode]
			if man and tonumber(cmdParams[2]) then
				man = man[tonumber(cmdParams[2])]
			end

			if man then
				send_command('input /pet "'..man..'" <me>')
			end
		else
			add_to_chat(123,'No valid pet.')
		end
	end
end


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	state.PetMode = get_pet_mode()
	adjust_gear_sets_for_pet()
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
	local defenseString = ''
	if state.Defense.Active then
		local defMode = state.Defense.PhysicalMode
		if state.Defense.Type == 'Magical' then
			defMode = state.Defense.MagicalMode
		end

		defenseString = 'Defense: '..state.Defense.Type..' '..defMode..', '
	end

	add_to_chat(122,'Melee: '..state.OffenseMode..'/'..state.DefenseMode..', WS: '..state.WeaponskillMode..', '..defenseString..
		'Kiting: '..on_off_names[state.Kiting])

	display_pet_status()

	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Hooks for pet mode handling.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function get_pet_mode()
	if pet.isvalid then
		return petModes[pet.head]
	end
end

function display_pet_status()
	if pet.isvalid then
		local petInfoString = pet.name..' ['..pet.head..']: '..tostring(pet.status)..'  TP='..tostring(pet.tp)..'  HP%='..tostring(pet.hpp)
		
		if magicPetModes:contains(state.PetMode) then
			petInfoString = petInfoString..'  MP%='..tostring(pet.mpp)
		end
		
		add_to_chat(122,petInfoString)
	end
end

function get_pet_haste()
	local haste = 0
	
	if pet.isvalid then
		if pet.attachments['Turbo Charger'] then
			haste = 5
			if buffactive['wind maneuver'] then
				haste = 10 + 5 * buffactive['wind maneuver']
			end
		end
	end
	
	return haste
end

function adjust_gear_sets_for_pet()
	classes.CustomIdleGroups:clear()
	classes.CustomMeleeGroups:clear()

	-- If the pet is engaged, adjust potential idle and melee groups.
	if pet.isvalid then
		if pet.status == 'Engaged' then
			-- idle
			classes.CustomIdleGroups:append(state.PetMode)
			
			-- melee
			local petHaste = get_pet_haste()
			if petHaste > 0 then
				--classes.CustomMeleeGroups:append('PetHaste'..tostring(petHaste))
			end
		end
	end
end

