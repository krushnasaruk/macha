import os
import shutil
import numpy as np
from PIL import Image
from scipy import ndimage
import rembg

SHEET_PATH = 'Cute Bear Chef Pose Sheet.png'

# 4 rows, 3 cols panel bounds (insets away from grid lines)
ROWS = [
    (10, 330),
    (336, 654),
    (662, 978),
    (986, 1302),
]

COLS = [
    (10, 400),
    (406, 790),
    (796, 1188),
]

POSES = [
    # Row 0
    (0, 0, 'standing.png', '1. Standing (Counter Stance)'),
    (0, 1, 'sitting.png', '2. Sitting (Stool Relax)'),
    (0, 2, 'walking.png', '3. Walking (Gait Style)'),
    # Row 1
    (1, 0, 'leaning.png', '4. Leaning (Counter Elbow)'),
    (1, 1, 'waving.png', '5. Waving (Welcome)'),
    (1, 2, 'pointing.png', '6. Pointing (Interface Guide)'),
    # Row 2
    (2, 0, 'carrying.png', '7. Carrying (Supplies Box)'),
    (2, 1, 'holding.png', '8. Holding (Signature Drink)'),
    (2, 2, 'celebrating.png', '9. Celebrating (Arms High)'),
    # Row 3
    (3, 0, 'thinking.png', '10. Thinking (Chin Paw)'),
    (3, 1, 'cooking.png', '11. Cooking (Active Prep)'),
    (3, 2, 'resting.png', '12. Resting (Post-Rush Break)'),
]

def clean_panel_text(panel_arr):
    """Erase only small letter characters in the top-left area without touching the chef hat."""
    h_panel, w_panel = panel_arr.shape[:2]
    text_region_mask = np.zeros((h_panel, w_panel), dtype=bool)
    # Text is always at y < 35, x < 260
    text_region_mask[5:36, 10:min(260, w_panel)] = True

    dark = (panel_arr.mean(axis=2) < 200) & text_region_mask
    labeled, num_features = ndimage.label(dark)
    slcs = ndimage.find_objects(labeled)

    cleaned = panel_arr.copy()
    bg_color = [253, 248, 238]

    for feat_id, slc in enumerate(slcs, start=1):
        if slc is None:
            continue
        h = slc[0].stop - slc[0].start
        w = slc[1].stop - slc[1].start
        # Only erase small letter glyphs (not chef hat or large elements)
        if h < 24 and w < 24:
            mask_feat = (labeled == feat_id)
            mask_dilated = ndimage.binary_dilation(mask_feat, iterations=1)
            cleaned[mask_dilated] = bg_color

    return Image.fromarray(cleaned)

def extract_poses():
    print(f"Loading master pose sheet from {SHEET_PATH}...")
    im = Image.open(SHEET_PATH)
    
    os.makedirs('assets/mascot/poses', exist_ok=True)
    os.makedirs('assets/mascot/reference', exist_ok=True)
    
    # 1. Update reference sheet with exact user sheet
    shutil.copy(SHEET_PATH, 'assets/mascot/reference/pose_reference_sheet.png')
    brain_ref = 'C:/Users/Krushna/.gemini/antigravity/brain/4fb76ec5-3f1d-412f-95a8-2c457a094599/pose_reference_sheet.png'
    shutil.copy(SHEET_PATH, brain_ref)
    print("-> Updated pose_reference_sheet.png")

    # 2. Extract each of the 12 poses
    for r_idx, c_idx, filename, label in POSES:
        r1, r2 = ROWS[r_idx]
        c1, c2 = COLS[c_idx]
        
        panel = im.crop((c1, r1, c2, r2))
        cleaned_panel = clean_panel_text(np.array(panel))
        
        # Remove background
        transparent = rembg.remove(cleaned_panel)
        
        # Crop tightly to character bounding box with padding
        bbox = transparent.getbbox()
        if bbox:
            pad = 12
            bx1 = max(0, bbox[0] - pad)
            by1 = max(0, bbox[1] - pad)
            bx2 = min(transparent.width, bbox[2] + pad)
            by2 = min(transparent.height, bbox[3] + pad)
            final_img = transparent.crop((bx1, by1, bx2, by2))
        else:
            final_img = transparent
            
        out_path = os.path.join('assets/mascot/poses', filename)
        final_img.save(out_path)
        print(f"-> Extracted {label} => {out_path} ({final_img.size})")

    # 3. Create directional & registry aliases
    standing_path = 'assets/mascot/poses/standing.png'
    pointing_path = 'assets/mascot/poses/pointing.png'
    waving_path = 'assets/mascot/poses/waving.png'
    celebrating_path = 'assets/mascot/poses/celebrating.png'
    holding_path = 'assets/mascot/poses/holding.png'
    carrying_path = 'assets/mascot/poses/carrying.png'
    cooking_path = 'assets/mascot/poses/cooking.png'
    resting_path = 'assets/mascot/poses/resting.png'

    # standing_relaxed
    shutil.copy(standing_path, 'assets/mascot/poses/standing_relaxed.png')
    # master_character_transparent
    shutil.copy(standing_path, 'assets/mascot/reference/master_character_transparent.png')
    
    # pointing left and right
    shutil.copy(pointing_path, 'assets/mascot/poses/pointing_right.png')
    pointing_img = Image.open(pointing_path)
    pointing_left = pointing_img.transpose(Image.FLIP_LEFT_RIGHT)
    pointing_left.save('assets/mascot/poses/pointing_left.png')

    # looking corner (leaning flipped/cropped)
    leaning_img = Image.open('assets/mascot/poses/leaning.png')
    leaning_flipped = leaning_img.transpose(Image.FLIP_LEFT_RIGHT)
    leaning_flipped.save('assets/mascot/poses/looking_corner.png')

    # App interaction & state aliases
    os.makedirs('assets/mascot/app_interactions', exist_ok=True)
    os.makedirs('assets/mascot/chef_actions', exist_ok=True)
    os.makedirs('assets/mascot/application_states', exist_ok=True)

    shutil.copy(waving_path, 'assets/mascot/app_interactions/welcoming.png')
    shutil.copy(waving_path, 'assets/mascot/app_interactions/waving_hello.png')
    shutil.copy(pointing_path, 'assets/mascot/app_interactions/pointing_interface.png')
    shutil.copy(celebrating_path, 'assets/mascot/app_interactions/celebrating_task.png')
    shutil.copy(celebrating_path, 'assets/mascot/application_states/celebrating_success.png')

    shutil.copy(holding_path, 'assets/mascot/chef_actions/holding_coffee_cup.png')
    shutil.copy(carrying_path, 'assets/mascot/chef_actions/carrying_cake.png')
    shutil.copy(cooking_path, 'assets/mascot/chef_actions/cooking_pan.png')
    shutil.copy(cooking_path, 'assets/mascot/chef_actions/preparing_order.png')
    shutil.copy(resting_path, 'assets/mascot/chef_actions/relaxing_shift.png')

    print("All 12 poses extracted and aliases updated successfully!")

if __name__ == '__main__':
    extract_poses()
