extends Control
class_name SkinUI


@onready var frame: Node2D = $frame

@onready var cost: Label = $frame/cost

@onready var animal: AnimatedSprite2D = $frame/frame_inner/animal
@onready var animal_skin_frame: AnimatedSprite2D = $frame/frame_inner/AnimalSkinFrame

@onready var sound_inc_local_component: SoundIncLocalComponent = $SoundIncLocalComponent
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	sound_inc_local_component.setup_inc()
	toggle_off()

func set_animal(anim_frames: SpriteFrames):
	animal.sprite_frames = anim_frames
	animal.animation = "flappy"



func toggle_off():
	animation_player.play("RESET")
	frame.modulate = Color(0.605, 0.605, 0.605, 0.553)
	cost.visible = false
	animal.stop()
	
func toggle_on():
	
	animation_player.play("stretch")
	frame.modulate = Color(1.0, 1.0, 1.0, 1.0)
	cost.visible = true
	animal.play("flappy")



@onready var block_particles: GPUParticles2D = $block_particles

func _on_button_pressed() -> void:
	block_particles.restart()
	block_particles.emitting = true
	print('WHAT')
	animal_skin_frame.frame += 1
	sound_inc_local_component.play_inc()
