"""
High-Fidelity 2D Café Artwork Generator for CaféOS
Renders crisp, charming, artisan cafe illustrations at 4x resolution
and downsamples with PIL Lanczos filter for smooth anti-aliased vector aesthetics.
"""

import os
import math
from PIL import Image, ImageDraw

SCALE = 4  # 4x supersampling for ultra-crisp antialiasing

# Color Palette matching the approved reference
C_DARK = (52, 43, 38, 255)         # Primary Dark Coffee #342B26
C_ROAST = (68, 52, 43, 255)        # Roasted Coffee Bean
C_CREMA = (195, 145, 105, 255)      # Crema / Coffee Foam
C_LATTE = (225, 195, 165, 255)      # Milk Coffee / Latte
C_MILK = (255, 252, 248, 255)       # Steamed Milk / Foam
C_CUP = (250, 246, 240, 255)        # Warm Cream Ceramic Cup
C_SAUCER = (238, 230, 220, 255)     # Ceramic Saucer
C_GLASS = (235, 242, 245, 210)      # Translucent Glass
C_SHADOW = (40, 30, 25, 40)         # Soft Drop Shadow
C_GOLD = (232, 146, 70, 255)        # Warm Amber / Sparkles #E89246
C_TERRA = (217, 148, 105, 255)      # Terracotta #D99469
C_STEAM = (180, 165, 155, 180)      # Delicate Steam Line
C_LINE = (52, 43, 38, 255)          # Clean Outline

def save_supersampled(img_hi, target_path, target_size):
    img = img_hi.resize(target_size, Image.Resampling.LANCZOS)
    img.save(target_path, 'PNG')
    print(f"Saved {target_path} at {target_size}")

