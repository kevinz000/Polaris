
#define VORTEX_ABILITY_RECALL			(1<<0)
#define VORTEX_ABILITY_WALL				(1<<1)
#define VORTEX_ABILITY_CARDINAL_BLAST	(1<<2)
#define VORTEX_ABILITY_DIAGONAL_BLAST	(1<<3)
#define VORTEX_ABILITY_BEAM_BLAST		(1<<4)
#define VORTEX_ABILITY_SPIRAL_BLAST		(1<<5)
#define VORTEX_ABILITY_MELEE_BLAST		(1<<6)
#define VORTEX_ABILITY_MOB_DAMAGE		(1<<7)
#define VORTEX_ABILITY_TELEPORT			(1<<8)
#define VORTEX_ABILITY_STRUCTURE_DAMAGE	(1<<9)
#define VORTEX_ABILITY_BLINK_DASH		(1<<10)
#define VORTEX_ABILITY_HEAL				(1<<11)
#define VORTEX_ABILITY_REPULSE			(1<<12)
#define VORTEX_ABILITY_DRILLTURF		(1<<13)
#define VORTEX_ABILITY_NODROP			(1<<14)
#define VORTEX_ABILITY_LIGHT			(1<<15)
#define VORTEX_ABILITY_ATTRACT			(1<<16)
#define VORTEX_ABILITY_BLOCK_THROW		(1<<17)
#define VORTEX_ABILITY_BLOCK_PROJECTILE	(1<<18)
#define VORTEX_ABILITY_BLOCK_MELEE		(1<<19)
#define VORTEX_ABILITY_CHASER			(1<<20)

#define VORTEX_ABILITY_ALL ALL

#define VORTEX_ANIMATION_RADIUS_RECALL		2		//3x3
#define VORTEX_ANIMATION_DURATION_BLAST		10		//deciseconds
#define VORTEX_ANIMATION_DURATION_TELEGRAPH	2		//deciseconds
#define VORTEX_ANIMATION_DURATION_TELEPORT	9		//deciseconds
#define VORTEX_ANIMATION_DURATION_TELEFADE	37.5	//deciseconds

#define VORTEX_DAMAGE_MODE_ALL		1
#define VORTEX_DAMAGE_MODE_HOSTILE	2
#define VORTEX_DAMAGE_MODE_NONE		3

#define VORTEX_WALL_MODE_ARENA			1
#define VORTEX_WALL_MODE_LINE_CROSS		2
#define VORTEX_WALL_MODE_LINE_PARALLEL	3


/proc/vortex_ability_text(flag)
	. = list()
	if(flag & VORTEX_ABILITY_RECALL)
		. += "Beaconed Recall"
	if(flag & VORTEX_ABILITY_WALL)
		. += "Vortex Barrier"
	if(flag & VORTEX_ABILITY_CARDINAL_BLAST)
		. += "Cardinal Blast"
	if(flag & VORTEX_ABILITY_DIAGONAL_BLAST)
		. += "Diagonal Blast"
	if(flag & VORTEX_ABILITY_BEAM_BLAST)
		. += "Vortex Beam"
	if(flag & VORTEX_ABILITY_SPIRAL_BLAST)
		. += "Vortex Explosion"
	if(flag & VORTEX_ABILITY_MELEE_BLAST)
		. += "Vortex Smash"
	if(flag & VORTEX_ABILITY_MOB_DAMAGE)
		. += "Burn Lifeform"
	if(flag & VORTEX_ABILITY_TELEPORT)
		. += "Vortex Blink"
	if(flag & VORTEX_ABILITY_STRUCTURE_DAMAGE)
		. += "Burn Structure"
	if(flag & VORTEX_ABILITY_BLINK_DASH)
		. += "Blink Dash"
	if(flag & VORTEX_ABILITY_HEAL)
		. += "Lifemend"
	if(flag & VORTEX_ABILITY_REPULSE)
		. += "Vortex Repulsion"
	if(flag & VORTEX_ABILITY_DRILLTURF)
		. += "Mineral Shatter"
	if(flag & VORTEX_ABILITY_NODROP)
		. += "Death Grip"
	if(flag & VORTEX_ABILITY_LIGHT)
		. += "Void Light"
	if(flag & VORTEX_ABILITY_ATTRACT)
		. += "Vortex Attraction"
	if(flag & VORTEX_ABILITY_BLOCK_PROJECTILE)
		. += "Void Deflection (Projectile)"
	if(flag & VORTEX_ABILITY_BLOCK_THROW)
		. += "Void Deflection (Thrown Instances)"
	if(flag & VORTEX_ABILITY_BLOCK_MELEE)
		. += "Void Parry"
	if(flag & VORTEX_ABILITY_CHASER)
		. += "Vortex Chaser"
	if(length(.) == 1)
		return .[1]
	else if(!length(.))
		return "None"
	return english_list(.)

