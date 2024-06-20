/obj/item/weapon/gun/projectile/submachinegun/ak101
	name = "AK-101"
	desc = "A modern Russian AK variant, chambered in NATO 5.56x45mm."
	icon_state = "ak100"
	item_state = "ak100"
	base_icon = "ak100"
	weight = 3.6
	var/folded = FALSE
	caliber = "a556x45"
	icon = 'icons/obj/guns/assault_rifles.dmi'
	fire_sound = 'sound/weapons/guns/fire/AKM.ogg'
	magazine_type = /obj/item/ammo_magazine/ak101
	good_mags = list(/obj/item/ammo_magazine/ak101)
	equiptimer = 7
	firemodes = list(
		list(name = "semi auto",	burst=1, burst_delay=0.7, recoil=0, move_delay=2),
		list(name = "full auto",	burst=1, burst_delay=1.2, recoil=0, move_delay=4),
		)
	sel_mode = 1
	attachment_slots = ATTACH_IRONSIGHTS|ATTACH_SCOPE|ATTACH_UNDER|ATTACH_BARREL
	accuracy = 1
	recoil = 30
	scope_mounts = list ("dovetail", "picatinny")
	under_mounts = list ("picatinny", "gp25_mount")

/obj/item/weapon/gun/projectile/submachinegun/ak101/update_icon()
	..()
	if (folded)
		icon_state = "[base_icon]_folded"
	else
		icon_state = "[base_icon]"

/obj/item/weapon/gun/projectile/submachinegun/ak101/verb/fold()
	set name = "Toggle Stock"
	set category = null
	set src in usr
	if (folded)
		folded = FALSE
		usr << "You extend the stock on \the [src]."
		equiptimer = 8
		set_stock()
		update_icon()
	else
		folded = TRUE
		usr << "You collapse the stock on \the [src]."
		equiptimer = 6
		set_stock()
		update_icon()

/obj/item/weapon/gun/projectile/submachinegun/ak101/proc/set_stock()
	if (folded)
		slot_flags = SLOT_SHOULDER|SLOT_BELT
	else
		slot_flags = SLOT_SHOULDER


/obj/item/weapon/gun/projectile/submachinegun/ak101/ak102
	name = "AK-102"
	desc = "A modern Russian AK variant, chambered in NATO 5.56x45mm. This is a carbine version of the AK-101."
	icon_state = "ak100"
	item_state = "ak100"
	base_icon = "ak100"
	weight = 3
	magazine_type = /obj/item/ammo_magazine/ak101
	good_mags = list(/obj/item/ammo_magazine/ak101)
	equiptimer = 6
	accuracy = 1
	recoil = 35

/obj/item/weapon/gun/projectile/submachinegun/ak101/ak103
	name = "AK-103"
	desc = "A modern Russian AK variant, chambered in 7.62x39mm."
	icon_state = "ak100"
	item_state = "ak100"
	base_icon = "ak100"
	weight = 3.6
	caliber = "a762x39"
	magazine_type = /obj/item/ammo_magazine/ak47
	good_mags = list(/obj/item/ammo_magazine/rpk47, /obj/item/ammo_magazine/rpk47/drum, /obj/item/ammo_magazine/ak47, /obj/item/ammo_magazine/ak47/makeshift)
	equiptimer = 6
	accuracy = 1
	recoil = 40


/obj/item/weapon/gun/projectile/submachinegun/ak101/ak103/ak104
	name = "AK-104"
	desc = "A modern Russian AK variant, chambered in 7.62x39mm. This is a carbine version of the AK-103."
	icon_state = "ak100"
	item_state = "ak100"
	base_icon = "ak100"
	weight = 3.2
	equiptimer = 6
	accuracy = 2
	recoil = 45

/obj/item/weapon/gun/projectile/submachinegun/ak101/ak105
	name = "AK-105"
	desc = "A modern Russian AK variant, chambered in 5.45x39mm. This is a carbine version of the AK-74M."
	icon_state = "ak100"
	item_state = "ak100"
	base_icon = "ak100"
	caliber = "a545x39"
	weight = 3.2
	equiptimer = 6
	magazine_type = /obj/item/ammo_magazine/ak74
	good_mags = list(/obj/item/ammo_magazine/rpk74, /obj/item/ammo_magazine/rpk74/drum, /obj/item/ammo_magazine/ak74, /obj/item/ammo_magazine/ak74/ak74m)
	accuracy = 2
	recoil = 25