# -------------------------------------------------------------
# 1. HERO COFFEE (Steaming Cup on Saucer for Sales Hero Card)
# -------------------------------------------------------------
def generate_hero_coffee():
    w, h = 320 * SCALE, 280 * SCALE
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, int(h * 0.58)

    # 1. Soft Warm Glow under saucer
    draw.ellipse([cx - 120*SCALE, cy + 30*SCALE, cx + 120*SCALE, cy + 70*SCALE], fill=(232, 146, 70, 45))

    # 2. Ceramic Saucer (Outer oval + Inner depression)
    draw.ellipse([cx - 110*SCALE, cy + 32*SCALE, cx + 110*SCALE, cy + 72*SCALE], fill=C_SAUCER, outline=C_LINE, width=4*SCALE)
    draw.ellipse([cx - 80*SCALE, cy + 42*SCALE, cx + 80*SCALE, cy + 64*SCALE], fill=(225, 216, 204, 255), outline=C_LINE, width=2*SCALE)

    # 3. Cup Handle
    draw.arc([cx + 55*SCALE, cy - 25*SCALE, cx + 115*SCALE, cy + 35*SCALE], 270, 90, fill=C_LINE, width=9*SCALE)
    draw.arc([cx + 57*SCALE, cy - 20*SCALE, cx + 107*SCALE, cy + 30*SCALE], 270, 90, fill=C_CUP, width=6*SCALE)

    # 4. Ceramic Cup Body
    # Rounded taper body
    cup_top_w = 75 * SCALE
    cup_bot_w = 55 * SCALE
    cup_top_y = cy - 35 * SCALE
    cup_bot_y = cy + 45 * SCALE

    # Fill body
    draw.polygon([
        (cx - cup_top_w, cup_top_y),
        (cx + cup_top_w, cup_top_y),
        (cx + cup_bot_w, cup_bot_y),
        (cx - cup_bot_w, cup_bot_y)
    ], fill=C_CUP)
    draw.ellipse([cx - cup_bot_w, cup_bot_y - 12*SCALE, cx + cup_bot_w, cup_bot_y + 12*SCALE], fill=C_CUP)

    # Cup Outline
    draw.line([(cx - cup_top_w, cup_top_y), (cx - cup_bot_w, cup_bot_y)], fill=C_LINE, width=4*SCALE)
    draw.line([(cx + cup_top_w, cup_top_y), (cx + cup_bot_w, cup_bot_y)], fill=C_LINE, width=4*SCALE)
    draw.arc([cx - cup_bot_w, cup_bot_y - 12*SCALE, cx + cup_bot_w, cup_bot_y + 12*SCALE], 0, 180, fill=C_LINE, width=4*SCALE)

    # 5. Cup Rim & Coffee Surface
    draw.ellipse([cx - cup_top_w, cup_top_y - 18*SCALE, cx + cup_top_w, cup_top_y + 18*SCALE], fill=C_CUP, outline=C_LINE, width=4*SCALE)
    draw.ellipse([cx - (cup_top_w - 6*SCALE), cup_top_y - 14*SCALE, cx + (cup_top_w - 6*SCALE), cup_top_y + 14*SCALE], fill=C_ROAST)

    # 6. Latte Art Rosetta / Heart
    art_y = cup_top_y - 1*SCALE
    # Heart lobes
    draw.ellipse([cx - 24*SCALE, art_y - 9*SCALE, cx + 2*SCALE, art_y + 7*SCALE], fill=C_MILK)
    draw.ellipse([cx - 2*SCALE, art_y - 9*SCALE, cx + 24*SCALE, art_y + 7*SCALE], fill=C_MILK)
    draw.polygon([(cx - 22*SCALE, art_y), (cx + 22*SCALE, art_y), (cx, art_y + 11*SCALE)], fill=C_MILK)
    # Inner delicate caramel accent
    draw.ellipse([cx - 10*SCALE, art_y - 4*SCALE, cx + 10*SCALE, art_y + 4*SCALE], fill=C_CREMA)

    # 7. Rising Steam Curves (Artisan Cafe Style)
    for sx, sy in [(cx - 25*SCALE, cup_top_y - 30*SCALE), (cx, cup_top_y - 40*SCALE), (cx + 25*SCALE, cup_top_y - 32*SCALE)]:
        # S-curve steam
        points = [
            (sx, sy),
            (sx + 8*SCALE, sy - 18*SCALE),
            (sx - 6*SCALE, sy - 36*SCALE),
            (sx + 4*SCALE, sy - 54*SCALE),
        ]
        for i in range(len(points) - 1):
            draw.line([points[i], points[i+1]], fill=C_STEAM, width=3*SCALE)

    # 8. Golden Sparkles (✦)
    for sp_x, sp_y in [(cx - 75*SCALE, cup_top_y - 50*SCALE), (cx + 80*SCALE, cup_top_y - 55*SCALE), (cx + 95*SCALE, cup_top_y - 20*SCALE)]:
        r = 7 * SCALE
        draw.line([(sp_x - r, sp_y), (sp_x + r, sp_y)], fill=C_GOLD, width=3*SCALE)
        draw.line([(sp_x, sp_y - r), (sp_x, sp_y + r)], fill=C_GOLD, width=3*SCALE)

    save_supersampled(img, 'assets/branding/hero_coffee.png', (320, 280))

