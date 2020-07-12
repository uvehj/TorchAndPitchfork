extends Node2D


export var faction = "neutral"
export var size = 10
var combat_speed = 10
var objective = Vector2(0,0)
var objective_mob = self
var action = "stay"
var mandated_action = "stay"
var movement_speed = 40
var rng = RandomNumberGenerator.new()

const max_x = 1280
const max_y = 720
const min_x = 100
const min_y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$MobBody.set_size(size)
	$MobBody.faction=faction
	self.set_color()
	rng.randomize()
	if faction == "neutral":
		movement_speed = movement_speed / 2
	if faction == "rebels":
		movement_speed = movement_speed * 1.5
	
func set_swarm(value):
	$MobBody.swarm=value

func set_color():
	if faction == "rebels":
		$MobBody.color=Color(1.0,0.0,0.0)
	elif faction == "monarch":
		$MobBody.color=Color(0.0,0.0,1.0)
	elif faction == "church":
		$MobBody.color=Color(0.5,0.5,0.0)
	else:
		$MobBody.color=Color(0.0,0.0,0.0)

func _process(delta):
	var overlapping_area_list = $MobBody.get_overlapping_areas()
	for area in overlapping_area_list:
		if area.name == "MobBody":
			self.mob_clash(area, delta)
	self.act()
	if action == "move" :
		var velocity=(objective - self.global_position).normalized() * movement_speed * delta
		translate(velocity)
	if action == "flee" :
		var velocity=(self.global_position - objective).normalized() * movement_speed * delta
		translate(velocity)
	
	if self.global_position.x < min_x:
		self.global_position.x = min_x
	if self.global_position.y < min_y:
		self.global_position.y = min_y
	if self.global_position.x > max_x:
		self.global_position.x = max_x
	if self.global_position.y > max_y:
		self.global_position.y = max_y

func mob_clash(clash_area, delta):
	var clash_faction = clash_area.faction
	if clash_faction == "church":
		if faction == "rebels":
			if clash_area.get_mob_size() > size:
				size = size - 1 * delta * combat_speed
			else:
				size = size + 1 * delta * combat_speed
		if faction == "neutral":
			size = size - 1 * delta * combat_speed
	if clash_faction == "rebels":
		if faction == "neutral":
			size = size - 1 * delta * combat_speed
		elif faction == "church" or faction == "church":
			if clash_area.get_mob_size() > size:
				size = size - 1 * delta * combat_speed
			else:
				size = size + 1 * delta * combat_speed
		elif faction == "monarch":
			size = size - 1 * delta * combat_speed
	if clash_faction == "neutral":
		if faction == "church" or faction == "rebels":
			size = size + 1 * delta * combat_speed
	if clash_faction == "monarch":
		if faction == "rebels":
			size = size - 1 * delta * combat_speed
	$MobBody.set_size(size)

func act():
	if faction == "church":
		self.church_actions()
	if faction == "monarch":
		self.monarch_actions()
	if faction == "neutral":
		self.neutral_actions()
	if faction == "rebels":
		self.rebel_actions()

func church_actions():
	action = "stay"
	objective = self.global_position
	var overlapping_area_list = $LineOfSight.get_overlapping_areas()
	var enemies_close = false
	for area in overlapping_area_list:
		if area.name == "MobBody":
			if area.faction == "rebels":
				enemies_close = true
				if area.size > self.size:
					action = "flee"
					objective = area.global_position
				if area.size <= self.size:
					if action != "flee" and action =="stay":
						action = "move"
						objective = area.global_position
					elif action != "flee": 
						if self.global_position.distance_to(objective) > self.global_position.distance_to(area.global_position):
							objective = area.global_position
							action = "move"
			if area.faction == "neutral" and !enemies_close:
				if action =="stay":
					action = "move"
					objective = area.global_position
				else:
					if self.global_position.distance_to(objective) > self.global_position.distance_to(area.global_position):
						objective = area.global_position
	if action == "stay":
		action = "move"
		if objective.distance_to(self.global_position) < movement_speed or objective.distance_to(Vector2(0,0)) == 0:
			objective = Vector2(rng.randi_range(min_x,max_x),rng.randi_range(min_y,max_y))
func monarch_actions():
	action = "stay"
	objective = self.global_position
	var overlapping_area_list = $LineOfSight.get_overlapping_areas()
	for area in overlapping_area_list:
		if area.name == "MobBody":
			if area.faction == "rebels":
				if action =="stay":
					action = "move"
					objective = area.global_position
				else:
					if self.global_position.distance_to(objective) > self.global_position.distance_to(area.global_position):
						objective = area.global_position
func neutral_actions():
	action = "move"
	if objective.distance_to(self.global_position) < movement_speed or objective.distance_to(Vector2(0,0)) == 0:
		objective = Vector2(rng.randi_range(min_x,max_x),rng.randi_range(min_y,max_y))
func rebel_actions():
	if objective_mob.size > 0:
		objective = objective_mob.global_position
	else:
		action = "stay"
		objective = self.global_position
