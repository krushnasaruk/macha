"""
CAFÉOS MASCOT REFINEMENT ENGINE — ARCHITECTURE & ASSET GENERATOR
Generates:
1. Facial Expression Reference Sheet (16 expressions, 4x4 grid) + individual transparent PNGs
2. Paw Anatomy Reference Sheet (15 anatomical studies, 3x5 grid) + individual transparent PNGs
3. Object Interaction Reference Sheet (12 objects, 3x4 grid) + individual transparent PNGs
4. Pose Reference Sheet (12 full-body poses, 3x4 grid) + individual transparent PNGs
5. Refined Chef Actions & Application States
"""

import os
import math
from PIL import Image, ImageDraw, ImageFont, ImageFilter, ImageOps

# Exact official palette
COLOR_FUR = (57, 54, 53, 255)            # #393635
COLOR_TAN = (210, 177, 142, 255)         # #D2B18E
COLOR_MUZZLE = (238, 224, 207, 255)      # #EEE0CF
COLOR_BLACK = (23, 22, 21, 255)          # #171615
COLOR_WHITE = (255, 255, 255, 255)       # #FFFFFF
COLOR_APRON = (244, 239, 230, 255)       # #F4EFE6
COLOR_APRON_LINE = (175, 166, 155, 255)  # #AFA69B
COLOR_PAD_INNER = (44, 41, 40, 255)      # #2C2928
COLOR_COFFEE = (105, 68, 48, 255)        # #694430
COLOR_GOLD = (232, 178, 52, 255)         # #E8B234
COLOR_STEEL = (215, 222, 228, 255)       # #D7DEE4
COLOR_STEEL_DARK = (150, 160, 170, 255)  # #96A0AA
COLOR_WOOD = (176, 120, 78, 255)         # #B0784E
COLOR_CHERRY = (218, 52, 45, 255)        # #DA342D
COLOR_TONGUE = (235, 130, 140, 255)      # #EB828C
COLOR_BLUE = (47, 128, 237, 255)         # #2F80ED
COLOR_GREEN = (39, 174, 96, 255)         # #27AE60
COLOR_PANEL_BG = (250, 247, 242, 255)    # Warm cream paper
COLOR_GRID_LINE = (220, 212, 202, 255)
COLOR_TEXT = (45, 42, 40, 255)
COLOR_MUTED_TEXT = (130, 120, 110, 255)

MASTER_PATH = 'assets/mascot/reference/master_character_transparent.png'

# Ensure directories
OUTPUT_DIRS = [
    'assets/mascot/reference',
    'assets/mascot/expressions',
    'assets/mascot/paws',
    'assets/mascot/object_interactions',
    'assets/mascot/poses',
    'assets/mascot/chef_actions',
    'assets/mascot/application_states',
]
for d in OUTPUT_DIRS:
    os.makedirs(d, exist_ok=True)

# Try loading system font, else fallback to default
def get_font(size=14, bold=False):
    try:
        # Windows standard fonts
        font_name = "segoeui.ttf" if not bold else "segoeuib.ttf"
        font_path = os.path.join(os.environ.get('WINDIR', 'C:\\Windows'), 'Fonts', font_name)
        if os.path.exists(font_path):
            return ImageFont.truetype(font_path, size)
        font_path = os.path.join(os.environ.get('WINDIR', 'C:\\Windows'), 'Fonts', 'arial.ttf')
        if os.path.exists(font_path):
            return ImageFont.truetype(font_path, size)
    except Exception:
        pass
    return ImageFont.load_default()

FONT_TITLE = get_font(18, bold=True)
FONT_SUBTITLE = get_font(12, bold=False)
FONT_LABEL = get_font(13, bold=True)
FONT_NUM = get_font(11, bold=False)

def get_master():
    return Image.open(MASTER_PATH).convert('RGBA')