# -------------------------------------------------------------
# 2. CAPPUCCINO (Top angle cup with heart art & steam wisps)
# -------------------------------------------------------------
def generate_cappuccino():
    w, h = 240 * SCALE, 240 * SCALE
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, int(h * 0.58)

    # Saucer
    draw.ellipse([cx - 85*SCALE, cy + 22*SCALE, cx + 85*SCALE, cy + 54*SCALE], fill=C_SAUCER, outline=C_LINE, width=3*SCALE)
    # Cup handle
    draw.arc([cx + 42*SCALE, cy - 20*SCALE, cx + 88*SCALE, cy + 24*SCALE], 270, 90, fill=C_LINE, width=6*SCALE)
    draw.arc([cx + 44*SCALE, cy - 16*SCALE, cx + 82*SCALE, cy + 20*SCALE], 270, 90, fill=C_CUP, width=4*SCALE)

    # Ceramic Cup Body
    draw.polygon([
        (cx - 58*SCALE, cy - 25*SCALE),
        (cx + 58*SCALE, cy - 25*SCALE),
        (cx + 42*SCALE, cy + 32*SCALE),
        (cx - 42*SCALE, cy + 32*SCALE)
    ], fill=C_CUP)
    draw.ellipse([cx - 42*SCALE, cy + 24*SCALE, cx + 42*SCALE, cy + 40*SCALE], fill=C_CUP)
    draw.line([(cx - 58*SCALE, cy - 25*SCALE), (cx - 42*SCALE, cy + 32*SCALE)], fill=C_LINE, width=3*SCALE)
    draw.line([(cx + 58*SCALE, cy - 25*SCALE), (cx + 42*SCALE, cy + 32*SCALE)], fill=C_LINE, width=3*SCALE)
    draw.arc([cx - 42*SCALE, cy + 24*SCALE, cx + 42*SCALE, cy + 40*SCALE], 0, 180, fill=C_LINE, width=3*SCALE)

    # Rim & Coffee Surface
    draw.ellipse([cx - 58*SCALE, cy - 38*SCALE, cx + 58*SCALE, cy - 12*SCALE], fill=C_CUP, outline=C_LINE, width=3*SCALE)
    draw.ellipse([cx - 52*SCALE, cy - 35*SCALE, cx + 52*SCALE, cy - 15*SCALE], fill=C_LATTE)

    # Heart Latte Art
    ly = cy - 25*SCALE
    draw.ellipse([cx - 18*SCALE, ly - 7*SCALE, cx + 2*SCALE, ly + 5*SCALE], fill=C_MILK)
    draw.ellipse([cx - 2*SCALE, ly - 7*SCALE, cx + 18*SCALE, ly + 5*SCALE], fill=C_MILK)
    draw.polygon([(cx - 16*SCALE, ly), (cx + 16*SCALE, ly), (cx, ly + 9*SCALE)], fill=C_MILK)

    # Steam wisps (\ | /)
    draw.line([(cx - 18*SCALE, cy - 48*SCALE), (cx - 26*SCALE, cy - 70*SCALE)], fill=C_STEAM, width=3*SCALE)
    draw.line([(cx, cy - 52*SCALE), (cx, cy - 78*SCALE)], fill=C_STEAM, width=3*SCALE)
    draw.line([(cx + 18*SCALE, cy - 48*SCALE), (cx + 26*SCALE, cy - 70*SCALE)], fill=C_STEAM, width=3*SCALE)

    save_supersampled(img, 'assets/menu/cappuccino.png', (240, 240))

# -------------------------------------------------------------
# 3. LATTE (Glass Mug with warm layers & steam)
# -------------------------------------------------------------
def generate_latte():
    w, h = 240 * SCALE, 240 * SCALE
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, int(h * 0.58)

    # Glass Handle
    draw.arc([cx + 38*SCALE, cy - 30*SCALE, cx + 80*SCALE, cy + 25*SCALE], 270, 90, fill=C_LINE, width=5*SCALE)

    # Glass Body
    gw_top, gw_bot = 46 * SCALE, 32 * SCALE
    gy_top, gy_bot = cy - 48 * SCALE, cy + 42 * SCALE

    # Liquid Layers
    # Base Milk Layer
    draw.polygon([(cx - 38*SCALE, cy + 10*SCALE), (cx + 38*SCALE, cy + 10*SCALE),
                  (cx + gw_bot, gy_bot), (cx - gw_bot, gy_bot)], fill=C_MILK)
    # Middle Espresso Blend Layer
    draw.polygon([(cx - 43*SCALE, cy - 22*SCALE), (cx + 43*SCALE, cy - 22*SCALE),
                  (cx + 38*SCALE, cy + 10*SCALE), (cx - 38*SCALE, cy + 10*SCALE)], fill=C_CREMA)
    # Top Steamed Froth
    draw.polygon([(cx - gw_top, gy_top), (cx + gw_top, gy_top),
                  (cx + 43*SCALE, cy - 22*SCALE), (cx - 43*SCALE, cy - 22*SCALE)], fill=C_LATTE)

    # Glass Base
    draw.ellipse([cx - gw_bot, gy_bot - 8*SCALE, cx + gw_bot, gy_bot + 8*SCALE], fill=C_GLASS, outline=C_LINE, width=3*SCALE)
    # Glass Outline
    draw.line([(cx - gw_top, gy_top), (cx - gw_bot, gy_bot)], fill=C_LINE, width=3*SCALE)
    draw.line([(cx + gw_top, gy_top), (cx + gw_bot, gy_bot)], fill=C_LINE, width=3*SCALE)
    draw.ellipse([cx - gw_top, gy_top - 10*SCALE, cx + gw_top, gy_top + 10*SCALE], fill=C_MILK, outline=C_LINE, width=3*SCALE)

    # Steam Lines (\ | /)
    draw.line([(cx - 16*SCALE, gy_top - 18*SCALE), (cx - 24*SCALE, gy_top - 38*SCALE)], fill=C_STEAM, width=3*SCALE)
    draw.line([(cx, gy_top - 20*SCALE), (cx, gy_top - 42*SCALE)], fill=C_STEAM, width=3*SCALE)
    draw.line([(cx + 16*SCALE, gy_top - 18*SCALE), (cx + 24*SCALE, gy_top - 38*SCALE)], fill=C_STEAM, width=3*SCALE)

    save_supersampled(img, 'assets/menu/latte.png', (240, 240))

