extends Control


signal back


func _on_music_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1,value)


func _on_sound_effects_volume_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_button_pressed() -> void:
	AudioManager.play_sound(AudioManager.Sound.UIBUTTON)
	back.emit()
