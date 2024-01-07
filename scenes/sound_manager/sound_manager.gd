extends Node2D

func laser_sound(pos):
    $LaserSound.global_position = pos
    $LaserSound.play()

func explosion_sound(pos):
    $ExplosionSound.global_position = pos
    $ExplosionSound.play()