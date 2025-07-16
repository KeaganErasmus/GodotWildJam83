extends AudioStreamPlayer

const level_music = preload("res://assets/Music/Dark Atmosphere to Synth.wav")
const menu_music = preload("res://assets/Music/The Story Continues.wav")

func play_music():
	if stream == level_music:
		return
	else:
		stream = level_music
		play()

func play_menu_music():
	if stream == menu_music:
		return
	stream = menu_music
	play()

func stop_menu_music():
	if stream == menu_music:
		stream = level_music
		play()
