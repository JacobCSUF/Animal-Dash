extends Node2D
@onready var batteries: Array[AnimatedSprite2D] = []
@onready var battery: AnimatedSprite2D = $battery
@onready var battery2: AnimatedSprite2D = $battery2
@onready var battery3: AnimatedSprite2D = $battery3
@onready var battery4: AnimatedSprite2D = $battery4
@onready var battery5: AnimatedSprite2D = $battery5
@onready var charge2: AudioStreamPlayer2D = $Charge
@onready var beep: AnimatedSprite2D = $beep
@onready var beep_2: AnimatedSprite2D = $beep2
@onready var beep_3: AnimatedSprite2D = $beep3
@onready var beep_4: AnimatedSprite2D = $beep4
@onready var beep_5: AnimatedSprite2D = $beep5
@onready var beep_6: AnimatedSprite2D = $beep6
@onready var beep_7: AnimatedSprite2D = $beep7
@onready var beep_8: AnimatedSprite2D = $beep8

@onready var charge: AudioStreamPlayer2D = $charge/Charge
@onready var line_2d: Line2D = $charge/Line2D
@onready var line_2d_2: Line2D = $charge/Line2D2
@onready var switch: AnimatedSprite2D = $switch
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var freesound_community_power_up_35839: AudioStreamPlayer2D = $charge/FreesoundCommunityPowerUp35839
@onready var switch_on: AudioStreamPlayer2D = $SwitchOn
@onready var juice_things: Node2D = $Area2D2/juice_things


func _ready() -> void:
	batteries = [battery, battery2, battery3, battery4, battery5]
	play_beeps_random()
func play_beeps_random() -> void:
	var beeps = [beep, beep_2, beep_3, beep_4, beep_5, beep_6, beep_7, beep_8,
				]
	var base_fps = beep.sprite_frames.get_animation_speed("default")
	for b in beeps:
		b.play("default")
		b.frame = randi() % 3
		b.speed_scale = randf_range(2.0, 4.0) / base_fps

		
		
		charge.play()
		var tween = create_tween()
		var target = PackedVector2Array([line_2d.points[0], Vector2(line_2d.points[1].x + 246.0, line_2d.points[1].y)])
		tween.tween_property(line_2d, "points", target, 1.0)
		var tween2 = create_tween()
		var target2 = PackedVector2Array([line_2d_2.points[0], Vector2(line_2d_2.points[1].x + 246.0, line_2d.points[1].y)])
		tween2.tween_property(line_2d_2, "points", target2, 1.0)
		await tween2.finished
		await get_tree().create_timer(0.15).timeout
		switch.play("on")
		switch_on.play()
		for child in juice_things.get_children():
			child.toggle_light_mask_off()



		


func _on_area_2d_area_entered(area: Area2D) -> void:
	freesound_community_power_up_35839.play()
	for b in batteries:
		b.play("default")
		charge2.play()
		charge2.pitch_scale += 0.6
		await get_tree().create_timer(0.4).timeout
	charge2.stop()


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	var tween = create_tween()
	SongManager.fade_out(-80,5.0)
	tween.tween_property(point_light_2d, "energy", .7, 2.0)


func _on_area_2d_4_area_entered(area: Area2D) -> void:
	var tween = create_tween()
	tween.tween_property(point_light_2d, "energy", 0, 0.2)


func _on_area_2d_5_area_entered(area: Area2D) -> void:
	SongManager.play_drop()
