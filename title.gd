extends Node2D

signal start_play

func _ready():
	pass



func _on_Exit_Button():
	get_tree().quit()


func _on_TextureButton_pressed():
	emit_signal("start_play")
