import os
import math
from PIL import Image, ImageDraw, ImageFilter
import numpy as np

# Palette Constants
COLOR_FUR = (57, 54, 53, 255)         # #393635
COLOR_TAN = (210, 177, 142, 255)      # #D2B18E
COLOR_MUZZLE = (238, 224, 207, 255)   # #EEE0CF
COLOR_BLACK = (23, 22, 21, 255)       # #171615
COLOR_WHITE = (255, 255, 255, 255)    # #FFFFFF
COLOR_APRON = (245, 237, 228, 255)    # #F5EDE4
COLOR_APRON_LINE = (155, 146, 137, 255) # #9B9289
COLOR_COFFEE = (111, 78, 55, 255)     # #6F4E37
COLOR_GOLD = (230, 175, 46, 255)      # #E6AF2E
COLOR_CHERRY = (217, 48, 37, 255)     # #D93025
COLOR_AMBER = (242, 153, 74, 255)     # #F2994A
COLOR_BLUE = (47, 128, 237, 255)      # #2F80ED
COLOR_GREEN = (39, 174, 96, 255)      # #27AE60

MASTER_PATH = 'assets/mascot/reference/master_character_transparent.png'

def get_base_bear():
    return Image.open(MASTER_PATH).convert('RGBA')

def create_canvas(w=320, h=400):
    return Image.new('RGBA', (w, h), (0, 0, 0, 0))

def paste_centered(canvas, img, y_offset=20):
    x = (canvas.width - img.width) // 2
    canvas.alpha_composite(img, (x, y_offset))
    return x, y_offset

print('Mascot generator script module initialized.')
