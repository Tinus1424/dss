def analyze_sleep_quality(hours_slept, sleep_satisfaction):
    if sleep_satisfaction == "poor" or sleep_satisfaction == "fair":
        if hours_slept < 3:
            return "Extermely low sleep quality"
        if hours_slept <= 6:
            return "Low sleep quality"
        if hours_slept > 6:
            return "Medium sleep quality"
    elif sleep_satisfaction == "good" or sleep_satisfaction == "excellent":
        if hours_slept < 3:
            return "Bad sleep quality"
        if hours_slept <= 6:
            return "Satisfactory sleep quality"
        if hours_slept > 6:
            return "Fantastic sleep quality"
        
sleep_quality_analysis = analyze_sleep_quality(10, "good")
print("Sleep Quality Analysis:", sleep_quality_analysis)