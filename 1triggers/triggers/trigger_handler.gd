extends Node

const RECEIVER_APPEAR = preload("uid://dypeca3fu16tv")

var trig_dict = {}
var repeat_dict = {}

var ctx = Context.new()
#if has target: add target trigger
#if has repeat: 

func _ready() -> void:
	var x = RECEIVER_APPEAR.instantiate()
	get_tree().root.add_child.call_deferred(x)
	ctx.appear = x


func add_response(response: ResponseResource):
	if response.repeat:
		return

	if !trig_dict.has(response.target_node):
		trig_dict[response.target_node] = {}
	
	
	if !trig_dict[response.target_node].has(response.r_type):
		trig_dict[response.target_node][response.r_type] = {"counter"= 1,"count" = 0}
	else:
		
		trig_dict[response.target_node][response.r_type]["counter"] += 1


func can_respond(response):
	if !trig_dict.has(response.target_node):
		print('ERROR: invalid dict')
		return false
	
	if !trig_dict[response.target_node].has(response.r_type):
		print('ERROR: invalid dict')
		return false
		
	var ind = trig_dict[response.target_node][response.r_type]
	ind["count"] += 1
	if ind["count"] >= ind["counter"]:
		return true
	else:

		return false
	
	
	
func add_repeat_response(response):
	pass
	
func can_repeat_response(response):
	pass
	
	
func reset():
	trig_dict = {}
	

func do_it(response: ResponseResource,pos):
	if response.has_group:
		var requested_nodes: Array[BaseObject]
		for obj in get_tree().get_nodes_in_group("base_object"):
			var base_obj := obj as BaseObject
			if !base_obj or  (base_obj.group_number == 0):
				continue
			
			if base_obj.group_number == response.group_number:
				requested_nodes.append(base_obj)
		
	
		response.execute_group(ctx,requested_nodes)
	
	else:
		response.execute(ctx,pos)
		
func direct_do_it(response: ResponseResource,pos):
	response.execute(ctx,pos)
	
	
		
func set_up_group(response: ResponseResource):

	await get_tree().create_timer(0.5).timeout
	if response.has_group:
		var requested_nodes: Array[BaseObject]
		for obj in get_tree().get_nodes_in_group("base_object"):
			var base_obj := obj as BaseObject
			if !base_obj or  (base_obj.group_number == 0):
				continue
			
			if base_obj.group_number == response.group_number:
				requested_nodes.append(base_obj)
		
	
		response.set_up_group(requested_nodes)
