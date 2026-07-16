extends Node2D
class_name BG_manager


@onready var bg_light: PointLight2D = $bg_light

func _ready() -> void:
	GameState.set_bg(self)

func _process(_delta: float) -> void:
	global_position.x = GameState.player_location.x



func flash_light(color: Color, inc:float , dec: float):
	bg_light.color = color
	var tween = create_tween()
	tween.tween_property(bg_light,"energy",3.0,inc)
	tween.tween_property(bg_light,"energy",0,dec)

func handle_input(p:BGParams):
	flash_light(p.color,p.inc_dur,p.dec_dur)
