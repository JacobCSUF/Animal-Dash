extends Node2D
class_name AnimationSounds
@onready var collision_shape_2d: CollisionShape2D = $"../CollisionShape2D"
@onready var a_col: CollisionShape2D = $"../Area2D/a_col"
@export var player: Player

@onready var float_wind: AudioStreamPlayer2D = $FloatWind
@onready var state_animations: AnimationPlayer = $"../state_animations"


var old_group

func handle_new_group():
	if player.curr_group == old_group:
		return
	
	old_group = player.curr_group 
	match player.curr_group:
		#####FLAPPY#############
		Player.StateType.FLAPPY:
			player.icon.play("flappy")
		
		#####FLOAT#############
		Player.StateType.FLOAT:
			player.icon.play("float")
			PlayerFollower.play_float_trail()
			float_wind.play()
			
			player.icon.frame = 0
		#####BALL#############
		Player.StateType.BALL:
			state_animations.play("spin")
			player.icon.play("ball")

		Player.StateType.CART:
			collision_shape_2d.call_deferred("set_disabled",true)
			a_col.call_deferred("set_disabled",true)
			player.icon.visible = false


func handle_exit_group():
	
	if !old_group:
		return

	if player.curr_group == old_group:
		return
		
	match old_group:
		Player.StateType.FLAPPY:
			player.icon.stop()
			
		
		#####FLOAT#############
		#####FLOAT#############
		Player.StateType.FLOAT:
			PlayerFollower.stop_float_trail()
			
			float_wind.stop()
		
		#####BALL#############
		Player.StateType.BALL:
			state_animations.play("RESET")
			state_animations.stop()
			

		Player.StateType.CART:
			a_col.call_deferred("set_disabled",false)
			collision_shape_2d.call_deferred("set_disabled",false)
			player.icon.visible = true
