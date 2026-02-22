extends ColorRect

@onready var roundreached := $RoundReached
@onready var totalpoints := $TotalPoints

func _ready():
	roundreached.text = "Round Reached: " + str(GlobalData.roundnum)
	totalpoints.text = "Total points: " + str(GlobalData.points)