//The holder for "vortex" abilities, used both by the hierophant and the club it drops.
/datum/component/vortex_powers

	//What abilities the holder has
	var/vortex_abilities = VORTEX_ABILITY_ALL

	//Global cooldown prevents all ability usage
	var/global_cooldown = 0

	//what things it'll hit
	var/damage_mode = VORTEX_DAMAGE_ALL
	var/structural_damage = FALSE

	//All effects
	var/list/obj/effect/temp_visual/hierophant/all_effects

	//Teleportation
	var/list/obj/effect/hierophant/beacon/beacons
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
	var/chaser_can_diagonal = FALSE
	var/chasers_max = 1

	//Walls
	var/list/obj/effect/temp_visual/hierophant/wall/walls
	var/wall_mode










#define VORTEX_ABILITY_RECALL			(1<<0)
#define VORTEX_ABILITY_WALL				(1<<1)
#define VORTEX_ABILITY_CARDINAL_BLAST	(1<<2)
#define VORTEX_ABILITY_DIAGONAL_BLAST	(1<<3)
#define VORTEX_ABILITY_BEAM_BLAST		(1<<4)
#define VORTEX_ABILITY_SPIRAL_BLAST		(1<<5)
#define VORTEX_ABILITY_MELEE_BLAST		(1<<6)
#define VORTEX_ABILITY_MOB_DAMAGE		(1<<7)
#define VORTEX_ABILITY_TELEPORT			(1<<8)
#define VORTEX_ABILITY_STRUCTURE_DAMAGE	(1<<9)
#define VORTEX_ABILITY_BLINK_DASH		(1<<10)
#define VORTEX_ABILITY_HEAL				(1<<11)
#define VORTEX_ABILITY_REPULSE			(1<<12)
#define VORTEX_ABILITY_DRILLTURF		(1<<13)
#define VORTEX_ABILITY_NODROP			(1<<14)
#define VORTEX_ABILITY_LIGHT			(1<<15)
#define VORTEX_ABILITY_ATTRACT			(1<<16)
#define VORTEX_ABILITY_BLOCK_THROW		(1<<17)
#define VORTEX_ABILITY_BLOCK_PROJECTILE	(1<<18)
#define VORTEX_ABILITY_BLOCK_MELEE		(1<<19)



/datum/component/vortex_powers/Initialize()
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	all_effects = list()
	chasers = list()
	walls = list()
	beacons = list()
	blah blah register signals

blah blah destroy() delete every effect etc etc

/datum/component/vortex_powers/proc/on_effect_create(obj/effect/hierophant/effect)
	all_effects += effect

/datum/component/vortex_powers/proc/on_effect_destroy(obj/effect/hierophant/effect)
	all_effects -= effect

/datum/component/vortex_powers/proc/can_damage(obj/effect/hierophant/effect, atom/target)
	if(target == parent)
		return FALSE
	return TRUE

/datum/component/vortex_powers/proc/check_global_cooldown()
	return (global_cooldown < world.time)


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

