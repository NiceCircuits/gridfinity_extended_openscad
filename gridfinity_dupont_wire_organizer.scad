// Gridfinity extended basic cup
// version 2024-02-17
//
// Source
// https://www.printables.com/model/630057-gridfinity-extended-openscad
//
// Documentation
// https://docs.ostat.com/docs/openscad/gridfinity-extended/basic-cup

include <modules/gridfinity_constants.scad>
use <modules/module_gridfinity_cup.scad>
use <modules/module_gridfinity_block.scad>

/*<!!start gridfinity_dupont_wire_organizer!!>*/
/* [General] */
// X dimension. grid units (multiples of 42mm) or mm.
width = [8, 0]; //0.1
// Y dimension. grid units (multiples of 42mm) or mm.
depth = [2, 0]; //0.1
// Z dimension excluding. grid units (multiples of 7mm) or mm.
height = [7, 0]; //0.1
// Wall thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
wall_thickness = 1.8;  // .01
//under size the bin top by this amount to allow for better stacking
headroom = 0.8; // 0.1

/* [Base] */
// Enable magnets
enable_magnets = false;
// Enable screws
enable_screws = false;
//size of magnet, diameter and height. Zack's original used 6.5 and 2.4
magnet_size = [6.5, 2.4];  // .1
//create relief for magnet removal
magnet_easy_release = "auto";//["off","auto","inner","outer"]
// Use with captive magnet for a 'refinded style' magnet
magnet_side_access = "disabled";//[disabled,left:"↰ left",right:"⬑ right"]
// raise the magnet void inside the part for print-in-magnets
magnet_captive_height = 0; // .1
// add a wavy pattern to the magnet hole
magnet_crush_depth = 0; //0.1
// add a chamfer to the magent hole
magnet_chamfer = 0; //0.1
//size of screw, diameter and height. Zack's original used 3 and 6
screw_size = [3, 6]; // .1
//size of center magnet, diameter and height.
center_magnet_size = [0,0];
// Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = 2;
//Only add attachments (magnets and screw) to box corners (prints faster).
box_corner_attachments_only = "enabled"; //["disabled","enabled","aligned"]
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 1.5;
cavity_floor_radius = -1;// .1
// Efficient floor option saves material and time, but the internal floor is not flat
efficient_floor = "on";//[off,on,rounded,smooth]
// AKA half pitch. Enable to subdivide bottom pads to allow sub-cell offsets
sub_pitch = 1; //[1:"disabled",2:"half pitch",3:"third pitch",4:"quarter pitch"]
// Removes the internal grid from base the shape
flat_base = "off"; // [off, gridfinity:gridfinity stackable, rounded]
// Remove floor to create a vertical spacer
spacer = false;
//Pads smaller than this will not be rendered as it interferes with the baseplate. Ensure appropriate support is added in slicer.
minimum_printable_pad_size = 0.2;

// Adjust the radius of the rounded flat base. -1 uses the corner radius.
flat_base_rounded_radius = -1;
// Add chamfer to the rounded bottom corner to make easier to print. -1 add auto 45deg.
flat_base_rounded_easyPrint = -1;
// grid position x
align_grid_x = "near";//[near, far]
// grid position y
align_grid_y = "near";//[near, far]

/* [Label] */
label_style = "disabled"; //[disabled: no label, normal:normal, gflabel:gflabel basic label, pred:pred - labels by pred, cullenect:Cullenect click labels V2,  cullenect_legacy:Cullenect click labels v1]
// Include overhang for labeling (and specify left/right/center justification)
label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
// Width, Depth, Height, Radius. Width in Gridfinity units of 42mm, Depth and Height in mm, radius in mm. Width of 0 uses full width. Height of 0 uses Depth, height of -1 uses depth*3/4.
// Enable labels on internal divider walls
label_dividers = "disabled"; //[disabled, horizontal, vertical, both]

label_size = [0,14,0,0.6]; // 0.01
// Size in mm of relief where appropriate. Width, depth, height, radius
label_relief = [0,0,0,0.6]; // 0.1
// wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
label_walls=[0,1,0,0];  //[0:1:1]