# -------------------------------------------------------------
# 4. AMERICANO (Dark ceramic mug with crema ring & steam)
# -------------------------------------------------------------
def generate_americano():
    w, h = 240 * SCALE, 240 * SCALE
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, int(h * 0.58)

    # Mug Handle
    draw.arc([cx + 44*SCALE, cy - 22*SCALE, cx + 86*SCALE, cy + 22*SCALE], 270, 90, fill=C_LINE, width=6*SCALE)
    draw.arc([cx + 46*SCALE, cy - 18*SCALE, cx + 80*SCALE, cy + 18*SCALE], 270, 90, fill=(60, 50, 44, 255), width=4*SCALE)

    # Mug Body (Dark Roast Ceramic #3D312A)
    c_mug = (60, 50, 44, 255)
    mw_top, mw_bot = 52 * SCALE, 44 * SCALE
    my_top, my_bot = cy - 35 * SCALE, cy + 35 * SCALE

    draw.polygon([(cx - mw_top, my_top), (cx + mw_top, my_top),
                  (cx + mw_bot, my_bot), (cx - mw_bot, my_bot)], fill=c_mug)
    draw.ellipse([cx - mw_bot, my_bot - 10*SCALE, cx + mw_bot, my_bot + 10*SCALE], fill=c_mug)
    draw.line([(cx - mw_top, my_top), (cx - mw_bot, my_bot)], fill=C_LINE, width=3*SCALE)
    draw.line([(cx + mw_top, my_top), (cx + mw_bot, my_bot)], fill=C_LINE, width=3*SCALE)
    draw.arc([cx - mw_bot, my_bot - 10*SCALE, cx + mw_bot, my_bot + 10*SCALE], 0, 180, fill=C_LINE, width=3*SCALE)

    # Top Rim & Deep Black Coffee with Crema
    draw.ellipse([cx - mw_top, my_top - 12*SCALE, cx + mw_top, my_top + 12*SCALE], fill=c_mug, outline=C_LINE, width=3*SCALE)
    draw.ellipse([cx - 46*SCALE, my_top - 10*SCALE, cx + 46*SCALE, my_top + 10*SCALE], fill=(28, 20, 16, 255))
    # Golden Crema swirl ring
    draw.ellipse([cx - 38*SCALE, my_top - 7*SCALE, cx + 38*SCALE, my_top + 7*SCALE], fill=C_CREMA)
    draw.ellipse([cx - 30*SCALE, my_top - 5*SCALE, cx + 30*SCALE, my_top + 5*SCALE], fill=(28, 20, 16, 255))

    # Steam
    draw.line([(cx - 12*SCALE, my_top - 20*SCALE), (cx - 18*SCALE, my_top - 42*SCALE)], fill=C_STEAM, width=3*SCALE)
    draw.line([(cx + 10*SCALE, my_top - 22*SCALE), (cx + 16*SCALE, my_top - 44*SCALE)], fill=C_STEAM, width=3*SCALE)

    save_supersampled(img, 'assets/menu/americano.png', (240, 240))

