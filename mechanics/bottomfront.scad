STL = false;
include <constant.scad>;
use <bottom.scad>;

BottomFront();

module BottomFront(){
    union(){
        scale([1, 0.995, 0.995]) intersection(){
            BottomAll();
            translate([29, 0, 55]) rotate([0,90,0])
            linear_extrude(24){
                offset(r=5) square([53, 53], center = true);
            }
        }
        translate([40, 0, 85]) cube([1.8,9.8,5], center = true);
    }
}