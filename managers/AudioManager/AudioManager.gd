extends Node

const MAX_HEIGHT = -18.0
const MIN_HEIGHT = 273.0

enum Sound{DASH,FIREWORK,SWOOSH1,WATER,FAIRYD,UIBUTTON,SWOOSHLOOP1,COIN,ICE,CANNON, SWOOSH2,DEATH, SWOOSH3,CREAK}


var sound_map ={
	Sound.DASH: preload("uid://c2glxcj5ajdv6"),
	Sound.FIREWORK: preload("uid://dqfsmfn0owe1f"),
	Sound.WATER: preload("uid://buvj1er471afn"),
	Sound.SWOOSH1: preload("uid://csa2wm55qi436"),
	Sound.FAIRYD: preload("uid://bctppa48lugdt"),
	Sound.UIBUTTON: preload("uid://cq5p680rxtmwp"),
	Sound.SWOOSHLOOP1: preload("uid://tor0hwwcmpex"),
	Sound.COIN: preload("uid://dxj06sxqwsra2"),
	Sound.ICE: preload("uid://6fbyuiyvroe1"),
	Sound.CANNON: preload("uid://dycwn72ij7e3"),
	Sound.SWOOSH2: preload("uid://bh8xokceh11bm"),
	Sound.DEATH: preload("uid://cb5lxf61pcvvo"),
	Sound.SWOOSH3:preload("uid://c2x6uvjn2vvv8"),
	Sound.CREAK:preload("uid://djio8lxrvnadh")
	
}


enum CSounds{GMOVE,WMOVE,GSPLASH,WSPLASH}

var CartMap={
	CSounds.GMOVE: preload("uid://ncsi3allu78x"),
	CSounds.WMOVE: preload("uid://djrgh0trdcn2r"),
	CSounds.GSPLASH: preload("uid://b23m104e6ily2"),
	CSounds.WSPLASH: preload("uid://cb01dw0wft6p1")
}


enum Scale{BUTTON} 

var Scale_map = {
	Scale.BUTTON: preload("uid://dfmrlipel3efm")
}



var sound_queues = {}

var loop_sounds= []


func route_sound(sound: Sound,pos: Vector2 = Vector2(0,0),data: SoundParams = null):
	var s_data: SoundResource = sound_map[sound]
	print('SDNijhsdfbsdjhk')
	if s_data.cooldown == 0:
		play_sound(sound,pos,data)
		return
	
	if !sound_queues.has(sound):
		sound_queues[sound] = {"data":[]
		,"cd":s_data.cooldown,"c": s_data.cooldown}
		
	
	sound_queues[sound]["data"].append({"pos":pos,"data":data})

	
	

func play_sound(sound: Sound,pos: Vector2 = Vector2(0,0),data: SoundParams = null):
	
	var s_data: SoundResource = sound_map[sound]
	var player = AudioStreamPlayer.new()
	
	if pos!= Vector2(0,0):
		player= AudioStreamPlayer2D.new()
		player.global_position = pos
		player.max_distance = s_data.range

	player.stream = s_data.sound
	add_child(player)
	player.volume_db = s_data.volume
	
	player.pitch_scale = s_data.pitch
	if data:
		if data.is_pitch_overide:
			player.pitch_scale = data.pitch
		if data.is_volume_overide:
			player.volume_db = data.volume
	var r = randf_range(-s_data.random_pitch,s_data.random_pitch)
	player.pitch_scale += r
	
	
	player.play()
	player.finished.connect(player.queue_free)
	


func _process(delta: float) -> void:
	for sq in sound_queues:
		
		var sd = sound_queues[sq]
		if sd["data"].size() > 0:
			if sd["c"] >= sd["cd"]:
				play_sound(sq,sd["data"][0]["pos"],sd["data"][0]["data"])
				sd["data"].pop_front()
				sd["c"] = 0
			else:
				sd["c"] += delta
		else:
			sd["c"] += delta
				

	
	
	
func get_height_adjustment(height_range: float,position: int):
	
	var y = position
	y = clamp(y, MAX_HEIGHT, MIN_HEIGHT)
	
	
	var part = y - MAX_HEIGHT
	var whole = MIN_HEIGHT - MAX_HEIGHT
	var percent = part/whole
	
	var change_value = (percent * height_range) - height_range/2.0
	
	return -change_value



func play_unreg_sound(sound: AudioStreamPlayer2D,pitch_rnd):
	var r = randf_range(-pitch_rnd,pitch_rnd)
	sound.pitch_scale += r
	sound.play()
	
	
func play_packed_audio(aud: AudioStream,volume,pitch):
	var a = AudioStreamPlayer.new()
	a.stream = aud
	a.volume_db= volume
	a.pitch_scale = pitch
	add_child(a)
	a.play()
	a.finished.connect(a.queue_free)
	
	
func play_scale(st: Scale):
	var sd: ScaleResource = Scale_map[st]
	var player = AudioStreamPlayer.new()
	add_child(player)
	player.pitch_scale = sd.return_pitch()
	player.volume_db = sd.volume
	player.stream = sd.sound
	player.play()

	player.finished.connect(player.queue_free)
	
	
func play_cart_sound(sound: CSounds):
	var player = AudioStreamPlayer.new()
	var x: SoundResource = CartMap[sound]
	player.pitch_scale = x.pitch
	player.volume_db = x.volume
	var r = randf_range(-x.random_pitch,x.random_pitch)
	player.pitch_scale += r
	player.stream = x.sound
	add_child(player)
	player.play()
	player.add_to_group("sound22")
	player.finished.connect(player.queue_free)
	
	return player
	
func reset_sound():
	var x = get_tree().get_nodes_in_group("sound22")
	for i in x:
		i.queue_free()
