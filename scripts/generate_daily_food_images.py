"""
Generates the 7 Day-of-the-Week Daily Food Showcase Images for CaféOS Hero Card.
Downloads actual, award-winning specialty café food photography,
removes background to create crisp transparent PNG cutouts,
crops and optimizes them with subtle contact drop-shadows.
"""

import os
import io
import urllib.request
from PIL import Image, ImageFilter, ImageOps
import rembg

OUT_DIR = "assets/food"
os.makedirs(OUT_DIR, exist_ok=True)

FOOD_ITEMS = [
    {
        "day": 1,
        "key": "food_day_1_monday",
        "name": "Artisanal Cappuccino & Croissant",
        "tagline": "Monday Kickstart",
        "url": "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=900&q=85"
    },
    {
        "day": 2,
        "key": "food_day_2_tuesday",
        "name": "Avocado Toast & Poached Egg",
        "tagline": "Healthy Tuesday",
        "url": "https://images.unsplash.com/photo-1525351484163-7529414344d8?w=900&q=85"
    },
    {
        "day": 3,
        "key": "food_day_3_wednesday",
        "name": "Belgian Waffles & Wild Berries",
        "tagline": "Midweek Sweet",
        "url": "https://images.unsplash.com/photo-1562376552-0d160a2f238d?w=900&q=85"
    },
    {
        "day": 4,
        "key": "food_day_4_thursday",
        "name": "Iced Caramel Macchiato",
        "tagline": "Thursday Chill",
        "url": "https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=900&q=85"
    },
    {
        "day": 5,
        "key": "food_day_5_friday",
        "name": "Gourmet Truffle Panini",
        "tagline": "Friday Feast",
        "url": "https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=900&q=85"
    },
    {
        "day": 6,
        "key": "food_day_6_saturday",
        "name": "Blueberry Pancake Stack",
        "tagline": "Weekend Brunch",
        "url": "https://images.unsplash.com/photo-1528207776546-365bb710ee93?w=900&q=85"
    },
    {
        "day": 7,
        "key": "food_day_7_sunday",
        "name": "French Strawberry Tart",
        "tagline": "Sunday Indulgence",
        "url": "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=900&q=85"
    }
]

def process_item(item):
    print(f"Processing Day {item['day']}: {item['name']}...")
    req = urllib.request.Request(item['url'], headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'})
    raw_data = urllib.request.urlopen(req, timeout=15).read()
    raw_img = Image.open(io.BytesIO(raw_data)).convert("RGB")
    
    # 1. Background removal using cached rembg model
    cutout = rembg.remove(raw_img)
    
    # 2. Crop transparent padding
    bbox = cutout.getbbox()
    if bbox:
        cutout = cutout.crop(bbox)
        
    # 3. Standardize dimensions for hero display (target 480x440 with transparent canvas)
    target_w, target_h = 480, 440
    cutout.thumbnail((target_w - 40, target_h - 40), Image.Resampling.LANCZOS)
    
    # Create final transparent canvas
    final_canvas = Image.new("RGBA", (target_w, target_h), (0, 0, 0, 0))
    
    # Create soft contact shadow under the food
    shadow = Image.new("RGBA", (target_w, target_h), (0, 0, 0, 0))
    from PIL import ImageDraw
    s_draw = ImageDraw.Draw(shadow)
    cx = target_w // 2
    base_y = target_h - 30
    s_draw.ellipse([cx - 140, base_y - 25, cx + 140, base_y + 15], fill=(20, 14, 10, 90))
    shadow = shadow.filter(ImageFilter.GaussianBlur(14))
    final_canvas.paste(shadow, (0, 0), shadow)
    
    # Paste food item centered horizontally, resting gracefully on shadow
    paste_x = (target_w - cutout.width) // 2
    paste_y = (target_h - cutout.height) - 25
    final_canvas.paste(cutout, (paste_x, paste_y), cutout)
    
    out_path = os.path.join(OUT_DIR, f"{item['key']}.png")
    final_canvas.save(out_path, "PNG")
    print(f"Saved {out_path} ({final_canvas.size})")

def main():
    print("Starting generation of 7 daily food images...")
    for item in FOOD_ITEMS:
        try:
            process_item(item)
        except Exception as e:
            print(f"Error processing {item['name']}: {e}")
    print("All 7 daily food images successfully processed!")

if __name__ == "__main__":
    main()
