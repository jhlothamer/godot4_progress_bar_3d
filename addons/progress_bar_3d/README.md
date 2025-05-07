# ProgressBar3D for Godot 4
A simple 3d progress bar that uses a quad mesh plus a shader and employs no view ports. Great for use on 3D enemy characters as a health bar.

<br>
<p align="center">
<img src="readme_images/progress_bar_3d_in_action.png" />
</p>

## Installation
The scripts are available on the Godot asset library, so it can be installed via the AssetLib feature in the Godot 4 editor.

Alternatively you can download/clone this repo and copy the addon folder to your Godot 4 project folder.

## Properties

### Size
Size of quad mesh used for progress bar.

### Value
Current value.

### Min Value
Minimum value.

### Max Value
Maximum value.

### Background Color
Background color.

### Progress Color
Fill color.

### Unshaded*
Turns on, off shading of quad mesh.

### Shadows Disabled*
Turns on, off shadows of quad mesh.

### Depth Test Disabled*
Turns on, off depth test of quad mesh.

### Billboard Mode
Sets the quad mesh to face the camera (enabled), face camera but remain upright (fixed y) or disabled.

## *Implementation Note
This addon comes with a shader that has the following render modes set: unshaded, shadows_diabled, depth_test_disabled.

Whenever one of the corresponding properties to these render modes is toggled off, the default shader file is duplicated and this duplicate is modified.  This means that you'll see new shader resource files appear in the addon folder that weren't there at install time.  This process also requires that the render_mode line in the shipped shader is left exactly as is or this process will not work.

The reason new shader files are generated is so that the shaders are compiled once.  If they are stored as embedded resources in the scene file, as was done previously for this addon, each instance will cause a shader compile though the shader code is actually the same.

## Support
If you would like to support my development work to maintain this and other such projects you can do so at https://www.buymeacoffee.com/jlothamer.
<br>

<p align="center">
<img src="readme_images/bmc-logo-yellow-128.png" />
</p>


