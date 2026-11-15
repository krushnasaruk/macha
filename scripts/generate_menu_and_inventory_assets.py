"""
CAFÉOS VISUAL ASSETS GENERATOR — MENU & INVENTORY
Generates high-resolution 2D cartoon illustrations matching the approved reference design:
- assets/branding/hero_coffee.png (for Home Dashboard Hero Card)
- assets/menu/cappuccino.png
- assets/menu/latte.png
- assets/menu/americano.png
- assets/menu/mocha.png
- assets/menu/cold_coffee.png
- assets/menu/iced_latte.png
- assets/inventory/coffee_beans.png
- assets/inventory/milk.png
- assets/inventory/sugar.png
- assets/inventory/tea_leaves.png
- assets/inventory/chocolate_syrup.png
"""

import os
from PIL import Image, ImageDraw

COLOR_BLACK = (35, 28, 24, 255)
COLOR_WHITE = (255, 255, 255, 255)
COLOR_COFFEE_DARK = (60, 42, 32, 255)
COLOR_COFFEE_CREAM = (175, 130, 95, 255)
COLOR_MILK = (245, 242, 235, 255)
COLOR_GOLD = (230, 175, 60, 255)
COLOR_TERRACOTTA = (217, 148, 105, 255)
COLOR_GREEN = (94, 170, 129, 255)
COLOR_CHOCOLATE = (75, 45, 30, 255)
COLOR_STEAM = (220, 215, 210, 190)

os.makedirs('assets/branding', exist_ok=True)
os.makedirs('assets/menu', exist_ok=True)
os.makedirs('assets/inventory', exist_ok=True)

# 1. HERO COFFEE (Steaming Cup on Saucer for Sales Hero Card)
def gen_hero_coffee():
    w, h = 260, 240
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, h // 2 + 25

    # Golden ambient glow rays
    for angle, r1, r2 in [(120, 50, 75), (90, 60, 85), (60, 50, 75)]:
        pass

    # Saucer
    draw.ellipse([cx - 75, cy + 30, cx + 75, cy + 62], fill=(235, 228, 218, 255), outline=COLOR_BLACK, width=3)
    draw.ellipse([cx - 50, cy + 38, cx + 50, cy + 54], fill=(215, 208, 198, 255))

    # Ceramic Cup Body
    draw.rounded_rectangle([cx - 52, cy - 25, cx + 52, cy + 40], radius=16, fill=(248, 244, 238, 255), outline=COLOR_BLACK, width=3)
    # Cup handle
    draw.arc([cx + 38, cy - 15, cx + 78, cy + 28], 270, 90, fill=COLOR_BLACK, width=4)
    # Coffee Surface
    draw.ellipse([cx - 48, cy - 35, cx + 48, cy - 15], fill=COLOR_COFFEE_DARK, outline=COLOR_BLACK, width=2)
    # Heart Latte Art
    draw.ellipse([cx - 20, cy - 30, cx + 2, cy - 20], fill=COLOR_MILK)
    draw.ellipse([cx - 2, cy - 30, cx + 20, cy - 20], fill=COLOR_MILK)
    draw.polygon([(cx - 18, cy - 24), (cx + 18, cy - 24), (cx, cy - 17)], fill=COLOR_MILK)

    # Rising Steam
    draw.arc([cx - 16, cy - 75, cx + 4, cy - 45], 180, 360, fill=COLOR_STEAM, width=3)
    draw.arc([cx + 2, cy - 90, cx + 22, cy - 60], 0, 180, fill=COLOR_STEAM, width=3)
    # Sparkles
    for sx, sy in [(cx - 45, cy - 50), (cx + 50, cy - 55), (cx + 65, cy - 30)]:
        draw.line([(sx - 5, sy), (sx + 5, sy)], fill=COLOR_GOLD, width=2)
        draw.line([(sx, sy - 5), (sx, sy + 5)], fill=COLOR_GOLD, width=2)

    img.save('assets/branding/hero_coffee.png')

# 2. MENU ITEMS
def gen_cappuccino():
    w, h = 200, 200
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, h // 2 + 10
    # Saucer
    draw.ellipse([cx - 55, cy + 25, cx + 55, cy + 50], fill=(235, 230, 222, 255), outline=COLOR_BLACK, width=3)
    # Cup
    draw.rounded_rectangle([cx - 42, cy - 18, cx + 42, cy + 32], radius=14, fill=(250, 246, 240, 255), outline=COLOR_BLACK, width=3)
    draw.arc([cx + 30, cy - 8, cx + 62, cy + 22], 270, 90, fill=COLOR_BLACK, width=3)
    # Foamy surface
    draw.ellipse([cx - 38, cy - 26, cx + 38, cy - 10], fill=COLOR_COFFEE_CREAM, outline=COLOR_BLACK, width=2)
    # Latte art rosette
    draw.ellipse([cx - 15, cy - 22, cx + 15, cy - 14], fill=COLOR_MILK)
    draw.arc([cx - 8, cy - 52, cx + 8, cy - 32], 180, 360, fill=COLOR_STEAM, width=2)
    img.save('assets/menu/cappuccino.png')

