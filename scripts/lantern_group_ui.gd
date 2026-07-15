extends Node2D

class_name LanternGroupUI

@onready var sound_inc: SoundIncLocalComponent = $SoundIncLocalComponent

@onready var l1: LanternUI = $lantern_ui
@onready var l2: LanternUI = $lantern_ui2
@onready var l3: LanternUI = $lantern_ui3
@onready var l4: LanternUI = $lantern_ui4
@onready var l5: LanternUI = $lantern_ui5


@onready var lans: Array[LanternUI] = [l1,l2,l3,l4,l5]


func set_lanterns(l_array: Array,f: Color, outline: Color):
	for i in lans:
		i.turn_off()
	
	for i in l_array:
		
		lans[i-1].set_colors(f,outline)
		
func turn_on_group(l_array: Array,f: Color, outline: Color):
	sound_inc.setup_inc()
	for i in l_array:
		sound_inc.play_inc()
		
	sound_inc.reset_inc()