/* [Wall Pattern] */
// Grid wall patter
wallpattern_enabled=false;
// Style of the pattern
wallpattern_style = "hexgrid"; //[hexgrid, grid, slats, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset, kumiko_tobi_asanoha, kumiko_asanoha , kumiko_goma, kumiko_tsumiishi_kikko, kumiko_bishamon_kikkou, kumiko_mikado]
// Spacing between pattern
wallpattern_strength = 2; //0.1
// wall to enable on, front, back, left, right.
wallpattern_walls=[1,1,1,1];  //[0:1:1]
// rotate the grid
wallpattern_rotate_grid=false;
//Size of the hole
wallpattern_cell_size = [10,10]; //0.1
// Add the pattern to the dividers
wallpattern_dividers_enabled="disabled"; //[disabled, horizontal, vertical, both]
//Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:hex, 8:octo, 64:circle]
//Radius of corners
wallpattern_hole_radius = 0.5;
// pattern fill mode
wallpattern_fill = "none"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
// border around the wall pattern, default is wall thickness
wallpattern_border = 0;
// depth of imprint in mm, 0 = is wall width.
wallpattern_depth = 0; // 0.1
//grid pattern hole taper
wallpattern_pattern_grid_chamfer = 0; //0.1
//voronoi pattern noise,
wallpattern_pattern_voronoi_noise = 0.75; //0.01
//brick pattern center weight
wallpattern_pattern_brick_weight = 5;
//Kumiko pattern ratio of main wall to fill wall 
wallpattern_pattern_kumiko_fill_ratio = [0.5, 1]; //0.01
//$fs for floor pattern, min size face.
wallpattern_pattern_quality = 0.4;//0.1:0.1:2
wallpattern_colored = "disabled"; //[disabled, enabled, split:enabled and split from model]

/* [Wall Cutout] */
wallcutout_vertical ="disabled"; //[disabled, enabled, inneronly, wallsonly, frontonly, backonly]
// wallcoutout position -0.5: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_vertical_position=[-2,-0.5,-0.5,-0.5];  //0.01
//default will be binwidth/2
wallcutout_vertical_width=0;
wallcutout_vertical_angle=70;
//default will be binHeight. 0: radius, -1 floor, Positive: depth from top; Negative: ratio height/abs(value)
wallcutout_vertical_height=0; //0.1
wallcutout_vertical_corner_radius=5;
wallcutout_horizontal ="disabled"; //[disabled, enabled, inneronly, wallsonly, leftonly, rightonly]
// wallcoutout position -0.5: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_horizontal_position=[-2,-0.5,-0.5,-0.5];  //0.01
//default will be binwidth/2
wallcutout_horizontal_width=0;
wallcutout_horizontal_angle=70;
//default will be binHeight
wallcutout_horizontal_height=0; //0.1
wallcutout_horizontal_corner_radius=5;

/* [Extendable] */
extension_x_enabled = "disabled"; //[disabled, front, back]
extension_x_position = 0.5;
extension_y_enabled = "disabled"; //[disabled, front, back]
extension_y_position = 0.5;
extension_tabs_enabled = true;
//Tab size, height, width, thickness, style. width default is height, thickness default is 1.4, style {0,1,2}.
extension_tab_size= [10,0,0,0];

/* [Bottom Text] */
// Add bin size to bin bottom
text_1 = false;
// Font Size of text, in mm (0 will auto size)
text_size = 0; // 0.1
// Depth of text, in mm
text_depth = 0.3; // 0.01
// Offset of text , in mm
text_offset = [0, 0]; // 0.1
// Font to use
text_font = "Aldo";  // [Aldo, B612, "Open Sans", Ubuntu]
// Add free-form text line to bin bottom (printing date, serial, etc)
text_2 = false;
// Actual text to add
text_2_text = "Gridfinity Extended";

/* [debug] */
// Debug slice
cut = [0,0,0]; //0.1

// Enable loging of help messages during render.
enable_help = "disabled"; //[info,debug,trace]

/* [Model detail] */
// Work in progress,  Modify the default grid size. Will break compatibility
pitch = [42,42,7];  //[0:1:9999]
// clearance around the bin, will reduce the bin by this amount in mm.
clearance = [0.5, 0.5, 0];
// Assign colours to the bin
set_colour = "enable"; //[disabled, enable, preview, lip]
// Where to render the model
render_position = "center"; //[default,center,zero]
// Minimum angle for a fragment (fragments = 360/fa).  Low is more fragments
fa = 6;
// minimum size of a fragment.  Low is more fragments
fs = 0.4;
// number of fragments, overrides $fa and $fs
fn = 0;
// set random seed for
random_seed = 0; //0.0001
// force render on costly components
force_render = true;

