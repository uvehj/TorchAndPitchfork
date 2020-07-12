extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_screen(result):
	$VictorySprite.visible = false
	$DefeatSprite.visible = false
	if result == "defeat":
		$DefeatSprite.visible = true
	else:
		$VictorySprite.visible = true
