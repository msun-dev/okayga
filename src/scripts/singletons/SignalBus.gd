extends Node

# Audio
signal _audio_settings_update()

# Game logic
signal _load_score()
signal _save_score(value)
signal _update_ui_score(score, high, last)
signal _disable()
signal _enable()
signal _predisable()
signal _trigger_game_over()
signal _trigger_game_start()

# Game logic UI
signal _show_settings()
signal _show_game_over_screen()
signal _show_game_screen()

# Saver
signal _update_high(value)

# Egg generator
signal _add_points(size)
signal _update_future_eggs(array)

# Eggsplotions
signal _eggsplotion()
signal _eggsploded()

# UI Freeze
signal _freeze()
signal _unfreeze()

# Okayga
signal _drop_egg()
