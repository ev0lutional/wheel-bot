include <constant.scad>;
use <library/gears.scad>;

Pinion();

module Pinion(){   
    bevel_gear_pair(modul=1, gear_teeth=61, pinion_teeth=25, axis_angle=90, tooth_width=5, gear_bore=49, pinion_bore=2.4*2+.1, pressure_angle = 25, helix_angle=20, together_built=false, draw_gear = false, draw_pinion = true);
}