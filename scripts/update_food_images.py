import os
import io
import urllib.request
from PIL import Image, ImageFilter, ImageDraw
import rembg

ITEMS = [
    {
        'key': 'food_day_1_monday',
        'url': 'https://images.unsplash.com/photo-1506372023823-741c83b836fe?w=800&q=85',
        'name': 'Artisanal Latte on Saucer'
    },
    {
        'key': 'food_day_5_friday',
        'url': 'https://images.unsplash.com/photo-1475090169767-40ed8d18f67d?w=800&q=85',
        'name': 'Gourmet Toasted Panini'
    },
    {
        'key': 'food_day_7_sunday',
        'url': 'https://images.unsplash.com/photo-1587314168485-3236d6710814?w=800&q=85',
        'name': 'French Strawberry Tart'
    }
]

for item in ITEMS:
    print(f"Processing {item['name']}...")
    req = urllib.request.Request(item['url'], headers={'User-Agent': 'Mozilla/5.0'})
    d = urllib.request.urlopen(req, timeout=15).read()
    raw = Image.open(io.BytesIO(d)).convert('RGB')
    
    cut = rembg.remove(raw)
    bbox = cut.getbbox()
    if bbox:
        cut = cut.crop(bbox)
        
    target_w, target_h = 480, 440
    cut.thumbnail((target_w - 40, target_h - 40), Image.Resampling.LANCZOS)
    
    final_canvas = Image.new('RGBA', (target_w, target_h), (0, 0, 0, 0))
    shadow = Image.new('RGBA', (target_w, target_h), (0, 0, 0, 0))
    s_draw = ImageDraw.Draw(shadow)
    cx = target_w // 2
    base_y = target_h - 25
    s_draw.ellipse([cx - 130, base_y - 20, cx + 130, base_y + 12], fill=(20, 14, 10, 85))
    shadow = shadow.filter(ImageFilter.GaussianBlur(12))
    final_canvas.paste(shadow, (0, 0), shadow)
    
    paste_x = (target_w - cut.width) // 2
    paste_y = (target_h - cut.height) - 20
    final_canvas.paste(cut, (paste_x, paste_y), cut)
    
    out_path = os.path.join('assets/food', f"{item['key']}.png")
    final_canvas.save(out_path, 'PNG')
    print(f"SAVED {out_path} {final_canvas.size}")

print("DONE ALL!")
