extends Node2D
class_name Trigger

@export var responses: Array[ResponseResource]

var external_path: Node2D
var direct = false

func set_direct(is_direct: bool):
	direct = is_direct

func set_external_path(path: Node2D):
	external_path = path

func path_resolver(path: Node2D, response: ResponseResource):
	if external_path:
		path = external_path
	if "target_path" in response:
		var n :BaseObject = path.get_node_or_null(response.target_path)
		
		response.set_target_node(n)
		
func helper_path_resolver():
	var self_path = self
	if external_path:
		self_path = external_path

	for response in responses:
		for name1 in response.paths:
			var path = response.paths[name1]
			response.paths[name1] = (self_path.get_node_or_null(path))
			


func _ready() -> void:
	if direct:
		handle_direct()
		return
		
	for i in responses.size():
		responses[i] = responses[i].duplicate(true)
	
	for response in responses:
		path_resolver(self,response)
		response.set_up()
		if response.has_group:
			TriggerHandler.set_up_group(response)
		
		if response.repeat:
			continue
		else:
			TriggerHandler.add_response(response)
	helper_path_resolver()
	
func trigger():
	if direct:
		for response in responses:
			TriggerHandler.direct_do_it(response,self.global_position)
		return
		
	for response in responses:
		if response.repeat and _is_trigger_ready(response):
			TriggerHandler.do_it(response,self.global_position)
		elif _is_trigger_ready(response):
			if TriggerHandler.can_respond(response):
				TriggerHandler.do_it(response,self.global_position)
	
		
func _is_trigger_ready(response: ResponseResource):
	if response.has_target:
		if response.target_node:
			
			return true
		else:
			return false
	return true



func handle_direct():
	
	for i in responses.size():
		responses[i] = responses[i].duplicate(true)
	
	for response in responses:
		path_resolver(self,response)
		response.set_up()
	helper_path_resolver()
