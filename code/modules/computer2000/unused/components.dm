//This can come later. For now I need to work on the basics.

//Physical hardware structs
/obj/item/computer2k

//Mainboard, holds 'pluggable' devices.
/obj/item/computer2k/mainboard
	var/obj/item/computer2k/pluggable/processor/main_cpu //All boards have at least one of these.
	var/list/obj/item/computer2k/pluggable/databus //the primary data bus, includes the main cpu.
	var/list/slots_max = list(
	PLUGGABLE_SLOT_CPU = 1,
	PLUGGABLE_SLOT_BIOSROM = 1,
	PLUGGABLE_SLOT_RTC = 1
	)
	var/list/slots_current = list()

/obj/item/computer2k/mainboard/Initialize()
	. = ..()
	slots_current = slots_max.Copy()
	for(var/key in slots_current)
		slots_current[key] = 0

/// Handles the logical part of installing. Doesn't care about physical location.
/obj/item/computer2k/mainboard/proc/add(var/obj/item/computer2k/pluggable/new_part)
	if(!(new_part.slot_type in slots_current))
		return PLUGFAIL_NO_SLOT
	if(slots_current[new_part.slot_type] == slots_max[new_part.slot_type])
		return PLUGFAIL_SLOTS_FULL
	if(istype(new_part, /obj/item/computer2k/pluggable/processor))
		main_cpu = new_part
	databus += new_part
	new_part.added(src)
	slots_current[new_part.slot_type]++

/// Handles the logical part of removing components. Doesn't care about physical location.
/obj/item/computer2k/mainboard/proc/remove(var/obj/item/computer2k/pluggable/removed_part)
	if(removed_part == main_cpu) //Hey buddy what the fuck?
		main_cpu = null
		//Do something wacky to complain about you ripping the fucking CPU out of a running machine
	databus -= removed_part
	removed_part.removed(src)
	slots_current[removed_part.slot_type]--

/obj/item/computer2k/mainboard/Destroy()
	. = ..()
	if(main_cpu)
		remove(main_cpu)
		qdel(main_cpu)
	for(var/pluggable in databus)
		remove(pluggable)
		qdel(pluggable)

// Devices that fit into mainboards.
/obj/item/computer2k/pluggable
	var/obj/item/computer2k/mainboard/hostboard
	var/slot_type //plug slot type, see _DEFINES/computer2k.dm

/obj/item/computer2k/pluggable/proc/added(var/obj/item/computer2k/mainboard/host)
	hostboard = host


/obj/item/computer2k/pluggable/proc/removed(var/obj/item/computer2k/mainboard/host)
	hostboard = null

/obj/item/computer2k/pluggable/Destroy()
	. = ..()
	if(hostboard)
		hostboard.remove(src)
		hostboard = null

//Processor, hosts compute units. Can also hold 'on-die' components.
/obj/item/computer2k/pluggable/processor
	var/datum/computer2k/compute_unit/compcore
	slot_type = PLUGGABLE_SLOT_CPU

/obj/item/computer2k/pluggable/processor/Destroy()
	. = ..()
	if(compcore)
		qdel(compcore)

//Peripherals, can be directly interacted with and are associated with a TGUI component.
/obj/item/computer2k/peripheral

/datum/computer2k/file