def gen_latte():
    w, h = 200, 200
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, h // 2 + 10
    # Glass latte cup
    draw.polygon([(cx - 32, cy - 35), (cx + 32, cy - 35), (cx + 24, cy + 38), (cx - 24, cy + 38)], fill=(245, 240, 230, 220), outline=COLOR_BLACK, width=3)
    # Layered espresso and milk
    draw.polygon([(cx - 28, cy - 15), (cx + 28, cy - 15), (cx + 25, cy + 12), (cx - 25, cy + 12)], fill=COLOR_COFFEE_CREAM)
    draw.polygon([(cx - 25, cy + 12), (cx + 25, cy + 12), (cx + 23, cy + 36), (cx - 23, cy + 36)], fill=COLOR_MILK)
    # Cream foam top
    draw.ellipse([cx - 32, cy - 42, cx + 32, cy - 28], fill=COLOR_WHITE, outline=COLOR_BLACK, width=2)
    img.save('assets/menu/latte.png')

def gen_americano():
    w, h = 200, 200
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, h // 2 + 10
    # Black ceramic mug
    draw.rounded_rectangle([cx - 40, cy - 22, cx + 40, cy + 32], radius=12, fill=(45, 38, 34, 255), outline=COLOR_BLACK, width=3)
    draw.arc([cx + 30, cy - 12, cx + 60, cy + 22], 270, 90, fill=COLOR_BLACK, width=3)
    # Dark espresso top with golden crema rim
    draw.ellipse([cx - 36, cy - 30, cx + 36, cy - 14], fill=COLOR_COFFEE_DARK, outline=COLOR_GOLD, width=2)
    draw.arc([cx - 6, cy - 54, cx + 10, cy - 36], 180, 360, fill=COLOR_STEAM, width=2)
    img.save('assets/menu/americano.png')

def gen_mocha():
    w, h = 200, 200
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, h // 2 + 15
    # Glass mug
    draw.rounded_rectangle([cx - 36, cy - 20, cx + 36, cy + 34], radius=12, fill=(245, 235, 225, 230), outline=COLOR_BLACK, width=3)
    draw.arc([cx + 28, cy - 8, cx + 56, cy + 24], 270, 90, fill=COLOR_BLACK, width=3)
    # Chocolate layer
    draw.polygon([(cx - 34, cy + 8), (cx + 34, cy + 8), (cx + 32, cy + 32), (cx - 32, cy + 32)], fill=COLOR_CHOCOLATE)
    # Whipped cream swirl
    draw.chord([cx - 28, cy - 42, cx + 28, cy - 16], 180, 360, fill=COLOR_WHITE, outline=COLOR_BLACK, width=2)
    draw.ellipse([cx - 15, cy - 52, cx + 15, cy - 36], fill=COLOR_WHITE, outline=COLOR_BLACK, width=2)
    # Chocolate drizzle
    draw.line([(cx - 16, cy - 34), (cx + 14, cy - 30)], fill=COLOR_CHOCOLATE, width=2)
    draw.line([(cx - 10, cy - 26), (cx + 18, cy - 22)], fill=COLOR_CHOCOLATE, width=2)
    img.save('assets/menu/mocha.png')

def gen_cold_coffee():
    w, h = 200, 200
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, h // 2 + 10
    # Tall flared iced glass
    draw.polygon([(cx - 28, cy - 44), (cx + 28, cy - 44), (cx + 20, cy + 42), (cx - 20, cy + 42)], fill=(235, 245, 255, 180), outline=COLOR_BLACK, width=3)
    # Iced coffee fill
    draw.polygon([(cx - 26, cy - 36), (cx + 26, cy - 36), (cx + 19, cy + 40), (cx - 19, cy + 40)], fill=COLOR_COFFEE_CREAM)
    # Ice cubes floating
    draw.rounded_rectangle([cx - 18, cy - 28, cx - 2, cy - 12], radius=2, fill=(255, 255, 255, 160), outline=COLOR_WHITE, width=1)
    draw.rounded_rectangle([cx + 2, cy - 20, cx + 18, cy - 4], radius=2, fill=(255, 255, 255, 160), outline=COLOR_WHITE, width=1)
    # Striped straw
    draw.line([(cx + 4, cy - 65), (cx + 8, cy + 20)], fill=COLOR_TERRACOTTA, width=4)
    img.save('assets/menu/cold_coffee.png')

