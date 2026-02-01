extends Area3D

@export var distancia_objetivo: float = 20.0
@export var angulo_grados: float = 80.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if(body is Area3D):
		body = body.get_parent().get_node("PlayerBody")
	if body is CharacterBody3D or body is RigidBody3D:
		lanzar_objeto(body)
		print("ES!!!!!!!" + str(body))
	else:
		print("NO ESS!!!" + str(body))

func lanzar_objeto(body: Node3D):
	# 1. Constantes de física
	var g = ProjectSettings.get_setting("physics/3d/default_gravity")
	var theta = deg_to_rad(angulo_grados)
	
	# 2. Cálculo de velocidad inicial (v0)
	# Usamos el valor absoluto de sin(2*theta) para evitar errores si el ángulo es raro
	var v0 = sqrt((distancia_objetivo * g) / sin(2 * theta))
	
	# 3. Construcción del vector en el plano X e Y
	# cos(theta) nos da la magnitud en el plano horizontal (X)
	# sin(theta) nos da la magnitud en el plano vertical (Y)
	var vx = cos(theta) * v0
	var vy = sin(theta) * v0
	
	# Aplicamos el movimiento hacia +X
	var vector_impulso = Vector3(vx, vy, 0)
	
	# 4. Aplicar al cuerpo
	if body is CharacterBody3D:
		body.velocity = vector_impulso
	elif body is RigidBody3D:
		# Reseteamos velocidad actual para que el salto sea consistente
		body.linear_velocity = Vector3.ZERO 
		body.apply_central_impulse(vector_impulso * body.mass)

	print("Lanzando hacia +X con fuerza vertical de: ", vy)
