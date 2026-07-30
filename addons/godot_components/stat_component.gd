extends Resource
class_name StatComponent

signal value_changed(old_value, new_value)
signal max_value_changed(old_value, new_value)
signal min_value_changed(old_value, new_value)
signal emptied
signal filled
 
@export var min_value: int = 0
@export var max_value: int = 100
@export var starting_value: int = 100

var _current_value: int
 
var current_value: int:
	get:
		return _current_value

func _ready() -> void:
	max_value = max(min_value, max_value)
	_current_value = clamp(starting_value, min_value, max_value)
	
func set_value(value: int) -> void:
	var old_value := current_value
	var old_empty := is_empty()
	var old_full := is_full()

	_current_value = clamp(value, min_value, max_value)

	if current_value == old_value:
		return

	value_changed.emit(old_value, current_value)

	if !old_empty and is_empty():
		emptied.emit()

	if !old_full and is_full():
		filled.emit()

func add(amount: int) -> void:
	set_value(current_value + amount)
	
func remove(amount: int) -> void:
	set_value(current_value - amount)

func fill() -> void:
	set_value(max_value)

func empty() -> void:
	set_value(min_value)

func set_max_value(value: int, fill_value := false) -> void:
	var old_full := is_full()
	
	var old := max_value
	max_value = max(value, min_value)

	if old == max_value:
		return

	max_value_changed.emit(old, max_value)

	if fill_value:
		fill()
	elif(!old_full and  is_full()):
		filled.emit()
	else:
		set_value(current_value)


func set_min_value(value: int, empty_value := false) -> void:
	var old_empty := is_empty()
	var old := min_value
	min_value = min(value, max_value)

	if old == min_value:
		return

	min_value_changed.emit(old, min_value)

	if empty_value:
		empty()
	elif(!old_empty and  is_empty()):
		filled.emit()
	else:
		set_value(current_value)

func is_empty() -> bool:
	return current_value <= min_value

func is_full() -> bool:
	return current_value >= max_value

func ratio() -> float:
	var range_size := max_value - min_value
	return 1.0 if range_size == 0 else float(current_value - min_value) / range_size
