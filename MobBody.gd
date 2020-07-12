extends Area2D


var size = 10
var faction
var color = Color(0.0,0.0,0.0)
var collisionShape = CollisionShape.new()
var shape_owner
var swarm = true
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	shape_owner= create_shape_owner(self)
	var shape = CircleShape2D.new()
	shape.radius= size
	shape_owner_add_shape(shape_owner, shape)
	rng.randomize()
func _draw():
	if !swarm:
		draw_circle(Vector2(0,0),size,color)
	elif size > 0:
		for i in PI * pow(size, 2) / 100:
			var r = size * sqrt(rng.randf_range(0.0,1.0))
			var t = rng.randf_range(0.0,1.0) * 2 * PI
			var x = r * cos(t)
			var y = r * sin(t)
			draw_circle(Vector2(x,y), 2, color)
	
func set_size(radius):
	size=radius
	remove_shape_owner(shape_owner)
	if size > 0:
		shape_owner= create_shape_owner(self)
		var shape = CircleShape2D.new()
		shape.radius= size
		shape_owner_add_shape(shape_owner, shape)

func _process(delta):
	update()

func get_mob_size():
	return size
