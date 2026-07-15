extends Node

var player_col_loc:= Vector2(0,0)
var player_location:= Vector2(0,0)
var bg_manager: BG_manager
var player: Player
var animal_resource: AnimalResource
var main_menu = false

signal died
signal changed_state(state: String, dict: Dictionary)



func set_animal_resource(anim: AnimalResource):
	animal_resource = anim

func set_player(play: Player,anim: AnimalResource):
	player = play
	animal_resource = anim
	PlayerFollower.set_animal()

func change_state(state: String, dict: Dictionary = {}):
	emit_signal("changed_state", state, dict)


func start_level():
	AudioManager.reset_sound()
	PlayerFollower.reset()
	player_location = Vector2(0,0)
	player_col_loc= Vector2(0,0)
	
	
func die():
	AudioManager.reset_sound()
	player.die()
	AudioManager.play_sound(AudioManager.Sound.DEATH)
	ParticleManager.play_particle(ParticleManager.particles.DEATH,player.global_position)
	PlayerFollower.reset()
	TriggerHandler.reset()
	SongManager.stop_s()
	player_location = Vector2(0,0)
	player_col_loc= Vector2(0,0)
	await get_tree().create_timer(2.0).timeout
	if !main_menu:
		
		get_tree().call_deferred("reload_current_scene")
	else:
		
		died.emit()



		
func set_bg(bg: BG_manager):
	bg_manager = bg
	
func handle_bg(p: BGParams):
	if bg_manager:
		bg_manager.handle_input(p)
	
