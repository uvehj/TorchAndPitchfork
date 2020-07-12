extends Node2D

signal start_play
signal change_swarms
signal howto

func _ready():
	pass



func _on_Exit_Button():
	get_tree().quit()


func _on_TextureButton_pressed():
	emit_signal("start_play")


func _on_CheckButton_pressed():
	emit_signal("change_swarms")


func _on_howto_pressed():
	emit_signal("howto")
