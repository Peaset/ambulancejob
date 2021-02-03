Config                            = {}

Config.DrawDistance               = 50.0

Config.Marker                     = { type = 2, x = 0.8, y = 0.8, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }

Config.ReviveReward               = 1500  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 5 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 30 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 3

Config.RespawnPoint = { coords = vector3(306.94, -590, 42.4), heading = 38.62  }

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(299.21, -584.46, 43.26),
			sprite = 61,
			scale  = 0.8,
			color  = 2
		},

		AmbulanceActions = {
			vector3(309.76, -602.51, 43.19)
		},

		Pharmacies = {
		},

		Vehicles = {
			{
				Spawner = vector3(294.56, -607.37, 43.33),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(290.51, -611.74, 42.3), heading = 70.01, radius = 4.0 },
					{ coords = vector3(295.82, -608.42, 42.34), heading = 70.01, radius = 4.0 },
					{ coords = vector3(294.94, -611.07, 42.36), heading = 70.01, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(341.86, -580.51, 75.17),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(351.78, -588.1, 74.17), heading = 142.7, radius = 10.0 }
				}
			}
		},

		FastTravels = {
		},

		FastTravelsPrompt = {


		}

	}
}


Config.AuthorizedVehicles = {

	ambulance = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 1},
		{ model = 'dodgeEMS', label = 'Ambulance Dodge', price = 1}
	},

	doctor = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 1},
		{ model = 'dodgeEMS', label = 'Ambulance Dodge', price = 1}
	},

	chief_doctor = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 1},
		{ model = 'dodgeEMS', label = 'Ambulance Dodge', price = 1}
	},

	boss = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 1},
		{ model = 'dodgeEMS', label = 'Ambulance Dodge', price = 1}
	}

}
Config.AuthorizedHelicopters = {

	ambulance = {},

	doctor = {},

	chief_doctor = {
	{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 10 },
		{ model = 'polmav', label = 'Ambulans Helikopteri', price = 20 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 10 }
	},

	boss = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 10 },
		{ model = 'polmav', label = 'Ambulans Helikopteri', price = 20 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 10 }
	}

}
