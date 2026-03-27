#!/usr/bin/env python3
"""Omamos app icon — rounded square, mark only."""
import numpy as np
from PIL import Image, ImageDraw, ImageFont

SCALE  = 4
SZ     = 1024 * SCALE   # 4096px, downscale to 1024
CORNER = int(180 * SCALE)  # macOS-style corner radius (~17.5%)
OUT    = "/Users/el-kal/omamos/configs/images/icon.png"

FONT_DIR = "/Users/el-kal/Library/Application Support/Claude/local-agent-mode-sessions/skills-plugin/06c402f7-0ab8-45d0-b23e-773a3b732f69/fb3aac1d-ef8e-48da-b16d-867c148ef9a5/skills/canvas-design/canvas-fonts"

# Tokyo Night palette
BG     = (26,  27,  46)
BLUE   = (122, 162, 247)
PURPLE = (187, 154, 247)
CYAN   = (125, 207, 255)
GRID   = (34,  36,  60)

# --- Background ---
canvas = np.full((SZ, SZ, 4), (*BG, 255), dtype=np.uint8)

# Subtle dot grid
gap = 44 * SCALE
dr  = SCALE
for gy in range(gap, SZ - gap, gap):
    for gx in range(gap, SZ - gap, gap):
        canvas[max(0,gy-dr):gy+dr+1, max(0,gx-dr):gx+dr+1, :3] = GRID

# --- Gradient ring ---
cx = cy = SZ // 2
R  = int(360 * SCALE)   # large ring, fills the icon
T  = int(24  * SCALE)   # thickness

yy, xx = np.mgrid[0:SZ, 0:SZ]
dx   = (xx - cx).astype(np.float32)
dy   = (yy - cy).astype(np.float32)
dist = np.sqrt(dx**2 + dy**2)
ang  = np.arctan2(dy, dx)

t     = (np.sin(ang) + 1.0) / 2.0
r_col = (BLUE[0] + (PURPLE[0] - BLUE[0]) * t).astype(np.float32)
g_col = (BLUE[1] + (PURPLE[1] - BLUE[1]) * t).astype(np.float32)
b_col = np.full_like(t, BLUE[2], dtype=np.float32)

aa      = 3.0 * SCALE
half_t  = T / 2.0
falloff = np.abs(dist - R) - (half_t - aa)
alpha   = np.clip(1.0 - falloff / aa, 0.0, 1.0)
alpha[(dist < R - half_t - aa) | (dist > R + half_t + aa)] = 0.0

mask  = alpha > 0
bg_r  = canvas[mask, 0].astype(np.float32)
bg_g  = canvas[mask, 1].astype(np.float32)
bg_b  = canvas[mask, 2].astype(np.float32)
a     = alpha[mask]
canvas[mask, 0] = np.clip(r_col[mask] * a + bg_r * (1-a), 0, 255).astype(np.uint8)
canvas[mask, 1] = np.clip(g_col[mask] * a + bg_g * (1-a), 0, 255).astype(np.uint8)
canvas[mask, 2] = np.clip(b_col[mask] * a + bg_b * (1-a), 0, 255).astype(np.uint8)

# --- Chevron + cursor ---
img  = Image.fromarray(canvas, 'RGBA')
draw = ImageDraw.Draw(img)

arm   = int(155 * SCALE)
gap_c = int(32  * SCALE)
cur_w = int(48  * SCALE)
cur_h = int(100 * SCALE)
sw    = int(20  * SCALE)

total_span = 2 * arm + gap_c + cur_w
chev_x     = cx - total_span // 2 + arm
chev_y     = cy

draw.line([(chev_x - arm, chev_y - arm), (chev_x, chev_y)], fill=CYAN, width=sw)
draw.line([(chev_x, chev_y), (chev_x - arm, chev_y + arm)], fill=CYAN, width=sw)

r_cap = sw // 2
draw.ellipse([chev_x - r_cap, chev_y - r_cap, chev_x + r_cap, chev_y + r_cap], fill=CYAN)

cur_x = chev_x + gap_c
cur_y = chev_y - cur_h // 2
draw.rectangle([cur_x, cur_y, cur_x + cur_w, cur_y + cur_h], fill=CYAN)

# --- Rounded corner mask ---
mask_img = Image.new('L', (SZ, SZ), 0)
ImageDraw.Draw(mask_img).rounded_rectangle([0, 0, SZ-1, SZ-1], radius=CORNER, fill=255)
img.putalpha(mask_img)

# --- Downscale ---
out = img.resize((1024, 1024), Image.LANCZOS)
out.save(OUT)
print(f"Saved → {OUT}")
