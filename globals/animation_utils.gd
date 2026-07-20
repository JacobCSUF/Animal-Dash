extends Node
class_name AnimationUtils

static func start_bob(node: Node2D, data: BobParams) -> Tween:
	var center_y = node.position.y
	var tween = node.create_tween()
	tween.set_loops()

	tween.tween_property(node, "position:y", center_y -data.height, data.duration / data.speed)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_interval(data.wait)
	
	tween.tween_property(node, "position:y", center_y + data.height, data.duration / data.speed)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)

	# Random phase (like seek)
	var total_time = (data.duration / data.speed) * 2.0
	if data.random:
		tween.custom_step(randf() * total_time)

	return tween


static func start_sway(node: Node2D, data:SwayParams) -> Tween:
	var center_x = node.position.x
	var tween = node.create_tween()
	tween.set_loops()

	tween.tween_property(node, "position:x", center_x - data.width,data.duration / data.speed)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(node, "position:x", center_x + data.width, data.duration / data.speed)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)

	var total_time = (data.duration / data.speed) * 2.0
	if data.random:
		tween.custom_step(randf() * total_time)

	return tween




static func obj_start_pos(node: Node2D, distance,direction):
	node.global_position += -1* direction * distance 


static func move_in_line(node: Node2D, data: MoveLineParams) -> Tween:
	var start_pos = node.position
	var target_pos = start_pos + data.direction.normalized() * data.distance

	var tween = node.create_tween()

	if data.loop:
		tween.set_loops()

	tween.tween_property(node, "position", target_pos, data.duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)

	# optional return back (ping-pong effect)
	if data.loop:
		tween.tween_property(node, "position", start_pos, data.duration)\
			.set_trans(Tween.TRANS_SINE)\
			.set_ease(Tween.EASE_IN_OUT)

	return tween


static func shrink_stretch(node: Node2D, data: ShrinkParams) -> Tween:
	var start_scale = node.scale

	var tween = node.create_tween()
	tween.set_loops()

	# shrink
	tween.tween_property(node, "scale", start_scale * (1.0 - data.amount), data.duration / data.speed)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)

	# stretch
	tween.tween_property(node, "scale", start_scale * (1.0 + data.amount), data.duration / data.speed)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)

	return tween
	
	
static func spin(node: Node2D, data: SpinParams) -> Tween:
	var start =  node.rotation_degrees + data.degrees
	var end =  node.rotation_degrees - data.degrees
	node.rotation_degrees = start
	

	var tween = node.create_tween()
	tween.set_loops()

	# shrink
	tween.tween_property(node, "rotation_degrees", end, data.speed)
	

	# stretch
	tween.tween_property(node, "rotation_degrees", start, data.speed)
		
	var total_time = (data.speed) * 2.0
	if data.random:
		tween.custom_step(randf() * total_time)
	return tween
