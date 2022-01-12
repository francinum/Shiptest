/obj/item/computer2k/part/storage
	name = "abstract computer2k storage device"
	var/datum/computer2k/directory/root //No, you don't get to fight over ext4/btrfs here. You get what you get.
	var/maxsize
	var/current_size



/obj/item/computer2k/part/storage/fixed
	name = "Hard Drive"
	icon_state = "harddisk"
