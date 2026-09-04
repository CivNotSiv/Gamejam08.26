extends Node

@onready var timer: Timer = $SpawnTimer
@onready var boss: Node3D = $Westwood

func _ready() -> void:
	timer.timeout.connect(_on_timeout)
	timer.start(3)


func _on_timeout() -> void:
	boss.attack(1, 0.2, 20)
	