# -------------------------------------------------------------
# 5. MOCHA (Whipped cream swirl + chocolate drizzle + steam)
# -------------------------------------------------------------
def generate_mocha():
    w, h = 240 * SCALE, 240 * SCALE
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, int(h * 0.62)

    # Glass Body
    gw_top, gw_bot = 44 * SCALE, 28 * SCALE
    gy_top, gy_bot = cy - 35 * SCALE, cy + 42 * SCALE

    # Chocolate bottom
    draw.polygon([(cx - 34*SCALE, cy + 18*SCALE), (cx + 34*SCALE, cy + 18*SCALE),
                  (cx + gw_bot, gy_bot), (cx - gw_bot, gy_bot)], fill=(75, 45, 30, 255))
    # Coffee middle
    draw.polygon([(cx - gw_top, gy_top), (cx + gw_top, gy_top),
                  (cx + 34*SCALE, cy + 18*SCALE), (cx - 34*SCALE, cy + 18*SCALE)], fill=C_CREMA)

    # Outline
    draw.line([(cx - gw_top, gy_top), (cx - gw_bot, gy_bot)], fill=C_LINE, width=3*SCALE)
    draw.line([(cx + gw_top, gy_top), (cx + gw_bot, gy_bot)], fill=C_LINE, width=3*SCALE)
    draw.ellipse([cx - gw_bot, gy_bot - 8*SCALE, cx + gw_bot, gy_bot + 8*SCALE], fill=C_GLASS, outline=C_LINE, width=3*SCALE)
    draw.ellipse([cx - gw_top, gy_top - 10*SCALE, cx + gw_top, gy_top + 10*SCALE], fill=C_MILK, outline=C_LINE, width=3*SCALE)

    # Whipped Cream Cloud Dome
    wy = gy_top - 12*SCALE
    draw.ellipse([cx - 40*SCALE, wy - 18*SCALE, cx + 40*SCALE, wy + 16*SCALE], fill=C_MILK, outline=C_LINE, width=3*SCALE)
    draw.ellipse([cx - 24*SCALE, wy - 30*SCALE, cx + 24*SCALE, wy - 4*SCALE], fill=C_MILK, outline=C_LINE, width=3*SCALE)
    draw.ellipse([cx - 10*SCALE, wy - 38*SCALE, cx + 10*SCALE, wy - 18*SCALE], fill=C_MILK)

    # Chocolate Drizzle Zig-Zag
    draw.line([(cx - 24*SCALE, wy - 10*SCALE), (cx - 10*SCALE, wy - 16*SCALE),
               (cx + 8*SCALE, wy - 8*SCALE), (cx + 22*SCALE, wy - 14*SCALE)], fill=(80, 45, 25, 255), width=3*SCALE)

    # Steam Wisps
    draw.line([(cx - 14*SCALE, wy - 45*SCALE), (cx - 20*SCALE, wy - 65*SCALE)], fill=C_STEAM, width=3*SCALE)
    draw.line([(cx + 12*SCALE, wy - 45*SCALE), (cx + 18*SCALE, wy - 65*SCALE)], fill=C_STEAM, width=3*SCALE)

    save_supersampled(img, 'assets/menu/mocha.png', (240, 240))

# -------------------------------------------------------------
# 6. COLD COFFEE (Chilled glass with swirl and condensation)
# -------------------------------------------------------------
def generate_cold_coffee():
    w, h = 240 * SCALE, 240 * SCALE
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, int(h * 0.56)

    # Tall Chilled Glass
    gw_top, gw_bot = 42 * SCALE, 30 * SCALE
    gy_top, gy_bot = cy - 50 * SCALE, cy + 50 * SCALE

    # Rich Cold Brew Milk Coffee blend
    draw.polygon([(cx - gw_top, gy_top), (cx + gw_top, gy_top),
                  (cx + gw_bot, gy_bot), (cx - gw_bot, gy_bot)], fill=C_CREMA)

    # Marble Swirl lines
    draw.arc([cx - 30*SCALE, cy - 20*SCALE, cx + 10*SCALE, cy + 20*SCALE], 45, 180, fill=C_MILK, width=4*SCALE)
    draw.arc([cx - 10*SCALE, cy, cx + 30*SCALE, cy + 40*SCALE], 180, 315, fill=(60, 42, 32, 255), width=4*SCALE)

    # Glass outline
    draw.line([(cx - gw_top, gy_top), (cx - gw_bot, gy_bot)], fill=C_LINE, width=3*SCALE)
    draw.line([(cx + gw_top, gy_top), (cx + gw_bot, gy_bot)], fill=C_LINE, width=3*SCALE)
    draw.ellipse([cx - gw_bot, gy_bot - 8*SCALE, cx + gw_bot, gy_bot + 8*SCALE], fill=C_GLASS, outline=C_LINE, width=3*SCALE)
    draw.ellipse([cx - gw_top, gy_top - 8*SCALE, cx + gw_top, gy_top + 8*SCALE], fill=C_MILK, outline=C_LINE, width=3*SCALE)

    # Chilled ice sparkle
    sp_x, sp_y = cx + 55*SCALE, cy - 25*SCALE
    draw.line([(sp_x - 5*SCALE, sp_y), (sp_x + 5*SCALE, sp_y)], fill=(180, 220, 240, 255), width=2*SCALE)
    draw.line([(sp_x, sp_y - 5*SCALE), (sp_x, sp_y + 5*SCALE)], fill=(180, 220, 240, 255), width=2*SCALE)

    save_supersampled(img, 'assets/menu/cold_coffee.png', (240, 240))