/* [Combs] */
// Comb width in mm.
comb_width = 70.0; //1.0
// Comb pitch in mm.
comb_pitch = 3.8; //0.1
// Comb tooth width in mm
comb_tooth_width = 1.8; //0.1
// Diameter of the double teardrop head at the top of each tooth in mm
comb_head_diameter = 2.6; //0.1
// Height of the double teardrop head from bottom tip to top tip in mm (at least the diameter)
comb_head_height = 4.0; //0.1
// Comb thickness in mm.
comb_thickness = 4.0; //0.5
// Comb spacing in mm - measured on outter faces of combs
comb_spacing = 200.0; //1.0
// Clearance in mm between combs and base cavity
comb_clearance = 0.0; //0.05
// Extra floor material on both X sides of comb slots in mm, spans full bin depth in Y (stiffens the floor, never above floor level)
comb_slot_reinforcement = 2; //0.1
// Height of the solid comb base above the cavity floor in mm, teeth start above it
comb_base_above_floor = 2.0; //0.1
// Render combs in slots or on the buildplate
comb_render_in_slots=true;

/* [Hidden] */
module end_of_customizer_opts() {}
/*<!!end gridfinity_dupont_wire_organizer!!>*/

/* [Lip] */
// Style of the lip
lip_style = "normal";  // [ normal, reduced, reduced_double, minimum, none:not stackable ]
// Below this the inside of the lip will be reduced for easier access.
lip_side_relief_trigger = [1,1]; //0.1
// Create a relief in the lip
lip_top_relief_height = -1; // 0.1
// how much of the lip to retain on each end
lip_top_relief_width = -1; // 0.1
// add a notch to the lip to prevent sliding.
lip_top_notches  = true;
// enable lip clip for connection cups
lip_clip_position = "disabled"; //[disabled, intersection, center_wall, both]
//allow stacking when bin is not multiples of 42
lip_non_blocking = false;
height_includes_lip = false;

/* [Subdivisions] */
// Wall thickness [bottom, top]
chamber_wall_thickness = [1.2, 1.2]; //0.1
//Reduce the wall height by this amount
chamber_wall_headroom = 0;//0.1
// Radius of the top of the chamber wall, -ve is ratio of top wall thickenss. (disabled for bent walls)
chamber_wall_top_radius = 0; //0.1
//Reduce the wall height by this amount
vertical_chambers = 1;
vertical_separator_bend_separation = 0;
vertical_separator_bend_angle = 45;
vertical_separator_bend_position = 0;
vertical_separator_cut_depth=0;
horizontal_chambers = 1;
horizontal_separator_bend_separation = 0;
horizontal_separator_bend_angle = 45;
horizontal_separator_bend_position = 0;
horizontal_separator_cut_depth=0;
// Enable irregular subdivisions
vertical_irregular_subdivisions = false;
// Separator positions are defined in terms of grid units from the left end
vertical_separator_config = "10.5|21|42|50|60";
// Enable irregular subdivisions
horizontal_irregular_subdivisions = false;
// Separator positions are defined in terms of grid units from the left end
horizontal_separator_config = "10.5|21|42|50|60";

/* [Removable Divider Walls] */
divider_walls_enabled = false;
// Wall to enable on, x direction, y direction
divider_walls = [1,1]; //[0:1:1]
// Thickness of the divider walls.
divider_walls_thickness = 2.5;  //0.1
// Spacing between the divider walls (0=divider_walls_thickness*2).
divider_walls_spacing = 0; //0.1
// Thickness of the support walls (0=walls_thickness*2).
divider_walls_support_thickness = 2;
// Size of the slot in the divider walls. width(0=divider_walls_thickness), depth(0=divider_walls_support_thickness)
divider_wall_slot_size = [0,0];
// Clearance between the divider walls top
divider_headroom = 0.1;
// Clearance subtracted from the removable divider wall. Width, Length
divider_clearance = [0.3, 0.2];
// Number of slot spanning divider to generate.
divider_slot_spanning = 2;
// depth of wall cut, -ve relative to height
divider_wall_cutout_depth = 0; //0.1
// width of wall cut, -ve relative to length
divider_wall_cutout_width = 0; //0.1
// radius of wall cut, -ve relative to cut depth
divider_wall_cutout_radius = 0; //0.1
//radius of wall top, -ve relative to thickness
divider_top_radius = 0; //0.1
//add label to the divider wall  
divider_label_size = 0;

