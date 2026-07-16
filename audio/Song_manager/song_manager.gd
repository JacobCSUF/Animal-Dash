extends Node2D
@onready var lvl_0: AudioStreamPlayer = $AdventureMusic
@onready var lvl_1: AudioStreamPlayer = $LuminkaiCrystalSkies170913
@onready var lvl_2: AudioStreamPlayer = $ChristmasSnow179849
@onready var lvl_3: AudioStreamPlayer = $DigitalOverture408211
@onready var lvl_4: AudioStreamPlayer = $WaterMusic



var curr_song: AudioStreamPlayer

func play_song():
	if curr_song:
		curr_song.play()


func set_song(num = 0):
	if num == 0:
		curr_song = lvl_0
	elif num == 1:
		curr_song = lvl_1
	elif num ==2:
		curr_song = lvl_2
	elif num ==3:
		curr_song = lvl_3
	elif num ==4:
		curr_song = lvl_4
	
func play_sound(player: AudioStreamPlayer2D):
	player.play()

func stop_s():
	if curr_song:
		curr_song.stop()


func fade_out(volume:= 0.0, time:= 1.0):
	
	var tween = create_tween()
	tween.tween_property(curr_song, "volume_db", volume, time)
	
func play_drop():
	var tween = create_tween()
	curr_song.seek(47.4) 
	tween.tween_property(curr_song, "volume_db", -12.5, 2.5)
	
	
	
	
func change_speed(_pitch: float):
	#var tween = get_tree().create_tween()
	#tween.tween_property(curr_song,"pitch_scale",curr_song.pitch_scale + pitch,0.1)
	pass
