extends Node2D

@export var total_orbs = 21  # Total number of orbs in the level
var collected_orbs = 0  # Counter for collected orbs

func _ready():
	# Connect the orb_collected signal for each orb
	for orb in $Orbs.get_children():
		orb.connect("orb_collected", Callable(self, "_on_orb_collected"))
	# Set the initial value of the ProgressBar
	$ProgressBar.max_value = total_orbs
	$ProgressBar.value = collected_orbs

func _on_orb_collected():
	# Update the collected orbs counter
	collected_orbs += 1
	# Update the ProgressBar
	$ProgressBar.value = collected_orbs

	# Check if all orbs have been collected
	if collected_orbs == total_orbs:
		_on_all_orbs_collected()

func _on_all_orbs_collected():
	print("All orbs collected!")
	# Add additional logic for when all orbs are collected
