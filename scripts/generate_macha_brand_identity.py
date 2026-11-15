"""
MΛCHA Brand Identity & Typographic Generator
Generates world-class brand assets, wordmarks, standalone emblems,
app icons, technical construction diagrams, and product mockups.
"""

import os
import math
from PIL import Image, ImageDraw, ImageFont

SCALE = 4  # 4x Supersampling for print-ready anti-aliased geometry

# Official MΛCHA Brand Colors
HEX_DEEP_FOREST = "#293D32"  # Primary signature dark
HEX_MATCHA_GREEN = "#A5B98A"  # Accent green
HEX_SOFT_LAVENDER = "#B9A7CE"  # Secondary accent
HEX_LILAC_MIST = "#D8CBE5"   # Tint
HEX_VANILLA_CREAM = "#FFF9F2" # Signature warm light background
HEX_WARM_NEUTRAL = "#E9E5DE"  # Neutral surface / card
HEX_MUTED_TEXT = "#827B82"   # Supporting text

C_DEEP_FOREST = (41, 61, 50, 255)
C_MATCHA_GREEN = (165, 185, 138, 255)
C_SOFT_LAVENDER = (185, 167, 206, 255)
C_LILAC_MIST = (216, 203, 229, 255)
C_VANILLA_CREAM = (255, 249, 242, 255)
C_WARM_NEUTRAL = (233, 229, 222, 255)
C_MUTED_TEXT = (130, 123, 130, 255)
C_WHITE = (255, 255, 255, 255)

OUT_DIR = "assets/branding/macha"
os.makedirs(OUT_DIR, exist_ok=True)

def save_img(img_hi, filename, target_size):
    path = os.path.join(OUT_DIR, filename)
    res = img_hi.resize(target_size, Image.Resampling.LANCZOS)
    res.save(path, "PNG")
    print(f"Generated {path} ({target_size[0]}x{target_size[1]})")

# -------------------------------------------------------------------------
# Letter Drawing Primitives for Custom M - Λ - C - H - A
# -------------------------------------------------------------------------

