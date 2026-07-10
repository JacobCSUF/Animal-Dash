extends Control


@export var  animal_skins: Array[AnimalResource]



var counter = 0
signal back

@onready var character: AnimatedSprite2D = $character


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	character.sprite_frames = animal_skins[0].animations
	change_skin()



func _on_change_button_down() -> void:
	AudioManager.play_sound(AudioManager.Sound.UIBUTTON)
	change_skin()
	
func change_skin():
	
	character.sprite_frames = animal_skins[counter].animations
	GameState.set_animal_resource(animal_skins[counter])
	character.play("flappy")
	counter += 1
	if counter % animal_skins.size() == 0:
		counter= 0
	
	
func _on_back_button_down() -> void:
	back.emit()
