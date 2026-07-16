extends BaseObject
class_name LanternChain

@export var lantern_index: int
@export var is_on:= false
@export var fire_color:= Color(0.0, 0.675, 1.0, 1.0)
@export var lantern: Lantern
@export var turn_off_chains:= false
@onready var rope: Rope = $Rope
@onready var chains: AudioStreamPlayer2D = $Chains

signal lan_new_hit

func _ready() -> void:
	if turn_off_chains:
		chains.stop()
	randomize()
	super()
	if is_on:
		if lantern:
			lantern.auto_on()
	if lantern:
		lantern.set_color(fire_color,fire_color)
		lantern.lantern_hit . connect(_on_lantern_hit)
		lantern.new_hit.connect(_on_new_hit)
	do_tween(.07)

func _on_new_hit():
	lan_new_hit.emit()

func set_lantern_on():
	is_on = true
	lantern.set_on()
	
func _on_lantern_hit(body: Node2D):
	is_on = true
	apply_strength(body.global_position,1.0)

func set_lantern_color(f: Color,c: Color):
	if f and c:
		lantern.set_color(f,c)
	#else:
		#lantern.set_color(fire_color)

func _on_timer_timeout() -> void:
	do_tween()


func do_tween(s= .09):
	var rnd_p = randf_range(s-.015,s)
	var rnd_n = randf_range(-s,-s+.015)
	
	var rnd_g = randi_range(0,1)
	var r = 0
	if rnd_g == 0:
		r = rnd_p
	else: 
		r = rnd_n
	
	
	var rnd = randf_range(.075,.15)
	var tween = create_tween()
	tween.tween_property(rope,"gravity_direction",Vector2(r,1),rnd)
	tween.tween_property(rope,"gravity_direction",Vector2(0,1),rnd)


var first = true


func _on_lantern_lantern() -> void:
	apply_strength(Vector2(0,0),1,true)
	

var first_2 = true
func apply_strength(pos: Vector2, strength,is_last= false):
	if !first_2:
		return
	first_2 = false
	chains.volume_db = -24
	# Find the nearest rope point to where the player is
	var contact_point = pos
	var nearest_index = rope.get_nearest_point_index(contact_point)
	if is_last:
		nearest_index = rope.get_num_points() - 1
	# Apply an impulse by offsetting the old point (Verlet integration trick)
	# The difference between current and old point becomes velocity
	
	var spread = 1  # How many neighboring points to affect
	
	for i in range(nearest_index - spread, nearest_index + spread + 1):
		if i < 0 or i >= rope.get_num_points():
			continue
		# Weight the impulse so it's strongest at the contact point
	
		var weight = 1.0
		var old_points = rope.get_old_points()
		old_points[i] -= Vector2(strength * weight, 0)
		rope.set_old_points(old_points)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if !first:
		return
	first = false
	apply_strength(area.global_position,1.5)