/* [Sliding Lid] */
sliding_lid_enabled = false;
// 0 = wall thickness *2
sliding_lid_thickness = 0; //0.1
// 0 = wall_thickness/2
sliding_lid_min_wall_thickness = 0;//0.1
// 0 = default_sliding_lid_thickness/2
sliding_lid_min_support = 0;//0.1
sliding_lid_clearance = 0.1;//0.1
sliding_lid_pull_style = "disabled"; //[disabled, lip, finger]
sliding_lid_nub_size = 0.5; //

/* [Finger Slide] */
// Include larger corner fillet
fingerslide = "none"; //[none, rounded, chamfered]
// Radius of the corner fillet, 0:none, >1: radius in mm, <0 dimention/abs(n) (i.e. -3 is 1/3 the width)
fingerslide_radius = -3;
// wall to enable on, front, back, left, right. 0: disabled; 1: enabled using radius; >1: override radius.
fingerslide_walls=[1,0,0,0];
//Align the fingerslide with the lip
fingerslide_lip_aligned=true;

/* [Tapered Corner] */
tapered_corner = "none"; //[none, rounded, chamfered]
tapered_corner_size = 10;
// Set back of the tapered corner, default is the gridfinity corner radius
tapered_setback = -1;//gridfinity_corner_radius/2;

/* [Floor Pattern] */
// enable Grid floor patter
floorpattern_enabled=false;
// Style of the pattern
floorpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset, kumiko_tobi_asanoha, kumiko_asanoha , kumiko_goma, kumiko_tsumiishi_kikko, kumiko_bishamon_kikkou, kumiko_mikado]*/
// Spacing between pattern
floorpattern_strength = 2; //0.1
// rotate the grid
floorpattern_rotate_grid = false;
//Size of the hole
floorpattern_cell_size = [10,10]; //0.1
//Number of sides of the hole op
floorpattern_hole_sides = 6; //[4:square, 6:hex, 8:octo, 64:circle]
//Radius of corners
floorpattern_hole_radius = 0.5;
// pattern fill mode
floorpattern_fill = "crop"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
// border around the wall pattern, default is wall thickness
floorpattern_border = 0;
// depth of imprint in mm, 0 = is wall width.
floorpattern_depth = 0; // 0.1
//grid pattern hole taper
floorpattern_pattern_grid_chamfer = 0; //0.1
//voronoi pattern noise,
floorpattern_pattern_voronoi_noise = 0.75; //0.01
//brick pattern center weight
floorpattern_pattern_brick_weight = 5;
//Kumiko ratio of main wall to fill wall 
floorpattern_pattern_kumiko_fill_ratio = 1;
//$fs for floor pattern, min size face.
floorpattern_pattern_quality = 0.4;//0.1:0.1:2
// Fill in solid block (overrides all following options)
filled_in = "disabled"; //[disabled, enabled, enabledfilllip:"Fill cup and lip"]


//Some online generators do not like direct setting of fa,fs,fn
$fa = fa;
$fs = fs;
$fn = fn;

module cup_environment() {
set_environment(
  width = width,
  depth = depth,
  height = height,
  height_includes_lip = height_includes_lip,
  lip_enabled = lip_style != "none",
  render_position = render_position,
  help = enable_help,
  pitch = pitch,
  clearance = clearance,
  cut = cut,
  setColour = set_colour,
  randomSeed = random_seed,
  force_render = force_render)
  children();
}

cup_base_settings = CupBaseSettings(
    magnetSize = enable_magnets?magnet_size:[0,0],
    magnetEasyRelease = magnet_easy_release,
    magnetSideAccess = magnet_side_access,
    magnetCaptiveHeight = magnet_captive_height,
    magnetCrushDepth = magnet_crush_depth,
    magnetChamfer = magnet_chamfer,
    centerMagnetSize = center_magnet_size,
    screwSize = enable_screws?screw_size:[0,0],
    holeOverhangRemedy = hole_overhang_remedy,
    cornerAttachmentsOnly = box_corner_attachments_only,
    floorThickness = floor_thickness,
    cavityFloorRadius = cavity_floor_radius,
    efficientFloor=efficient_floor,
    subPitch=sub_pitch,
    flatBase=flat_base,
    spacer=spacer,
    minimumPrintablePadSize=minimum_printable_pad_size,
    flatBaseRoundedRadius = flat_base_rounded_radius,
    flatBaseRoundedEasyPrint = flat_base_rounded_easyPrint,
    alignGrid = [align_grid_x, align_grid_y]
    );

