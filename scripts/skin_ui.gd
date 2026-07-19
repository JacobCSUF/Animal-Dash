extends Control
class_name SkinUI


@onready var frame: Node2D = $frame
@onready var cost: Label = $frame/cost
@onready var animal: AnimatedSprite2D = $frame/frame_inner/animal
@onready var animal_skin_frame: AnimatedSprite2D = $frame/frame_inner/AnimalSkinFrame
@onready var sound_inc_local_component: SoundIncLocalComponent = $SoundIncLocalComponent
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var button: Button = $Button
@onready var denied: AudioStreamPlayer2D = $Denied
@onready var unlocked: AudioStreamPlayer2D = $Unlocked

signal purchased(ind)
var price := 0
var ind := 0
var bought = false
var animal_r: AnimalResource

func _ready() -> void:
	sound_inc_local_component.setup_inc()
	toggle_off()

func set_animal(anim: AnimalResource):
	animal_r = anim
	ind = anim.save_index
	price = anim.cost
	cost.text = "x"+str(price)
	animal.sprite_frames = anim.animations
	animal.animation = "flappy"



func toggle_off():
	if bought:
		animal.visible = false
	button.disabled = true
	animation_player.play("RESET")
	frame.modulate = Color(0.605, 0.605, 0.605, 0.553)
	cost.visible = false
	animal.stop()
	
func toggle_on():
	
	button.disabled = false
	animation_player.play("stretch")
	frame.modulate = Color(1.0, 1.0, 1.0, 1.0)
	cost.visible = true
	animal.play("flappy")



@onready var block_particles: GPUParticles2D = $block_particles

var counter = 5
var count = 0
func _on_button_pressed() -> void:
	if SaveManager.can_buy_skin(price):
		ParticleManager.play_duplicate(block_particles,block_particles.global_position)
		animal_skin_frame.frame += 1
		sound_inc_local_component.play_inc()
		count+=1 
		if count >= counter:
			
			animation_player.play("unlocked")
			button.disabled = true
			purchased.emit(ind)
			bought = true
			
	else:
		denied.play()
		animation_player.play("RESET")
		animation_player.play("cant_buy")
		


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "unlocked":
		unlocked.play()
		
