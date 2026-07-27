extends Node2D
class_name LightBulb

@onready var panel: Panel = $Panel
@onready var anis: AnimationPlayer = $anis
@onready var label: RichTextLabel = $Panel/Label
@onready var switch_on: AudioStreamPlayer = $SwitchOn

var is_triggered = false
var level_num := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panel.visible = false
	


func set_text(description: String,num: int):
	is_triggered = false
	label.text = description
	level_num = num
	if SaveManager.get_tutorial_hint(num):
		anis.play("half")
		is_triggered = true
	else:
		anis.play("blink")
	panel.visible = false
	


	
func _on_button_pressed() -> void:
	if !panel.visible:
		switch_on.pitch_scale = 1.75
		switch_on.volume_db = -17
		switch_on.play()
		panel.visible = true
		anis.play("on")
		if !is_triggered:
			SaveManager.set_tutorial_hint(level_num)
			is_triggered = true
			
	else:
		switch_on.pitch_scale = 1.25
		switch_on.volume_db = -23
		switch_on.play()
		panel.visible = false
		if is_triggered:
			anis.play("half")
		else:
			anis.play("blink")
