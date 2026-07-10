extends Coin



@onready var particles: GPUParticles2D = $particles
@onready var particles_2: GPUParticles2D = $particles2

@onready var gold_ring_left: Sprite2D = $GoldRingLeft
@onready var gold_ring_right: Sprite2D = $GoldRingRight



func _ready() -> void:
	super()


	#AnimationUtils.start_bob(self, 2.0,  0.50, 1.0, false)
	



func _on_direct_area_area_entered(area: Area2D) -> void:
	if !entered1:
		is_taken = true
		entered1 = true
		particles.emitting= false
		gold_ring_left.visible = false
		gold_ring_right.visible = false
		particles_2.emitting = true
