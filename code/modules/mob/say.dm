/mob/proc/say()
	return

/mob/verb/whisper()
	set name = "Whisper"
	set category = "IC"
	return

/mob/verb/say_verb(message as text)
	set name = "Say"
	set category = "IC"
	if (say_disabled)	//This is here to try to identify lag problems
		usr << "<span class = 'red'>Speech is currently admin-disabled.</span>"
		return

	set_typing_indicator(0)
	if (dd_hasprefix(message, "*scream") && isobserver(src))
		usr << "<span class = 'warning'>You can't scream, because you're dead.</span>"
		return

	usr.say(message)

/mob/verb/me_verb(message as text)
	set name = "Me"
	set category = "IC"
	if (ishuman(src))
		var/mob/living/carbon/human/H = src
		if ((H.werewolf || H.gorillaman) && H.icon_state != "human")
			usr << "<span class = 'red'>You can't emote.</span>"
			return
	if (say_disabled)	//This is here to try to identify lag problems
		usr << "<span class = 'red'>Speech is currently admin-disabled.</span>"
		return

	message = sanitize(message)

	set_typing_indicator(0)
	if (use_me)
		usr.emote("me",usr.emote_type,message)
	else
		usr.emote(message)

/mob/proc/say_dead(var/message)
	if (say_disabled)	//This is here to try to identify lag problems
		usr << "<span class='danger'>Speech is currently admin-disabled.</span>"
		return
	if (client)
		if (!client.holder)
			if (!config.dsay_allowed)
				src << "<span class='danger'>Deadchat is globally muted.</span>"
				return

	if (!is_preference_enabled(/datum/client_preference/show_dsay))
		usr << "<span class='danger'>You have deadchat muted.</span>"
		return

	say_dead_direct("[pick("complains","moans","whines","laments","blubbers")], <span class='message'>\"[message]\"</span>", src)

/mob/proc/say_understands(var/mob/other,var/datum/language/speaking = null)

	if (stat == 2)		//Dead
		return TRUE

	//Universal speak makes everything understandable, for obvious reasons.
	else if (universal_speak || universal_understand)
		return TRUE

	//Languages are handled after.
	if (!speaking)
		if (!other)
			return TRUE
		if (other.universal_speak)
			return TRUE
		if (istype(other, type) || istype(src, other.type))
			return TRUE
		return FALSE

	if (speaking.flags & INNATE)
		return TRUE

	//Language check.
	for (var/datum/language/L in languages)
		if (speaking.name == L.name)
			return TRUE

	return FALSE

/*
   ***Deprecated***
   let this be handled at the hear_say or hear_radio proc
   There is no language handling build into it however there is at the /mob level so we accept the call
   for it but just ignore it.
*/

/mob/proc/say_quote(var/message, var/datum/language/speaking = null)
        var/verb = "says"
        var/ending = copytext(message, length(message))
        if (ending=="!")
                verb=pick("exclaims","shouts","yells")
        else if (ending=="?")
                verb="asks"

        return verb


/mob/proc/emote(var/act, var/type, var/message)
	if (act == "me")
		return custom_emote(type, message)

/mob/proc/get_ear()
	// returns an atom representing a location on the map from which this
	// mob can hear things

	// should be overloaded for all mobs whose "ear" is separate from their "mob"

	return get_turf(src)

/mob/proc/say_test(var/text)
	var/ending = copytext(text, length(text))
	if (ending == "?")
		return "1"
	else if (ending == "!")
		return "2"
	return "0"

//parses the message mode code (e.g. :h, :w) from text, such as that supplied to say.
//returns the message mode string or null for no message mode.
//standard mode is the mode returned for the special ';' radio code.
/mob/proc/parse_message_mode(var/message, var/standard_mode="headset")
	if (length(message) >= 1 && copytext(message,1,2) == ";")
		return standard_mode

	if (length(message) >= 2)
		var/channel_prefix = copytext(message, TRUE ,3)
		return department_radio_keys[channel_prefix]

	return null

//parses the language code (e.g. :j) from text, such as that supplied to say.
//returns the language object only if the code corresponds to a language that src can speak, otherwise null.
/mob/proc/parse_language(var/message)
	var/prefix = copytext(message,1,2)
	if (length(message) >= 1 && prefix == "!")
		return all_languages["Noise"]

	if (length(message) >= 2 && is_language_prefix(prefix))
		var/language_prefix = lowertext(copytext(message, 2 ,3))
		var/datum/language/L = language_keys[rkey2key(language_prefix)]
		if (can_speak(L))
			return L

	return null
