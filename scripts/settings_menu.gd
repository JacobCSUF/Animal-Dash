extends Control

@onready var check_box: CheckBox = $VBoxContainer/HBoxContainer/CheckBox

signal back

func _ready() -> void:
	if SaveManager.is_show_progress():
		check_box.button_pressed = true


func _on_music_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1,value)


func _on_sound_effects_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value)



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
