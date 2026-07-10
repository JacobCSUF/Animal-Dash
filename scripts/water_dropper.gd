extends Node2D


const WATER = preload("uid://d2e1mst32aoql")

var cooldown := 0.0
const INTERVAL := 0.25


func _process(delta: float) -> void:
	
	cooldown -= delta

	if cooldown <= 0.0:
		spawn_water()
		cooldown = INTERVAL


func spawn_water():
	
	AudioManager.play_sound(AudioManager.Sound.WATER)

	var watta = WATER.instantiate()
	var random_x = randf_range(-10.0, 10.0)
	watta.global_position = Vector2(global_position.x + random_x, global_position.y)
	watta.z_index = -1
	get_tree().get_root().add_child(watta)



	var fall_distance = 300.0

	var tween = watta.create_tween()
	tween.tween_property(
		watta,
		"global_position:y",
		watta.global_position.y + fall_distance,
		1.5
	).set_trans(Tween.TRANS_LINEAR)

	tween.finished.connect(watta.queue_free)
