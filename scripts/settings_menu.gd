extends Control

@onready var check_box: CheckBox = $VBoxContainer/HBoxContainer/CheckBox
@onready var sound_effects_volume: HSlider = $"VBoxContainer/Sound effects volume"
@onready var music_volume: HSlider = $"VBoxContainer/Music volume"

signal back

func _ready() -> void:
	if SaveManager.is_show_progress():
		check_box.button_pressed = true
	sound_effects_volume.value = SaveManager.get_master_volume()
	music_volume.value = SaveManager.get_music_volume()

func _on_music_volume_value_changed(value: float) -> void:
	SaveManager.change_music_volume(value)


func _on_sound_effects_volume_value_changed(value: float) -> void:
	SaveManager.change_master_volume(value)



func _on_button_pressed() -> void:
	AudioManager.play_sound(AudioManager.Sound.UIBUTTON)
	back.emit()


func _on_button_2_pressed() -> void:
	SaveManager.saved_data["total_coins"] = 777
	SaveManager.saved_data["total_lanterns"] = 777
	SaveManager.currency_updated.emit()


func _on_button_3_pressed() -> void:
	SaveManager.saved_data["total_coins"] = 0
	SaveManager.saved_data["total_lanterns"] = 0
	SaveManager.currency_updated.emit()


func _on_button_4_pressed() -> void:
	pass


func _on_check_box_toggled(toggled_on: bool) -> void:
	print(toggled_on)
	SaveManager.change_progress_bar(toggled_on)
