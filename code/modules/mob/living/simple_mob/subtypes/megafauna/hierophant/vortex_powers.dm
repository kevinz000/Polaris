
#define RECALL_ICON_SPRITE_RADIUS

//The holder for "vortex" abilities, used both by the hierophant and the club it drops.
/datum/component/vortex_powers

	//What abilities the holder has
	var/vortex_abilities = VORTEX_ABILITY_ALL

	//Global cooldown prevents all ability usage
	var/global_cooldown = 0

	//All effects
	var/list/obj/effect/temp_visual/hierophant/all_effects

	//Teleportation
	var/recall_max_beacons = 1
	var/recall_delay = 20
	var/recall_radius = 2
	var/recall_global_cooldown = 0

	//Chasers
	var/list/obj/effect/temp_visual/hierophant/chaser/chasers
	var/chaser_speed = 3
	var/chaser_tiles_per_step = 1
	var/chaser_steps_before_recalc = 4
	var/chaser_damage = 10
	var/chaser_duration = 98
	var/chaser_global_cooldown = 0
	var/chaser_cooldown = 98

	//Walls
	WIP

	//Blasts
	WIP

	//Subtype - Beam blasts
	WIP






/datum/component/vortex_powers/Initialize()
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	all_effects = list()
	chasers = list()
	blah blah register signals

/datum/component/vortex_powers/proc/on_effect_create(obj/effect/hierophant/effect)
	all_effects += effect
	if(istype(effect, /obj/effect/hierophant/chaser))
		chasers += effect

/datum/component/vortex_powers/proc/can_damage(obj/effect/hierophant/effect, atom/target)
	if(target == parent)
		return FALSE
	return TRUE




//TODO: COMSIG PORT
/obj/effect/hierophant/attackby(obj/item/I, mob/user, params)

	if(istype(I, /obj/item/hierophant_club))
		var/obj/item/hierophant_club/H = I
		if(H.timer > world.time)
			return
		if(H.beacon == src)
			to_chat(user, "<span class='notice'>You start removing your hierophant beacon...</span>")
			H.timer = world.time + 51
			INVOKE_ASYNC(H, /obj/item/hierophant_club.proc/prepare_icon_update)
			if(do_after(user, 50, target = src))
				playsound(src,'sound/magic/blind.ogg', 200, 1, -4)
				new /obj/effect/temp_visual/hierophant/telegraph/teleport(get_turf(src), user)
				to_chat(user, "<span class='hierophant_warning'>You collect [src], reattaching it to the club!</span>")
				H.beacon = null
				user.update_action_buttons_icon()
				qdel(src)
			else
				H.timer = world.time
				INVOKE_ASYNC(H, /obj/item/hierophant_club.proc/prepare_icon_update)
		else
			to_chat(user, "<span class='hierophant_warning'>You touch the beacon with the club, but nothing happens.</span>")
	else
		return ..()

