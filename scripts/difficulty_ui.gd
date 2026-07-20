extends Node2D
@onready var s1: AnimatedSprite2D = $star
@onready var s2: AnimatedSprite2D = $star2
@onready var s3: AnimatedSprite2D = $star3
@onready var s4: AnimatedSprite2D = $star4
@onready var s5: AnimatedSprite2D = $star5
@onready var s6: AnimatedSprite2D = $star6

@onready var stars: Array[AnimatedSprite2D] = [s1,s2,s3,s4,s5,s6]


func set_difficulty(d := 1):
	if d <= 6 and d > 0:
		for i in range(stars.size()):
			if d > i:
				stars[i].frame = 1
			else:
				stars[i].frame = 0
	
	elif d > 6 and d <= 12:
		for i in stars:
			i.frame = 1
		
		for i in range(d - 6):
			stars[i].frame = 2
	
	
