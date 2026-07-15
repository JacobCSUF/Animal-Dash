extends Coin


@onready var coin_sheet: AnimatedSprite2D = $CoinSheet
@onready var particles: GPUParticles2D = $particles
@onready var particles_2: GPUParticles2D = $particles2


func _ready() -> void:
	super()


	#AnimationUtils.start_bob(self, 2.0,  0.50, 1.0, false)
func set_taken():

	self.modulate = Color(1.0, 1.0, 1.0, 0.8)
	is_taken = true
	coin_sheet.play("taken")




func _on_direct_area_area_entered(area: Area2D) -> void:
	if !entered1:
		#coin hasnt been taken before on completed level
		if is_taken:
			new_take.emit(true)
		else:
		#coin has been taken before on completed level
			new_take.emit(false)
		is_taken = true
		entered1 = true
		particles.emitting= false
		coin_sheet.visible = false
		particles_2.emitting = true
