extends Node

signal transition_half_completed(target_scene: String)
signal transition_completed

var current_transition: Node = null
var is_transitioning: bool = false
