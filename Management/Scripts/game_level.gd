extends Node2D

@export var label: Label
# Called when the node enters the scene tree for the first time.
func _ready():
	global.gamelevel = self


func _process(delta):
	label.text = "N° de Tentativas: " + str(global.tentativas)
