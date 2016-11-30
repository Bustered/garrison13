/obj/structure/barbed_wire
	name = 			"barbed wire"
	desc = 			"A strand of wires having small pieces of sharply pointed wires like spikes."
	icon = 			'icons/obj/barbed_wire.dmi'
	icon_state = 	"wire_t"
	anchored =		1
	buckle_lying = 	0
	density = 		0
	obj_integrity = 50

/obj/structure/barbed_wire/Crossed(atom/movable/AM, mob/living/buckled_mob, mob/user) //when the user passes, all the stuff below happens
	if(isliving(AM))
		if(icon_state == "wire_cut1")
			return
		var/mob/living/L = AM
		barbed_wire_wound(L)
		buckle_mob(L)

/obj/structure/barbed_wire/proc/barbed_wire_wound(mob/living/L)
	L << "<span class='danger'><B>Your body gets torn in the barbed wire!</B></span>"
	L.apply_damage(10, BRUTE, null) //does damage to random body part

/obj/structure/barbed_wire/user_unbuckle_mob(mob/living/buckled_mob, mob/user) //handles unbuckling mob
	var/mob/living/M = buckled_mob
	if(M)
		M.visible_message(\
			"<span class='warning'>[M] struggles to break free from [src]!</span>",\
			"<span class='notice'>You struggle to free yourself... (Stay still for five seconds.)</span>",\
			"<span class='italics'>You hear rips...</span>")
		if(!do_after(M, 50, target = src))
			M << "<span class='warning'>You fail to free yourself!</span>"
			return
		M.visible_message(\
			"<span class='warning'>[M] rips themselves from [src]!</span>",\
			"<span class='warning'>You rip yourself from [src]!</span>",\
			"<span class='italics'>You hear ripping...</span>")
	unbuckle_mob(M)
	barbed_wire_wound(M)

/obj/structure/barbed_wire/buckle_mob(mob/living/M) //handles buckling the mob for the crossed function
	M.buckled = src
	M << "<span class='danger'><B>You get stuck in [src]!</B></span>"

/obj/structure/barbed_wire/attackby(obj/item/weapon/W, mob/living/buckled_mob, mob/user, params) //handles cutting the barbed wire and changes it's state
	if(istype(W, /obj/item/weapon/wirecutters))
		icon_state = "wire_cut1"
		playsound(loc, W.usesound, 100, 1)
		unbuckle_mob(buckled_mob)

/obj/structure/barbed_wire/wp
	icon_state = "wire_pole"

/obj/structure/barbed_wire/we
	icon_state = "wire_edge"

/obj/structure/barbed_wire/wb1
	icon_state = "wire_broken1"

/obj/structure/barbed_wire/wb2
	icon_state = "wire_broken2"

/obj/structure/barbed_wire/ww
	icon_state = "wire_whole"

/obj/structure/barbed_wire/wc1
	icon_state = "wire_cut1"

/obj/structure/barbed_wire/wc2
	icon_state = "wire_cut2"

/obj/structure/barbed_wire/we
	icon_state = "wire_end"