//HTML ENCODE/DECODE + RUS TO CP1251 TODO: OVERRIDE html_encode after fix
/proc/rhtml_encode(var/msg)
	msg = list2text(text2list(msg, "<"), "&lt;")
	msg = list2text(text2list(msg, ">"), "&gt;")
	msg = list2text(text2list(msg, "�"), "&#255;")
	return msg

/proc/rhtml_decode(var/msg)
	msg = list2text(text2list(msg, "&gt;"), ">")
	msg = list2text(text2list(msg, "&lt;"), "<")
	msg = list2text(text2list(msg, "&#255;"), "�")
	return msg


//UPPER/LOWER TEXT + RUS TO CP1251 TODO: OVERRIDE uppertext
/proc/ruppertext(text as text)
	text = uppertext(text)
	var/t = ""
	for(var/i = 1, i <= length(text), i++)
		var/a = text2ascii(text, i)
		if (a > 223)
			t += ascii2text(a - 32)
		else if (a == 184)
			t += ascii2text(168)
		else t += ascii2text(a)
	t = replacetext(t,"&#255;","�")
	return t

/proc/rlowertext(text as text)
	text = lowertext(text)
	var/t = ""
	for(var/i = 1, i <= length(text), i++)
		var/a = text2ascii(text, i)
		if (a > 191 && a < 224)
			t += ascii2text(a + 32)
		else if (a == 168)
			t += ascii2text(184)
		else t += ascii2text(a)
	return t


//TEXT SANITIZATION + RUS TO CP1251
/*
sanitize_simple(var/t,var/list/repl_chars = list("\n"="#","\t"="#","�"="&#255;","<"="(",">"=")"))
	for(var/char in repl_chars)
		var/index = findtext(t, char)
		while(index)
			t = copytext(t, 1, index) + repl_chars[char] + copytext(t, index+1)
			index = findtext(t, char)
	return t
*/


//RUS CONVERTERS
/proc/russian_to_cp1251(var/msg)//CHATBOX
	return list2text(text2list(msg, "�"), "&#255;")

/proc/russian_to_utf8(var/msg)//PDA PAPER POPUPS
	return list2text(text2list(msg, "�"), "&#1103;")

/proc/utf8_to_cp1251(msg)
    return list2text(text2list(msg, "&#1103;"), "&#255;")

/proc/cp1251_to_utf8(msg)
    return list2text(text2list(msg, "&#255;"), "&#1103;")



//TEXT MODS RUS
/proc/capitalize_cp1251(var/t as text)
	var/s = 2
	if (copytext(t,1,2) == ";")
		s += 1
	else if (copytext(t,1,2) == ":")
		s += 2
	return ruppertext(copytext(t, 1, s)) + copytext(t, s)

/proc/intonation(text)
	if (copytext(text,-1) == "!")
		text = "<b>[text]</b>"
	return text