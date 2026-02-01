extends AnimatableBody3D

@export var speed := 2.0
@export var distance := 5.0

var start_pos: Vector3
var dir: Vector3 = Vector3(0,0,1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		return
	start_pos = global_position
	var tween = create_tween().set_loops()
	# Mueve a la posición destino y regresa
	var duration = distance / speed
	tween.tween_property(self, "global_position", start_pos + dir * distance, duration)
	tween.tween_property(self, "global_position", start_pos, duration)

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		var destination: Vector3 = start_pos + dir.normalized() * distance
		DebugDraw3D.draw_box(destination - Vector3(4,1,4), Quaternion.IDENTITY, Vector3(8,2,8), Color.RED)
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta: float) -> void:
	#if Engine.is_editor_hint():
		#return
	#if global_position.distance_to(start_pos) < distance:
		#constant_linear_velocity = dir * speed
		#global_position +=  dir * speed * delta
		
	
		