// Top of the (efficient) floor, same as efficientFloorGridHeight in basic_cavity
comb_floor_top = max(
  enable_magnets ? magnet_size[1] : 0,
  enable_screws ? screw_size[1] : 0,
  gfBaseHeight()) + floor_thickness - fudgeFactor;

// Cup height in grid units, same as num_z in set_environment
comb_num_z =
  let(z_temp = calcDimension(height, "height", pitch.z, false))
  height_includes_lip && lip_style != "none" ? z_temp - gf_Lip_Height/pitch.z : z_temp;
// Combs stand on the slot bottom (z=0) and reach the cup top minus headroom,
// leaving space for the base of the next stacked cup
comb_height = pitch.z * comb_num_z - headroom;

// grow: [x, y] margin added on each side of the slot
module comb_slot(grow = [0, 0]) {
  for (side = [-1, 1])
    comb_slot_side(side, grow)
      children();
}

// side: -1 left, 1 right
module comb_slot_side(side, grow = [0, 0]) {
  translate([side * (comb_spacing - comb_thickness) / 2, 0, 0])
    translate([
      -(comb_thickness + comb_clearance) / 2 - grow.x,
      -(comb_width + comb_clearance) / 2 - grow.y,
      0
    ])
      children();
}

// Solid outer cup shape up to the floor top, unrestricted above it
module comb_clip_volume() {
  union() {
    intersection() {
      cup_environment()
        grid_block(
          env_numx(), env_numy(), env_numz(),
          cupBase_settings = cup_base_settings,
          wall_thickness = wall_thickness,
          filledin = "enabled");
      translate([-5000, -5000, -1])
        cube([10000, 10000, comb_floor_top + 1]);
    }
    translate([-5000, -5000, comb_floor_top - fudgeFactor])
      cube([10000, 10000, 10000]);
  }
}

// Rotate the whole model 45 degrees around Z
model_rotation = [0, 0, 45];

