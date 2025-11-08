extends CharacterBody2D

@onready var nav_agent = $NavigationAgent2D

const SPEED = 3000

func _ready() -> void:
	nav_agent.navigation_finished.connect(_on_nav_finished)
	nav_agent.velocity_computed.connect(_on_navigation_agent_2d_velocity_computed)
	make_path(Vector2(randf_range(0,get_viewport_rect().size.x), randf_range(0,get_viewport_rect().size.y)))

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("lmb"):
		make_path(get_global_mouse_position())
	var next_path_pos = nav_agent.get_next_path_position()
	var direction = global_position.direction_to(next_path_pos)
	var new_velocity = direction * SPEED * delta
	
	nav_agent.velocity = new_velocity
func _on_nav_finished():
	pass #make_path(Vector2(randf_range(0,get_viewport_rect().size.x), randf_range(0,get_viewport_rect().size.y)))

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, 160)
	move_and_slide()

func make_path(pos: Vector2):
	nav_agent.target_position = pos
	
