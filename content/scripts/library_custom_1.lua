-- revolution settings
-- set/unset these to change different aspects of the game

-- developer use only, show radar calcuations on operator screens
g_radar_debug = false

-- set to a number above 1 to expand radar ranges
-- set below 1 to reduce needlefish radar ranges
g_override_radar_multiplier = 1

-- set true to hide the production type of hostile islands on the logistics map
-- that are masked by the fog of war (ie they are too far away to see who controls it)
g_revolution_hide_hostile_island_types = false

-- set true to hide island shield (difficutly) numbers from the holomap and control screens.
g_revolution_hide_island_difficulty = false

-- RADAR boosts disabled by default
-- set to an altitude above which the AWACS gets a range boost (above 2000 disables this)
g_revolution_awacs_boost_above_alt = 9999

-- set to a value used for the AWACS range boost (if enabled)
-- 1.2 works out at a 20% boost to range at 2000m if above was set to 1600
g_revolution_awacs_alt_boost_factor = 1.2

-- below this altitude, hide aircraft from operator screen RADAR display
g_revolution_radar_clutter_level = 65

-- render grey HUD circles around hot ground/air targets when you are equipped with an IR/AA/TV
-- missile and the target is in front of you within this distance
-- in revolution 1.2 this was 2500
g_revolution_hud_missile_heat_circles = 1500

-- render grey HUD circles around hot targets using this % of the middle of the HUD. Outside
-- this region hot targets are not displayed
-- in revolution 1.2 this was 0.3
g_revolution_hud_missile_heat_scope = 0.25


-- attachment hardpoint overrides

-- useful constants to reduce typing later
g_std_wing_attachments = {
	-- the weapons all aircraft can normally mount on wing pylons
	e_game_object_type.attachment_turret_plane_chaingun,
	e_game_object_type.attachment_turret_rocket_pod,
	e_game_object_type.attachment_hardpoint_bomb_1,
	e_game_object_type.attachment_hardpoint_bomb_2,
	e_game_object_type.attachment_hardpoint_bomb_3,
	e_game_object_type.attachment_hardpoint_missile_ir,
	e_game_object_type.attachment_hardpoint_missile_laser,
	e_game_object_type.attachment_hardpoint_missile_aa,
	e_game_object_type.attachment_hardpoint_missile_tv,
	e_game_object_type.attachment_hardpoint_torpedo,
	e_game_object_type.attachment_hardpoint_torpedo_noisemaker,
	e_game_object_type.attachment_hardpoint_torpedo_decoy,
	e_game_object_type.attachment_fuel_tank_plane
}

g_std_wing_utils = {
	-- the utility items aircraft can normally use
	e_game_object_type.attachment_flare_launcher,
	e_game_object_type.attachment_sonic_pulse_generator,
	e_game_object_type.attachment_smoke_launcher_explosive,
	e_game_object_type.attachment_smoke_launcher_stream
}

g_revolution_override_attachment_options = {
	-- each [x] element is a chassis type
	-- the value can have rows, or options or both,

	-- to prevent a hardpoint being used, you need to omit it from `rows` for that unit
	-- to limit/expand the choices for a hardpoint, you define an `options` value

	[e_game_object_type.chassis_air_wing_heavy] = {
		-- the manta here is roughly the Revoltion 1.2 Manta with some changes to
		-- illustrate the example
		rows = {
			-- each row shows where the hardpoint box graphic will appear for each hardpoint
			-- in this example, there are 3 rows for the manta
			{
				{ i = 1, x = 0, y = -23 }, -- front camera slot
				{ i = 2, x = 8, y = -11 }  -- internal gun
			},
			{
				{ i = 8, x = -26, y = 11 }, -- left outer
				{ i = 4, x = -16, y = 0 }, -- left inner
				{ i = 3, x = 0, y = 0 },   -- centre
				{ i = 5, x = 16, y = 0 },  -- right inner
				{ i = 9, x = 26, y = 11 }   -- right outer
			},
			{
				{ i = 6, x = -13, y = 20 }, -- left util
				{ i = 7, x = 13, y = 20 }   -- right util
			}
		},
		options = {
			-- the list of attachment choices for each hardpoint on the unit
			-- the [x] numbers here are the attachment index numbers, they
			-- normally correspond to the i=x values above or in library_ui.lua

			-- nose slot
			[1] = {
				e_game_object_type.attachment_camera_plane,
				e_game_object_type.attachment_turret_gimbal_30mm,
			},
			-- left wing inner
			[4] = g_std_wing_attachments,  -- g_std_wing_attachments is a list defined above

			-- middle
			[3] = {
				-- middle hardpoint limited to fuel or light/medium bombs
				e_game_object_type.attachment_fuel_tank_plane,
				e_game_object_type.attachment_hardpoint_bomb_1,
				e_game_object_type.attachment_hardpoint_bomb_2,
			},

			-- internal gun
			[2] = {
				-- internal hardpoint limited to chaingun only
				e_game_object_type.attachment_turret_plane_chaingun
			},

			-- right wing inner
			[5] = g_std_wing_attachments,

			-- left wing outer
			[8] = g_std_wing_attachments,

			-- right wing outer
			[9] = g_std_wing_attachments,

			-- utils
			[6] = g_std_wing_utils,
			[7] = g_std_wing_utils,


		}
	}
}


if g_radar_ranges == nil then
	-- revolution is not installed, tell the user
	update_screen_overrides = function(screen_w, screen_h, ticks)
		update_ui_text(20, 20, "Heavy Manta mod needs Revolution mod 1.3+",
				110, 0, color_white, 0)
		return false
	end
end
if g_rev_mods ~= nil then
	table.insert(g_rev_mods, "Heavy Manta")
end