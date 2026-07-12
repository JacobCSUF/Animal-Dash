extends Node2D
class_name SoundIncManager

enum inc_type{COIN,CANNON,SPEEDUP,SLOWDOWN,TODASH, SPIN}

const  s := AudioManager.Sound


var type_map = {
	inc_type.COIN: {
		"pitch": .69,
		"step": 1.059463
	},
	inc_type.CANNON: {
		"pitch": 1.7,
		"step": 1.059463
	},
	inc_type.SPEEDUP: {
		"pitch": 2.2,
		"step": 1.15,
	},
	inc_type.SLOWDOWN: {
		"pitch": 2.2,
		"step": 1.15,
		"reverse": true
	},
	inc_type.TODASH: {
		"pitch": 1.0,
		"step": 1.059463,
	},
	inc_type.SPIN: {
		"pitch": 3.3,
		"step": 1.059463,
	},
}



func _ready() -> void:
	call_deferred("_fetch_group")

class GroupClass:
	var total_num: int
	var counter:= 1
	var starting_pitch:= 1.0
	var step = 0.05
	var reverse = false
	
	func get_total():
		return total_num
	
	func add_counter():
		counter += 1
	
	func add_total():
		total_num+= 1
	
	func set_starting_pitch(type1,map):
		var s = map[type1]
		var p = s["pitch"]
		step = s["step"]
		if s.has("reverse"):
			reverse = true
			starting_pitch = p*(step**(total_num/2.0))
		else:
			starting_pitch = p/(step**(total_num/2.0))
	
		
	func get_pitch():
		if reverse:
			starting_pitch /= step
			add_counter() 
			return starting_pitch 
		else:
			starting_pitch *= step
			add_counter() 
			return starting_pitch 
	
var group_dict = {}
func _fetch_group():
	for obj: SoundIncComponent in get_tree().get_nodes_in_group("sound_inc"):
		
		if obj.number_group == 0:
			continue
		if !group_dict.has(obj.sound_type):
			group_dict[obj.sound_type] = {}
			
		if !group_dict[obj.sound_type].has(obj.number_group):
			group_dict[obj.sound_type][obj.number_group] = GroupClass.new()
			
		group_dict[obj.sound_type][obj.number_group].add_total()
		
		obj.play_sound.connect(_on_play_sound)
		
	for i in group_dict:
		for j in group_dict[i]:
			var type1 = i
			if !type_map.has(i):
				type1 = s.COIN
				
			
			group_dict[i][j].set_starting_pitch(type1,type_map)
	

			

func _on_play_sound(num: int, t: AudioManager.Sound,b: SoundIncComponent):
	var p = group_dict[t][num].get_pitch()
	
	b.send_pitch(p)
	
