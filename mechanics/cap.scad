STL = false;
include <constant.scad>;

use <library/threads-library-by-cuiso-v1.scad>;

Cap();

module Cap(){
    // Cap of the ball
    difference(){
        union(){
            thread_for_screw(diameter = 20, length=25);
            translate([0, 0, 16]) cylinder(10, 8.2, 8.2);
        }
        translate([0, 0, -5]) sphere(8);
        translate([0, 0, 24]) cube([2, 5, 5], center = true);
    }
}