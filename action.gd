extends Node2D

var current_action = ""
var rng = RandomNumberGenerator.new()
const ACTION_SIZE = 70
var respawn_position_y = 720

signal pointed_action

func _ready():
	randomize_action()
	
func randomize_action():
	rng.randomize()
	var my_random_number = rng.randi_range(0, 3)
	$background/runAway.visible = false
	$background/citizens.visible = false
	$background/soldiers.visible = false
	$background/believers.visible = false
	
	match my_random_number:
		0:
			$background/runAway.visible = true
			current_action = "retreat"
		1:
			$background/citizens.visible = true
			current_action = "neutral"
		2:
			$background/soldiers.visible = true
			current_action = "monarch"
		3:
			$background/believers.visible = true
			current_action = "church"

func _process(delta):
	if self.position.y > -ACTION_SIZE:
		self.position.y = self.position.y - ACTION_SIZE*3*delta
	else:
		self.position.y = respawn_position_y
		self.randomize_action()


func _on_area_entered(area):
	emit_signal("pointed_action", current_action)