# -------------------------------------------------------------
# 7. ICED LATTE (Glass with ice cubes & diagonal straw)
# -------------------------------------------------------------
def generate_iced_latte():
    w, h = 240 * SCALE, 240 * SCALE
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, int(h * 0.56)

    gw_top, gw_bot = 40 * SCALE, 28 * SCALE
    gy_top, gy_bot = cy - 45 * SCALE, cy + 45 * SCALE

    # Diagonal Striped Straw (Behind front glass)
    straw_top = (cx + 25*SCALE, gy_top - 40*SCALE)
    straw_bot = (cx - 15*SCALE, gy_bot - 10*SCALE)
    draw.line([straw_top, straw_bot], fill=C_TERRA, width=6*SCALE)
    # Straw stripes
    draw.line([straw_top, straw_bot], fill=C_LINE, width=2*SCALE)

    # Liquid Layers
    draw.polygon([(cx - 36*SCALE, cy), (cx + 36*SCALE, cy),
                  (cx + gw_bot, gy_bot), (cx - gw_bot, gy_bot)], fill=C_MILK)
    draw.polygon([(cx - gw_top, gy_top), (cx + gw_top, gy_top),
                  (cx + 36*SCALE, cy), (cx - 36*SCALE, cy)], fill=C_ROAST)

    # Ice Cubes floating
    for ix, iy in [(cx - 18*SCALE, cy - 30*SCALE), (cx + 12*SCALE, cy - 25*SCALE), (cx - 6*SCALE, cy - 10*SCALE)]:
        draw.rounded_rectangle([ix - 12*SCALE, iy - 12*SCALE, ix + 12*SCALE, iy + 12*SCALE], radius=3*SCALE,
                               fill=(255, 255, 255, 170), outline=C_LINE, width=2*SCALE)

    # Glass outline
    draw.line([(cx - gw_top, gy_top), (cx - gw_bot, gy_bot)], fill=C_LINE, width=3*SCALE)
    draw.line([(cx + gw_top, gy_top), (cx + gw_bot, gy_bot)], fill=C_LINE, width=3*SCALE)
    draw.ellipse([cx - gw_bot, gy_bot - 7*SCALE, cx + gw_bot, gy_bot + 7*SCALE], fill=C_GLASS, outline=C_LINE, width=3*SCALE)
    draw.ellipse([cx - gw_top, gy_top - 7*SCALE, cx + gw_top, gy_top + 7*SCALE], fill=(230, 200, 180, 180), outline=C_LINE, width=3*SCALE)

    save_supersampled(img, 'assets/menu/iced_latte.png', (240, 240))

