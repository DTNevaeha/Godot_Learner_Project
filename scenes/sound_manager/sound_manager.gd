extends Node2D

func laser_sound(pos):
    $LaserSound.global_position = pos
    $LaserSound.play()