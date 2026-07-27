extends Resource
class_name AnimalResource


@export var sprites: Texture2D
@export var animations: SpriteFrames
@export var dash_colors: GradientTexture1D
@export var float_colors: GradientTexture1D
@export var gpu_colors: Color

@export_group("Shop Stuff")
@export var save_index := 0
@export var cost := 20