# -------------------------------------------------------------
# 8. INVENTORY ITEMS (Coffee beans, Milk, Sugar, Tea, Syrup)
# -------------------------------------------------------------
def generate_coffee_beans():
    w, h = 200 * SCALE, 200 * SCALE
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, h // 2

    # Draw 3 roasted Arabica coffee beans overlapping
    def draw_bean(bx, by, rot):
        # Bean body (dark roasted brown)
        draw.ellipse([bx - 26*SCALE, by - 38*SCALE, bx + 26*SCALE, by + 38*SCALE], fill=(70, 48, 36, 255), outline=C_LINE, width=3*SCALE)
        # S-curve center crease
        draw.arc([bx - 12*SCALE, by - 32*SCALE, bx + 12*SCALE, by], 270, 90, fill=C_LINE, width=3*SCALE)
        draw.arc([bx - 12*SCALE, by, bx + 12*SCALE, by + 32*SCALE], 90, 270, fill=C_LINE, width=3*SCALE)

    draw_bean(cx - 24*SCALE, cy + 10*SCALE, -20)
    draw_bean(cx + 24*SCALE, cy + 8*SCALE, 25)
    draw_bean(cx, cy - 14*SCALE, 0)

    save_supersampled(img, 'assets/inventory/coffee_beans.png', (200, 200))

def generate_milk():
    w, h = 200 * SCALE, 200 * SCALE
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, h // 2

    # Vintage Milk Glass Bottle
    draw.rounded_rectangle([cx - 28*SCALE, cy - 25*SCALE, cx + 28*SCALE, cy + 50*SCALE], radius=8*SCALE, fill=C_MILK, outline=C_LINE, width=3*SCALE)
    # Bottle neck & cap
    draw.rounded_rectangle([cx - 16*SCALE, cy - 48*SCALE, cx + 16*SCALE, cy - 25*SCALE], radius=4*SCALE, fill=C_MILK, outline=C_LINE, width=3*SCALE)
    draw.rounded_rectangle([cx - 19*SCALE, cy - 56*SCALE, cx + 19*SCALE, cy - 46*SCALE], radius=4*SCALE, fill=C_TERRA, outline=C_LINE, width=3*SCALE)

    # Blue/Pastel Milk Label
    draw.rounded_rectangle([cx - 22*SCALE, cy - 5*SCALE, cx + 22*SCALE, cy + 25*SCALE], radius=4*SCALE, fill=(225, 238, 248, 255), outline=C_LINE, width=2*SCALE)
    # Cow / Droplet icon
    draw.ellipse([cx - 6*SCALE, cy + 2*SCALE, cx + 6*SCALE, cy + 16*SCALE], fill=(90, 140, 180, 255))

    save_supersampled(img, 'assets/inventory/milk.png', (200, 200))

def generate_sugar():
    w, h = 200 * SCALE, 200 * SCALE
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, h // 2

    # Rustic Kraft Sugar Sack / Pouch
    draw.polygon([
        (cx - 30*SCALE, cy - 20*SCALE),
        (cx + 30*SCALE, cy - 20*SCALE),
        (cx + 36*SCALE, cy + 40*SCALE),
        (cx - 36*SCALE, cy + 40*SCALE)
    ], fill=(215, 185, 150, 255))
    draw.ellipse([cx - 36*SCALE, cy + 30*SCALE, cx + 36*SCALE, cy + 48*SCALE], fill=(215, 185, 150, 255))
    draw.line([(cx - 30*SCALE, cy - 20*SCALE), (cx - 36*SCALE, cy + 40*SCALE)], fill=C_LINE, width=3*SCALE)
    draw.line([(cx + 30*SCALE, cy - 20*SCALE), (cx + 36*SCALE, cy + 40*SCALE)], fill=C_LINE, width=3*SCALE)
    draw.arc([cx - 36*SCALE, cy + 30*SCALE, cx + 36*SCALE, cy + 48*SCALE], 0, 180, fill=C_LINE, width=3*SCALE)

    # Top crinkled closure
    draw.ellipse([cx - 30*SCALE, cy - 28*SCALE, cx + 30*SCALE, cy - 14*SCALE], fill=(195, 165, 130, 255), outline=C_LINE, width=3*SCALE)
    # String tie
    draw.line([(cx - 34*SCALE, cy - 18*SCALE), (cx + 34*SCALE, cy - 18*SCALE)], fill=C_LINE, width=3*SCALE)
    # Label
    draw.rounded_rectangle([cx - 20*SCALE, cy, cx + 20*SCALE, cy + 22*SCALE], radius=3*SCALE, fill=C_MILK, outline=C_LINE, width=2*SCALE)

    save_supersampled(img, 'assets/inventory/sugar.png', (200, 200))

