# Finite State machine
extends Node

# Events
# ------
# global_input -> [state]_input
# global_unhandled_input -> global_unhandled_key_input -> [state]_unhandled_input
# global_pre_fixed_process -> [state]_fixed_process -> global_post_fixed_process
# global_pre_process -> [state]_process -> global_post_process

var __last_state setget __set_last_state, get_last_state
var __current_state setget set_current_state, get_current_state
	
func _input(event):
	if has_method("global_input"):
		call_deferred("global_input", event)
	
	if __current_state:
		if has_method(__current_state + "_input"):
			call_deferred(__current_state + "_input", event)
	
func _unhandled_input(event):
	if has_method("global_unhandled_input"):
		call_deferred("global_unhandled_input", event)
		
	if __current_state:
		if has_method(__current_state + "_unhandled_input"):
			call_deferred(__current_state + "_unhandled_input", event)
			
func _unhandled_key_input(key_event):
	if has_method("global_unhandled_key_input"):
		call_deferred("global_unhandled_key_input", key_event)
		
	if __current_state:
		if has_method(__current_state + "_unhandled_key_input"):
			call_deferred(__current_state + "_unhandled_key_input", key_event)
	
func _process(delta):
	if has_method("global_pre_update"):
		call_deferred("global_pre_update", delta)
	
	if __current_state:
		if has_method(__current_state + "_update"): 
			call_deferred(__current_state + "_update", delta)
		
	if has_method("global_post_update"):
		call_deferred("global_post_update", delta)
	
func _fixed_process(delta):
	if has_method("global_pre_fixed_update"):
		call_deferred("global_pre_fixed_update", delta)
	
	if __current_state:
		if has_method(__current_state + "_fixed_update"): 
			call_deferred(__current_state + "_fixed_update", delta)
	
	if has_method("global_post_fixed_update"):
		call_deferred("global_post_fixed_update", delta)
	
func set_current_state(new_state):
	if __current_state == new_state: return
	
	if has_method("global_exit"):
		call_deferred("global_exit")
	
	if __current_state:
		if has_method(__current_state + "_exit"): 
			call_deferred(__current_state + "_exit")
	
	__last_state = __current_state
	__current_state = new_state
	
	if has_method("global_enter"):
		call_deferred("global_enter")
	
	if __current_state:
		if has_method(__current_state + "_enter"): 
			call_deferred(__current_state + "_enter")
	
func get_current_state():
	return __current_state
	
func __set_last_state():
	pass
	
func get_last_state():
	return __last_state