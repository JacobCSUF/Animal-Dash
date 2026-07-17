extends Node2D


@export var  animal_skins: Array[AnimalResource]


@onready var character: AnimatedSprite2D = $"Settings Title2/character"
@onready var skin_frames: Node2D = $skin_frames
@onready var s1: SkinUI = $skin_frames/skin_ui
@onready var s2: SkinUI = $skin_frames/skin_ui2
@onready var s3: SkinUI = $skin_frames/skin_ui3
@onready var s4: SkinUI = $skin_frames/skin_ui4
@onready var s5: SkinUI = $skin_frames/skin_ui5
@onready var right: Button = $right

@onready var frames: Array[SkinUI] = [s1,s2,s3,s4,s5]
var counter = 0
signal back


var bought_skins = []
var shop_skins: Array[SpriteFrames] = []
var skin_counter = 0

var spawn_location = Vector2(-40,184)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	character.sprite_frames = animal_skins[0].animations
	

	for i in range(animal_skins.size()):
		if SaveManager.has_bought_skin(i):
			bought_skins.append(animal_skins[i])
			
		else:
			shop_skins.append(animal_skins[i].animations)

	change_skin()
	


	var frame_counter = 0
	
	
	for i in frames:
		i.set_animal(shop_skins[skin_counter-1])
		skin_counter += 1
		if skin_counter%shop_skins.size() == 0:
			skin_counter = 0 
	skin_counter = shop_skins.size()-1

	toggle_frames()


func toggle_frames():
	for i in range(frames.size()):
		if i == 2:
			frames[i].toggle_on()
		else:
			frames[i].toggle_off()

func toggle_center_frame():
	frames[2].toggle_off()


func _on_change_button_down() -> void:
	AudioManager.play_sound(AudioManager.Sound.UIBUTTON)
	change_skin()
	
func change_skin():
	print(bought_skins," boutght")
	character.sprite_frames = bought_skins[counter].animations
	GameState.set_animal_resource(bought_skins[counter])
	character.play("flappy")
	counter += 1
	if counter % bought_skins.size() == 0:
		counter= 0
	
	
	
const SKIN_UI = preload("uid://srr2wd5rvthy")
	
func set_next_animal(s: SkinUI):
	s.set_animal(shop_skins[skin_counter-1])
	skin_counter -= 1
	if skin_counter == 0:
		skin_counter = shop_skins.size() 
	
	
func _on_right_button_down() -> void:
	AudioManager.play_sound(AudioManager.Sound.UIBUTTON)
	right.disabled = true
	toggle_center_frame()
	var s = SKIN_UI.instantiate()
	skin_frames.add_child(s)
	set_next_animal(s)
	s.global_position = spawn_location
	
	var tween = create_tween()
	tween.tween_property(skin_frames,"position",skin_frames.position+Vector2(120,0),0.55)
	await tween.finished
	
	var old =frames.pop_back()
	old.queue_free()
	frames.push_front(s)
	toggle_frames()
	right.disabled = false
	
	
func _on_back_button_down() -> void:
	back.emit()
