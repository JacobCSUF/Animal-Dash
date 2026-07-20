extends ProgressBar


@export var player: Player

func _ready() -> void:
	self.visible = SaveManager.is_show_progress()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = player.distance_helper.get_percent()
	
