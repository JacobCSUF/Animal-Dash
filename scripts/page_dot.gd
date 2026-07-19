extends Control
class_name PageDots
@onready var ui_button: Sprite2D = $UiButton
@onready var ui_button_filled: Sprite2D = $UiButtonFilled
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var lock: AnimatedSprite2D = $Lock
@onready var denied: AudioStreamPlayer2D = $Denied
@onready var appear: AudioStreamPlayer2D = $Appear
@onready var lan_count: Label = $Panel/LanternUi/lan_count

var locked = false
var is_gray = false
func toggle_on():
	lock.visible = false
	animation_player.play("hover")
	ui_button_filled.visible = true
	
func toggle_off():
	ui_button_filled.visible = false
	
func toggle_gray():
	ui_button.modulate = Color(0.253, 0.253, 0.253, 0.809)
	is_gray = true

func toggle_color():
	ui_button.modulate = Color(1.0, 1.0, 1.0, 1.0)

func toggle_lock_on():
	toggle_gray()
	lock.visible = true
	locked = true

func toggle_lock_off():
	lock.visible = false
	locked = false
	
func open_lock():
	lock.play("default")
	animation_player.play("unlock")
	appear.play()
	await animation_player.animation_finished
	
	locked = false
	
func deny_lock(count: int):
	animation_player.stop()
	lan_count.text = "x"+str(count)
	animation_player.play("lock_bob")
	denied.play()
