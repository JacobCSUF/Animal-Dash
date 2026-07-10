extends Resource
class_name ResponseResource

enum Responses {APPEAR,ROUTE,DEFAULT,SHADER,AUDIO,BGROUND,PARTICLE,UNREG_A}

var r_type: Responses
var repeat := false

var has_target := true
var target_node: BaseObject

var has_group := false
var group_number := 0
var group_delay_time:= 0.0

var paths = {}


func set_up():
	pass

func execute(ctx: Context,pos):
	pass



func set_target_node(node: BaseObject):
	has_target = true
	target_node = node

func set_repeat(is_repeat: bool):
	repeat = is_repeat

func set_group(num,time = 0):
	group_delay_time = time
	if num!= 0:
		has_group = true
		group_number = num
		has_target = false
		repeat = true
	
func execute_group(ctx: Context, objects: Array[BaseObject]):
	for i in objects:
		target_node = i
		execute(ctx,target_node.global_position)
		if group_delay_time > 0:
			await Engine.get_main_loop().create_timer(group_delay_time).timeout
		
		
func set_up_group(objects: Array[BaseObject]):
	
	for i in objects:
		target_node = i
		set_up()
