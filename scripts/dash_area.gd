extends Area2D


@export var time: = .5
@export_enum("flappy", "ball", "float","train_end") var state: String = "flappy"
@export var dir: = Vector2(0,0)
@export var speed:= 400
@export var amount:= 10
@export var auto_dash:= true

var in1 = false

func _ready() -> void:
	var x = get_parent()
	rotation = x.rotation


func _on_area_entered(area: Area2D) -> void:
	in1 = true


func _on_area_exited(area: Area2D) -> void:
	in1 = false


func _physics_process(_delta: float) -> void:
	if in1:
		
		if auto_dash or Input.is_action_just_pressed("e"):
			dir = Vector2.from_angle(rotation)
		
		
			in1 = false
			GameState.change_state("dash",{"time":time, "end_state":state,
			 "dir":dir,"speed":speed,"point":self.global_position,"amount":amount})
			
		else:
			GameState.change_state(state)
			in1 = false
	
