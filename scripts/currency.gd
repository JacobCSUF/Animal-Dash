extends Panel
@onready var coin_count: Label = $coin_count

@onready var lan_count: Label = $LanternUi/lan_count

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveManager.currency_updated.connect(_on_currency_updated)
	_on_currency_updated()

func _on_currency_updated():
	coin_count.text = "x"+str(int(SaveManager.get_total_coins()))
	lan_count.text = "x"+str(int(SaveManager.get_total_lanterns()))
