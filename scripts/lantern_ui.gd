extends Node2D
class_name LanternUI

@onready var flame: AnimatedSprite2D = $LanternUi/flame
@onready var outline: AnimatedSprite2D = $LanternUi/outline
@onready var lantern_ui: AnimatedSprite2D = $LanternUi




func set_colors(f:Color, c:Color):
	lantern_ui.frame = 1
	flame.visible = true
	outline.visible = true
	flame.modulate = f
	outline.modulate = c

func turn_off():
	lantern_ui.frame = 0
	flame.visible = false
	outline.visible = false
