extends BaseObject

@export var rotate1: bool = false
@export var rotation_time: float = 1.0
@export var rotation_offset: int = 90
@export var auto_fire: bool = false
@export var speed: int = 400
@onready var sound_inc_component_2: SoundIncComponent = $SoundIncComponent2

@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal signaled

var ani: Tween
var ani2: Tween
var can_shoot = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	var p = ShrinkParams.new()
	p.amount = .02
	p.duration = .35
	ani = AnimationUtils.shrink_stretch(self,p)
	#ani2 = AnimationUtils.start_bob(self,2.5,0.75)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event: InputEvent) -> void:
	if can_shoot:
		if event.is_action_pressed("e"):
			shoot()




func shoot():
	GameState.change_state("cannon_movement",{"pos"=self.global_position,"angle"=self.rotation_degrees,"speed"= speed})
	signaled.emit()
	can_shoot = false
	animation_player.play("shoot")
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	ani.kill()
	var tween = create_tween()
	await tween.tween_property(GameState.player, "global_position",sound_inc_component_2.global_position, 0.02).finished
	
	if auto_fire:
		shoot()
	
	GameState.change_state("stop",{"pos"=self.global_position})
	can_shoot = true
	
	if auto_fire:
		shoot()
