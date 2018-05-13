class BRM_insurgency_respawn
{
	class fnc {
		file = "framework\plugins\insurgency_respawn\functions";
		class closeDialog{};
		class findNearest{};
		class keyDown{};
		class openDialog{};
		class selectSpawn{};
		class selectUnit{};
		class spawnOn{};
		class spawnOnNearest{};
		class telePort{};
		class telePortVehicle{};
	};
	class vehicles_fnc {
		file = "framework\plugins\insurgency_respawn\functions\vehicles";
		class addVehicleToList{};
		class respawnVehicle{};
	};
	class players_fnc {
		file = "framework\plugins\insurgency_respawn\functions\players";
		class addRespawnTime{};
		class evaluateRespawnTime{};
		class findRespawnTime{};
		class removeRespawnTime{};
		class respawnMenu{};
	};
	class init {
		file = "framework\plugins\insurgency_respawn\functions";
		class postInit{postInit = 1;};
	};
};