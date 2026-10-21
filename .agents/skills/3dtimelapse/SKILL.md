---
name: 3dtimelapse
description: Assemble JPG timelapse frames into a 60fps H.264 MP4, rotated 270 degrees clockwise, with the last frame held for 2 seconds. Use when the user says /3dtimelapse or asks to join timelapse frames into a video.
---

# 3D Timelapse — frames to video

Turn a folder of `frame*.jpg` stills into a finished MP4: **60fps, 270° clockwise rotation, last frame held 2s**.

## Inputs

- Argument is a folder containing zero-padded JPG frames (e.g. `frame000001.jpg` … `frame001062.jpg`).
- Frame numbering may have gaps — never use the `frame%06d.jpg` sequence pattern (ffmpeg stops at the first gap).

## Pipeline

1. `cd` into the given frames folder. Verify with `ls frame*.jpg | wc -l` and check first/last file.
2. This project runs on **NixOS** — `ffmpeg`/`ffprobe` are generally not on PATH. Run them via:
   `nix shell nixpkgs#ffmpeg --command bash -c "<ffmpeg/ffprobe command>"`
3. Encode from the source frames (don't re-encode a previous MP4). Output goes **next to** the frames folder, named `<folder-basename>_60fps_rot270CW_hold2s.mp4`. Example: folder `timelapse__20261018_0044_frames` → sibling file `timelapse__20261018_0044_frames_60fps_rot270CW_hold2s.mp4` (or strip a trailing `_frames` if present).
4. Run ffmpeg with the glob demuxer (handles gaps), 60fps in and out, triple-transpose for 270° CW (= 90° CCW), `tpad` to clone the last frame for 2s, even-dimension scale for `yuv420p`, H.264 + faststart:

```bash
nix shell nixpkgs#ffmpeg --command bash -c "ffmpeg -y -framerate 60 -pattern_type glob -i 'frame*.jpg' -vf 'transpose=1,transpose=1,transpose=1,tpad=stop_mode=clone:stop_duration=2,scale=trunc(iw/2)*2:trunc(ih/2)*2' -c:v libx264 -pix_fmt yuv420p -crf 19 -preset medium -movflags +faststart -r 60 '<output.mp4>'"
```

Notes:
- `transpose=1` is 90° clockwise, so ×3 = 270° CW. A 640x480 source becomes 480x640 portrait.
- `tpad` adds 120 frames at 60fps = exactly 2s hold. Total frames = N + 120, duration = N/60 + 2.
- Keep `-crf 19 -preset medium` unless the user asks for smaller/larger files.

5. Verify with ffprobe and report resolution, fps, frame count, duration, and size:

```bash
nix shell nixpkgs#ffmpeg --command bash -c "ffprobe -v error -select_streams v:0 -show_entries stream=width,height,avg_frame_rate,duration,nb_frames -of default=noprint_wrappers=1 '<output.mp4>'"
```
