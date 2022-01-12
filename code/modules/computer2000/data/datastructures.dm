//We don't give a shit about permissions right now. SEOS/4 coming maybe[tm]

/// Abstract datatype. Exists. Can be deleted.
/datum/computer2k/data
	var/name = "BAD_SECTORS"
	var/class = "ERR" // Three character 'class', entirely cosmetic, used for directory listings.
	var/size = 0
	var/obj/item/computer2k/part/storage/drive
	var/datum/computer2k/data/directory/s_directory



///Abstract file.
/datum/computer2k/data/file
	var/class = "BIN"

/datum/computer2k/data/file/Destroy(force, ...)
	. = ..()
	s_directory.rm(src)

/datum/computer2k/data/directory
	class = "DIR"
	var/depth //Don't want to let these get TOO deep.

/datum/computer2k/data/directory/proc/writedata(var/datum/computer2k/data/newdata)
	if((newdata.size + drive.current_size) > drive.maxsize)
		return ERR_STORAGE_FULL


/datum/computer2k/data/directory/proc/rm(var/datum/computer2k/data/target)
	drive.

/datum/computer2k/data/file/program
	class = "EXE"
