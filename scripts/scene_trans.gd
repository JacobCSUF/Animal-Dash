extends Sprite2D
class_name SceneTrans

signal finished_fade_in
signal finished_fade_out

func play_trans(fi_time:= .15,fo_time:= .15):
	var tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_property(self,"modulate",Color(1.0, 1.0, 1.0, 0.96),fi_time)
	await tween.finished
	finished_fade_in.emit()
	
	var tween2 = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	
	tween2.play()
	tween2.tween_property(self,"modulate",Color(1.0, 1.0, 1.0, 0.0),fo_time)
	await tween2.finished
	finished_fade_out.emit()