rotate(model_rotation)
difference() {
union() {
cup_environment()
gridfinity_cup(
  filled_in=filled_in,
  label_settings=LabelSettings(
    labelStyle=label_style,
    labelPosition=label_position,
    labelSize=label_size,
    labelRelief=label_relief,
    labelWalls=label_walls,
    labelDividers=label_dividers),
  finger_slide_settings = FingerSlideSettings(
    type = fingerslide,
    radius = fingerslide_radius,
    walls = fingerslide_walls,
    lip_aligned = fingerslide_lip_aligned),
  cupBase_settings = cup_base_settings,
  wall_thickness=wall_thickness,
  divider_wall_removable_settings = DividerRemovableSettings(
    enabled=divider_walls_enabled,
    walls=divider_walls,
    headroom=divider_headroom,
    support_thickness=divider_walls_support_thickness,
    slot_size=divider_wall_slot_size,
    divider_spacing=divider_walls_spacing,
    divider_thickness=divider_walls_thickness,
    divider_clearance=divider_clearance,
    divider_slot_spanning=divider_slot_spanning,
    divider_wall_cutout_depth = divider_wall_cutout_depth,
    divider_wall_cutout_width = divider_wall_cutout_width,
    divider_wall_cutout_radius = divider_wall_cutout_radius,
    divider_top_radius = divider_top_radius,
    divider_label_size = divider_label_size),
  vertical_chambers = ChamberSettings(
    chambers_count = vertical_chambers,
    chamber_wall_thickness = chamber_wall_thickness,
    chamber_wall_headroom = chamber_wall_headroom,
    chamber_wall_top_radius = chamber_wall_top_radius,
    separator_bend_position = vertical_separator_bend_position,
    separator_bend_angle = vertical_separator_bend_angle,
    separator_bend_separation = vertical_separator_bend_separation,
    separator_cut_depth = vertical_separator_cut_depth,
    irregular_subdivisions = vertical_irregular_subdivisions,
    separator_config = vertical_separator_config),
  horizontal_chambers = ChamberSettings(
    chambers_count = horizontal_chambers,
    chamber_wall_thickness = chamber_wall_thickness,
    chamber_wall_headroom = chamber_wall_headroom,
    chamber_wall_top_radius = chamber_wall_top_radius,
    separator_bend_position = horizontal_separator_bend_position,
    separator_bend_angle = horizontal_separator_bend_angle,
    separator_bend_separation = horizontal_separator_bend_separation,
    separator_cut_depth = horizontal_separator_cut_depth,
    irregular_subdivisions = horizontal_irregular_subdivisions,
    separator_config = horizontal_separator_config),
  lip_settings = LipSettings(
    lipStyle=lip_style,
    lipSideReliefTrigger=lip_side_relief_trigger,
    lipTopReliefHeight=lip_top_relief_height,
    lipTopReliefWidth=lip_top_relief_width,
    lipNotch=lip_top_notches,
    lipClipPosition=lip_clip_position,
    lipNonBlocking=lip_non_blocking),
  headroom=headroom,
  tapered_corner=tapered_corner,
  tapered_corner_size = tapered_corner_size,
  tapered_setback = tapered_setback,
  wallpattern_walls=wallpattern_walls,
  wallpattern_dividers_enabled=wallpattern_dividers_enabled,
  wall_pattern_settings = PatternSettings(
    patternEnabled = wallpattern_enabled,
    patternStyle = wallpattern_style,
    patternRotate = wallpattern_rotate_grid,
    patternFill = wallpattern_fill,
    patternBorder = wallpattern_border,
    patternDepth = wallpattern_depth,
    patternCellSize = wallpattern_cell_size,
    patternHoleSides = wallpattern_hole_sides,
    patternStrength = wallpattern_strength,
    patternHoleRadius = wallpattern_hole_radius,
    patternGridChamfer = wallpattern_pattern_grid_chamfer,
    patternVoronoiNoise = wallpattern_pattern_voronoi_noise,
    patternBrickWeight = wallpattern_pattern_brick_weight,
    patternKumikoFillRatio = wallpattern_pattern_kumiko_fill_ratio,
    patternFs = wallpattern_pattern_quality,
    patternColored = wallpattern_colored),
  floor_pattern_settings = PatternSettings(
    patternEnabled = floorpattern_enabled,
    patternStyle = floorpattern_style,
    patternRotate = floorpattern_rotate_grid,
    patternFill = floorpattern_fill,
    patternBorder = floorpattern_border,
    patternDepth = floorpattern_depth,
    patternCellSize = floorpattern_cell_size,
    patternHoleSides = floorpattern_hole_sides,
    patternStrength = floorpattern_strength,
    patternHoleRadius = floorpattern_hole_radius,
    patternGridChamfer = floorpattern_pattern_grid_chamfer,
    patternVoronoiNoise = floorpattern_pattern_voronoi_noise,
    patternBrickWeight = floorpattern_pattern_brick_weight,
    patternKumikoFillRatio = floorpattern_pattern_kumiko_fill_ratio,
    patternFs = floorpattern_pattern_quality),
  wallcutout_vertical_settings = WallCutoutSettings(
    type = wallcutout_vertical,
    position = wallcutout_vertical_position,
    width = wallcutout_vertical_width,
    angle = wallcutout_vertical_angle,
    height = wallcutout_vertical_height,
    corner_radius = wallcutout_vertical_corner_radius),
  wallcutout_horizontal_settings = WallCutoutSettings(
    type = wallcutout_horizontal,
    position = wallcutout_horizontal_position,
    width = wallcutout_horizontal_width,
    angle = wallcutout_horizontal_angle,
    height = wallcutout_horizontal_height,
    corner_radius = wallcutout_horizontal_corner_radius),
  extendable_Settings = ExtendableSettings(
    extendablexEnabled = extension_x_enabled,
    extendablexPosition = extension_x_position,
    extendableyEnabled = extension_y_enabled,
    extendableyPosition = extension_y_position,
    extendableTabsEnabled = extension_tabs_enabled,
    extendableTabSize = extension_tab_size),
  sliding_lid_settings = SlidingLidSettings(
    enabled = sliding_lid_enabled,
    thickness = sliding_lid_thickness,
    min_wall_thickness = sliding_lid_min_wall_thickness,
    min_support = sliding_lid_min_support,
    clearance = sliding_lid_clearance,
    pull_style = sliding_lid_pull_style,
    nub_size = sliding_lid_nub_size),
  cupBaseTextSettings = CupBaseTextSettings(
    baseTextLine1Enabled = text_1,
    baseTextLine2Enabled = text_2,
    baseTextLine2Value = text_2_text,
    baseTextFontSize = text_size,
    baseTextFont = text_font,
    baseTextDepth = text_depth,
    baseTextOffset = text_offset));

  // Floor reinforcement around comb slots, clipped to the outer base shape
  if (comb_slot_reinforcement > 0)
    intersection() {
      cup_environment()
        grid_block(
          env_numx(), env_numy(), env_numz(),
          cupBase_settings = cup_base_settings,
          wall_thickness = wall_thickness,
          filledin = "enabled");
      // Full bin depth in Y (oversized, clipped by grid_block)
      comb_slot([comb_slot_reinforcement, 1000])
        cube([
          comb_thickness + comb_clearance + 2 * comb_slot_reinforcement,
          comb_width + comb_clearance + 2 * 1000,
          comb_floor_top
        ]);
    }
}

  // Comb slots
  comb_slot()
    translate([0, 0, -0.01])
      cube([
        comb_thickness + comb_clearance,
        comb_width + comb_clearance,
        100
      ]);
}

