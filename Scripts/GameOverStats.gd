extends ColorRect

@onready var roundreached := $RoundReached
@onready var totalpoints := $TotalPoints

func _ready():
	roundreached.text = "Highest Round Reached: " + str(GlobalData.roundnum)
	totalpoints.text = "Ending Amount of Points: " + str(GlobalData.points)
