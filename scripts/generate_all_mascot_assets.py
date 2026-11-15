import os
import math
from PIL import Image, ImageDraw, ImageFilter, ImageOps
import numpy as np

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
COLOR_PINK = (242, 138, 178, 255)     # #F28AB2
COLOR_STEAM = (210, 210, 210, 180)

MASTER_PATH = 'assets/mascot/reference/master_character_transparent.png'

def get_base_canvas(width=340, height=440):
    canvas = Image.new('RGBA', (width, height), (0, 0, 0, 0))
    master = Image.open(MASTER_PATH).convert('RGBA')
    # Center master bear horizontally, anchor near bottom
    ox = (width - master.width) // 2
    oy = height - master.height - 25
    canvas.alpha_composite(master, (ox, oy))
    return canvas, ox, oy

def draw_outline_rect(draw, bbox, fill, outline=COLOR_BLACK, width=3, radius=6):
    draw.rounded_rectangle(bbox, radius=radius, fill=fill, outline=outline, width=width)

def draw_steam(draw, sx, sy):
    draw.arc([sx - 8, sy - 24, sx + 8, sy - 8], 180, 360, fill=COLOR_STEAM, width=3)
    draw.arc([sx - 4, sy - 40, sx + 12, sy - 20], 0, 180, fill=COLOR_STEAM, width=3)

def draw_sparkle(draw, cx, cy, size=8, color=COLOR_GOLD):
    draw.line([cx - size, cy, cx + size, cy], fill=color, width=2)
    draw.line([cx, cy - size, cx, cy + size], fill=color, width=2)
    draw.ellipse([cx - 2, cy - 2, cx + 2, cy + 2], fill=COLOR_WHITE)

def draw_coffee_cup(draw, cx, cy):
    # Ceramic café mug with handle
    draw_outline_rect(draw, [cx - 18, cy - 14, cx + 18, cy + 18], fill=COLOR_WHITE, outline=COLOR_BLACK, width=3, radius=4)
    # Coffee fill top
    draw.ellipse([cx - 15, cy - 18, cx + 15, cy - 10], fill=COLOR_COFFEE, outline=COLOR_BLACK, width=2)
    # Mug handle
    draw.arc([cx + 14, cy - 8, cx + 28, cy + 12], 270, 90, fill=COLOR_BLACK, width=3)
    draw_steam(draw, cx, cy - 18)

def draw_serving_tray(draw, cx, cy):
    draw.ellipse([cx - 45, cy - 10, cx + 45, cy + 10], fill=(225, 230, 235, 255), outline=COLOR_BLACK, width=3)
    draw_outline_rect(draw, [cx - 24, cy - 16, cx - 6, cy + 2], fill=COLOR_WHITE, outline=COLOR_BLACK, width=2, radius=2)
    draw.ellipse([cx - 22, cy - 18, cx - 8, cy - 14], fill=COLOR_COFFEE)
    draw.arc([cx + 6, cy - 16, cx + 30, cy + 2], 200, 340, fill=COLOR_GOLD, width=6)

# Ensure output directories exist
DIRS = [
    'assets/mascot/expressions',
    'assets/mascot/chef_actions',
    'assets/mascot/app_interactions',
    'assets/mascot/application_states',
    'assets/mascot/poses',
    'assets/mascot/onboarding',
    'assets/mascot/empty_states',
    'assets/mascot/celebrations',
]
for d in DIRS:
    os.makedirs(d, exist_ok=True)

