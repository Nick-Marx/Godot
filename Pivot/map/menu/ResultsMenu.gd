extends VBoxContainer


@export var lastResultsLabel: Label
@export var totalResultsLabel: Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	Signals.newGame.connect(new_game_callable)


func new_game_callable():
	last_results_text()
	total_results_text()

func last_results_text():
	lastResultsLabel.text = "Last Score Reached: %s \nLast Time Reached: %s" % [Global.lastEndScore, Global.lastEndTime]


func total_results_text():
	totalResultsLabel.text = "Total Score: %s \nTotal Time: %s" % [Global.totalScore, total_time()]


func total_time():
	var seconds = fmod(Global.totalTime, 60)
	var minutes = fmod(Global.totalTime, 3600) / 60
	var hours = fmod(Global.totalTime, 86400) / 3600
	return "%02d : %02d : %02d" % [hours, minutes, seconds]
	
