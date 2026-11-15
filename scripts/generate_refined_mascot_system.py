"""
Refined Mascot Identity & Anatomical Drawing Engine for CaféOS / MΛCHA
Fixes:
1. Strict 2-Arm Rule: Active poses cleanly remove default resting limbs so character NEVER has 4 hands!
2. Natural Character-Grade Paw Anatomy: Organic, soft cartoon bear paws matching master character.
3. Expressive, theme-aligned postures and chef actions.
"""

import os
import math
from PIL import Image, ImageDraw, ImageFont, ImageFilter

MASTER_PATH = 'assets/mascot/reference/master_character_transparent.png'
if not os.path.exists(MASTER_PATH):
    MASTER_PATH = 'assets/mascot/reference/master_character.png'

# Master Character Palette (#393635 fur, #D2B18E eye patch, #EEE0CF muzzle, #171615 line)
COLOR_FUR = (57, 54, 52, 255)
COLOR_FUR_DARK = (42, 39, 38, 255)
COLOR_BLACK = (23, 22, 21, 255)
COLOR_TAN = (210, 177, 142, 255)
COLOR_MUZZLE = (238, 224, 207, 255)
COLOR_NOSE = (23, 22, 21, 255)
COLOR_APRON = (246, 238, 229, 255)
COLOR_APRON_LINE = (180, 170, 160, 255)
COLOR_WHITE = (255, 255, 255, 255)
COLOR_PAD_INNER = (210, 177, 142, 255)

# Accent & Prop Colors
COLOR_GOLD = (232, 146, 70, 255)
COLOR_COFFEE = (68, 52, 43, 255)
COLOR_WOOD = (168, 122, 86, 255)
COLOR_STEEL = (210, 215, 220, 255)
COLOR_STEEL_DARK = (140, 145, 150, 255)
COLOR_BLUE = (2, 132, 199, 255)
COLOR_MUTED_TEXT = (130, 123, 130, 255)

_master_cache = None

def get_master():
    global _master_cache
    if _master_cache is None:
        _master_cache = Image.open(MASTER_PATH).convert('RGBA')
    return _master_cache

def get_base_body(no_left=False, no_right=False):
    """
    Returns a copy of the master bear with resting arms removed and body flanks cleanly sealed.
    Ensures that when active arms are drawn, the bear has EXACTLY 2 ARMS!
    """
    master = get_master()
    base = master.copy()
    pix = base.load()
    w, h = master.size

    if no_left:
        # Clear left resting arm
        for y in range(160, 285):
            for x in range(0, 56):
                pix[x, y] = (0, 0, 0, 0)
        # Seal flank contour
        draw = ImageDraw.Draw(base)
        draw.line([(55, 160), (55, 285)], fill=COLOR_BLACK, width=2)

    if no_right:
        # Clear right resting arm
        for y in range(160, 285):
            for x in range(172, w):
                pix[x, y] = (0, 0, 0, 0)
        # Seal flank contour
        draw = ImageDraw.Draw(base)
        draw.line([(173, 160), (173, 285)], fill=COLOR_BLACK, width=2)

    return base

