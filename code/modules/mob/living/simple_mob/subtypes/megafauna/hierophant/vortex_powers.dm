
#define RECALL_ICON_SPRITE_RADIUS

//The holder for "vortex" abilities, used both by the hierophant and the club it drops.
/datum/component/vortex_powers

	//What abilities the holder has
	var/vortex_abilities = VORTEX_ABILITY_ALL

	//Global cooldown prevents all ability usage
	var/global_cooldown = 0

	//Teleportation
	var/recall_max_beacons = 1
	var/recall_delay = 20
	var/recall_radius = 2
	var/recall_global_cooldown = 0

	var/

