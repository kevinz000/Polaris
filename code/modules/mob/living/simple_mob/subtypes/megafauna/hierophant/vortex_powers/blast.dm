/datum/component/vortex_powers
	var/blast_enabled = TRUE
	var/blast_directions
	var/blast_damage = 15
	var/blast_global_cooldown = 0
	var/blast_cooldown = 10
	var/blast_hit_delay = 6
	var/blast_hit_duration = 1.3
	var/blast_size = 13

/datum/component/vortex_powers/Initialize()
	. = ..()
	if(isnull(blast_directions))
		blast_directions = GLOB.alldirs
	RegisterSignal(src, COMSIG_VORTEX_BLAST, .proc/vortex_blast)

/datum/component/vortex_powers/proc/vortex_blast(force = FALSE, size = blast_size, damage = blast_damage, dirs = blast_directions, hit_delay = blast_hit_delay, hit_duration = blast_hit_duration, cooldown = blast_cooldown, global_cooldown = blast_global_cooldown)


/datum/component/vortex_powers/proc/vortex_blast_onhit(obj/effect/hierophant/blast, atom/target)
	return

/obj/effect/temp_visual/hierophant/blast
	icon_state = "hierophant_blast"
	name = "vortex blast"
	light_range = 2
	light_power = 2
	desc = "Get out of the way!"
	duration = 9
	var/damage = 10 //how much damage do we do?
	var/list/hit_things = list() //we hit these already, ignore them
	var/bursting = FALSE //if we're bursting and need to hit anyone crossing us

/obj/effect/temp_visual/hierophant/blast/Initialize(mapload, new_caster, friendly_fire)
	. = ..()
	friendly_fire_check = friendly_fire
	if(new_caster)
		hit_things += new_caster
	if(ismineralturf(loc)) //drill mineral turfs
		var/turf/closed/mineral/M = loc
		M.gets_drilled(caster)
	INVOKE_ASYNC(src, .proc/blast)

/obj/effect/temp_visual/hierophant/blast/proc/blast()
	var/turf/T = get_turf(src)
	if(!T)
		return
	playsound(T,'sound/magic/blind.ogg', 125, 1, -5) //make a sound
	sleep(6) //wait a little
	bursting = TRUE
	do_damage(T) //do damage and mark us as bursting
	sleep(1.3) //slightly forgiving; the burst animation is 1.5 deciseconds
	bursting = FALSE //we no longer damage crossers

/obj/effect/temp_visual/hierophant/blast/Crossed(atom/movable/AM)
	..()
	if(bursting)
		do_damage(get_turf(src))

/obj/effect/temp_visual/hierophant/blast/proc/do_damage(turf/T)
	if(!damage)
		return
	for(var/mob/living/L in T.contents - hit_things) //find and damage mobs...
		hit_things += L
		if((friendly_fire_check && caster && caster.faction_check_mob(L)) || L.stat == DEAD)
			continue
		if(L.client)
			flash_color(L.client, "#660099", 1)
		playsound(L,'sound/weapons/sear.ogg', 50, 1, -4)
		to_chat(L, "<span class='userdanger'>You're struck by a [name]!</span>")
		var/limb_to_hit = L.get_bodypart(pick(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG))
		var/armor = L.run_armor_check(limb_to_hit, "melee", "Your armor absorbs [src]!", "Your armor blocks part of [src]!", 50, "Your armor was penetrated by [src]!")
		L.apply_damage(damage, BURN, limb_to_hit, armor)
		if(ishostile(L))
			var/mob/living/simple_animal/hostile/H = L //mobs find and damage you...
			if(H.stat == CONSCIOUS && !H.target && H.AIStatus != AI_OFF && !H.client)
				if(!QDELETED(caster))
					if(get_dist(H, caster) <= H.aggro_vision_range)
						H.FindTarget(list(caster), 1)
					else
						H.Goto(get_turf(caster), H.move_to_delay, 3)
		if(monster_damage_boost && (ismegafauna(L) || istype(L, /mob/living/simple_animal/hostile/asteroid)))
			L.adjustBruteLoss(damage)
		log_combat(caster, L, "struck with a [name]")
	for(var/obj/mecha/M in T.contents - hit_things) //also damage mechs.
		hit_things += M
		if(M.occupant)
			if(friendly_fire_check && caster && caster.faction_check_mob(M.occupant))
				continue
			to_chat(M.occupant, "<span class='userdanger'>Your [M.name] is struck by a [name]!</span>")
		playsound(M,'sound/weapons/sear.ogg', 50, 1, -4)
		M.take_damage(damage, BURN, 0, 0)