# ----------------------------------------------------------------------
# 1. ORGANIC CARTOON BEAR PAW ARTICULATION
# ----------------------------------------------------------------------
def render_paw(paw_id, width=280, height=280):
    """
    Renders soft, cute, organic 2D cartoon bear paws matching the master character.
    Tapering arm, 3 rounded digit pads, opposable thumb, natural wrist crease.
    """
    canvas = Image.new('RGBA', (width, height), (0, 0, 0, 0))
    draw = ImageDraw.Draw(canvas)
    cx, cy = width // 2, height // 2

    if paw_id == 'waving':
        # Upward raised waving paw, palm facing viewer
        draw.polygon([(cx - 30, height - 20), (cx + 30, height - 20), (cx + 25, cy + 20), (cx - 25, cy + 20)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx - 45, cy - 35, cx + 45, cy + 30], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx - 28, cy - 15, cx + 28, cy + 20], fill=COLOR_PAD_INNER)
        # 3 Top digit pads
        draw.ellipse([cx - 36, cy - 58, cx - 14, cy - 30], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx - 11, cy - 64, cx + 11, cy - 34], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx + 14, cy - 58, cx + 36, cy - 30], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Thumb
        draw.ellipse([cx - 52, cy - 12, cx - 28, cy + 18], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Motion arcs
        draw.arc([cx + 45, cy - 40, cx + 65, cy], 290, 70, fill=COLOR_BLACK, width=2)
        draw.arc([cx + 55, cy - 50, cx + 78, cy + 10], 290, 70, fill=COLOR_BLACK, width=2)

    elif paw_id == 'pointing':
        # Horizontal arm from left, cute rounded index finger pointing right
        draw.polygon([(20, cy - 25), (20, cy + 25), (cx - 10, cy + 20), (cx - 10, cy - 20)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx - 30, cy - 30, cx + 25, cy + 25], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Extended rounded index
        draw.rounded_rectangle([cx + 10, cy - 18, cx + 85, cy + 8], radius=13, fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Curled bottom digits
        draw.ellipse([cx - 5, cy, cx + 25, cy + 26], fill=COLOR_FUR_DARK, outline=COLOR_BLACK, width=2)
        # Thumb resting along top
        draw.ellipse([cx - 8, cy - 26, cx + 22, cy - 4], fill=COLOR_FUR, outline=COLOR_BLACK, width=2)

    elif paw_id == 'thumbs_up':
        # Arm from left, upright rounded thumb pad, curled digits
        draw.polygon([(20, cy), (20, cy + 45), (cx, cy + 35), (cx, cy - 5)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx - 25, cy - 15, cx + 35, cy + 35], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Upright thumb
        draw.rounded_rectangle([cx - 14, cy - 75, cx + 16, cy - 5], radius=15, fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # 3 curled finger creases
        for i in range(3):
            draw.arc([cx + 10, cy - 5 + i * 14, cx + 36, cy + 18 + i * 14], 270, 90, fill=COLOR_BLACK, width=3)

    elif paw_id == 'holding_cup':
        # Cute ceramic cup held gently by curved bear fingers
        cup_x, cup_y = cx + 15, cy
        # Cup body
        draw.rounded_rectangle([cup_x - 28, cup_y - 25, cup_x + 28, cup_y + 30], radius=8, fill=COLOR_WHITE, outline=COLOR_BLACK, width=3)
        draw.ellipse([cup_x - 22, cup_y - 32, cup_x + 22, cup_y - 18], fill=COLOR_COFFEE, outline=COLOR_BLACK, width=2)
        draw.arc([cup_x + 20, cup_y - 12, cup_x + 44, cup_y + 16], 270, 90, fill=COLOR_BLACK, width=3)
        # Arm entering from left
        draw.polygon([(20, cy - 15), (20, cy + 35), (cup_x - 30, cy + 25), (cup_x - 30, cy - 5)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Paw palm wrapped around front of cup
        draw.ellipse([cup_x - 45, cup_y - 15, cup_x + 5, cup_y + 25], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # 3 cute curled fingertips wrapping cup
        draw.ellipse([cup_x - 8, cup_y - 18, cup_x + 14, cup_y - 2], fill=COLOR_FUR, outline=COLOR_BLACK, width=2)
        draw.ellipse([cup_x - 8, cup_y - 2, cup_x + 14, cup_y + 14], fill=COLOR_FUR, outline=COLOR_BLACK, width=2)
        draw.ellipse([cup_x - 8, cup_y + 14, cup_x + 14, cup_y + 28], fill=COLOR_FUR, outline=COLOR_BLACK, width=2)

    elif paw_id == 'open_relaxed':
        # Front-facing open relaxed palm
        draw.polygon([(cx - 30, height - 20), (cx + 30, height - 20), (cx + 25, cy + 25), (cx - 25, cy + 25)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx - 45, cy - 35, cx + 45, cy + 30], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx - 28, cy - 15, cx + 28, cy + 20], fill=COLOR_PAD_INNER)
        # 3 Digit pads
        draw.ellipse([cx - 38, cy - 62, cx - 14, cy - 32], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx - 12, cy - 68, cx + 12, cy - 38], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx + 14, cy - 62, cx + 38, cy - 32], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Thumb
        draw.ellipse([cx - 52, cy - 15, cx - 26, cy + 15], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif paw_id == 'gripping_handle':
        # Wooden handle held horizontally
        draw.rounded_rectangle([cx - 85, cy - 10, cx + 85, cy + 10], radius=5, fill=COLOR_WOOD, outline=COLOR_BLACK, width=3)
        # Arm from bottom
        draw.polygon([(cx - 25, height - 20), (cx + 25, height - 20), (cx + 25, cy + 20), (cx - 25, cy + 20)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Curled fingers wrapped over top of handle
        draw.ellipse([cx - 35, cy - 25, cx + 35, cy + 20], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        for i in [-18, 0, 18]:
            draw.arc([cx + i - 8, cy - 25, cx + i + 8, cy + 5], 180, 360, fill=COLOR_BLACK, width=2)

    elif paw_id == 'touching_screen':
        # POS tablet edge on right
        tx = width - 45
        draw.rounded_rectangle([tx - 8, 30, tx + 20, height - 30], radius=8, fill=(240, 243, 246, 255), outline=COLOR_BLACK, width=3)
        draw.ellipse([tx - 18, cy - 18, tx + 18, cy + 18], outline=COLOR_BLUE, width=2)
        # Arm extending from left
        draw.polygon([(20, cy - 20), (20, cy + 20), (cx + 10, cy + 15), (cx + 10, cy - 15)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx - 10, cy - 22, cx + 35, cy + 22], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Finger tip contacting screen
        draw.rounded_rectangle([cx + 20, cy - 12, tx - 4, cy + 8], radius=10, fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif paw_id == 'supporting_platter':
        # Silver tray resting on top of bear fingertips
        draw.ellipse([cx - 75, cy - 18, cx + 75, cy + 8], fill=COLOR_STEEL, outline=COLOR_BLACK, width=3)
        draw.polygon([(cx - 25, height - 20), (cx + 25, height - 20), (cx + 25, cy + 15), (cx - 25, cy + 15)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx - 40, cy + 2, cx + 40, cy + 30], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # 3 supporting fingertips pressing bottom of platter
        draw.ellipse([cx - 30, cy - 2, cx - 12, cy + 15], fill=COLOR_FUR, outline=COLOR_BLACK, width=2)
        draw.ellipse([cx - 9, cy - 4, cx + 9, cy + 14], fill=COLOR_FUR, outline=COLOR_BLACK, width=2)
        draw.ellipse([cx + 12, cy - 2, cx + 30, cy + 15], fill=COLOR_FUR, outline=COLOR_BLACK, width=2)

    elif paw_id == 'precision_stylus':
        # Digital stylus
        draw.line([(cx - 60, cy + 50), (cx + 60, cy - 50)], fill=COLOR_BLUE, width=6)
        draw.line([(cx - 60, cy + 50), (cx - 70, cy + 60)], fill=COLOR_BLACK, width=4)
        # Arm & pinching thumb/finger
        draw.polygon([(20, cy), (20, cy + 40), (cx - 10, cy + 30), (cx - 10, cy - 5)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx - 25, cy - 15, cx + 25, cy + 25], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.rounded_rectangle([cx - 5, cy - 28, cx + 35, cy - 5], radius=10, fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx - 12, cy + 2, cx + 18, cy + 28], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif paw_id == 'dual_paw_grip':
        # Left and right paws holding center object
        obj_x = cx
        draw.rounded_rectangle([obj_x - 30, cy - 35, obj_x + 30, cy + 35], radius=8, fill=COLOR_WOOD, outline=COLOR_BLACK, width=3)
        # Left paw
        draw.polygon([(15, cy - 15), (15, cy + 25), (obj_x - 20, cy + 20), (obj_x - 20, cy - 10)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([obj_x - 38, cy - 18, obj_x - 2, cy + 22], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Right paw
        draw.polygon([(width - 15, cy - 15), (width - 15, cy + 25), (obj_x + 20, cy + 20), (obj_x + 20, cy - 10)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([obj_x + 2, cy - 18, obj_x + 38, cy + 22], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    else:
        # Default cute front-facing resting paw
        draw.polygon([(cx - 28, height - 20), (cx + 28, height - 20), (cx + 25, cy + 15), (cx - 25, cy + 15)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx - 40, cy - 30, cx + 40, cy + 25], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx - 32, cy - 52, cx - 12, cy - 26], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx - 10, cy - 56, cx + 10, cy - 30], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx + 12, cy - 52, cx + 32, cy - 26], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    return canvas

# ----------------------------------------------------------------------
# 2. FULL-BODY POSE GENERATOR (STRICT 2-ARM ENFORCEMENT)
# ----------------------------------------------------------------------
def render_full_pose(pose_id, width=320, height=380):
    """
    Renders Chef Barnaby in dynamic body poses.
    Guarantees that active limbs replace resting limbs so the bear has EXACTLY TWO ARMS.
    """
    canvas = Image.new('RGBA', (width, height), (0, 0, 0, 0))
    master = get_master()

    bx = (width - master.width) // 2
    by = height - master.height - 15

    if pose_id == 'celebrating':
        # Both arms raised high in triumphant victory (BOTH RESTING ARMS REMOVED!)
        base = get_base_body(no_left=True, no_right=True)
        canvas.alpha_composite(base, (bx, by))
        draw = ImageDraw.Draw(canvas)
        # Left Raised Arm
        draw.polygon([(bx + 52, by + 175), (bx + 15, by + 55), (bx + 40, by + 45), (bx + 72, by + 165)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([bx + 10, by + 35, bx + 42, by + 65], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Right Raised Arm
        draw.polygon([(bx + 172, by + 175), (bx + 210, by + 55), (bx + 185, by + 45), (bx + 152, by + 165)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([bx + 182, by + 35, bx + 214, by + 65], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Golden celebration sparkles
        for sx, sy in [(bx - 10, by + 25), (bx + 235, by + 25), (bx + 114, by - 8)]:
            draw.line([(sx - 6, sy), (sx + 6, sy)], fill=COLOR_GOLD, width=3)
            draw.line([(sx, sy - 6), (sx, sy + 6)], fill=COLOR_GOLD, width=3)

    elif pose_id == 'waving':
        # Friendly welcoming wave: Left arm rests, Right arm raised waving (RIGHT RESTING ARM REMOVED!)
        base = get_base_body(no_left=False, no_right=True)
        canvas.alpha_composite(base, (bx, by))
        draw = ImageDraw.Draw(canvas)
        # Raised Right Arm
        draw.polygon([(bx + 172, by + 180), (bx + 215, by + 85), (bx + 235, by + 98), (bx + 182, by + 205)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([bx + 210, by + 65, bx + 245, by + 95], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Inner palm pad
        draw.ellipse([bx + 218, by + 74, bx + 238, by + 90], fill=COLOR_PAD_INNER)
        # Waving motion arcs
        draw.arc([bx + 246, by + 60, bx + 262, by + 85], 290, 70, fill=COLOR_BLACK, width=2)
        draw.arc([bx + 254, by + 50, bx + 274, by + 95], 290, 70, fill=COLOR_BLACK, width=2)

    elif pose_id == 'pointing':
        # Pointing to interface: Left arm rests, Right arm extended pointing (RIGHT RESTING ARM REMOVED!)
        base = get_base_body(no_left=False, no_right=True)
        canvas.alpha_composite(base, (bx, by))
        draw = ImageDraw.Draw(canvas)
        # Extended pointing arm
        draw.polygon([(bx + 172, by + 170), (bx + 235, by + 170), (bx + 235, by + 195), (bx + 172, by + 205)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([bx + 225, by + 168, bx + 255, by + 196], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.rounded_rectangle([bx + 245, by + 172, bx + 275, by + 190], radius=8, fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif pose_id == 'thinking':
        # Contemplative chin paw: Left arm rests, Right arm touches chin (RIGHT RESTING ARM REMOVED!)
        base = get_base_body(no_left=False, no_right=True)
        canvas.alpha_composite(base, (bx, by))
        draw = ImageDraw.Draw(canvas)
        # Arm bent upward to chin
        draw.polygon([(bx + 172, by + 180), (bx + 148, by + 130), (bx + 170, by + 120), (bx + 188, by + 185)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([bx + 138, by + 115, bx + 168, by + 138], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif pose_id == 'carrying':
        # Supplies box carried in front: BOTH RESTING ARMS REMOVED!
        base = get_base_body(no_left=True, no_right=True)
        canvas.alpha_composite(base, (bx, by))
        draw = ImageDraw.Draw(canvas)
        # Cardboard box
        box_x = bx + 114
        box_y = by + 225
        draw.rounded_rectangle([box_x - 42, box_y - 25, box_x + 42, box_y + 25], radius=4, fill=(195, 150, 110, 255), outline=COLOR_BLACK, width=3)
        draw.line([(box_x, box_y - 25), (box_x, box_y + 25)], fill=(160, 120, 85, 255), width=2)
        # Left holding arm
        draw.polygon([(bx + 52, by + 175), (box_x - 40, box_y), (box_x - 30, box_y + 22), (bx + 62, by + 195)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([box_x - 46, box_y - 6, box_x - 24, box_y + 20], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Right holding arm
        draw.polygon([(bx + 172, by + 175), (box_x + 40, box_y), (box_x + 30, box_y + 22), (bx + 162, by + 195)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([box_x + 24, box_y - 6, box_x + 46, box_y + 20], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif pose_id == 'holding':
        # Holding signature drink: Left arm rests, Right arm holds drink (RIGHT RESTING ARM REMOVED!)
        base = get_base_body(no_left=False, no_right=True)
        canvas.alpha_composite(base, (bx, by))
        draw = ImageDraw.Draw(canvas)
        cx = bx + 114
        cy = by + 220
        # Drink cup
        draw.rounded_rectangle([cx + 10, cy - 25, cx + 45, cy + 20], radius=6, fill=COLOR_WHITE, outline=COLOR_BLACK, width=3)
        draw.line([(cx + 28, cy - 35), (cx + 28, cy - 25)], fill=COLOR_GOLD, width=3)
        # Arm holding cup
        draw.polygon([(bx + 172, by + 175), (cx + 15, cy - 5), (cx + 25, cy + 18), (bx + 172, by + 210)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx + 5, cy - 10, cx + 32, cy + 16], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif pose_id == 'leaning':
        # Leaning on counter: Left elbow on counter, Right arm on hip (LEFT RESTING ARM REMOVED!)
        base = get_base_body(no_left=True, no_right=False)
        canvas.alpha_composite(base, (bx, by))
        draw = ImageDraw.Draw(canvas)
        # Counter
        draw.rounded_rectangle([bx - 35, by + 205, bx + 50, by + 255], radius=4, fill=(235, 225, 215, 255), outline=COLOR_BLACK, width=3)
        # Left forearm on counter
        draw.polygon([(bx + 52, by + 175), (bx - 15, by + 200), (bx + 10, by + 225), (bx + 65, by + 195)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([bx - 20, by + 195, bx + 15, by + 220], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif pose_id == 'cooking':
        # Cooking active prep: Left holds spatula, Right holds pan (BOTH RESTING ARMS REMOVED!)
        base = get_base_body(no_left=True, no_right=True)
        canvas.alpha_composite(base, (bx, by))
        draw = ImageDraw.Draw(canvas)
        cx = bx + 114
        cy = by + 220
        # Pan handle & pan
        draw.line([(cx - 10, cy + 10), (cx + 35, cy + 10)], fill=COLOR_WOOD, width=6)
        draw.ellipse([cx + 28, cy - 5, cx + 65, cy + 25], fill=COLOR_STEEL, outline=COLOR_BLACK, width=3)
        # Right arm holding pan handle
        draw.polygon([(bx + 172, by + 175), (cx, cy + 5), (cx + 10, cy + 25), (bx + 172, by + 210)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx - 15, cy, cx + 15, cy + 22], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif pose_id == 'resting':
        # Sitting with warm mug: Left rests, Right holds mug (RIGHT RESTING ARM REMOVED!)
        base = get_base_body(no_left=False, no_right=True)
        canvas.alpha_composite(base, (bx, by))
        draw = ImageDraw.Draw(canvas)
        # Warm mug
        mug_x, mug_y = bx + 195, by + 220
        draw.rounded_rectangle([mug_x - 12, mug_y - 12, mug_x + 12, mug_y + 14], radius=4, fill=COLOR_WHITE, outline=COLOR_BLACK, width=2)
        draw.arc([mug_x + 8, mug_y - 5, mug_x + 20, mug_y + 8], 270, 90, fill=COLOR_BLACK, width=2)
        # Right arm holding mug
        draw.polygon([(bx + 172, by + 175), (mug_x - 10, mug_y), (mug_x - 5, mug_y + 20), (bx + 172, by + 210)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([mug_x - 16, mug_y - 6, mug_x + 8, mug_y + 16], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif pose_id == 'sitting':
        canvas.alpha_composite(master, (bx, by + 15))
        draw = ImageDraw.Draw(canvas)
        # Barstool seat
        draw.ellipse([bx + 30, by + 285, bx + 198, by + 315], fill=COLOR_WOOD, outline=COLOR_BLACK, width=3)
        draw.line([(bx + 60, by + 310), (bx + 50, by + 360)], fill=COLOR_STEEL_DARK, width=5)
        draw.line([(bx + 168, by + 310), (bx + 178, by + 360)], fill=COLOR_STEEL_DARK, width=5)

    elif pose_id == 'walking':
        canvas.alpha_composite(master, (bx, by))
        draw = ImageDraw.Draw(canvas)
        # Dynamic stride lines
        draw.arc([bx + 35, by + 340, bx + 75, by + 360], 180, 360, fill=COLOR_BLACK, width=2)

    else:
        # Default standing pose (master)
        canvas.alpha_composite(master, (bx, by))

    return canvas

# ----------------------------------------------------------------------
# 3. SHEET ASSEMBLER & MAIN RUNNER
# ----------------------------------------------------------------------
PAW_ITEMS = [
    ('front_facing', '1. Front-Facing Paw'),
    ('side_facing', '2. Side-Facing Paw'),
    ('open_relaxed', '3. Open Relaxed Palm'),
    ('closed_paw', '4. Closed Fist'),
    ('pointing', '5. Pointing Paw'),
    ('waving', '6. Waving Paw'),
    ('thumbs_up', '7. Thumbs-Up Paw'),
    ('holding_cup', '8. Holding Ceramic Cup'),
    ('gripping_handle', '9. Gripping Handle'),
    ('dual_paw_grip', '10. Clamping Object'),
    ('supporting_platter', '11. Supporting Platter'),
    ('front_facing', '12. Resting on Surface'),
    ('precision_stylus', '13. Precision Stylus Grip'),
    ('touching_screen', '14. Touching POS Screen'),
    ('dual_paw_grip', '15. Dual Paw Grip'),
]

POSE_ITEMS = [
    ('standing', '1. Standing (Counter Stance)'),
    ('sitting', '2. Sitting (Stool Relax)'),
    ('walking', '3. Walking (Gait Stride)'),
    ('leaning', '4. Leaning (Counter Elbow)'),
    ('waving', '5. Waving (Welcoming)'),
    ('pointing', '6. Pointing (Interface Guide)'),
    ('carrying', '7. Carrying (Supplies Box)'),
    ('holding', '8. Holding (Signature Drink)'),
    ('celebrating', '9. Celebrating (Arms High)'),
    ('thinking', '10. Thinking (Chin Paw)'),
    ('cooking', '11. Cooking (Active Prep)'),
    ('resting', '12. Resting (Post-Rush Break)'),
]

def assemble_sheet(title, subtitle, items, render_fn, cols=3, panel_w=340, panel_h=360):
    rows = math.ceil(len(items) / cols)
    margin = 40
    header_h = 100
    footer_h = 40
    canvas_w = margin * 2 + cols * panel_w
    canvas_h = margin * 2 + header_h + rows * panel_h + footer_h

    sheet = Image.new('RGB', (canvas_w, canvas_h), (255, 252, 248))
    draw = ImageDraw.Draw(sheet)

    # Header banner
    draw.rectangle([0, 0, canvas_w, 80], fill=(245, 238, 230))
    draw.line([(0, 80), (canvas_w, 80)], fill=(210, 195, 180), width=2)

    try:
        font_title = ImageFont.truetype('arial.ttf', 24)
        font_sub = ImageFont.truetype('arial.ttf', 13)
        font_label = ImageFont.truetype('arial.ttf', 13)
        font_tag = ImageFont.truetype('arialbd.ttf', 13)
    except:
        font_title = font_sub = font_label = font_tag = ImageFont.load_default()

    draw.text((margin, 20), title, fill=COLOR_BLACK, font=font_title)
    draw.text((margin, 50), subtitle, fill=(110, 100, 95), font=font_sub)
    draw.text((canvas_w - margin - 280, 30), "MΛCHA BRAND IDENTITY SYSTEM", fill=(130, 115, 105), font=font_sub)

    for idx, (item_id, item_label) in enumerate(items):
        r = idx // cols
        c = idx % cols
        px = margin + c * panel_w
        py = margin + header_h + r * panel_h

        # Panel outline
        draw.rectangle([px, py, px + panel_w - 1, py + panel_h - 1], outline=(230, 222, 214), width=1)
        draw.text((px + 12, py + 12), item_label, fill=COLOR_BLACK, font=font_label)

        # Render panel
        img = render_fn(item_id)
        # Center in panel
        ix = px + (panel_w - img.width) // 2
        iy = py + (panel_h - img.height) // 2 + 10
        sheet.paste(img, (ix, iy), img)

    # Footer note
    draw.text((margin, canvas_h - 30), "Preserve exact character anatomy: 2 articulated limbs (#393635 fur, #D2B18E eye markings, #EEE0CF muzzle).", fill=(140, 130, 125), font=font_sub)
    return sheet

def main():
    print("Regenerating Refined Mascot System with strict 2-arm rule & natural paw anatomy...")
    os.makedirs('assets/mascot/reference', exist_ok=True)
    os.makedirs('assets/mascot/poses', exist_ok=True)
    os.makedirs('assets/mascot/paws', exist_ok=True)

    # 1. Poses Reference Sheet
    print("Generating Pose Reference Sheet (12 poses, 2 arms strictly)...")
    pose_sheet = assemble_sheet(
        title="Chef Barnaby — Body Language & Dynamic Pose Standard",
        subtitle="Expressive weight distribution, active limb articulation, balance, and culinary storytelling.",
        items=POSE_ITEMS,
        render_fn=lambda pid: render_full_pose(pid, 240, 280),
        cols=3,
        panel_w=340,
        panel_h=360,
    )
    pose_sheet.save('assets/mascot/reference/pose_reference_sheet.png')
    pose_sheet.save('C:/Users/Krushna/.gemini/antigravity/brain/4fb76ec5-3f1d-412f-95a8-2c457a094599/pose_reference_sheet.png')
    print("-> Saved pose_reference_sheet.png")

    # Save individual poses
    for pid, _ in POSE_ITEMS:
        img = render_full_pose(pid, 320, 380)
        img.save(f'assets/mascot/poses/{pid}.png')

    # 2. Paw Anatomy Sheet
    print("Generating Paw Anatomy Reference Sheet (15 natural cartoon gestures)...")
    paw_sheet = assemble_sheet(
        title="Chef Barnaby — Bear Paw Anatomy & Articulation Standard",
        subtitle="Soft cartoon bear digit pads, opposable thumb, natural wrist crease, and prop handling.",
        items=PAW_ITEMS,
        render_fn=lambda pid: render_paw(pid, 200, 200),
        cols=3,
        panel_w=340,
        panel_h=280,
    )
    paw_sheet.save('assets/mascot/reference/paw_anatomy_sheet.png')
    paw_sheet.save('C:/Users/Krushna/.gemini/antigravity/brain/4fb76ec5-3f1d-412f-95a8-2c457a094599/paw_anatomy_sheet.png')
    print("-> Saved paw_anatomy_sheet.png")

    # Save individual paws
    for pid, _ in PAW_ITEMS:
        img = render_paw(pid, 240, 240)
        img.save(f'assets/mascot/paws/{pid}.png')

    print("All poses and paw anatomy assets successfully regenerated!")

if __name__ == '__main__':
    main()
