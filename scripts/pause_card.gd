extends Control
class_name PauseCard

signal button_pressed(menu: MenuHandler.Menus)
@onready var sound_effects_volume: HSlider = $"VBoxContainer/Sound effects volume"
@onready var music_volume: HSlider = $"VBoxContainer/Music volume"
@onready var lightbulb_hints: LightBulb = $lightbulb_hints




func toggle_on():
	self.visible = true
	sound_effects_volume.value = SaveManager.get_master_volume()
	music_volume.value = SaveManager.get_music_volume()

func toggle_off():
	self.visible = false

func _on_resume_b_pressed(m: MenuHandler.Menus) -> void:
	button_pressed.emit(m)


func _on_redo_b_pressed(m: MenuHandler.Menus) -> void:
	button_pressed.emit(m)


func _on_level_select_b_pressed(m: MenuHandler.Menus) -> void:
	button_pressed.emit(m)


func _on_main_menu_b_pressed(m: MenuHandler.Menus) -> void:
	button_pressed.emit(m)



func _on_sound_effects_volume_value_changed(value: float) -> void:
	SaveManager.change_master_volume(value)


func _on_music_volume_value_changed(value: float) -> void:
	SaveManager.change_music_volume(value)



func set_lightbulb(desc: String,num: int):
	lightbulb_hints.set_text(desc, num)