def draw_letter_m(draw, x, y, h, stroke, color, style="primary"):
    """Draws custom geometric M with architectural vertical outer legs and apex center."""
    w = int(h * 1.05)
    s = stroke
    if style == "compact":
        w = int(h * 0.85)
    
    # Outer Left Leg
    draw.rounded_rectangle([x, y, x + s, y + h], radius=int(s*0.2), fill=color)
    # Outer Right Leg
    draw.rounded_rectangle([x + w - s, y, x + w, y + h], radius=int(s*0.2), fill=color)
    
    # Center Diagonals meeting at baseline
    # Left diagonal from (x + s, y) down to (x + w/2, y + h)
    draw.polygon([
        (x + s, y),
        (x + s + int(s*0.8), y),
        (x + w//2 + s//2, y + h),
        (x + w//2 - s//2, y + h),
        (x + s, y + int(s*1.2))
    ], fill=color)
    # Right diagonal from (x + w - s, y) down to (x + w/2, y + h)
    draw.polygon([
        (x + w - s, y),
        (x + w - s - int(s*0.8), y),
        (x + w//2 - s//2, y + h),
        (x + w//2 + s//2, y + h),
        (x + w - s, y + int(s*1.2))
    ], fill=color)
    return w

def draw_letter_lambda(draw, x, y, h, stroke, color, accent_color=None, style="primary"):
    """
    Draws the signature custom geometric Λ.
    Sharp architectural apex, exact negative space balance, no crossbar.
    """
    w = int(h * 0.96)
    s = stroke
    if style == "compact":
        w = int(h * 0.78)

    cx = x + w // 2
    # Left diagonal leg
    draw.polygon([
        (cx, y),
        (cx + int(s*0.6), y + int(s*0.9)),
        (x + s, y + h),
        (x, y + h)
    ], fill=color)

    # Right diagonal leg
    draw.polygon([
        (cx, y),
        (cx - int(s*0.6), y + int(s*0.9)),
        (x + w - s, y + h),
        (x + w, y + h)
    ], fill=color)

    # Architectural Apex Cap (Clean architectural chamfer)
    apex_cap_w = int(s * 0.45)
    draw.polygon([
        (cx - apex_cap_w, y),
        (cx + apex_cap_w, y),
        (cx + apex_cap_w, y + int(s*0.4)),
        (cx - apex_cap_w, y + int(s*0.4))
    ], fill=color)

    # Optional internal accent (floating geometric dot or lavender accent)
    if accent_color:
        dot_r = int(s * 0.35)
        dot_cy = y + int(h * 0.60)
        draw.ellipse([cx - dot_r, dot_cy - dot_r, cx + dot_r, dot_cy + dot_r], fill=accent_color)

    return w

def draw_letter_c(draw, x, y, h, stroke, color, style="primary"):
    """Draws custom geometric C matching the architectural proportions."""
    w = int(h * 0.88)
    s = stroke
    if style == "compact":
        w = int(h * 0.75)

    # Left upright back
    draw.rounded_rectangle([x, y, x + s, y + h], radius=int(s*0.25), fill=color)
    # Top horizontal arm
    draw.rounded_rectangle([x, y, x + w, y + s], radius=int(s*0.2), fill=color)
    # Bottom horizontal arm
    draw.rounded_rectangle([x, y + h - s, x + w, y + h], radius=int(s*0.2), fill=color)
    
    # Elegant 45-degree inner chamfers for architectural cadence
    draw.polygon([(x + s, y + s), (x + int(s*1.8), y + s), (x + s, y + int(s*1.8))], fill=color)
    draw.polygon([(x + s, y + h - s), (x + int(s*1.8), y + h - s), (x + s, y + h - int(s*1.8))], fill=color)

    # Distinctive terminal accent cuts on the open arms
    t_w = int(s * 0.8)
    draw.rectangle([x + w - t_w, y, x + w, y + s], fill=color)
    draw.rectangle([x + w - t_w, y + h - s, x + w, y + h], fill=color)
    return w

def draw_letter_h(draw, x, y, h, stroke, color, style="primary"):
    """Draws custom geometric H with high/low harmonic crossbar."""
    w = int(h * 0.88)
    s = stroke
    if style == "compact":
        w = int(h * 0.72)

    # Left Stem
    draw.rounded_rectangle([x, y, x + s, y + h], radius=int(s*0.2), fill=color)
    # Right Stem
    draw.rounded_rectangle([x + w - s, y, x + w, y + h], radius=int(s*0.2), fill=color)
    # Crossbar (optical center slightly above middle at 0.48)
    bar_y = y + int(h * 0.48) - s // 2
    draw.rounded_rectangle([x + s, bar_y, x + w - s, bar_y + s], radius=int(s*0.15), fill=color)
    return w

def draw_letter_final_a(draw, x, y, h, stroke, color, style="primary"):
    """
    Draws the final A in MΛCHA.
    Coordinates geometrically with the custom Λ, but features a deliberate low architectural
    crossbar that bridges the legs, providing visual grounding and cadence.
    """
    w = int(h * 0.96)
    s = stroke
    if style == "compact":
        w = int(h * 0.78)

    cx = x + w // 2
    # Left diagonal leg
    draw.polygon([
        (cx, y),
        (cx + int(s*0.6), y + int(s*0.9)),
        (x + s, y + h),
        (x, y + h)
    ], fill=color)

    # Right diagonal leg
    draw.polygon([
        (cx, y),
        (cx - int(s*0.6), y + int(s*0.9)),
        (x + w - s, y + h),
        (x + w, y + h)
    ], fill=color)

    # Apex Cap
    apex_cap_w = int(s * 0.45)
    draw.polygon([
        (cx - apex_cap_w, y),
        (cx + apex_cap_w, y),
        (cx + apex_cap_w, y + int(s*0.4)),
        (cx - apex_cap_w, y + int(s*0.4))
    ], fill=color)

    # Grounded Low Crossbar (positioned at 62% of height)
    bar_y = y + int(h * 0.62)
    # Calculate inner triangle bounds at bar_y
    rel_y = (bar_y - y) / h
    bar_left = int(x + (s * 0.7) + (cx - x) * rel_y * 0.55)
    bar_right = int(x + w - (s * 0.7) - (cx - x) * rel_y * 0.55)
    draw.rounded_rectangle([bar_left, bar_y, bar_right, bar_y + s], radius=int(s*0.15), fill=color)
    return w

# -------------------------------------------------------------------------
# Full Wordmark Rendering Functions
# -------------------------------------------------------------------------

def render_wordmark(bg_color, main_color, accent_color=None, kerning=24*SCALE, stroke_ratio=0.17, style="primary"):
    """Renders the full MΛCHA wordmark on given background with specified geometry."""
    canvas_w, canvas_h = 960 * SCALE, 320 * SCALE
    img = Image.new('RGBA', (canvas_w, canvas_h), bg_color)
    draw = ImageDraw.Draw(img)

    cap_h = 130 * SCALE
    stroke = int(cap_h * stroke_ratio)
    y_pos = (canvas_h - cap_h) // 2

    # Calculate letter widths first to center the wordmark
    w_m = int(cap_h * (0.85 if style == "compact" else 1.05))
    w_lambda = int(cap_h * (0.78 if style == "compact" else 0.96))
    w_c = int(cap_h * (0.75 if style == "compact" else 0.88))
    w_h = int(cap_h * (0.72 if style == "compact" else 0.88))
    w_a = int(cap_h * (0.78 if style == "compact" else 0.96))

    total_w = w_m + w_lambda + w_c + w_h + w_a + (4 * kerning)
    start_x = (canvas_w - total_w) // 2

    curr_x = start_x
    # 1. Letter M
    curr_x += draw_letter_m(draw, curr_x, y_pos, cap_h, stroke, main_color, style) + kerning
    # 2. Letter Λ (The Hero Character)
    curr_x += draw_letter_lambda(draw, curr_x, y_pos, cap_h, stroke, main_color, accent_color, style) + kerning
    # 3. Letter C
    curr_x += draw_letter_c(draw, curr_x, y_pos, cap_h, stroke, main_color, style) + kerning
    # 4. Letter H
    curr_x += draw_letter_h(draw, curr_x, y_pos, cap_h, stroke, main_color, style) + kerning
    # 5. Letter A (Terminal companion)
    draw_letter_final_a(draw, curr_x, y_pos, cap_h, stroke, main_color, style)

    return img

# -------------------------------------------------------------------------
# 1. Primary Wordmark (Vanilla Cream Background)
# -------------------------------------------------------------------------
def generate_primary_wordmark():
    img = render_wordmark(
        bg_color=C_VANILLA_CREAM,
        main_color=C_DEEP_FOREST,
        accent_color=C_MATCHA_GREEN,
        kerning=22*SCALE,
        stroke_ratio=0.175,
        style="primary"
    )
    save_img(img, "macha_wordmark_primary.png", (960, 320))

# -------------------------------------------------------------------------
# 2. Dark Inverse Wordmark (Deep Forest Matcha Background)
# -------------------------------------------------------------------------
def generate_dark_wordmark():
    img = render_wordmark(
        bg_color=C_DEEP_FOREST,
        main_color=C_VANILLA_CREAM,
        accent_color=C_MATCHA_GREEN,
        kerning=22*SCALE,
        stroke_ratio=0.175,
        style="primary"
    )
    save_img(img, "macha_wordmark_dark.png", (960, 320))

# -------------------------------------------------------------------------
# 3. Compact Architecture Wordmark (Narrow & Vertical Spacing)
# -------------------------------------------------------------------------
def generate_compact_wordmark():
    img = render_wordmark(
        bg_color=C_VANILLA_CREAM,
        main_color=C_DEEP_FOREST,
        accent_color=C_SOFT_LAVENDER,
        kerning=14*SCALE,
        stroke_ratio=0.19,
        style="compact"
    )
    save_img(img, "macha_wordmark_compact.png", (960, 320))

# -------------------------------------------------------------------------
# 4. Soft Lavender Wordmark (Brand Accent Exploration)
# -------------------------------------------------------------------------
def generate_lavender_wordmark():
    img = render_wordmark(
        bg_color=C_LILAC_MIST,
        main_color=C_DEEP_FOREST,
        accent_color=C_MATCHA_GREEN,
        kerning=22*SCALE,
        stroke_ratio=0.175,
        style="primary"
    )
    save_img(img, "macha_wordmark_lavender.png", (960, 320))

# -------------------------------------------------------------------------
# 5. Standalone Geometric Λ Symbol (App Icon & Monogram)
# -------------------------------------------------------------------------
def generate_standalone_symbol():
    size = 600 * SCALE
    img = Image.new('RGBA', (size, size), C_VANILLA_CREAM)
    draw = ImageDraw.Draw(img)

    cx, cy = size // 2, size // 2
    h = 320 * SCALE
    stroke = int(h * 0.185)
    y_pos = cy - h // 2

    # Draw refined standalone architectural Λ with floating geometric accent
    draw_letter_lambda(draw, cx - int(h * 0.48), y_pos, h, stroke, C_DEEP_FOREST, accent_color=C_MATCHA_GREEN, style="primary")

    # Corner framing ticks for geometric drafting precision
    tick_len = 24 * SCALE
    tick_margin = 40 * SCALE
    # Top-Left
    draw.line([(tick_margin, tick_margin), (tick_margin + tick_len, tick_margin)], fill=C_MATCHA_GREEN, width=3*SCALE)
    draw.line([(tick_margin, tick_margin), (tick_margin, tick_margin + tick_len)], fill=C_MATCHA_GREEN, width=3*SCALE)
    # Bottom-Right
    draw.line([(size - tick_margin, size - tick_margin), (size - tick_margin - tick_len, size - tick_margin)], fill=C_MATCHA_GREEN, width=3*SCALE)
    draw.line([(size - tick_margin, size - tick_margin), (size - tick_margin, size - tick_margin - tick_len)], fill=C_MATCHA_GREEN, width=3*SCALE)

    save_img(img, "macha_symbol_standalone.png", (600, 600))

# -------------------------------------------------------------------------
# 6. iOS / Android App Icon (Deep Forest Matcha)
# -------------------------------------------------------------------------
def generate_app_icon_forest():
    size = 512 * SCALE
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    # Squircle Container (iOS 22.5% radius)
    radius = int(size * 0.225)
    draw.rounded_rectangle([0, 0, size, size], radius=radius, fill=C_DEEP_FOREST)

    # Subtle ambient inner ring
    draw.rounded_rectangle([16*SCALE, 16*SCALE, size - 16*SCALE, size - 16*SCALE], radius=radius - 12*SCALE,
                           outline=(55, 80, 66, 255), width=3*SCALE)

    # Standalone Architectural Λ in Vanilla Cream with Matcha Accent
    cx, cy = size // 2, size // 2
    h = 280 * SCALE
    stroke = int(h * 0.18)
    y_pos = cy - h // 2

    draw_letter_lambda(draw, cx - int(h * 0.48), y_pos, h, stroke, C_VANILLA_CREAM, accent_color=C_MATCHA_GREEN)

    save_img(img, "macha_app_icon_forest.png", (512, 512))

# -------------------------------------------------------------------------
# 7. iOS / Android App Icon (Soft Lavender Special Edition)
# -------------------------------------------------------------------------
def generate_app_icon_lavender():
    size = 512 * SCALE
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    radius = int(size * 0.225)
    draw.rounded_rectangle([0, 0, size, size], radius=radius, fill=C_SOFT_LAVENDER)

    cx, cy = size // 2, size // 2
    h = 280 * SCALE
    stroke = int(h * 0.18)
    y_pos = cy - h // 2

    draw_letter_lambda(draw, cx - int(h * 0.48), y_pos, h, stroke, C_DEEP_FOREST, accent_color=C_DEEP_FOREST)

    save_img(img, "macha_app_icon_lavender.png", (512, 512))

# -------------------------------------------------------------------------
# 8. Technical Geometry & Construction Spec Diagram
# -------------------------------------------------------------------------
def generate_geometry_spec():
    w, h = 1000 * SCALE, 560 * SCALE
    img = Image.new('RGBA', (w, h), C_VANILLA_CREAM)
    draw = ImageDraw.Draw(img)

    # Technical grid lines (cadence: 40px)
    grid_c = (235, 230, 222, 255)
    grid_step = 35 * SCALE
    for gx in range(0, w, grid_step):
        draw.line([(gx, 0), (gx, h)], fill=grid_c, width=1*SCALE)
    for gy in range(0, h, grid_step):
        draw.line([(0, gy), (w, gy)], fill=grid_c, width=1*SCALE)

    # Header drafting notes
    # Baseline, Cap-height, optical grid
    cap_h = 220 * SCALE
    stroke = int(cap_h * 0.18)
    y_base = int(h * 0.72)
    y_cap = y_base - cap_h

    # Guide lines: Cap-line & Baseline in Matcha Green
    draw.line([(60*SCALE, y_cap), (w - 60*SCALE, y_cap)], fill=C_MATCHA_GREEN, width=2*SCALE)
    draw.line([(60*SCALE, y_base), (w - 60*SCALE, y_base)], fill=C_MATCHA_GREEN, width=2*SCALE)
    # Optical center line
    draw.line([(60*SCALE, y_cap + cap_h//2), (w - 60*SCALE, y_cap + cap_h//2)], fill=(200, 215, 185, 255), width=2*SCALE)

    # Draw the Custom Hero Character Λ in the center
    cx = w // 2
    lambda_w = int(cap_h * 0.96)
    lx = cx - lambda_w // 2

    # Draw construction angle guide lines (68-degree slant extensions)
    draw.line([(cx, y_cap - 40*SCALE), (lx - 40*SCALE, y_base + 40*SCALE)], fill=C_SOFT_LAVENDER, width=2*SCALE)
    draw.line([(cx, y_cap - 40*SCALE), (lx + lambda_w + 40*SCALE, y_base + 40*SCALE)], fill=C_SOFT_LAVENDER, width=2*SCALE)

    # Angle arc & callout
    draw.arc([cx - 45*SCALE, y_cap + 15*SCALE, cx + 45*SCALE, y_cap + 105*SCALE], 245, 295, fill=C_MUTED_TEXT, width=2*SCALE)

    # Draw the actual Λ form
    draw_letter_lambda(draw, lx, y_cap, cap_h, stroke, C_DEEP_FOREST, accent_color=C_MATCHA_GREEN)

    # Drafting Callout Boxes & Technical Typography
    # Title
    draw.rectangle([60*SCALE, 45*SCALE, 380*SCALE, 80*SCALE], fill=C_DEEP_FOREST)
    # Dimensions markers
    # Height dimension
    hx = lx - 40*SCALE
    draw.line([(hx, y_cap), (hx, y_base)], fill=C_MUTED_TEXT, width=2*SCALE)
    draw.line([(hx - 10*SCALE, y_cap), (hx + 10*SCALE, y_cap)], fill=C_MUTED_TEXT, width=2*SCALE)
    draw.line([(hx - 10*SCALE, y_base), (hx + 10*SCALE, y_base)], fill=C_MUTED_TEXT, width=2*SCALE)

    # Width dimension
    by = y_base + 35*SCALE
    draw.line([(lx, by), (lx + lambda_w, by)], fill=C_MUTED_TEXT, width=2*SCALE)
    draw.line([(lx, by - 10*SCALE), (lx, by + 10*SCALE)], fill=C_MUTED_TEXT, width=2*SCALE)
    draw.line([(lx + lambda_w, by - 10*SCALE), (lx + lambda_w, by + 10*SCALE)], fill=C_MUTED_TEXT, width=2*SCALE)

    save_img(img, "macha_geometry_spec.png", (1000, 560))

# -------------------------------------------------------------------------
# 9. Brand Color Swatch Palette Visualizer
# -------------------------------------------------------------------------
def generate_color_palette():
    w, h = 900 * SCALE, 260 * SCALE
    img = Image.new('RGBA', (w, h), C_VANILLA_CREAM)
    draw = ImageDraw.Draw(img)

    swatches = [
        ("DEEP FOREST", HEX_DEEP_FOREST, C_DEEP_FOREST, "Primary Dark"),
        ("MATCHA GREEN", HEX_MATCHA_GREEN, C_MATCHA_GREEN, "Accent"),
        ("SOFT LAVENDER", HEX_SOFT_LAVENDER, C_SOFT_LAVENDER, "Secondary"),
        ("LILAC MIST", HEX_LILAC_MIST, C_LILAC_MIST, "Subtle Tint"),
        ("VANILLA CREAM", HEX_VANILLA_CREAM, C_VANILLA_CREAM, "Light Surface"),
        ("WARM NEUTRAL", HEX_WARM_NEUTRAL, C_WARM_NEUTRAL, "Structure"),
    ]

    margin_x = 40 * SCALE
    spacing = 16 * SCALE
    swatch_w = (w - (2 * margin_x) - (len(swatches) - 1) * spacing) // len(swatches)
    swatch_h = 160 * SCALE
    y_pos = 50 * SCALE

    for i, (name, hex_code, col, role) in enumerate(swatches):
        sx = margin_x + i * (swatch_w + spacing)
        # Swatch Pill Container
        draw.rounded_rectangle([sx, y_pos, sx + swatch_w, y_pos + swatch_h], radius=16*SCALE, fill=col, outline=(220, 215, 205, 255), width=2*SCALE)

    save_img(img, "macha_color_palette.png", (900, 260))

# -------------------------------------------------------------------------
# 10. Thermal Receipt Application Mockup
# -------------------------------------------------------------------------
def generate_receipt_mockup():
    w, h = 600 * SCALE, 820 * SCALE
    img = Image.new('RGBA', (w, h), C_WARM_NEUTRAL)
    draw = ImageDraw.Draw(img)

    # Receipt paper strip
    rw, rh = 460 * SCALE, 740 * SCALE
    rx = (w - rw) // 2
    ry = (h - rh) // 2

    # Paper shadow & body
    draw.rounded_rectangle([rx + 6*SCALE, ry + 8*SCALE, rx + rw + 6*SCALE, ry + rh + 8*SCALE], radius=12*SCALE, fill=(210, 205, 198, 200))
    draw.rounded_rectangle([rx, ry, rx + rw, ry + rh], radius=12*SCALE, fill=C_VANILLA_CREAM, outline=(225, 220, 212, 255), width=2*SCALE)

    # Brand Header on Receipt
    cap_h = 42 * SCALE
    stroke = int(cap_h * 0.18)
    head_y = ry + 40 * SCALE

    # Render small MΛCHA wordmark centered on receipt
    w_m = int(cap_h * 1.05)
    w_lambda = int(cap_h * 0.96)
    w_c = int(cap_h * 0.88)
    w_h = int(cap_h * 0.88)
    w_a = int(cap_h * 0.96)
    kern = 8 * SCALE
    tot_w = w_m + w_lambda + w_c + w_h + w_a + (4 * kern)
    cx = rx + (rw - tot_w) // 2

    cx += draw_letter_m(draw, cx, head_y, cap_h, stroke, C_DEEP_FOREST) + kern
    cx += draw_letter_lambda(draw, cx, head_y, cap_h, stroke, C_DEEP_FOREST, C_MATCHA_GREEN) + kern
    cx += draw_letter_c(draw, cx, head_y, cap_h, stroke, C_DEEP_FOREST) + kern
    cx += draw_letter_h(draw, cx, head_y, cap_h, stroke, C_DEEP_FOREST) + kern
    draw_letter_final_a(draw, cx, head_y, cap_h, stroke, C_DEEP_FOREST)

    # Sub-header separator lines
    sep_y = head_y + 70 * SCALE
    draw.line([(rx + 30*SCALE, sep_y), (rx + rw - 30*SCALE, sep_y)], fill=C_MATCHA_GREEN, width=2*SCALE)

    # Dashed divider
    dash_y = sep_y + 40 * SCALE
    for dx in range(rx + 30*SCALE, rx + rw - 30*SCALE, 16*SCALE):
        draw.line([(dx, dash_y), (dx + 8*SCALE, dash_y)], fill=(180, 175, 170, 255), width=2*SCALE)

    # Barcode at bottom of receipt
    bar_y = ry + rh - 90 * SCALE
    bar_h = 45 * SCALE
    import random
    random.seed(42)
    bx = rx + 50 * SCALE
    while bx < rx + rw - 50 * SCALE:
        bw = random.choice([2, 4, 6]) * SCALE
        draw.rectangle([bx, bar_y, bx + bw, bar_y + bar_h], fill=C_DEEP_FOREST)
        bx += bw + random.choice([2, 3, 5]) * SCALE

    save_img(img, "macha_receipt_mockup.png", (600, 820))

# -------------------------------------------------------------------------
# 11. Café Cup & Sleeve Mockup
# -------------------------------------------------------------------------
def generate_cup_mockup():
    w, h = 700 * SCALE, 700 * SCALE
    img = Image.new('RGBA', (w, h), C_VANILLA_CREAM)
    draw = ImageDraw.Draw(img)

    cx, cy = w // 2, h // 2 + 30 * SCALE

    # Cup geometry: Paper coffee cup with Kraft sleeve
    # Cup top & bottom
    cw_top = 150 * SCALE
    cw_bot = 105 * SCALE
    cy_top = cy - 160 * SCALE
    cy_bot = cy + 180 * SCALE

    # Cup Body (Vanilla Cream with subtle shading)
    draw.polygon([
        (cx - cw_top, cy_top),
        (cx + cw_top, cy_top),
        (cx + cw_bot, cy_bot),
        (cx - cw_bot, cy_bot)
    ], fill=(250, 245, 238, 255))
    draw.ellipse([cx - cw_bot, cy_bot - 16*SCALE, cx + cw_bot, cy_bot + 16*SCALE], fill=(238, 232, 224, 255), outline=C_DEEP_FOREST, width=3*SCALE)
    draw.line([(cx - cw_top, cy_top), (cx - cw_bot, cy_bot)], fill=C_DEEP_FOREST, width=4*SCALE)
    draw.line([(cx + cw_top, cy_top), (cx + cw_bot, cy_bot)], fill=C_DEEP_FOREST, width=4*SCALE)

    # Kraft Corrugated Sleeve
    sy_top = cy - 40 * SCALE
    sy_bot = cy + 90 * SCALE
    sw_top = int(cw_top - (cw_top - cw_bot) * ((sy_top - cy_top) / (cy_bot - cy_top)))
    sw_bot = int(cw_top - (cw_top - cw_bot) * ((sy_bot - cy_top) / (cy_bot - cy_top)))

    draw.polygon([
        (cx - sw_top, sy_top),
        (cx + sw_top, sy_top),
        (cx + sw_bot, sy_bot),
        (cx - sw_bot, sy_bot)
    ], fill=C_DEEP_FOREST)

    # Embossed Wordmark on Sleeve
    cap_h = 36 * SCALE
    stroke = int(cap_h * 0.18)
    head_y = cy + 8 * SCALE

    w_m = int(cap_h * 1.05)
    w_lambda = int(cap_h * 0.96)
    w_c = int(cap_h * 0.88)
    w_h = int(cap_h * 0.88)
    w_a = int(cap_h * 0.96)
    kern = 7 * SCALE
    tot_w = w_m + w_lambda + w_c + w_h + w_a + (4 * kern)
    lx = cx - tot_w // 2

    lx += draw_letter_m(draw, lx, head_y, cap_h, stroke, C_VANILLA_CREAM) + kern
    lx += draw_letter_lambda(draw, lx, head_y, cap_h, stroke, C_MATCHA_GREEN, accent_color=C_SOFT_LAVENDER) + kern
    lx += draw_letter_c(draw, lx, head_y, cap_h, stroke, C_VANILLA_CREAM) + kern
    lx += draw_letter_h(draw, lx, head_y, cap_h, stroke, C_VANILLA_CREAM) + kern
    draw_letter_final_a(draw, lx, head_y, cap_h, stroke, C_VANILLA_CREAM)

    # Cup Lid (Sleek Matcha Green Drink Lid)
    lid_y = cy_top - 20 * SCALE
    draw.rounded_rectangle([cx - cw_top - 12*SCALE, lid_y, cx + cw_top + 12*SCALE, cy_top + 4*SCALE], radius=10*SCALE, fill=C_MATCHA_GREEN, outline=C_DEEP_FOREST, width=4*SCALE)
    draw.rounded_rectangle([cx - cw_top + 14*SCALE, lid_y - 22*SCALE, cx + cw_top - 14*SCALE, lid_y + 4*SCALE], radius=8*SCALE, fill=C_MATCHA_GREEN, outline=C_DEEP_FOREST, width=4*SCALE)

    save_img(img, "macha_cup_mockup.png", (700, 700))

if __name__ == '__main__':
    print("Beginning MΛCHA Brand Identity & Typographic generation...")
    generate_primary_wordmark()
    generate_dark_wordmark()
    generate_compact_wordmark()
    generate_lavender_wordmark()
    generate_standalone_symbol()
    generate_app_icon_forest()
    generate_app_icon_lavender()
    generate_geometry_spec()
    generate_color_palette()
    generate_receipt_mockup()
    generate_cup_mockup()
    print("All MΛCHA brand identity assets successfully generated!")
