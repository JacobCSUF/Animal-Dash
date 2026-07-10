extends ResponseResource
class_name UnregAudioResource


@export var sound: AudioStream
@export var volume:= -20.0
@export var pitch:= 1.0



func _init():
	r_type = Responses.AUDIO
	set_repeat(true)
	has_target = false
	



func execute(ctx: Context,pos):
	AudioManager.play_packed_audio(sound,volume,pitch)
	
		