# ----------------------------------------------------
# 1. EVERYDAY EXPRESSIONS (15)
# ----------------------------------------------------
def gen_expressions():
    print('Generating Category A: Everyday Expressions...')

    # 1. Neutral
    img, ox, oy = get_base_canvas()
    img.save('assets/mascot/expressions/neutral.png')

    # 2. Slight Smile
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Cover default mouth
    draw.rectangle([ox + 124, oy + 127, ox + 142, oy + 140], fill=COLOR_MUZZLE)
    # Draw gentle smile
    draw.arc([ox + 124, oy + 124, ox + 142, oy + 138], 20, 160, fill=COLOR_BLACK, width=3)
    img.save('assets/mascot/expressions/slight_smile.png')

    # 3. Happy (^ ^ eyes)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Cover eyes
    draw.ellipse([ox + 88, oy + 88, ox + 104, oy + 104], fill=COLOR_TAN)
    draw.ellipse([ox + 135, oy + 84, ox + 151, oy + 100], fill=COLOR_TAN)
    # Arced happy eyes
    draw.arc([ox + 88, oy + 88, ox + 104, oy + 104], 200, 340, fill=COLOR_BLACK, width=3)
    draw.arc([ox + 135, oy + 84, ox + 151, oy + 100], 200, 340, fill=COLOR_BLACK, width=3)
    # Warm smile
    draw.rectangle([ox + 124, oy + 127, ox + 142, oy + 140], fill=COLOR_MUZZLE)
    draw.arc([ox + 124, oy + 122, ox + 144, oy + 138], 20, 160, fill=COLOR_BLACK, width=3)
    img.save('assets/mascot/expressions/happy.png')

    # 4. Very Excited
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.rectangle([ox + 124, oy + 127, ox + 144, oy + 142], fill=COLOR_MUZZLE)
    # Open joyful mouth
    draw.chord([ox + 124, oy + 124, ox + 144, oy + 142], 0, 180, fill=COLOR_CHERRY, outline=COLOR_BLACK, width=2)
    # Sparkles near eyes
    draw_sparkle(draw, ox + 72, oy + 80, size=7)
    draw_sparkle(draw, ox + 162, oy + 76, size=7)
    img.save('assets/mascot/expressions/very_excited.png')

    # 5. Laughing (> < eyes)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.ellipse([ox + 88, oy + 88, ox + 104, oy + 104], fill=COLOR_TAN)
    draw.ellipse([ox + 135, oy + 84, ox + 151, oy + 100], fill=COLOR_TAN)
    # Closed laughter lines
    draw.line([ox + 90, oy + 92, ox + 102, oy + 98], fill=COLOR_BLACK, width=3)
    draw.line([ox + 90, oy + 104, ox + 102, oy + 98], fill=COLOR_BLACK, width=3)
    draw.line([ox + 147, oy + 88, ox + 135, oy + 94], fill=COLOR_BLACK, width=3)
    draw.line([ox + 147, oy + 100, ox + 135, oy + 94], fill=COLOR_BLACK, width=3)
    # Open laughing mouth
    draw.rectangle([ox + 124, oy + 127, ox + 144, oy + 143], fill=COLOR_MUZZLE)
    draw.chord([ox + 123, oy + 125, ox + 145, oy + 145], 0, 180, fill=COLOR_CHERRY, outline=COLOR_BLACK, width=2)
    img.save('assets/mascot/expressions/laughing.png')

    # 6. Confused (one brow up, wavy mouth)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Left brow raised
    draw.arc([ox + 88, oy + 78, ox + 104, oy + 90], 190, 350, fill=COLOR_BLACK, width=3)
    # Wavy mouth
    draw.rectangle([ox + 124, oy + 127, ox + 144, oy + 142], fill=COLOR_MUZZLE)
    draw.line([ox + 124, oy + 134, ox + 130, oy + 131], fill=COLOR_BLACK, width=3)
    draw.line([ox + 130, oy + 131, ox + 136, oy + 135], fill=COLOR_BLACK, width=3)
    draw.line([ox + 136, oy + 135, ox + 142, oy + 132], fill=COLOR_BLACK, width=3)
    # Tiny question mark near hat
    draw.text((ox + 155, oy + 30), '?', fill=COLOR_AMBER, font_size=24)
    img.save('assets/mascot/expressions/confused.png')

    # 7. Surprised (wide eyes, small 'o' mouth)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Wide pupils
    draw.ellipse([ox + 92, oy + 92, ox + 102, oy + 102], fill=COLOR_BLACK)
    draw.ellipse([ox + 139, oy + 88, ox + 149, oy + 98], fill=COLOR_BLACK)
    # Small 'o' mouth
    draw.rectangle([ox + 124, oy + 127, ox + 144, oy + 142], fill=COLOR_MUZZLE)
    draw.ellipse([ox + 129, oy + 130, ox + 139, oy + 142], fill=COLOR_BLACK)
    img.save('assets/mascot/expressions/surprised.png')

    # 8. Thinking (eyes looking up, paw near chin)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Shift pupils up-right
    draw.ellipse([ox + 88, oy + 88, ox + 104, oy + 104], fill=COLOR_TAN)
    draw.ellipse([ox + 135, oy + 84, ox + 151, oy + 100], fill=COLOR_TAN)
    draw.ellipse([ox + 98, oy + 90, ox + 104, oy + 97], fill=COLOR_BLACK)
    draw.ellipse([ox + 145, oy + 86, ox + 151, oy + 93], fill=COLOR_BLACK)
    # Paw to chin
    draw.ellipse([ox + 148, oy + 132, ox + 172, oy + 156], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/expressions/thinking.png')

    # 9. Sleepy (half-closed eyelids, Zzz)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Eyelids cutting across pupils
    draw.chord([ox + 91, oy + 91, ox + 103, oy + 103], 180, 360, fill=COLOR_TAN, outline=COLOR_BLACK, width=2)
    draw.chord([ox + 138, oy + 87, ox + 150, oy + 99], 180, 360, fill=COLOR_TAN, outline=COLOR_BLACK, width=2)
    # Zzz
    draw.text((ox + 155, oy + 25), 'Z', fill=COLOR_BLUE, font_size=20)
    draw.text((ox + 170, oy + 12), 'z', fill=COLOR_BLUE, font_size=16)
    draw.text((ox + 182, oy + 2), 'z', fill=COLOR_BLUE, font_size=12)
    img.save('assets/mascot/expressions/sleepy.png')

    # 10. Worried (angled brows, small tight mouth)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Angled brow lines
    draw.line([ox + 88, oy + 86, ox + 104, oy + 92], fill=COLOR_BLACK, width=3)
    draw.line([ox + 150, oy + 82, ox + 134, oy + 88], fill=COLOR_BLACK, width=3)
    # Small tight curved down mouth
    draw.rectangle([ox + 124, oy + 127, ox + 144, oy + 142], fill=COLOR_MUZZLE)
    draw.arc([ox + 125, oy + 132, ox + 143, oy + 144], 190, 350, fill=COLOR_BLACK, width=3)
    img.save('assets/mascot/expressions/worried.png')

    # 11. Proud (chin up, confident grin)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Confident eyes
    draw.arc([ox + 88, oy + 88, ox + 104, oy + 102], 190, 350, fill=COLOR_BLACK, width=3)
    draw.arc([ox + 135, oy + 84, ox + 151, oy + 98], 190, 350, fill=COLOR_BLACK, width=3)
    # Confident grin
    draw.rectangle([ox + 124, oy + 127, ox + 144, oy + 140], fill=COLOR_MUZZLE)
    draw.arc([ox + 123, oy + 122, ox + 145, oy + 137], 15, 165, fill=COLOR_BLACK, width=3)
    img.save('assets/mascot/expressions/proud.png')

    # 12. Disappointed
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.chord([ox + 91, oy + 91, ox + 103, oy + 103], 180, 360, fill=COLOR_TAN, outline=COLOR_BLACK, width=2)
    draw.chord([ox + 138, oy + 87, ox + 150, oy + 99], 180, 360, fill=COLOR_TAN, outline=COLOR_BLACK, width=2)
    draw.rectangle([ox + 124, oy + 127, ox + 144, oy + 142], fill=COLOR_MUZZLE)
    draw.arc([ox + 124, oy + 133, ox + 144, oy + 145], 190, 350, fill=COLOR_BLACK, width=3)
    img.save('assets/mascot/expressions/disappointed.png')

    # 13. Embarrassed (rosy cheeks, shy smile)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Pink blush ovals
    draw.ellipse([ox + 74, oy + 104, ox + 94, oy + 116], fill=COLOR_PINK)
    draw.ellipse([ox + 146, oy + 100, ox + 166, oy + 112], fill=COLOR_PINK)
    draw.rectangle([ox + 124, oy + 127, ox + 144, oy + 140], fill=COLOR_MUZZLE)
    draw.arc([ox + 126, oy + 124, ox + 142, oy + 136], 20, 160, fill=COLOR_BLACK, width=3)
    img.save('assets/mascot/expressions/embarrassed.png')

    # 14. Curious
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Bright wide eyes
    draw.ellipse([ox + 93, oy + 92, ox + 103, oy + 102], fill=COLOR_BLACK)
    draw.ellipse([ox + 140, oy + 88, ox + 150, oy + 98], fill=COLOR_BLACK)
    draw.ellipse([ox + 95, oy + 94, ox + 98, oy + 97], fill=COLOR_WHITE)
    draw.ellipse([ox + 142, oy + 90, ox + 145, oy + 93], fill=COLOR_WHITE)
    img.save('assets/mascot/expressions/curious.png')

    # 15. Determined
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Firm brow lines
    draw.line([ox + 88, oy + 88, ox + 104, oy + 94], fill=COLOR_BLACK, width=3)
    draw.line([ox + 148, oy + 84, ox + 134, oy + 90], fill=COLOR_BLACK, width=3)
    draw.rectangle([ox + 124, oy + 127, ox + 144, oy + 140], fill=COLOR_MUZZLE)
    draw.line([ox + 126, oy + 132, ox + 142, oy + 132], fill=COLOR_BLACK, width=3)
    img.save('assets/mascot/expressions/determined.png')

    print('Category A complete: 15 expressions saved.')

# ----------------------------------------------------
# 2. CHEF ACTIONS & PROPS (15)
# ----------------------------------------------------
def gen_chef_actions():
    print('Generating Category B: Chef Actions & Props...')

    # 16. Holding Coffee Cup
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw_coffee_cup(draw, ox + 165, oy + 215)
    # Paw holding mug
    draw.ellipse([ox + 150, oy + 215, ox + 172, oy + 235], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/chef_actions/holding_coffee_cup.png')

    # 17. Holding Serving Tray
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw_serving_tray(draw, ox + 160, oy + 210)
    draw.ellipse([ox + 148, oy + 210, ox + 172, oy + 230], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/chef_actions/holding_tray.png')

    # 18. Cooking Pan
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Skillet pan
    draw.ellipse([ox + 140, oy + 200, ox + 195, oy + 225], fill=(70, 75, 80, 255), outline=COLOR_BLACK, width=3)
    draw.ellipse([ox + 145, oy + 203, ox + 190, oy + 222], fill=(45, 50, 55, 255))
    # Golden pancake
    draw.ellipse([ox + 152, oy + 206, ox + 182, oy + 219], fill=COLOR_GOLD, outline=COLOR_BLACK, width=2)
    # Pan handle
    draw.line([ox + 190, oy + 215, ox + 225, oy + 225], fill=(30, 30, 30, 255), width=6)
    draw.ellipse([ox + 175, oy + 212, ox + 195, oy + 230], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/chef_actions/cooking_pan.png')

    # 19. Holding Spatula
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Wooden spatula blade & handle
    draw.polygon([(ox + 185, oy + 140), (ox + 205, oy + 135), (ox + 210, oy + 165), (ox + 190, oy + 170)], fill=(215, 175, 130, 255), outline=COLOR_BLACK)
    draw.line([ox + 195, oy + 170, ox + 180, oy + 225], fill=(180, 140, 100, 255), width=5)
    draw.ellipse([ox + 172, oy + 205, ox + 192, oy + 225], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/chef_actions/holding_spatula.png')

    # 20. Checking Recipe
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Notepad ticket
    draw_outline_rect(draw, [ox + 140, oy + 175, ox + 195, oy + 245], fill=COLOR_WHITE, outline=COLOR_BLACK, width=3, radius=4)
    # Recipe lines
    for ly in range(oy + 190, oy + 235, 10):
        draw.line([ox + 150, ly, ox + 185, ly], fill=COLOR_APRON_LINE, width=2)
    draw.ellipse([ox + 135, oy + 215, ox + 155, oy + 235], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/chef_actions/checking_recipe.png')

    # 21. Holding Menu
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw_outline_rect(draw, [ox + 135, oy + 170, ox + 200, oy + 250], fill=(40, 40, 40, 255), outline=COLOR_GOLD, width=3, radius=6)
    draw.text((ox + 146, oy + 180), 'MENU', fill=COLOR_GOLD, font_size=14)
    for ly in range(oy + 205, oy + 240, 9):
        draw.line([ox + 145, ly, ox + 190, ly], fill=(200, 200, 200, 255), width=2)
    draw.ellipse([ox + 130, oy + 210, ox + 150, oy + 230], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/chef_actions/holding_menu.png')

    # 22. Holding Receipt
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Thermal receipt slip
    draw.polygon([
        (ox + 150, oy + 170), (ox + 190, oy + 170),
        (ox + 190, oy + 265), (ox + 183, oy + 260), (ox + 176, oy + 265), (ox + 170, oy + 260),
        (ox + 163, oy + 265), (ox + 156, oy + 260), (ox + 150, oy + 265)
    ], fill=COLOR_WHITE, outline=COLOR_BLACK)
    for ly in range(oy + 185, oy + 250, 8):
        draw.line([ox + 156, ly, ox + 184, ly], fill=COLOR_BLACK, width=1)
    draw.ellipse([ox + 142, oy + 200, ox + 162, oy + 220], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/chef_actions/holding_receipt.png')

    # 23. Carrying Cake
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Cake base
    draw_outline_rect(draw, [ox + 130, oy + 205, ox + 195, oy + 240], fill=(245, 230, 210, 255), outline=COLOR_BLACK, width=3, radius=4)
    # White cream frosting
    draw.chord([ox + 130, oy + 195, ox + 195, oy + 215], 180, 360, fill=COLOR_WHITE, outline=COLOR_BLACK, width=2)
    # Cherry on top
    draw.ellipse([ox + 158, oy + 188, ox + 168, oy + 198], fill=COLOR_CHERRY, outline=COLOR_BLACK, width=2)
    draw.ellipse([ox + 120, oy + 215, ox + 140, oy + 235], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    draw.ellipse([ox + 185, oy + 215, ox + 205, oy + 235], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/chef_actions/carrying_cake.png')

    # 24. Wearing Oven Mitts
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Red quilted mitts covering paws
    draw_outline_rect(draw, [ox + 30, oy + 190, ox + 65, oy + 235], fill=COLOR_AMBER, outline=COLOR_BLACK, width=3, radius=12)
    draw_outline_rect(draw, [ox + 165, oy + 195, ox + 200, oy + 240], fill=COLOR_AMBER, outline=COLOR_BLACK, width=3, radius=12)
    img.save('assets/mascot/chef_actions/wearing_oven_mitts.png')

    # 25. Thumbs Up
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Thumbs up paw
    draw.ellipse([ox + 165, oy + 185, ox + 195, oy + 215], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    draw.ellipse([ox + 172, oy + 165, ox + 188, oy + 195], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    draw_sparkle(draw, ox + 195, oy + 165, size=8)
    img.save('assets/mascot/chef_actions/thumbs_up.png')

    # 26. Arms Crossed
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Crossed forearm bar over apron
    draw_outline_rect(draw, [ox + 60, oy + 205, ox + 170, oy + 235], fill=COLOR_FUR, outline=COLOR_BLACK, width=4, radius=12)
    img.save('assets/mascot/chef_actions/arms_crossed.png')

    # 27. Tasting Food (spoon to mouth)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Spoon
    draw.line([ox + 175, oy + 175, ox + 140, oy + 140], fill=(190, 195, 200, 255), width=4)
    draw.ellipse([ox + 132, oy + 130, ox + 146, oy + 144], fill=(210, 215, 220, 255), outline=COLOR_BLACK, width=2)
    draw.ellipse([ox + 165, oy + 170, ox + 185, oy + 190], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/chef_actions/tasting_food.png')

    # 28. Holding Coffee Pot (Chemex/Carafe)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Glass carafe
    draw.polygon([(ox + 155, oy + 175), (ox + 185, oy + 175), (ox + 200, oy + 235), (ox + 140, oy + 235)], fill=(230, 240, 250, 190), outline=COLOR_BLACK)
    # Coffee brew inside
    draw.polygon([(ox + 150, oy + 205), (ox + 190, oy + 205), (ox + 198, oy + 233), (ox + 142, oy + 233)], fill=COLOR_COFFEE)
    draw.ellipse([ox + 175, oy + 190, ox + 195, oy + 210], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/chef_actions/holding_coffee_pot.png')

    # 29. Preparing Order (cutting board)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Cutting board
    draw_outline_rect(draw, [ox + 110, oy + 215, ox + 205, oy + 255], fill=(200, 150, 100, 255), outline=COLOR_BLACK, width=3, radius=4)
    # Sandwich layers
    draw_outline_rect(draw, [ox + 130, oy + 225, ox + 180, oy + 245], fill=(240, 215, 170, 255), outline=COLOR_BLACK, width=2, radius=2)
    draw.line([ox + 132, oy + 235, ox + 178, oy + 235], fill=COLOR_GREEN, width=3)
    img.save('assets/mascot/chef_actions/preparing_order.png')

    # 30. Relaxing Shift
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.text((ox + 160, oy + 30), '☕', fill=COLOR_COFFEE, font_size=28)
    # Content smile
    draw.rectangle([ox + 124, oy + 127, ox + 144, oy + 140], fill=COLOR_MUZZLE)
    draw.arc([ox + 123, oy + 122, ox + 145, oy + 137], 15, 165, fill=COLOR_BLACK, width=3)
    img.save('assets/mascot/chef_actions/relaxing_shift.png')

    print('Category B complete: 15 chef actions saved.')

# ----------------------------------------------------
# 3. APPLICATION INTERACTIONS (12)
# ----------------------------------------------------
def gen_app_interactions():
    print('Generating Category C: Application Interactions...')

    # 31. Welcoming (both arms open)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.ellipse([ox + 20, oy + 165, ox + 50, oy + 195], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    draw.ellipse([ox + 180, oy + 165, ox + 210, oy + 195], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    draw.rectangle([ox + 124, oy + 127, ox + 144, oy + 140], fill=COLOR_MUZZLE)
    draw.arc([ox + 123, oy + 122, ox + 145, oy + 137], 15, 165, fill=COLOR_BLACK, width=3)
    img.save('assets/mascot/app_interactions/welcoming.png')

    # 32. Waving Hello
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.ellipse([ox + 175, oy + 135, ox + 205, oy + 165], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    # Waving lines
    draw.arc([ox + 205, oy + 130, ox + 220, oy + 155], 300, 60, fill=COLOR_BLACK, width=2)
    draw.arc([ox + 210, oy + 125, ox + 228, oy + 160], 300, 60, fill=COLOR_BLACK, width=2)
    img.save('assets/mascot/app_interactions/waving_hello.png')

    # 33. Pointing Interface
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.ellipse([ox + 175, oy + 190, ox + 205, oy + 215], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    draw.line([ox + 200, oy + 202, ox + 235, oy + 202], fill=COLOR_FUR, width=10)
    draw.ellipse([ox + 225, oy + 197, ox + 242, oy + 207], fill=COLOR_FUR, outline=COLOR_BLACK, width=2)
    img.save('assets/mascot/app_interactions/pointing_interface.png')

    # 34. Explaining
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.ellipse([ox + 170, oy + 175, ox + 200, oy + 205], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    draw.text((ox + 185, oy + 150), '💡', fill=COLOR_GOLD, font_size=24)
    img.save('assets/mascot/app_interactions/explaining.png')

    # 35. Holding Checklist
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw_outline_rect(draw, [ox + 140, oy + 170, ox + 200, oy + 245], fill=(225, 235, 245, 255), outline=COLOR_BLACK, width=3, radius=4)
    for ly in [oy + 190, oy + 208, oy + 226]:
        draw.text((ox + 146, ly - 4), '✓', fill=COLOR_GREEN, font_size=14)
        draw.line([ox + 162, ly + 4, ox + 190, ly + 4], fill=COLOR_BLACK, width=2)
    draw.ellipse([ox + 132, oy + 205, ox + 152, oy + 225], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/app_interactions/holding_checklist.png')

    # 36. Looking Dashboard (holding tablet with charts)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw_outline_rect(draw, [ox + 135, oy + 170, ox + 205, oy + 235], fill=(30, 35, 40, 255), outline=COLOR_BLACK, width=3, radius=6)
    # Mini chart bars
    draw.rectangle([ox + 145, oy + 215, ox + 153, oy + 225], fill=COLOR_BLUE)
    draw.rectangle([ox + 158, oy + 200, ox + 166, oy + 225], fill=COLOR_GOLD)
    draw.rectangle([ox + 171, oy + 190, ox + 179, oy + 225], fill=COLOR_GREEN)
    draw.rectangle([ox + 184, oy + 205, ox + 192, oy + 225], fill=COLOR_AMBER)
    draw.ellipse([ox + 128, oy + 205, ox + 148, oy + 225], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/app_interactions/looking_dashboard.png')

    # 37. Typing Laptop
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Laptop screen
    draw_outline_rect(draw, [ox + 135, oy + 170, ox + 200, oy + 215], fill=(50, 55, 60, 255), outline=COLOR_BLACK, width=3, radius=3)
    draw.rectangle([ox + 142, oy + 176, ox + 193, oy + 209], fill=(230, 240, 250, 255))
    # Keyboard base
    draw.polygon([(ox + 125, oy + 225), (ox + 210, oy + 225), (ox + 195, oy + 215), (ox + 140, oy + 215)], fill=(180, 185, 190, 255), outline=COLOR_BLACK)
    img.save('assets/mascot/app_interactions/typing_laptop.png')

    # 38. Reading Notification
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw_outline_rect(draw, [ox + 140, oy + 170, ox + 195, oy + 230], fill=COLOR_WHITE, outline=COLOR_AMBER, width=3, radius=8)
    draw.text((ox + 158, oy + 180), '🔔', fill=COLOR_AMBER, font_size=20)
    draw.line([ox + 150, oy + 215, ox + 185, oy + 215], fill=COLOR_BLACK, width=2)
    draw.ellipse([ox + 132, oy + 200, ox + 152, oy + 220], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/app_interactions/reading_notification.png')

    # 39. Waiting Patiently
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Paws resting gently together on apron pocket
    draw.ellipse([ox + 115, oy + 230, ox + 145, oy + 250], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/app_interactions/waiting_patiently.png')

    # 40. Celebrating Task (Confetti burst)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Raised arms
    draw.ellipse([ox + 20, oy + 150, ox + 48, oy + 180], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    draw.ellipse([ox + 180, oy + 150, ox + 208, oy + 180], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    # Confetti dots & stars
    confetti_colors = [COLOR_GOLD, COLOR_GREEN, COLOR_BLUE, COLOR_PINK, COLOR_AMBER]
    for i, (cx, cy) in enumerate([(40, 60), (70, 40), (160, 35), (200, 55), (220, 85), (30, 95)]):
        draw.ellipse([ox + cx, oy + cy, ox + cx + 8, oy + cy + 8], fill=confetti_colors[i % len(confetti_colors)])
    draw_sparkle(draw, ox + 80, oy + 60, size=9)
    draw_sparkle(draw, ox + 180, oy + 50, size=9)
    img.save('assets/mascot/app_interactions/celebrating_task.png')

    # 41. High Five
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # High-five palm facing viewer
    draw.ellipse([ox + 175, oy + 140, ox + 215, oy + 180], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    # Palm pads in spectacle tan
    draw.ellipse([ox + 185, oy + 152, ox + 205, oy + 170], fill=COLOR_TAN)
    draw_sparkle(draw, ox + 215, oy + 135, size=8)
    img.save('assets/mascot/app_interactions/high_five.png')

    # 42. Waving Goodbye
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.ellipse([ox + 175, oy + 140, ox + 205, oy + 170], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    draw.text((ox + 205, oy + 145), '👋', font_size=20)
    img.save('assets/mascot/app_interactions/waving_goodbye.png')

    print('Category C complete: 12 application interactions saved.')

# ----------------------------------------------------
# 4. APPLICATION STATUS ILLUSTRATIONS (12)
# ----------------------------------------------------
def gen_application_states():
    print('Generating Category D: Application Status Illustrations...')

    # 43. Loading Patiently (hourglass)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Hourglass
    draw.polygon([(ox + 150, oy + 180), (ox + 180, oy + 180), (ox + 165, oy + 205)], fill=COLOR_GOLD, outline=COLOR_BLACK, width=2)
    draw.polygon([(ox + 150, oy + 230), (ox + 180, oy + 230), (ox + 165, oy + 205)], fill=COLOR_GOLD, outline=COLOR_BLACK, width=2)
    draw.line([ox + 145, oy + 180, ox + 185, oy + 180], fill=COLOR_COFFEE, width=4)
    draw.line([ox + 145, oy + 230, ox + 185, oy + 230], fill=COLOR_COFFEE, width=4)
    draw.ellipse([ox + 138, oy + 200, ox + 158, oy + 220], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/application_states/loading_patiently.png')

    # 44. Offline Concerned (unplugged WiFi cord)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Unplugged cord & lightning spark
    draw.line([ox + 150, oy + 220, ox + 180, oy + 220], fill=COLOR_BLACK, width=4)
    draw.rectangle([ox + 180, oy + 213, ox + 195, oy + 227], fill=(80, 80, 80, 255), outline=COLOR_BLACK)
    draw.line([ox + 195, oy + 216, ox + 203, oy + 216], fill=COLOR_GOLD, width=3)
    draw.line([ox + 195, oy + 224, ox + 203, oy + 224], fill=COLOR_GOLD, width=3)
    draw.text((ox + 160, oy + 180), '📶❌', font_size=18)
    img.save('assets/mascot/application_states/offline_concerned.png')

    # 45. Synchronizing (circular sync arrows)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Circular arrows around paw
    draw.arc([ox + 150, oy + 185, ox + 195, oy + 230], 40, 310, fill=COLOR_BLUE, width=4)
    draw.polygon([(ox + 185, oy + 180), (ox + 198, oy + 192), (ox + 180, oy + 195)], fill=COLOR_BLUE)
    draw.ellipse([ox + 160, oy + 197, ox + 185, oy + 218], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/application_states/synchronizing.png')

    # 46. Error Warning (amber triangle)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.polygon([(ox + 175, oy + 175), (ox + 150, oy + 225), (ox + 200, oy + 225)], fill=COLOR_AMBER, outline=COLOR_BLACK, width=3)
    draw.text((ox + 171, oy + 188), '!', fill=COLOR_BLACK, font_size=24)
    draw.ellipse([ox + 140, oy + 210, ox + 160, oy + 230], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/application_states/error_warning.png')

    # 47. Holding Retry Sign
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw_outline_rect(draw, [ox + 145, oy + 175, ox + 205, oy + 235], fill=COLOR_GREEN, outline=COLOR_BLACK, width=3, radius=8)
    draw.text((ox + 156, oy + 185), '↻', fill=COLOR_WHITE, font_size=32)
    draw.ellipse([ox + 135, oy + 205, ox + 155, oy + 225], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/application_states/holding_retry_sign.png')

    # 48. Celebrating Success (Trophy)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Golden trophy cup
    draw.polygon([(ox + 150, oy + 180), (ox + 190, oy + 180), (ox + 185, oy + 215), (ox + 155, oy + 215)], fill=COLOR_GOLD, outline=COLOR_BLACK, width=3)
    draw.arc([ox + 142, oy + 185, ox + 155, oy + 205], 90, 270, fill=COLOR_GOLD, width=3)
    draw.arc([ox + 185, oy + 185, ox + 198, oy + 205], 270, 90, fill=COLOR_GOLD, width=3)
    draw.rectangle([ox + 165, oy + 215, ox + 175, oy + 228], fill=COLOR_GOLD, outline=COLOR_BLACK, width=2)
    draw.rectangle([ox + 155, oy + 228, ox + 185, oy + 238], fill=(60, 60, 60, 255), outline=COLOR_BLACK, width=2)
    draw_sparkle(draw, ox + 170, oy + 170, size=8)
    img.save('assets/mascot/application_states/celebrating_success.png')

    # 49. Empty Plate ("No items yet")
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Empty plate on ground/stand
    draw.ellipse([ox + 135, oy + 220, ox + 210, oy + 250], fill=COLOR_WHITE, outline=COLOR_BLACK, width=3)
    draw.ellipse([ox + 148, oy + 226, ox + 197, oy + 244], fill=(245, 245, 245, 255), outline=COLOR_APRON_LINE, width=1)
    # Fork and knife beside plate
    draw.line([ox + 125, oy + 220, ox + 125, oy + 248], fill=(180, 180, 180, 255), width=3)
    draw.line([ox + 218, oy + 220, ox + 218, oy + 248], fill=(180, 180, 180, 255), width=3)
    img.save('assets/mascot/application_states/empty_plate.png')

    # 50. Low Inventory Warning (empty burlap sack)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.polygon([(ox + 145, oy + 195), (ox + 185, oy + 195), (ox + 195, oy + 240), (ox + 135, oy + 240)], fill=(180, 140, 100, 255), outline=COLOR_BLACK, width=3)
    draw.text((ox + 152, oy + 205), 'BEANS', fill=(80, 50, 20, 255), font_size=10)
    draw.text((ox + 180, oy + 175), '⚠️', font_size=20)
    draw.ellipse([ox + 130, oy + 210, ox + 150, oy + 230], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/application_states/low_inventory_warning.png')

    # 51. Sleeping Idle
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.chord([ox + 91, oy + 91, ox + 103, oy + 103], 180, 360, fill=COLOR_TAN, outline=COLOR_BLACK, width=2)
    draw.chord([ox + 138, oy + 87, ox + 150, oy + 99], 180, 360, fill=COLOR_TAN, outline=COLOR_BLACK, width=2)
    draw.text((ox + 155, oy + 25), 'Z', fill=COLOR_BLUE, font_size=24)
    draw.text((ox + 175, oy + 10), 'z', fill=COLOR_BLUE, font_size=18)
    draw.text((ox + 190, oy + 0), 'z', fill=COLOR_BLUE, font_size=12)
    img.save('assets/mascot/application_states/sleeping_idle.png')

    # 52. Reacting New Order (Bell ringing)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Golden counter call bell
    draw.ellipse([ox + 155, oy + 225, ox + 185, oy + 240], fill=(60, 60, 60, 255), outline=COLOR_BLACK, width=2)
    draw.chord([ox + 158, oy + 210, ox + 182, oy + 230], 180, 360, fill=COLOR_GOLD, outline=COLOR_BLACK, width=2)
    draw.line([ox + 170, oy + 205, ox + 170, oy + 212], fill=COLOR_BLACK, width=3)
    # Sound waves
    draw.arc([ox + 182, oy + 200, ox + 200, oy + 225], 300, 60, fill=COLOR_AMBER, width=2)
    draw_sparkle(draw, ox + 180, oy + 195, size=7)
    img.save('assets/mascot/application_states/reacting_new_order.png')

    # 53. Failed Printer (tangled receipt)
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Mini POS printer box
    draw_outline_rect(draw, [ox + 145, oy + 200, ox + 195, oy + 245], fill=(50, 50, 50, 255), outline=COLOR_BLACK, width=3, radius=4)
    # Tangled paper ribbon
    draw.arc([ox + 155, oy + 180, ox + 185, oy + 205], 0, 360, fill=COLOR_WHITE, width=4)
    draw.text((ox + 160, oy + 165), '⚠️', font_size=16)
    img.save('assets/mascot/application_states/failed_printer.png')

    # 54. Stock Warning Tag
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Tag placard
    draw.polygon([(ox + 150, oy + 185), (ox + 195, oy + 185), (ox + 205, oy + 235), (ox + 140, oy + 235)], fill=COLOR_AMBER, outline=COLOR_BLACK, width=3)
    draw.text((ox + 165, oy + 195), 'LOW', fill=COLOR_WHITE, font_size=12)
    draw.ellipse([ox + 132, oy + 210, ox + 152, oy + 230], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/application_states/stock_warning.png')

    print('Category D complete: 12 application status illustrations saved.')

# ----------------------------------------------------
# 5. POSE VARIATIONS (8) & ONBOARDING / EMPTY STATES
# ----------------------------------------------------
def gen_poses_and_states():
    print('Generating Category E: Pose Variations & States...')

    # Poses:
    # 1. Standing Relaxed
    img, ox, oy = get_base_canvas()
    img.save('assets/mascot/poses/standing_relaxed.png')

    # 2. Pointing Left
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.line([ox + 40, oy + 202, ox + 10, oy + 202], fill=COLOR_FUR, width=10)
    draw.ellipse([ox + 5, oy + 197, ox + 22, oy + 207], fill=COLOR_FUR, outline=COLOR_BLACK, width=2)
    img.save('assets/mascot/poses/pointing_left.png')

    # 3. Pointing Right
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.line([ox + 200, oy + 202, ox + 235, oy + 202], fill=COLOR_FUR, width=10)
    draw.ellipse([ox + 225, oy + 197, ox + 242, oy + 207], fill=COLOR_FUR, outline=COLOR_BLACK, width=2)
    img.save('assets/mascot/poses/pointing_right.png')

    # 4. Celebrating
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.ellipse([ox + 20, oy + 150, ox + 48, oy + 180], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    draw.ellipse([ox + 180, oy + 150, ox + 208, oy + 180], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    draw_sparkle(draw, ox + 70, oy + 60, size=8)
    draw_sparkle(draw, ox + 170, oy + 50, size=8)
    img.save('assets/mascot/poses/celebrating.png')

    # 5. Looking around corner
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    # Wall line on left
    draw.line([ox + 30, 0, ox + 30, oy + 350], fill=(160, 160, 160, 255), width=6)
    img.save('assets/mascot/poses/looking_corner.png')

    # 6. Sleeping
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.chord([ox + 91, oy + 91, ox + 103, oy + 103], 180, 360, fill=COLOR_TAN, outline=COLOR_BLACK, width=2)
    draw.chord([ox + 138, oy + 87, ox + 150, oy + 99], 180, 360, fill=COLOR_TAN, outline=COLOR_BLACK, width=2)
    draw.text((ox + 155, oy + 25), 'Zzz', fill=COLOR_BLUE, font_size=20)
    img.save('assets/mascot/poses/sleeping.png')

    # Onboarding & Empty states:
    # Onboarding Welcome
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.ellipse([ox + 20, oy + 165, ox + 50, oy + 195], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    draw.ellipse([ox + 180, oy + 165, ox + 210, oy + 195], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    draw_sparkle(draw, ox + 60, oy + 80, size=8)
    draw_sparkle(draw, ox + 175, oy + 70, size=8)
    img.save('assets/mascot/onboarding/welcome_chef.png')

    # Empty Menu State
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw_outline_rect(draw, [ox + 135, oy + 170, ox + 200, oy + 250], fill=(40, 40, 40, 255), outline=COLOR_GOLD, width=3, radius=6)
    draw.text((ox + 146, oy + 180), 'MENU', fill=COLOR_GOLD, font_size=14)
    draw.ellipse([ox + 130, oy + 210, ox + 150, oy + 230], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/empty_states/empty_menu.png')

    # Empty Orders State
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.ellipse([ox + 135, oy + 220, ox + 210, oy + 250], fill=COLOR_WHITE, outline=COLOR_BLACK, width=3)
    img.save('assets/mascot/empty_states/empty_orders.png')

    # Celebration Confetti
    img, ox, oy = get_base_canvas()
    draw = ImageDraw.Draw(img)
    draw.ellipse([ox + 20, oy + 150, ox + 48, oy + 180], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    draw.ellipse([ox + 180, oy + 150, ox + 208, oy + 180], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    for i, (cx, cy) in enumerate([(40, 50), (80, 30), (160, 25), (200, 45), (230, 80), (20, 85)]):
        draw.ellipse([ox + cx, oy + cy, ox + cx + 9, oy + cy + 9], fill=COLOR_GOLD)
    img.save('assets/mascot/celebrations/confetti_celebration.png')

    print('Poses and state variants complete.')

if __name__ == '__main__':
    gen_expressions()
    gen_chef_actions()
    gen_app_interactions()
    gen_application_states()
    gen_poses_and_states()
    print('ALL MASCOT ASSETS GENERATED SUCCESSFULLY!')