// Solid comb base, from the slot bottom to above the cavity floor
comb_base_height = comb_floor_top + comb_base_above_floor;
// Teeth that fit within the comb width, centred along it
comb_tooth_count = floor((comb_width - max(comb_tooth_width, comb_head_diameter)) / comb_pitch) + 1;

// Single tooth with a double teardrop head (vertically symmetric, top tip
// ending at height), centred on x = 0, standing on y = 0 (comb local coordinates)
module comb_tooth(height) {
  head_half_height = max(comb_head_height, comb_head_diameter) / 2;
  head_center = height - head_half_height;
  translate([-comb_tooth_width / 2, 0, 0])
    cube([comb_tooth_width, head_center, comb_thickness]);
  translate([0, head_center, 0])
    linear_extrude(comb_thickness)
      hull() {
        circle(d = comb_head_diameter);
        for (tip = [-1, 1])
          translate([0, tip * head_half_height])
            square(0.01, center = true);
      }
}

// Comb local coordinates: x along width, y up, z through thickness
module comb() {
  // Base with chamfered side edges (both ends along width, both faces)
  chamfer = comb_thickness / 4;
  rotate([-90, 0, 0])
    linear_extrude(comb_base_height)
      // 2D y is -z after rotation
      polygon([
        [chamfer, 0], [comb_width - chamfer, 0],
        [comb_width, -chamfer], [comb_width, -(comb_thickness - chamfer)],
        [comb_width - chamfer, -comb_thickness], [chamfer, -comb_thickness],
        [0, -(comb_thickness - chamfer)], [0, -chamfer]
      ]);
  for (i = [0 : comb_tooth_count - 1])
    translate([
      comb_width / 2 + (i - (comb_tooth_count - 1) / 2) * comb_pitch,
      comb_base_height - fudgeFactor,
      0
    ])
      comb_tooth(comb_height - comb_base_height + fudgeFactor);
}

// Position of the comb's local origin when standing in its slot
function comb_origin(side) = [
  side * (comb_spacing - comb_thickness) / 2 - comb_thickness / 2,
  -comb_width / 2,
  0
];

// Comb standing upright in its slot, bottom clipped to the outer cup shape
module comb_in_slot(side) {
  intersection() {
    comb_clip_volume();
    // Stand comb upright in the slot: comb x -> Y, y -> Z, z -> X
    translate(comb_origin(side))
      multmatrix([[0, 0, 1, 0], [1, 0, 0, 0], [0, 1, 0, 0]])
        comb();
  }
}

rotate(model_rotation)
if (comb_render_in_slots)
  for (side = [-1, 1])
    comb_in_slot(side);
else
  for (side = [-1, 1])
    // Centre each comb at x = 0, y = ±(box depth + 10mm)
    translate([
      -comb_width / 2,
      side * (calcDimension(depth, "depth", pitch.y, false) * pitch.y) - comb_height / 2,
      0
    ])
      // Lay the clipped comb back flat: X -> z, Y -> x, Z -> y
      multmatrix([[0, 1, 0, 0], [0, 0, 1, 0], [1, 0, 0, 0]])
        translate(-comb_origin(side))
          comb_in_slot(side);
