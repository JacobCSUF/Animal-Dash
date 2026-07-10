extends BaseObject
class_name Coin


@export var coin_index: int
@export_group("Triggers")

@export var area_entered: Array[ResponseResource]


var is_taken = false
var entered1 := false

func _ready() -> void:
	super()
	set_up_trigger(area_entered)

	


	
func get_taken():
	return is_taken
