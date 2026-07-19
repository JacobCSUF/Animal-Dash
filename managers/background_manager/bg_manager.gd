extends Node2D
class_name BG_manager

@onready var label: RichTextLabel = $Label

@onready var bg_text: Sprite2D = $bg_text
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

func modulate_background(color:= Color(0.096, 0.096, 0.096, 0.495),time:=0.4):
	var tween = create_tween()
	tween.tween_property(bg_text,"modulate",color,time)




func handle_input(p:BGParams):
	flash_light(p.color,p.inc_dur,p.dec_dur)
	


func play_death(percent: int):
	
	label.text = str(percent)+"[font_size=38]%[/font_size]"
	var tween = create_tween()
	tween.tween_property(label,"modulate",Color(1.0, 1.0, 1.0, 1.0),0.5)
	
	modulate_background()
