/**
 * Trigger the ship picker.
 *
 */

/proc/ship_picker(mob/dead/new_player/user)
	if (!user)
		user = usr
	if(!istype(user))
		CRASH("Tried to run the ship picker on a non-lobby player of type [user.type]")
	if(!length(buttons))
		return
	if (!istype(user))
		if (istype(user, /client))
			var/client/client = user
			user = client.mob
		else
			return
	var/datum/ship_picker/shipsel = new(user, message, title, buttons, timeout)
	shipsel.ui_interact(user)
	shipsel.wait()
	if (shipsel)
		. = shipsel.choice
		qdel(shipsel)

/datum/ship_picker
	/// Are we done in any way, stores a trigger value and is what's to be returned.
	var/done
	/// Were we closed prematurely?
	var/closed



/**
 * Waits for a user's response to the selection prompt before returning. Returns early if
 * the window was closed by the user.
 */
/datum/ship_picker/proc/wait()
	while (!done && !closed)
		stoplag(1)

/datum/ship_picker/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Shipselect")
		ui.open()

/datum/ship_picker/ui_close(mob/user)
	. = ..()
	closed = TRUE

/datum/ship_picker/ui_act(action, list/params)
	. = ..()
	if (.)
		return
	switch(action)
		if("choose")
			if (!(params["choice"] in buttons))
				return
			set_choice(buttons_map[params["choice"]])
			SStgui.close_uis(src)
			return TRUE
		if("cancel")
			SStgui.close_uis(src)
			closed = TRUE
			return TRUE