def gen_iced_latte():
    w, h = 200, 200
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, h // 2 + 10
    # Tall glass
    draw.polygon([(cx - 30, cy - 44), (cx + 30, cy - 44), (cx + 22, cy + 42), (cx - 22, cy + 42)], fill=(240, 245, 250, 180), outline=COLOR_BLACK, width=3)
    # Dark espresso top layer
    draw.polygon([(cx - 28, cy - 40), (cx + 28, cy - 40), (cx + 26, cy - 10), (cx - 26, cy - 10)], fill=COLOR_COFFEE_DARK)
    # Creamy milk lower layer
    draw.polygon([(cx - 26, cy - 10), (cx + 26, cy - 10), (cx + 21, cy + 40), (cx - 21, cy + 40)], fill=COLOR_MILK)
    # Glass shine
    draw.line([(cx - 22, cy - 30), (cx - 18, cy + 25)], fill=(255, 255, 255, 180), width=2)
    img.save('assets/menu/iced_latte.png')

# 3. INVENTORY ICONS
def gen_coffee_beans():
    w, h = 160, 160
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, h // 2
    # 2 Roasted Coffee Beans
    # Bean 1
    draw.ellipse([cx - 35, cy - 25, cx + 5, cy + 25], fill=COLOR_COFFEE_DARK, outline=COLOR_BLACK, width=2)
    draw.arc([cx - 25, cy - 20, cx - 5, cy + 20], 310, 50, fill=COLOR_COFFEE_CREAM, width=2)
    # Bean 2
    draw.ellipse([cx - 5, cy - 15, cx + 35, cy + 30], fill=(85, 55, 40, 255), outline=COLOR_BLACK, width=2)
    draw.arc([cx + 5, cy - 10, cx + 25, cy + 25], 290, 70, fill=COLOR_COFFEE_CREAM, width=2)
    img.save('assets/inventory/coffee_beans.png')

def gen_milk():
    w, h = 160, 160
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, h // 2
    # Glass milk bottle
    draw.rounded_rectangle([cx - 18, cy - 45, cx + 18, cy + 45], radius=8, fill=(240, 248, 255, 200), outline=COLOR_BLACK, width=3)
    # Milk level
    draw.rounded_rectangle([cx - 16, cy - 15, cx + 16, cy + 42], radius=6, fill=COLOR_WHITE)
    # Blue cap
    draw.rounded_rectangle([cx - 12, cy - 50, cx + 12, cy - 42], radius=2, fill=(47, 128, 237, 255), outline=COLOR_BLACK, width=2)
    # Blue label
    draw.rectangle([cx - 15, cy, cx + 15, cy + 18], fill=(220, 235, 250, 255))
    img.save('assets/inventory/milk.png')

def gen_sugar():
    w, h = 160, 160
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, h // 2
    # Burlap sugar sack
    draw.polygon([(cx - 30, cy + 35), (cx + 30, cy + 35), (cx + 25, cy - 25), (cx - 25, cy - 25)], fill=(215, 185, 145, 255), outline=COLOR_BLACK, width=3)
    # Tied neck
    draw.ellipse([cx - 18, cy - 35, cx + 18, cy - 20], fill=(190, 160, 120, 255), outline=COLOR_BLACK, width=2)
    # "S" label
    draw.ellipse([cx - 14, cy - 5, cx + 14, cy + 20], fill=COLOR_WHITE, outline=COLOR_TERRACOTTA, width=2)
    img.save('assets/inventory/sugar.png')

def gen_tea_leaves():
    w, h = 160, 160
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, h // 2
    # Ceramic bowl
    draw.chord([cx - 35, cy - 10, cx + 35, cy + 38], 0, 180, fill=(235, 230, 222, 255), outline=COLOR_BLACK, width=3)
    # Green tea leaves mound
    draw.ellipse([cx - 32, cy - 20, cx + 32, cy + 5], fill=COLOR_GREEN, outline=COLOR_BLACK, width=2)
    # Fresh leaf detail
    draw.ellipse([cx - 8, cy - 30, cx + 8, cy - 10], fill=(60, 180, 100, 255), outline=COLOR_BLACK, width=2)
    img.save('assets/inventory/tea_leaves.png')

def gen_chocolate_syrup():
    w, h = 160, 160
    img = Image.new('RGBA', (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = w // 2, h // 2
    # Squeeze bottle
    draw.rounded_rectangle([cx - 18, cy - 35, cx + 18, cy + 45], radius=6, fill=COLOR_CHOCOLATE, outline=COLOR_BLACK, width=3)
    # Cone dispenser tip
    draw.polygon([(cx - 12, cy - 35), (cx + 12, cy - 35), (cx, cy - 55)], fill=(220, 70, 50, 255), outline=COLOR_BLACK, width=2)
    # Red label
    draw.rectangle([cx - 16, cy - 5, cx + 16, cy + 18], fill=(230, 190, 150, 255))
    img.save('assets/inventory/chocolate_syrup.png')

if __name__ == '__main__':
    gen_hero_coffee()
    gen_cappuccino()
    gen_latte()
    gen_americano()
    gen_mocha()
    gen_cold_coffee()
    gen_iced_latte()
    gen_coffee_beans()
    gen_milk()
    gen_sugar()
    gen_tea_leaves()
    gen_chocolate_syrup()
    print("Menu and Inventory visual assets generated successfully!")