# ----------------------------------------------------------------------
# 1. FACIAL EXPRESSION GENERATOR
# ----------------------------------------------------------------------
def render_facial_expression(expr_id, width=240, height=240):
    """
    Renders a high-detail close-up of Chef Barnaby's head with exact facial acting:
    Eyes, eyelids, tan patches, cream muzzle, black nose, mouth, and toque.
    """
    canvas = Image.new('RGBA', (width, height), (0, 0, 0, 0))
    draw = ImageDraw.Draw(canvas)
    cx, cy = width // 2, height // 2 + 10

    # Head tilt angles based on emotion
    tilt = 0.0
    if expr_id in ['confused', 'curious']:
        tilt = -5.0
    elif expr_id in ['thinking']:
        tilt = 4.0
    elif expr_id in ['sleepy', 'sad', 'disappointed']:
        tilt = -2.0
    elif expr_id in ['proud', 'excited']:
        tilt = 2.0

    # Draw Ears
    # Left ear
    draw.ellipse([cx - 72, cy - 82, cx - 36, cy - 42], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
    # Right ear
    draw.ellipse([cx + 36, cy - 82, cx + 72, cy - 42], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    # Toque (Chef Hat) - tilted slightly right
    hx, hy = cx + 2, cy - 78
    # Hat puffs
    draw.ellipse([hx - 28, hy - 40, hx + 4, hy - 12], fill=COLOR_WHITE, outline=COLOR_BLACK, width=3)
    draw.ellipse([hx - 8, hy - 48, hx + 24, hy - 16], fill=COLOR_WHITE, outline=COLOR_BLACK, width=3)
    draw.ellipse([hx + 12, hy - 38, hx + 36, hy - 14], fill=COLOR_WHITE, outline=COLOR_BLACK, width=3)
    # Hat band
    draw.polygon([
        (hx - 18, hy - 14),
        (hx + 28, hy - 14),
        (hx + 25, hy - 2),
        (hx - 15, hy - 2)
    ], fill=COLOR_WHITE, outline=COLOR_BLACK)
    draw.line([(hx - 18, hy - 14), (hx + 28, hy - 14)], fill=COLOR_BLACK, width=3)
    draw.line([(hx - 15, hy - 2), (hx + 25, hy - 2)], fill=COLOR_BLACK, width=3)

    # Head Main Oval
    draw.ellipse([cx - 78, cy - 65, cx + 78, cy + 65], fill=COLOR_FUR, outline=COLOR_BLACK, width=4)

    # Tan Eye Patches (The distinctive spectacles)
    # Tan patch left
    draw.ellipse([cx - 62, cy - 35, cx - 10, cy + 18], fill=COLOR_TAN, outline=None)
    # Tan patch right
    draw.ellipse([cx + 10, cy - 35, cx + 62, cy + 18], fill=COLOR_TAN, outline=None)
    # Bridge between patches
    draw.rectangle([cx - 16, cy - 20, cx + 16, cy - 5], fill=COLOR_TAN)

    # Eyebrow / tan patch subtle tension
    if expr_id in ['worried', 'sad']:
        # Inward tension: shade subtle upper crease
        draw.line([(cx - 45, cy - 25), (cx - 20, cy - 18)], fill=COLOR_BLACK, width=2)
        draw.line([(cx + 45, cy - 25), (cx + 20, cy - 18)], fill=COLOR_BLACK, width=2)
    elif expr_id in ['determined', 'thinking']:
        # Determined furrow
        draw.line([(cx - 48, cy - 16), (cx - 22, cy - 20)], fill=COLOR_BLACK, width=3)
        draw.line([(cx + 48, cy - 16), (cx + 22, cy - 20)], fill=COLOR_BLACK, width=3)
    elif expr_id in ['surprised', 'excited']:
        # Raised brow arch
        draw.arc([cx - 48, cy - 32, cx - 22, cy - 18], 190, 350, fill=COLOR_BLACK, width=2)
        draw.arc([cx + 22, cy - 32, cx + 48, cy - 18], 190, 350, fill=COLOR_BLACK, width=2)

    # Muzzle (Cream-colored broad snout)
    draw.ellipse([cx - 36, cy - 8, cx + 36, cy + 44], fill=COLOR_MUZZLE, outline=COLOR_BLACK, width=3)

    # Black Oval Nose
    draw.ellipse([cx - 15, cy - 4, cx + 15, cy + 16], fill=COLOR_BLACK)
    # Subtle nose highlight
    draw.ellipse([cx - 7, cy - 1, cx + 2, cy + 5], fill=(70, 68, 66, 255))

    # Eyes & Eyelids
    lx, ly = cx - 35, cy - 10
    rx, ry = cx + 35, cy - 10

    if expr_id in ['happy', 'proud', 'laughing']:
        # Arc happy eyes (^ ^)
        draw.arc([lx - 12, ly - 10, lx + 12, ly + 14], 190, 350, fill=COLOR_BLACK, width=4)
        draw.arc([rx - 12, ly - 10, rx + 12, ly + 14], 190, 350, fill=COLOR_BLACK, width=4)
        if expr_id == 'laughing':
            # Cheerful cheek creases
            draw.arc([lx - 16, ly + 8, lx - 4, ly + 18], 100, 260, fill=COLOR_BLACK, width=2)
            draw.arc([rx + 4, ry + 8, rx + 16, ry + 18], 280, 80, fill=COLOR_BLACK, width=2)
    elif expr_id == 'sleepy':
        # Half closed droopy eyes
        draw.arc([lx - 12, ly - 4, lx + 12, ly + 12], 200, 340, fill=COLOR_BLACK, width=4)
        draw.arc([rx - 12, ry - 4, rx + 12, ry + 12], 200, 340, fill=COLOR_BLACK, width=4)
        # Gentle closed lower line
        draw.line([(lx - 10, ly + 4), (lx + 10, ly + 4)], fill=COLOR_BLACK, width=2)
        draw.line([(rx - 10, ry + 4), (rx + 10, ry + 4)], fill=COLOR_BLACK, width=2)
    elif expr_id == 'surprised':
        # Wide alert open ovals
        draw.ellipse([lx - 10, ly - 14, lx + 10, ly + 10], fill=COLOR_BLACK)
        draw.ellipse([rx - 10, ry - 14, rx + 10, ry + 10], fill=COLOR_BLACK)
        # Catchlight
        draw.ellipse([lx - 4, ly - 10, lx + 2, ly - 4], fill=COLOR_WHITE)
        draw.ellipse([rx - 4, ry - 10, rx + 2, ry - 4], fill=COLOR_WHITE)
    elif expr_id == 'thinking':
        # Eyes looking up-right
        draw.ellipse([lx - 7, ly - 12, lx + 9, ly + 4], fill=COLOR_BLACK)
        draw.ellipse([rx - 3, ry - 12, rx + 13, ry + 4], fill=COLOR_BLACK)
        draw.ellipse([lx + 1, ly - 10, lx + 5, ly - 6], fill=COLOR_WHITE)
        draw.ellipse([rx + 5, ry - 10, rx + 9, ry - 6], fill=COLOR_WHITE)
    elif expr_id == 'confused':
        # Left eye wide, right eye narrowed
        draw.ellipse([lx - 9, ly - 10, lx + 9, ly + 8], fill=COLOR_BLACK)
        draw.ellipse([lx - 3, ly - 7, lx + 3, ly - 1], fill=COLOR_WHITE)
        # Narrowed right eye
        draw.arc([rx - 9, ry - 6, rx + 9, ry + 6], 190, 350, fill=COLOR_BLACK, width=3)
        draw.ellipse([rx - 5, ry - 2, rx + 5, ry + 6], fill=COLOR_BLACK)
    elif expr_id == 'worried':
        # Oval eyes looking slightly off-center with subtle inner tension
        draw.ellipse([lx - 8, ly - 7, lx + 8, ly + 9], fill=COLOR_BLACK)
        draw.ellipse([rx - 8, ry - 7, rx + 8, ry + 9], fill=COLOR_BLACK)
        # Angled top lid
        draw.line([(lx - 11, ly - 3), (lx + 8, ly - 8)], fill=COLOR_TAN, width=4)
        draw.line([(rx - 8, ry - 8), (rx + 11, ry - 3)], fill=COLOR_TAN, width=4)
    elif expr_id == 'curious':
        # Attentive eyes looking forward-down
        draw.ellipse([lx - 8, ly - 6, lx + 8, ly + 10], fill=COLOR_BLACK)
        draw.ellipse([rx - 8, ry - 6, rx + 8, ry + 10], fill=COLOR_BLACK)
        draw.ellipse([lx - 2, ly - 3, lx + 3, ly + 2], fill=COLOR_WHITE)
        draw.ellipse([rx - 2, ry - 3, rx + 3, ry + 2], fill=COLOR_WHITE)
    elif expr_id == 'determined':
        # Solid focused pupils with slight top eyelid shield
        draw.ellipse([lx - 8, ly - 6, lx + 8, ly + 8], fill=COLOR_BLACK)
        draw.ellipse([rx - 8, ry - 6, rx + 8, ry + 8], fill=COLOR_BLACK)
        draw.line([(lx - 10, ly - 6), (lx + 10, ly - 3)], fill=COLOR_FUR, width=3)
        draw.line([(rx - 10, ry - 3), (rx + 10, ry - 6)], fill=COLOR_FUR, width=3)
    elif expr_id == 'embarrassed':
        # Eyes looking down and to the side, slight blush marks
        draw.ellipse([lx - 8, ly - 3, lx + 6, ly + 11], fill=COLOR_BLACK)
        draw.ellipse([rx - 8, ry - 3, rx + 6, ry + 11], fill=COLOR_BLACK)
        # Soft blush on cheeks
        draw.ellipse([cx - 55, cy + 15, cx - 35, cy + 27], fill=(235, 150, 145, 160))
        draw.ellipse([cx + 35, cy + 15, cx + 55, cy + 27], fill=(235, 150, 145, 160))
    elif expr_id == 'sad':
        # Drooping outer eye corners
        draw.ellipse([lx - 8, ly - 5, lx + 8, ly + 9], fill=COLOR_BLACK)
        draw.ellipse([rx - 8, ry - 5, rx + 8, ry + 9], fill=COLOR_BLACK)
        draw.line([(lx - 10, ly - 6), (lx + 9, ly)], fill=COLOR_TAN, width=3)
        draw.line([(rx - 9, ry), (rx + 10, ry - 6)], fill=COLOR_TAN, width=3)
    elif expr_id == 'disappointed':
        draw.ellipse([lx - 7, ly - 4, lx + 7, ly + 8], fill=COLOR_BLACK)
        draw.ellipse([rx - 7, ry - 4, rx + 7, ry + 8], fill=COLOR_BLACK)
        draw.line([(lx - 9, ly - 4), (lx + 9, ly - 4)], fill=COLOR_TAN, width=3)
        draw.line([(rx - 9, ry - 4), (rx + 9, ry - 4)], fill=COLOR_TAN, width=3)
    else:  # Neutral, slightly_happy, excited
        draw.ellipse([lx - 8, ly - 8, lx + 8, ly + 8], fill=COLOR_BLACK)
        draw.ellipse([rx - 8, ry - 8, rx + 8, ry + 8], fill=COLOR_BLACK)
        # Catchlight
        draw.ellipse([lx - 4, ly - 5, lx + 1, ly], fill=COLOR_WHITE)
        draw.ellipse([rx - 4, ry - 5, rx + 1, ry], fill=COLOR_WHITE)

    # Philtrum Line (Vertical line from nose to mouth)
    draw.line([(cx, cy + 15), (cx, cy + 24)], fill=COLOR_BLACK, width=2)

    # Mouth Expressions
    my = cy + 25
    if expr_id == 'neutral':
        # Calm, understated horizontal line with subtle tuck
        draw.line([(cx - 10, my), (cx + 10, my)], fill=COLOR_BLACK, width=3)
    elif expr_id in ['slightly_happy', 'proud']:
        # Gentle curved smile
        draw.arc([cx - 12, my - 6, cx + 12, my + 8], 20, 160, fill=COLOR_BLACK, width=3)
    elif expr_id == 'happy':
        # Warm, clear upward smile
        draw.arc([cx - 16, my - 8, cx + 16, my + 10], 15, 165, fill=COLOR_BLACK, width=3)
    elif expr_id == 'laughing':
        # Open joyful mouth with tongue
        draw.pieslice([cx - 14, my - 4, cx + 14, my + 18], 0, 180, fill=COLOR_BLACK, outline=COLOR_BLACK, width=2)
        draw.pieslice([cx - 8, my + 4, cx + 8, my + 18], 0, 180, fill=COLOR_TONGUE)
    elif expr_id == 'excited':
        # Energetic open smile
        draw.pieslice([cx - 12, my - 3, cx + 12, my + 14], 0, 180, fill=COLOR_BLACK, outline=COLOR_BLACK, width=2)
    elif expr_id == 'surprised':
        # Small rounded 'O' mouth
        draw.ellipse([cx - 6, my - 2, cx + 6, my + 10], fill=COLOR_BLACK, outline=COLOR_BLACK, width=2)
    elif expr_id in ['confused', 'thinking']:
        # Asymmetrical quizzical curve
        draw.arc([cx - 8, my - 4, cx + 14, my + 6], 30, 190, fill=COLOR_BLACK, width=3)
    elif expr_id == 'curious':
        # Slight side perk
        draw.line([(cx - 8, my + 2), (cx + 10, my - 2)], fill=COLOR_BLACK, width=3)
    elif expr_id == 'sleepy':
        # Relaxed small neutral line
        draw.line([(cx - 7, my + 1), (cx + 7, my + 1)], fill=COLOR_BLACK, width=2)
    elif expr_id in ['worried', 'sad']:
        # Downward gentle curve
        draw.arc([cx - 12, my + 1, cx + 12, my + 14], 195, 345, fill=COLOR_BLACK, width=3)
    elif expr_id == 'disappointed':
        # Straight flat tense mouth
        draw.line([(cx - 12, my + 3), (cx + 12, my + 3)], fill=COLOR_BLACK, width=3)
    elif expr_id == 'determined':
        # Firm line with tiny downward tick
        draw.line([(cx - 14, my + 1), (cx + 14, my + 1)], fill=COLOR_BLACK, width=3)
        draw.line([(cx - 14, my + 1), (cx - 14, my + 4)], fill=COLOR_BLACK, width=2)
        draw.line([(cx + 14, my + 1), (cx + 14, my + 4)], fill=COLOR_BLACK, width=2)
    elif expr_id == 'embarrassed':
        # Small wavy bashful line
        draw.arc([cx - 10, my - 3, cx - 2, my + 5], 190, 350, fill=COLOR_BLACK, width=2)
        draw.arc([cx - 2, my - 1, cx + 8, my + 7], 10, 170, fill=COLOR_BLACK, width=2)

    # Apply overall head tilt if any
    if tilt != 0.0:
        canvas = canvas.rotate(tilt, resample=Image.Resampling.BICUBIC, center=(cx, cy))

    return canvas

# ----------------------------------------------------------------------
# 2. PAW ANATOMY GENERATOR
# ----------------------------------------------------------------------
def render_paw_study(paw_id, width=320, height=260):
    """
    Renders an anatomical bear-paw study with arm connection, wrist line,
    3 rounded bear digits + 1 opposable thumb pad, and optional prop grip.
    """
    canvas = Image.new('RGBA', (width, height), (0, 0, 0, 0))
    draw = ImageDraw.Draw(canvas)
    cx, cy = width // 2, height // 2 + 10

    # Arm origin (left or bottom based on pose)
    # Default: Arm entering from bottom-left extending up-right
    if paw_id in ['resting_surface']:
        # Arm coming from top-left resting down
        draw.polygon([(40, 80), (120, 80), (170, 160), (90, 170)], fill=COLOR_FUR, outline=COLOR_BLACK)
        # Flat surface line
        draw.line([(40, 180), (280, 180)], fill=COLOR_APRON_LINE, width=4)
        # Palm pad spread on surface
        draw.ellipse([100, 140, 190, 182], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Digits pressed down
        draw.ellipse([180, 155, 208, 182], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([155, 155, 182, 182], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([130, 155, 156, 182], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Thumb
        draw.ellipse([92, 155, 120, 182], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif paw_id in ['waving']:
        # Arm raised high
        draw.polygon([(80, 240), (140, 240), (190, 110), (140, 100)], fill=COLOR_FUR, outline=COLOR_BLACK)
        # Wrist curve
        draw.arc([130, 95, 190, 120], 30, 150, fill=COLOR_BLACK, width=2)
        # Palm face forward
        draw.ellipse([140, 50, 220, 115], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Inner soft palm pad
        draw.ellipse([155, 68, 205, 102], fill=COLOR_PAD_INNER)
        # 3 Bear digits raised
        draw.ellipse([145, 30, 170, 62], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([170, 24, 195, 58], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([195, 32, 218, 65], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Thumb to left
        draw.ellipse([124, 75, 150, 105], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Motion lines for wave
        draw.arc([225, 40, 245, 65], 290, 70, fill=COLOR_BLACK, width=2)
        draw.arc([235, 30, 260, 75], 290, 70, fill=COLOR_BLACK, width=2)

    elif paw_id in ['thumbs_up']:
        # Forearm extending horizontally
        draw.polygon([(40, 130), (150, 130), (150, 180), (40, 180)], fill=COLOR_FUR, outline=COLOR_BLACK)
        # Closed fist body
        draw.ellipse([130, 120, 205, 190], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # 3 curled finger folds
        draw.arc([150, 130, 195, 150], 30, 180, fill=COLOR_BLACK, width=2)
        draw.arc([150, 150, 195, 170], 30, 180, fill=COLOR_BLACK, width=2)
        draw.arc([150, 170, 195, 188], 30, 180, fill=COLOR_BLACK, width=2)
        # Prominent hitchhiker bear thumb pointing straight up
        draw.rounded_rectangle([135, 60, 168, 130], radius=16, fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Thumb knuckle crease
        draw.arc([136, 95, 166, 110], 20, 160, fill=COLOR_BLACK, width=2)

    elif paw_id in ['pointing']:
        # Forearm angled forward
        draw.polygon([(40, 140), (140, 130), (150, 180), (40, 190)], fill=COLOR_FUR, outline=COLOR_BLACK)
        # Closed base fist
        draw.ellipse([130, 125, 195, 185], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Curled bottom digits
        draw.arc([145, 145, 185, 165], 20, 180, fill=COLOR_BLACK, width=2)
        draw.arc([145, 165, 185, 182], 20, 180, fill=COLOR_BLACK, width=2)
        # Extended index paw digit pointing right
        draw.rounded_rectangle([165, 126, 255, 154], radius=14, fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Thumb locked underneath
        draw.ellipse([140, 132, 175, 158], fill=COLOR_FUR, outline=COLOR_BLACK, width=2)

    elif paw_id in ['holding_cup']:
        # Ceramic café cup
        # Cup body
        cup_x, cup_y = 170, 130
        draw.rounded_rectangle([cup_x - 30, cup_y - 30, cup_x + 30, cup_y + 30], radius=6, fill=COLOR_WHITE, outline=COLOR_BLACK, width=3)
        draw.ellipse([cup_x - 26, cup_y - 36, cup_x + 26, cup_y - 24], fill=COLOR_COFFEE, outline=COLOR_BLACK, width=2)
        # Handle on right
        draw.arc([cup_x + 20, cup_y - 15, cup_x + 45, cup_y + 18], 270, 90, fill=COLOR_BLACK, width=3)
        # Forearm from left
        draw.polygon([(40, 140), (130, 130), (130, 180), (40, 190)], fill=COLOR_FUR, outline=COLOR_BLACK)
        # Paw wrapping securely around cup body
        draw.rounded_rectangle([120, 115, 175, 175], radius=20, fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # 3 wrapped finger segments over cup front
        draw.arc([145, 122, 185, 140], 310, 80, fill=COLOR_BLACK, width=3)
        draw.arc([145, 140, 185, 158], 310, 80, fill=COLOR_BLACK, width=3)
        draw.arc([145, 158, 185, 174], 310, 80, fill=COLOR_BLACK, width=3)
        # Opposing thumb clamped on top rim
        draw.ellipse([125, 105, 158, 128], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif paw_id in ['holding_handle']:
        # Cylindrical pan/pot handle
        hx, hy = 180, 140
        draw.rounded_rectangle([hx - 70, hy - 8, hx + 70, hy + 8], radius=6, fill=COLOR_WOOD, outline=COLOR_BLACK, width=3)
        # Arm from bottom
        draw.polygon([(110, 240), (160, 240), (170, 160), (120, 160)], fill=COLOR_FUR, outline=COLOR_BLACK)
        # Full wrapped grip over handle
        draw.ellipse([130, 115, 195, 170], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Digit wraps
        draw.arc([140, 120, 165, 165], 280, 80, fill=COLOR_BLACK, width=3)
        draw.arc([160, 120, 185, 165], 280, 80, fill=COLOR_BLACK, width=3)
        # Locking thumb underneath
        draw.ellipse([140, 145, 175, 172], fill=COLOR_FUR, outline=COLOR_BLACK, width=2)

    elif paw_id in ['supporting_underneath']:
        # Platter/tray edge
        tx, ty = 180, 120
        draw.line([(80, ty), (270, ty)], fill=COLOR_STEEL_DARK, width=6)
        draw.line([(80, ty - 2), (270, ty - 2)], fill=COLOR_STEEL, width=4)
        # Arm supporting from below
        draw.polygon([(100, 240), (160, 240), (175, 145), (115, 145)], fill=COLOR_FUR, outline=COLOR_BLACK)
        # Open upward palm cradling bottom of platter
        draw.ellipse([120, 122, 205, 160], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Digits curled slightly over front rim
        draw.ellipse([140, 112, 162, 128], fill=COLOR_FUR, outline=COLOR_BLACK, width=2)
        draw.ellipse([165, 110, 188, 126], fill=COLOR_FUR, outline=COLOR_BLACK, width=2)
        draw.ellipse([190, 112, 212, 128], fill=COLOR_FUR, outline=COLOR_BLACK, width=2)

    elif paw_id in ['holding_pen']:
        # Precision pinch grip on stylus/pen
        px, py = 180, 130
        draw.polygon([(130, 220), (220, 60), (230, 65), (140, 225)], fill=COLOR_BLUE, outline=COLOR_BLACK)
        # Nib
        draw.polygon([(125, 228), (135, 220), (130, 235)], fill=COLOR_STEEL_DARK)
        # Arm
        draw.polygon([(40, 170), (130, 140), (140, 200), (40, 210)], fill=COLOR_FUR, outline=COLOR_BLACK)
        # Index paw digit pressed along barrel
        draw.rounded_rectangle([135, 105, 185, 140], radius=14, fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Thumb pinching from opposite side
        draw.ellipse([145, 138, 185, 172], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif paw_id in ['touching_screen']:
        # POS tablet screen surface
        sx, sy = 220, 140
        draw.rounded_rectangle([sx - 10, 50, sx + 50, 220], radius=8, fill=(230, 235, 240, 255), outline=COLOR_BLACK, width=3)
        # Ripple circle on touch point
        draw.ellipse([sx - 20, sy - 20, sx + 20, sy + 20], outline=COLOR_BLUE, width=2)
        # Arm entering from left
        draw.polygon([(40, 150), (140, 130), (150, 185), (40, 195)], fill=COLOR_FUR, outline=COLOR_BLACK)
        # Hand with extended paw tip
        draw.ellipse([130, 125, 190, 180], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Finger tip contacting screen
        draw.rounded_rectangle([165, 128, 220, 152], radius=12, fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif paw_id in ['both_paws_holding']:
        # Central prop (e.g. coffee jar)
        jx, jy = cx, cy
        draw.rounded_rectangle([jx - 30, jy - 35, jx + 30, jy + 35], radius=10, fill=COLOR_COFFEE, outline=COLOR_BLACK, width=3)
        # Left paw wrapping from left
        draw.polygon([(20, 140), (jx - 40, 120), (jx - 30, 170), (20, 180)], fill=COLOR_FUR, outline=COLOR_BLACK)
        draw.ellipse([jx - 48, jy - 22, jx - 12, jy + 25], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Right paw wrapping from right
        draw.polygon([(width - 20, 140), (jx + 40, 120), (jx + 30, 170), (width - 20, 180)], fill=COLOR_FUR, outline=COLOR_BLACK)
        draw.ellipse([jx + 12, jy - 22, jx + 48, jy + 25], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    else:  # front_facing, side_facing, open_relaxed, closed_fist, gripping_object
        # Symmetrical bear paw anatomy
        draw.polygon([(cx - 35, 220), (cx + 35, 220), (cx + 40, 130), (cx - 40, 130)], fill=COLOR_FUR, outline=COLOR_BLACK)
        # Wrist seam
        draw.arc([cx - 40, 125, cx + 40, 145], 20, 160, fill=COLOR_BLACK, width=2)
        # Main palm
        draw.ellipse([cx - 50, cy - 45, cx + 50, cy + 30], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

        if paw_id == 'open_relaxed':
            # Inner palm pad
            draw.ellipse([cx - 32, cy - 25, cx + 32, cy + 18], fill=COLOR_PAD_INNER)
            # 3 extended bear finger pads + inner thumb
            draw.ellipse([cx - 42, cy - 65, cx - 18, cy - 35], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
            draw.ellipse([cx - 14, cy - 72, cx + 14, cy - 40], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
            draw.ellipse([cx + 18, cy - 65, cx + 42, cy - 35], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
            # Thumb pad
            draw.ellipse([cx - 56, cy - 20, cx - 34, cy + 12], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        elif paw_id == 'closed_paw':
            # Tightly curled digits
            draw.arc([cx - 36, cy - 35, cx - 6, cy + 5], 30, 200, fill=COLOR_BLACK, width=3)
            draw.arc([cx - 15, cy - 40, cx + 15, cy], 30, 200, fill=COLOR_BLACK, width=3)
            draw.arc([cx + 6, cy - 35, cx + 36, cy + 5], 30, 200, fill=COLOR_BLACK, width=3)
            draw.ellipse([cx - 42, cy - 10, cx - 10, cy + 22], fill=COLOR_FUR, outline=COLOR_BLACK, width=2)
        elif paw_id == 'side_facing':
            # Profile silhouette
            draw.ellipse([cx - 20, cy - 40, cx + 35, cy + 25], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
            draw.ellipse([cx + 10, cy - 58, cx + 38, cy - 28], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
            draw.ellipse([cx - 18, cy - 20, cx + 10, cy + 15], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        else:  # front_facing / gripping
            draw.ellipse([cx - 38, cy - 58, cx - 14, cy - 30], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
            draw.ellipse([cx - 12, cy - 64, cx + 12, cy - 36], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
            draw.ellipse([cx + 14, cy - 58, cx + 38, cy - 30], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    return canvas

# ----------------------------------------------------------------------
# 3. OBJECT INTERACTION GENERATOR (Full bear interacting with prop)
# ----------------------------------------------------------------------
def render_object_interaction(obj_id, width=320, height=380):
    """
    Renders Chef Barnaby physically holding and interacting with an object.
    Depth sorted: Torso -> Back arm/palm -> Object -> Front paw wrap & fingers.
    """
    canvas = Image.new('RGBA', (width, height), (0, 0, 0, 0))
    master = get_master()

    # Anchor master bear horizontally in canvas
    bx = (width - master.width) // 2
    by = height - master.height - 15

    # Blit master bear base
    canvas.alpha_composite(master, (bx, by))
    draw = ImageDraw.Draw(canvas)

    cx = width // 2
    cy = height // 2 + 30

    if obj_id == 'coffee_cup':
        # Cup at chest height (cx + 10, cy - 10)
        # Clear default resting arm on right
        draw.ellipse([bx + 175, by + 180, bx + 215, by + 265], fill=COLOR_FUR)
        # Forearm extending toward center
        draw.polygon([(bx + 185, by + 160), (cx + 5, cy), (cx + 15, cy + 35), (bx + 185, by + 210)], fill=COLOR_FUR, outline=COLOR_BLACK)
        # Ceramic cup
        cup_x, cup_y = cx + 25, cy - 10
        draw.rounded_rectangle([cup_x - 22, cup_y - 18, cup_x + 22, cup_y + 22], radius=6, fill=COLOR_WHITE, outline=COLOR_BLACK, width=3)
        draw.ellipse([cup_x - 18, cup_y - 24, cup_x + 18, cup_y - 12], fill=COLOR_COFFEE, outline=COLOR_BLACK, width=2)
        draw.arc([cup_x + 16, cup_y - 10, cup_x + 34, cup_y + 14], 270, 90, fill=COLOR_BLACK, width=3)
        # Steam
        draw.arc([cup_x - 8, cup_y - 42, cup_x + 8, cup_y - 26], 180, 360, fill=(200, 200, 200, 180), width=3)
        draw.arc([cup_x, cup_y - 56, cup_x + 14, cup_y - 38], 0, 180, fill=(200, 200, 200, 180), width=3)
        # Front Paw wrap over cup
        draw.rounded_rectangle([cup_x - 30, cup_y - 8, cup_x + 5, cy + 22], radius=12, fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.arc([cup_x - 20, cup_y - 4, cup_x + 4, cup_y + 8], 300, 70, fill=COLOR_BLACK, width=2)
        draw.arc([cup_x - 20, cup_y + 6, cup_x + 4, cup_y + 18], 300, 70, fill=COLOR_BLACK, width=2)

    elif obj_id == 'serving_tray':
        # Tray supported with both paws from underneath
        ty = cy - 5
        # Silver tray ellipse
        draw.ellipse([cx - 65, ty - 12, cx + 65, ty + 14], fill=COLOR_STEEL, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx - 56, ty - 8, cx + 56, ty + 10], fill=(235, 240, 245, 255), outline=COLOR_STEEL_DARK, width=2)
        # Cup on tray
        draw.rounded_rectangle([cx - 25, ty - 28, cx - 5, ty - 2], radius=3, fill=COLOR_WHITE, outline=COLOR_BLACK, width=2)
        draw.ellipse([cx - 23, ty - 32, cx - 7, ty - 24], fill=COLOR_COFFEE)
        # Cloche dome
        draw.chord([cx + 5, ty - 34, cx + 45, ty - 2], 180, 360, fill=COLOR_GOLD, outline=COLOR_BLACK, width=2)
        draw.ellipse([cx + 22, ty - 39, cx + 28, ty - 33], fill=COLOR_GOLD, outline=COLOR_BLACK, width=2)
        # Left supporting paw underneath
        draw.ellipse([cx - 55, ty + 4, cx - 22, ty + 24], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Right supporting paw underneath
        draw.ellipse([cx + 22, ty + 4, cx + 55, ty + 24], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif obj_id == 'receipt':
        # Bill receipt held with right paw
        rx, ry = cx + 35, cy
        # Paper receipt with natural curl
        draw.polygon([(rx - 20, ry - 35), (rx + 24, ry - 30), (rx + 20, ry + 45), (rx - 24, ry + 40)], fill=COLOR_WHITE, outline=COLOR_BLACK)
        # Printed text lines
        for offset in range(-20, 35, 8):
            draw.line([(rx - 14, ry + offset), (rx + 14, ry + offset + 2)], fill=COLOR_MUTED_TEXT, width=2)
        # Paw clutching top of receipt
        draw.ellipse([rx - 28, ry - 42, rx + 4, ry - 14], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Digit clamp over paper edge
        draw.arc([rx - 18, ry - 36, rx + 2, ry - 20], 310, 80, fill=COLOR_BLACK, width=3)

    elif obj_id == 'menu':
        # Hardcover menu folder held in center
        mx, my = cx, cy + 5
        draw.rounded_rectangle([mx - 42, my - 45, mx + 42, my + 40], radius=6, fill=COLOR_COFFEE, outline=COLOR_BLACK, width=3)
        draw.rounded_rectangle([mx - 36, my - 40, mx + 36, my + 34], radius=4, fill=(245, 238, 226, 255), outline=COLOR_GOLD, width=2)
        draw.line([(mx - 22, my - 20), (mx + 22, my - 20)], fill=COLOR_COFFEE, width=3)
        draw.line([(mx - 18, my - 8), (mx + 18, my - 8)], fill=COLOR_COFFEE, width=2)
        draw.line([(mx - 18, my + 4), (mx + 18, my + 4)], fill=COLOR_COFFEE, width=2)
        # Left and right paws holding sides
        draw.ellipse([mx - 52, my - 10, mx - 22, my + 20], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([mx + 22, my - 10, mx + 52, my + 20], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif obj_id == 'spatula':
        # Cooking spatula gripped firmly in hand
        sx, sy = cx + 35, cy - 20
        # Long handle
        draw.polygon([(sx - 35, sy + 65), (sx - 28, sy + 70), (sx + 25, sy - 20), (sx + 18, sy - 25)], fill=COLOR_WOOD, outline=COLOR_BLACK)
        # Stainless slotted blade
        draw.polygon([(sx + 18, sy - 25), (sx + 45, sy - 55), (sx + 65, sy - 38), (sx + 38, sy - 8)], fill=COLOR_STEEL, outline=COLOR_BLACK)
        draw.line([(sx + 30, sy - 35), (sx + 48, sy - 22)], fill=COLOR_STEEL_DARK, width=2)
        draw.line([(sx + 36, sy - 42), (sx + 54, sy - 29)], fill=COLOR_STEEL_DARK, width=2)
        # Paw wrapped tightly around handle
        draw.ellipse([sx - 20, sy + 8, rx := sx + 16, sy + 44], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.arc([sx - 12, sy + 14, sx + 14, sy + 30], 280, 80, fill=COLOR_BLACK, width=3)
        draw.arc([sx - 12, sy + 26, sx + 14, sy + 42], 280, 80, fill=COLOR_BLACK, width=3)

    elif obj_id == 'cooking_pan':
        # Sauté pan with sizzle
        px, py = cx + 25, cy
        # Long pan handle from paw to pan
        draw.rounded_rectangle([px - 55, py + 8, px + 5, py + 20], radius=5, fill=COLOR_BLACK, outline=COLOR_BLACK, width=2)
        # Pan body
        draw.ellipse([px, py - 18, px + 75, py + 38], fill=COLOR_STEEL_DARK, outline=COLOR_BLACK, width=3)
        draw.ellipse([px + 5, py - 12, px + 70, py + 32], fill=(60, 65, 70, 255))
        # Butter / sizzle
        draw.ellipse([px + 28, py + 2, px + 48, py + 18], fill=COLOR_GOLD)
        # Steam arcs
        draw.arc([px + 20, py - 35, px + 36, py - 15], 180, 360, fill=(210, 210, 210, 200), width=3)
        draw.arc([px + 38, py - 45, px + 54, py - 22], 0, 180, fill=(210, 210, 210, 200), width=3)
        # Paw wrapping handle
        draw.ellipse([px - 45, py + 2, px - 12, py + 32], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif obj_id == 'laptop':
        # POS register laptop
        lx, ly = cx, cy + 18
        # Keyboard base
        draw.polygon([(lx - 55, ly + 25), (lx + 55, ly + 25), (lx + 42, ly - 2), (lx - 42, ly - 2)], fill=COLOR_STEEL, outline=COLOR_BLACK)
        # Screen angled up
        draw.polygon([(lx - 42, ly - 2), (lx + 42, ly - 2), (lx + 38, ly - 50), (lx - 38, ly - 50)], fill=COLOR_STEEL_DARK, outline=COLOR_BLACK)
        draw.polygon([(lx - 35, ly - 5), (lx + 35, ly - 5), (lx + 32, ly - 45), (lx - 32, ly - 45)], fill=(30, 40, 50, 255))
        # Blue POS screen content glow
        draw.line([(lx - 26, ly - 35), (lx + 20, ly - 35)], fill=COLOR_BLUE, width=3)
        draw.line([(lx - 26, ly - 25), (lx + 10, ly - 25)], fill=COLOR_BLUE, width=2)
        # Dual paws typing on keys
        draw.ellipse([lx - 36, ly + 6, lx - 8, ly + 28], fill=COLOR_FUR, outline=COLOR_BLACK, width=2)
        draw.ellipse([lx + 8, ly + 6, lx + 36, ly + 28], fill=COLOR_FUR, outline=COLOR_BLACK, width=2)

    elif obj_id == 'shopping_basket':
        # Wire basket with ingredients
        bx_pos, by_pos = cx + 30, cy + 10
        # Basket wire frame
        draw.polygon([(bx_pos - 32, by_pos - 15), (bx_pos + 32, by_pos - 15), (bx_pos + 25, by_pos + 35), (bx_pos - 25, by_pos + 35)], fill=(230, 230, 235, 255), outline=COLOR_CHERRY, width=3)
        draw.line([(bx_pos - 28, by_pos + 5), (bx_pos + 28, by_pos + 5)], fill=COLOR_CHERRY, width=2)
        draw.line([(bx_pos - 26, by_pos + 20), (bx_pos + 26, by_pos + 20)], fill=COLOR_CHERRY, width=2)
        # Coffee bag and milk inside
        draw.rectangle([bx_pos - 22, by_pos - 28, bx_pos - 4, by_pos - 10], fill=COLOR_COFFEE)
        draw.rectangle([bx_pos + 2, by_pos - 32, bx_pos + 20, by_pos - 10], fill=COLOR_WHITE, outline=COLOR_BLUE, width=2)
        # Basket swing handle
        draw.arc([bx_pos - 25, by_pos - 52, bx_pos + 25, by_pos - 5], 180, 360, fill=COLOR_CHERRY, width=3)
        # Paw looping through handle
        draw.ellipse([bx_pos - 15, by_pos - 55, bx_pos + 15, by_pos - 32], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif obj_id == 'coffee_pot':
        # Glass coffee decanter / pot
        gx, gy = cx + 32, cy - 8
        # Pot body
        draw.polygon([(gx - 15, gy - 25), (gx + 15, gy - 25), (gx + 28, gy + 22), (gx - 28, gy + 22)], fill=(225, 235, 245, 180), outline=COLOR_BLACK, width=2)
        # Coffee level
        draw.polygon([(gx - 24, gy - 5), (gx + 24, gy - 5), (gx + 26, gy + 20), (gx - 26, gy + 20)], fill=COLOR_COFFEE)
        # Black heat collar and handle
        draw.rounded_rectangle([gx - 16, gy - 24, gx + 16, gy - 16], radius=2, fill=COLOR_BLACK)
        draw.arc([gx + 12, gy - 20, gx + 38, gy + 15], 270, 90, fill=COLOR_BLACK, width=4)
        # Paw wrapped firmly around handle
        draw.ellipse([gx + 16, gy - 12, gx + 42, gy + 18], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif obj_id == 'cake':
        # Elegant cake on platter
        kx, ky = cx, cy - 2
        # Pedestal base
        draw.polygon([(kx - 12, ky + 25), (kx + 12, ky + 25), (kx + 4, ky + 12), (kx - 4, ky + 12)], fill=COLOR_STEEL, outline=COLOR_BLACK)
        draw.ellipse([kx - 48, ky + 6, kx + 48, ky + 18], fill=COLOR_STEEL, outline=COLOR_BLACK, width=2)
        # 2-Tier Cake
        draw.rounded_rectangle([kx - 35, ky - 18, kx + 35, ky + 8], radius=4, fill=(255, 235, 215, 255), outline=COLOR_BLACK, width=2)
        draw.rounded_rectangle([kx - 24, ky - 36, kx + 24, ky - 16], radius=4, fill=COLOR_WHITE, outline=COLOR_BLACK, width=2)
        # Strawberry / Cherry on top
        draw.ellipse([kx - 6, ky - 45, kx + 6, ky - 33], fill=COLOR_CHERRY)
        # Paws supporting platter left and right
        draw.ellipse([kx - 48, ky + 10, kx - 22, ky + 26], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([kx + 22, ky + 10, kx + 48, ky + 26], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif obj_id == 'checklist':
        # Wooden clipboard with checklist
        cl_x, cl_y = cx + 25, cy - 5
        draw.rounded_rectangle([cl_x - 26, cl_y - 36, cl_x + 26, cl_y + 36], radius=4, fill=COLOR_WOOD, outline=COLOR_BLACK, width=3)
        draw.rectangle([cl_x - 21, cl_y - 28, cl_x + 21, cl_y + 30], fill=COLOR_WHITE)
        # Top metal clip
        draw.rounded_rectangle([cl_x - 12, cl_y - 42, cl_x + 12, cl_y - 32], radius=2, fill=COLOR_STEEL_DARK, outline=COLOR_BLACK, width=2)
        # Green checkmarks
        for dy, check in [(-18, True), (-6, True), (6, True), (18, False)]:
            if check:
                draw.line([(cl_x - 15, cl_y + dy), (cl_x - 11, cl_y + dy + 4), (cl_x - 6, cl_y + dy - 3)], fill=COLOR_GREEN, width=2)
            draw.line([(cl_x - 2, cl_y + dy), (cl_x + 16, cl_y + dy)], fill=COLOR_MUTED_TEXT, width=2)
        # Paw holding side edge of clipboard
        draw.ellipse([cl_x - 36, cl_y - 12, cl_x - 10, cl_y + 16], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif obj_id == 'trophy':
        # Gold Champion Trophy Cup
        tx, ty = cx, cy - 8
        # Trophy base
        draw.rounded_rectangle([tx - 18, ty + 24, tx + 18, ty + 36], radius=2, fill=COLOR_BLACK, outline=COLOR_BLACK)
        draw.polygon([(tx - 8, ty + 24), (tx + 8, ty + 24), (tx + 4, ty + 12), (tx - 4, ty + 12)], fill=COLOR_GOLD)
        # Cup body
        draw.polygon([(tx - 26, ty - 25), (tx + 26, ty - 25), (tx + 18, ty + 12), (tx - 18, ty + 12)], fill=COLOR_GOLD, outline=COLOR_BLACK, width=2)
        draw.ellipse([tx - 26, ty - 32, tx + 26, ty - 18], fill=(255, 215, 80, 255), outline=COLOR_BLACK, width=2)
        # Twin handles
        draw.arc([tx - 38, ty - 22, tx - 22, ty + 2], 90, 270, fill=COLOR_BLACK, width=3)
        draw.arc([tx + 22, ty - 22, tx + 38, ty + 2], 270, 90, fill=COLOR_BLACK, width=3)
        # Dual paws clutching trophy handles
        draw.ellipse([tx - 42, ty - 16, tx - 18, ty + 8], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([tx + 18, ty - 16, tx + 42, ty + 8], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    return canvas

# ----------------------------------------------------------------------
# 4. FULL-BODY POSE GENERATOR
# ----------------------------------------------------------------------
def render_full_pose(pose_id, width=320, height=380):
    """
    Renders Chef Barnaby in dynamic body poses with expressive weight distribution,
    arm angles, and posture.
    """
    canvas = Image.new('RGBA', (width, height), (0, 0, 0, 0))
    master = get_master()

    bx = (width - master.width) // 2
    by = height - master.height - 15

    if pose_id == 'celebrating':
        # Both arms raised high in triumphant victory
        # Copy base bear
        canvas.alpha_composite(master, (bx, by))
        draw = ImageDraw.Draw(canvas)
        # Raised Left Arm
        draw.polygon([(bx + 40, by + 160), (bx - 10, by + 60), (bx + 20, by + 50), (bx + 65, by + 140)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([bx - 18, by + 40, bx + 16, by + 70], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Raised Right Arm
        draw.polygon([(bx + 165, by + 140), (bx + 210, by + 50), (bx + 240, by + 60), (bx + 190, by + 160)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([bx + 212, by + 40, bx + 246, by + 70], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Golden confetti sparks around head
        for sx, sy in [(bx - 15, by + 20), (bx + 240, by + 20), (bx + 115, by - 10), (bx + 40, by - 5), (bx + 190, by - 5)]:
            draw.line([(sx - 6, sy), (sx + 6, sy)], fill=COLOR_GOLD, width=3)
            draw.line([(sx, sy - 6), (sx, sy + 6)], fill=COLOR_GOLD, width=3)

    elif pose_id == 'waving':
        canvas.alpha_composite(master, (bx, by))
        draw = ImageDraw.Draw(canvas)
        # Clear default right arm
        draw.ellipse([bx + 175, by + 180, bx + 215, by + 265], fill=COLOR_FUR)
        # Raised right waving arm
        draw.polygon([(bx + 175, by + 150), (bx + 225, by + 80), (bx + 245, by + 95), (bx + 185, by + 190)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([bx + 220, by + 65, bx + 255, by + 95], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Wave motion arcs
        draw.arc([bx + 256, by + 65, bx + 270, by + 85], 290, 70, fill=COLOR_BLACK, width=2)
        draw.arc([bx + 264, by + 55, bx + 282, by + 95], 290, 70, fill=COLOR_BLACK, width=2)

    elif pose_id == 'pointing':
        canvas.alpha_composite(master, (bx, by))
        draw = ImageDraw.Draw(canvas)
        # Clear default right arm
        draw.ellipse([bx + 175, by + 180, bx + 215, by + 265], fill=COLOR_FUR)
        # Right arm pointing forward-right
        draw.polygon([(bx + 170, by + 150), (bx + 240, by + 170), (bx + 240, by + 195), (bx + 170, by + 200)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.rounded_rectangle([bx + 235, by + 168, bx + 275, by + 188], radius=10, fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif pose_id == 'thinking':
        canvas.alpha_composite(master, (bx, by))
        draw = ImageDraw.Draw(canvas)
        # Clear default right arm
        draw.ellipse([bx + 175, by + 180, bx + 215, by + 265], fill=COLOR_FUR)
        # Arm bent upward toward chin
        draw.polygon([(bx + 175, by + 170), (bx + 150, by + 120), (bx + 175, by + 110), (bx + 195, by + 180)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Paw resting under chin
        draw.ellipse([bx + 140, by + 105, bx + 172, by + 130], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif pose_id == 'leaning':
        canvas.alpha_composite(master, (bx, by))
        draw = ImageDraw.Draw(canvas)
        # Counter surface on left
        draw.rounded_rectangle([bx - 30, by + 210, bx + 55, by + 260], radius=4, fill=(235, 225, 215, 255), outline=COLOR_BLACK, width=3)
        # Forearm resting flat on counter
        draw.polygon([(bx + 60, by + 160), (bx - 10, by + 200), (bx + 10, by + 225), (bx + 80, by + 190)], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([bx - 20, by + 195, bx + 18, by + 220], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif pose_id == 'sitting':
        # Seated posture with shortened lower legs and wider base
        canvas.alpha_composite(master, (bx, by + 15))
        draw = ImageDraw.Draw(canvas)
        # Barstool seat
        draw.ellipse([bx + 30, by + 285, bx + 198, by + 315], fill=COLOR_WOOD, outline=COLOR_BLACK, width=3)
        draw.line([(bx + 60, by + 310), (bx + 50, by + 360)], fill=COLOR_STEEL_DARK, width=5)
        draw.line([(bx + 168, by + 310), (bx + 178, by + 360)], fill=COLOR_STEEL_DARK, width=5)

    elif pose_id == 'walking':
        canvas.alpha_composite(master, (bx, by))
        draw = ImageDraw.Draw(canvas)
        # Left foot stepping forward
        draw.ellipse([bx + 35, by + 320, bx + 85, by + 355], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        # Right foot trailing back
        draw.ellipse([bx + 150, by + 310, bx + 195, by + 342], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif pose_id == 'cooking':
        # Active pan tossing
        canvas.alpha_composite(master, (bx, by))
        draw = ImageDraw.Draw(canvas)
        # Pan handle gripped forward
        draw.rounded_rectangle([bx + 110, by + 215, bx + 190, by + 228], radius=4, fill=COLOR_WOOD, outline=COLOR_BLACK, width=2)
        draw.ellipse([bx + 180, by + 205, bx + 245, by + 245], fill=COLOR_STEEL_DARK, outline=COLOR_BLACK, width=3)
        # Steam & sizzle
        draw.arc([bx + 200, by + 175, bx + 220, by + 198], 180, 360, fill=(210, 210, 210, 200), width=3)

    elif pose_id == 'resting':
        # Leaning back comfortably with eyes relaxed
        canvas.alpha_composite(master, (bx, by))
        draw = ImageDraw.Draw(canvas)
        # Coffee mug sitting on small side stool
        draw.rounded_rectangle([bx + 210, by + 220, bx + 245, by + 252], radius=4, fill=COLOR_WHITE, outline=COLOR_BLACK, width=2)
        draw.ellipse([bx + 214, by + 215, bx + 241, by + 225], fill=COLOR_COFFEE)
        # "Zzz" breath arc
        draw.arc([bx + 150, by + 70, bx + 165, by + 85], 270, 90, fill=COLOR_BLUE, width=2)

    elif pose_id == 'carrying':
        # Carrying a fresh coffee box
        canvas.alpha_composite(master, (bx, by))
        draw = ImageDraw.Draw(canvas)
        cx_box, cy_box = bx + 114, by + 225
        draw.polygon([(cx_box - 45, cy_box - 25), (cx_box + 45, cy_box - 25), (cx_box + 38, cy_box + 25), (cx_box - 38, cy_box + 25)], fill=(215, 175, 125, 255), outline=COLOR_BLACK, width=3)
        # Box tape & label
        draw.line([(cx_box, cy_box - 25), (cx_box, cy_box + 25)], fill=(180, 140, 95, 255), width=4)
        # Dual paws supporting box sides
        draw.ellipse([cx_box - 54, cy_box - 8, cx_box - 28, cy_box + 18], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)
        draw.ellipse([cx_box + 28, cy_box - 8, cx_box + 54, cy_box + 18], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    elif pose_id == 'holding':
        # Proudly presenting a signature iced latte at chest level
        canvas.alpha_composite(master, (bx, by))
        draw = ImageDraw.Draw(canvas)
        # Tall glass
        gx, gy = bx + 114, by + 195
        draw.polygon([(gx - 18, gy - 30), (gx + 18, gy - 30), (gx + 12, gy + 22), (gx - 12, gy + 22)], fill=(235, 245, 255, 200), outline=COLOR_BLACK, width=2)
        # Layered milk and cold brew
        draw.polygon([(gx - 14, gy - 8), (gx + 14, gy - 8), (gx + 12, gy + 20), (gx - 12, gy + 20)], fill=(245, 235, 220, 255))
        draw.polygon([(gx - 17, gy - 28), (gx + 17, gy - 28), (gx + 14, gy - 8), (gx - 14, gy - 8)], fill=COLOR_COFFEE)
        # Straw
        draw.line([(gx - 5, gy - 42), (gx + 4, gy + 15)], fill=COLOR_CHERRY, width=3)
        # Paws presenting from underneath
        draw.ellipse([gx - 28, gy + 14, gx + 28, gy + 32], fill=COLOR_FUR, outline=COLOR_BLACK, width=3)

    else:  # standing
        canvas.alpha_composite(master, (bx, by))

    return canvas

# ----------------------------------------------------------------------
# 5. ASSEMBLE REFERENCE SHEETS (GRIDS WITH LABELS & HEADERS)
# ----------------------------------------------------------------------
def assemble_reference_sheet(title, subtitle, items, render_fn, cols=4, panel_w=300, panel_h=300, is_transparent=False):
    """
    Assembles a master studio model sheet with headers, grid borders, and panel labels.
    """
    rows = math.ceil(len(items) / cols)
    header_h = 100
    footer_h = 40
    sheet_w = cols * panel_w
    sheet_h = header_h + rows * panel_h + footer_h

    sheet = Image.new('RGBA', (sheet_w, sheet_h), COLOR_PANEL_BG)
    draw = ImageDraw.Draw(sheet)

    # Header Background Accent
    draw.rectangle([0, 0, sheet_w, header_h], fill=(242, 236, 226, 255))
    draw.line([(0, header_h), (sheet_w, header_h)], fill=COLOR_GRID_LINE, width=2)

    # Title & Subtitle
    draw.text((32, 26), title, font=FONT_TITLE, fill=COLOR_TEXT)
    draw.text((34, 58), subtitle, font=FONT_SUBTITLE, fill=COLOR_MUTED_TEXT)

    # Watermark Brand Tag
    tag = "CAFÉOS BRAND IDENTITY SYSTEM • CHEF BARNABY"
    draw.text((sheet_w - 360, 42), tag, font=FONT_LABEL, fill=COLOR_COFFEE)

    # Draw Grid Panels
    for idx, (item_id, label) in enumerate(items):
        r = idx // cols
        c = idx % cols
        px = c * panel_w
        py = header_h + r * panel_h

        # Panel Border
        draw.rectangle([px, py, px + panel_w, py + panel_h], outline=COLOR_GRID_LINE, width=1)

        # Panel Number and Name Tag
        num_str = f"#{idx + 1:02d}"
        draw.text((px + 14, py + 12), num_str, font=FONT_NUM, fill=COLOR_MUTED_TEXT)
        draw.text((px + 45, py + 12), label, font=FONT_LABEL, fill=COLOR_TEXT)

        # Render Item
        item_img = render_fn(item_id)
        # Center in panel below header
        ix = px + (panel_w - item_img.width) // 2
        iy = py + 28 + (panel_h - 35 - item_img.height) // 2
        sheet.alpha_composite(item_img, (ix, iy))

    # Footer
    draw.line([(0, sheet_h - footer_h), (sheet_w, sheet_h - footer_h)], fill=COLOR_GRID_LINE, width=1)
    footer_text = "Preserve exact facial anatomy, tan eye markings (#D2B18E), cream muzzle (#EEE0CF), and bear paw structure in all production builds."
    draw.text((32, sheet_h - footer_h + 12), footer_text, font=FONT_NUM, fill=COLOR_MUTED_TEXT)

    return sheet

# ----------------------------------------------------------------------
# 6. MAIN EXECUTION PIPELINE
# ----------------------------------------------------------------------
def main():
    print("================================================================")
    print("CAFÉOS MASCOT REFINEMENT — COMPREHENSIVE GENERATION PIPELINE")
    print("================================================================")

    # 1. 16 Expressions
    EXPRESSIONS = [
        ('neutral', '1. Neutral (Default)'),
        ('slightly_happy', '2. Slightly Happy'),
        ('happy', '3. Happy (Joyful)'),
        ('laughing', '4. Laughing (Chuckle)'),
        ('excited', '5. Excited (Rush Start)'),
        ('surprised', '6. Surprised (Ding!)'),
        ('confused', '7. Confused (Ticket ?)'),
        ('curious', '8. Curious (Inspecting)'),
        ('thinking', '9. Thinking (Recipe)'),
        ('sleepy', '10. Sleepy (Opening Shift)'),
        ('worried', '11. Worried (Low Stock)'),
        ('sad', '12. Sad (Canceled Order)'),
        ('disappointed', '13. Disappointed (Offline)'),
        ('proud', '14. Proud (5-Star Review)'),
        ('determined', '15. Determined (Rush Ready)'),
        ('embarrassed', '16. Embarrassed (Spill)'),
    ]

    print("\n[Step 1/5] Generating 16 Facial Expressions Reference Sheet...")
    expr_sheet = assemble_reference_sheet(
        title="Chef Barnaby — Official Facial Expression System",
        subtitle="16 distinct emotional states maintaining consistent eye-patches, cream muzzle, and head structure.",
        items=EXPRESSIONS,
        render_fn=lambda eid: render_facial_expression(eid, 220, 220),
        cols=4,
        panel_w=280,
        panel_h=270,
    )
    expr_sheet.save('assets/mascot/reference/facial_expression_sheet.png')
    print("-> Saved assets/mascot/reference/facial_expression_sheet.png")

    # Export individual expressions
    print("-> Exporting individual transparent expression assets...")
    for eid, _ in EXPRESSIONS:
        # Full body bear with expressive head
        body = get_master()
        head = render_facial_expression(eid, 170, 170)
        # Composite expressive head over base body
        body.alpha_composite(head, (29, 2))
        body.save(f'assets/mascot/expressions/{eid}.png')

    # 2. 15 Paw Anatomy Studies
    PAW_STUDIES = [
        ('front_facing', '1. Front-Facing Paw'),
        ('side_facing', '2. Side-Facing Paw'),
        ('open_relaxed', '3. Open Relaxed Palm'),
        ('closed_paw', '4. Closed Fist'),
        ('pointing', '5. Pointing Paw'),
        ('waving', '6. Waving Paw'),
        ('thumbs_up', '7. Thumbs-Up Paw'),
        ('holding_cup', '8. Holding Ceramic Cup'),
        ('holding_handle', '9. Gripping Handle'),
        ('gripping_object', '10. Clamping Object'),
        ('supporting_underneath', '11. Supporting Platter'),
        ('resting_surface', '12. Resting on Surface'),
        ('holding_pen', '13. Precision Stylus Grip'),
        ('touching_screen', '14. Touching POS Screen'),
        ('both_paws_holding', '15. Dual Paw Grip'),
    ]

    print("\n[Step 2/5] Generating Paw Anatomy Reference Sheet (15 Studies)...")
    paw_sheet = assemble_reference_sheet(
        title="Chef Barnaby — Bear Paw Anatomy & Articulation Standard",
        subtitle="3-pad digit arch + opposable thumb pad, continuous charcoal fur lineage, and natural wrist articulation.",
        items=PAW_STUDIES,
        render_fn=lambda pid: render_paw_study(pid, 280, 230),
        cols=3,
        panel_w=340,
        panel_h=280,
    )
    paw_sheet.save('assets/mascot/reference/paw_anatomy_sheet.png')
    print("-> Saved assets/mascot/reference/paw_anatomy_sheet.png")

    for pid, _ in PAW_STUDIES:
        paw_img = render_paw_study(pid, 320, 260)
        paw_img.save(f'assets/mascot/paws/{pid}.png')

    # 3. 12 Object Interactions
    OBJECT_INTERACTIONS = [
        ('coffee_cup', '1. Ceramic Coffee Cup'),
        ('serving_tray', '2. Serving Tray (Dual Support)'),
        ('receipt', '3. Order Receipt (Paper Grip)'),
        ('menu', '4. Menu Folder (Dual Grip)'),
        ('spatula', '5. Grill Spatula (Firm Handle)'),
        ('cooking_pan', '6. Sauté Pan (Toss Grip)'),
        ('laptop', '7. POS Terminal (Typing)'),
        ('shopping_basket', '8. Supplies Basket (Handle)'),
        ('coffee_pot', '9. Glass Decanter Pot'),
        ('cake', '10. Platter Cake (Balance)'),
        ('checklist', '11. Inventory Audit Board'),
        ('trophy', '12. Champion Trophy (Dual Clutches)'),
    ]

    print("\n[Step 3/5] Generating Object Interaction Reference Sheet (12 Props)...")
    obj_sheet = assemble_reference_sheet(
        title="Chef Barnaby — Physical Object Interaction & Grip Standard",
        subtitle="Depth-sorted occlusion: forearms behind props, digits wrapped over surface/rims, weight balance.",
        items=OBJECT_INTERACTIONS,
        render_fn=lambda oid: render_object_interaction(oid, 280, 320),
        cols=3,
        panel_w=340,
        panel_h=360,
    )
    obj_sheet.save('assets/mascot/reference/object_interaction_sheet.png')
    print("-> Saved assets/mascot/reference/object_interaction_sheet.png")

    for oid, _ in OBJECT_INTERACTIONS:
        obj_img = render_object_interaction(oid, 320, 380)
        obj_img.save(f'assets/mascot/object_interactions/{oid}.png')

    # 4. 12 Full-Body Poses
    POSES = [
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

    print("\n[Step 4/5] Generating Body Language & Pose Reference Sheet (12 Dynamics)...")
    pose_sheet = assemble_reference_sheet(
        title="Chef Barnaby — Body Language & Dynamic Pose Standard",
        subtitle="Expressive weight distribution, active limb articulation, balance, and culinary storytelling.",
        items=POSES,
        render_fn=lambda pid: render_full_pose(pid, 280, 320),
        cols=3,
        panel_w=340,
        panel_h=360,
    )
    pose_sheet.save('assets/mascot/reference/pose_reference_sheet.png')
    print("-> Saved assets/mascot/reference/pose_reference_sheet.png")

    for pid, _ in POSES:
        pose_img = render_full_pose(pid, 320, 380)
        pose_img.save(f'assets/mascot/poses/{pid}.png')

    # 5. Production Illustrations Sync (Chef Actions & Application States)
    print("\n[Step 5/5] Refreshing Chef Actions & Application States with Refined Anatomy...")
    # Chef actions
    render_object_interaction('coffee_cup', 320, 380).save('assets/mascot/chef_actions/holding_coffee_cup.png')
    render_object_interaction('serving_tray', 320, 380).save('assets/mascot/chef_actions/holding_tray.png')
    render_object_interaction('receipt', 320, 380).save('assets/mascot/chef_actions/holding_receipt.png')
    render_object_interaction('menu', 320, 380).save('assets/mascot/chef_actions/holding_menu.png')
    render_object_interaction('spatula', 320, 380).save('assets/mascot/chef_actions/holding_spatula.png')
    render_object_interaction('cooking_pan', 320, 380).save('assets/mascot/chef_actions/cooking_pan.png')
    render_object_interaction('coffee_pot', 320, 380).save('assets/mascot/chef_actions/holding_coffee_pot.png')
    render_object_interaction('cake', 320, 380).save('assets/mascot/chef_actions/carrying_cake.png')

    # App interactions
    render_full_pose('waving', 320, 380).save('assets/mascot/app_interactions/waving_hello.png')
    render_full_pose('pointing', 320, 380).save('assets/mascot/app_interactions/pointing_interface.png')
    render_full_pose('celebrating', 320, 380).save('assets/mascot/app_interactions/celebrating_task.png')
    render_object_interaction('laptop', 320, 380).save('assets/mascot/app_interactions/typing_laptop.png')
    render_object_interaction('checklist', 320, 380).save('assets/mascot/app_interactions/holding_checklist.png')

    # States
    render_full_pose('resting', 320, 380).save('assets/mascot/application_states/sleeping_idle.png')
    render_full_pose('celebrating', 320, 380).save('assets/mascot/application_states/celebrating_success.png')

    print("\nAll 4 Reference Sheets, 16 Expressions, 15 Paws, 12 Objects, and 12 Poses generated successfully!")

if __name__ == '__main__':
    main()
