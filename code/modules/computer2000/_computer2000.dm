/*
 Split these out into their own directories later.
*/

// Embedded controllers still own the `datum/computer` section and I'm not touching that hot mess tonight.

//Astract compute unit. Lives in the computer. Lets us abstract a lot of the nastiness.
/datum/computer2k/compute_unit
	var/name = "Compute Unit"
	var/list/outbuf //List of 20 80 character strings. Yes this is nasty.
	var/obj/machinery/computer2k/hardware
	var/datum/computer2k/data/file/program/active_program

/datum/computer2k/compute_unit/New(cpu_host)
	name = "Compute Unit [rand(0,999999999)]"
	// host = cpu_host
	outbuf = list()


/datum/computer2k/compute_unit/Destroy(force, ...)
	. = ..()
	outbuf.Cut()

/*
 Text Functions
*/

//Print a new line to the output buffer
/datum/computer2k/compute_unit/proc/printline(output)
	if(outbuf?[20]) //Purge the oldest line and insert output in a new cell.
		outbuf.Cut(1,2)
	outbuf += output

//directly write to a specific line of the screen buffer
/datum/computer2k/compute_unit/proc/setline(lindex, output)
	outbuf[lindex] = output


/datum/computer2k/compute_unit/proc/clearscreen()
	outbuf.Cut()

/*
 Program management
*/

/datum/computer2k/compute_unit/proc/stdin(command as text)
	if(!active_program) //what
		CRASH("computecore given input with no program running at all???")
