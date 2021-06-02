STL = false;
include <constant.scad>;
use <bottom.scad>;

BottomRight();

module BottomRight(){
    union(){
        difference(){
            union(){
                intersection(){
                    BottomAll();
                    translate([0, 77, 50]) cube([100, 20, 200], center = true);
                }        
                // Flat surface for 3D printing
                translate([0, 65, 0]) rotate([-90,0,0]) linear_extrude(2){    
                    // Project to XY plane
                    projection() rotate([90,0,0]){
                        //Cut the right of the bottom ronot
                        intersection(){
                            BottomAll();
                            translate([0, 77, 50]) cube([100, 20, 100], center = true);
                        }
                    }   
                }   
            }
            // Holes to screw right part
            translate([0, 0, 75]) rotate([90, 0, 0]) cylinder(150, 1.6, 1.6, center = true);
        }
    }
}