def generate_tea_leaves():
    w, h = 200 * SCALE, 200 * SCALE
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, h // 2

    # Dark Ceramic Bowl with fresh green & black tea leaves
    draw.ellipse([cx - 42*SCALE, cy - 20*SCALE, cx + 42*SCALE, cy + 18*SCALE], fill=(75, 125, 85, 255))
    draw.ellipse([cx - 44*SCALE, cy + 10*SCALE, cx + 44*SCALE, cy + 42*SCALE], fill=C_DARK, outline=C_LINE, width=3*SCALE)
    draw.polygon([(cx - 44*SCALE, cy - 4*SCALE), (cx + 44*SCALE, cy - 4*SCALE),
                  (cx + 44*SCALE, cy + 26*SCALE), (cx - 44*SCALE, cy + 26*SCALE)], fill=C_DARK)
    draw.line([(cx - 44*SCALE, cy - 4*SCALE), (cx - 44*SCALE, cy + 26*SCALE)], fill=C_LINE, width=3*SCALE)
    draw.line([(cx + 44*SCALE, cy - 4*SCALE), (cx + 44*SCALE, cy + 26*SCALE)], fill=C_LINE, width=3*SCALE)
    draw.arc([cx - 44*SCALE, cy + 10*SCALE, cx + 44*SCALE, cy + 42*SCALE], 0, 180, fill=C_LINE, width=3*SCALE)

    # Leaves sticking up
    def draw_leaf(lx, ly, fill_color):
        draw.ellipse([lx - 12*SCALE, ly - 22*SCALE, lx + 12*SCALE, ly + 6*SCALE], fill=fill_color, outline=C_LINE, width=2*SCALE)
        draw.line([(lx, ly - 20*SCALE), (lx, ly + 4*SCALE)], fill=C_LINE, width=2*SCALE)

    draw_leaf(cx - 18*SCALE, cy - 10*SCALE, (90, 145, 95, 255))
    draw_leaf(cx + 18*SCALE, cy - 8*SCALE, (65, 115, 75, 255))
    draw_leaf(cx, cy - 16*SCALE, (110, 165, 115, 255))

    save_supersampled(img, 'assets/inventory/tea_leaves.png', (200, 200))

def generate_chocolate_syrup():
    w, h = 200 * SCALE, 200 * SCALE
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, h // 2

    # Chocolate Squeeze Bottle
    draw.rounded_rectangle([cx - 24*SCALE, cy - 25*SCALE, cx + 24*SCALE, cy + 48*SCALE], radius=8*SCALE, fill=(75, 45, 30, 255), outline=C_LINE, width=3*SCALE)
    # Tapered Nozzle
    draw.polygon([(cx - 16*SCALE, cy - 25*SCALE), (cx + 16*SCALE, cy - 25*SCALE),
                  (cx + 6*SCALE, cy - 52*SCALE), (cx - 6*SCALE, cy - 52*SCALE)], fill=C_TERRA, outline=C_LINE)
    draw.rounded_rectangle([cx - 8*SCALE, cy - 60*SCALE, cx + 8*SCALE, cy - 50*SCALE], radius=3*SCALE, fill=C_DARK, outline=C_LINE, width=2*SCALE)

    # Gold swirl label
    draw.rounded_rectangle([cx - 18*SCALE, cy - 6*SCALE, cx + 18*SCALE, cy + 24*SCALE], radius=4*SCALE, fill=(245, 215, 160, 255), outline=C_LINE, width=2*SCALE)
    draw.ellipse([cx - 8*SCALE, cy + 2*SCALE, cx + 8*SCALE, cy + 16*SCALE], fill=(75, 45, 30, 255))

    save_supersampled(img, 'assets/inventory/chocolate_syrup.png', (200, 200))

if __name__ == '__main__':
    print("Generating rich cafe illustrations...")
    generate_hero_coffee()
    generate_cappuccino()
    generate_latte()
    generate_americano()
    generate_mocha()
    generate_cold_coffee()
    generate_iced_latte()
    generate_coffee_beans()
    generate_milk()
    generate_sugar()
    generate_tea_leaves()
    generate_chocolate_syrup()
    print("All illustrations successfully generated!")
