use <asset.scad>;
use <connector.scad>;

Neck();

module Neck(ball = 2.25, hole = false, height = 40){
    difference(){
        union(){
            
            //Top with hole for ball bearing
            translate([0, 0, height-7]) rotate([180, 0, 0]) rotate_extrude(angle=360){
                difference(){
                    translate([38, 0, 0]) Sector(7, [-90, 0], 80);
                    translate([38, -ball-.2-1, 0]) rotate([0, 0, 0]) circle(r=ball+.1);
                }
            }

            rotate_extrude(angle=360){
                translate([38, 0, 0]) square([7, height-7]);
            }
            
            // Connectors to attach bottomtop
            for (angle = [0:360/3:360])
            translate([48*cos(angle), 48*sin(angle), 0]) rotate(a=[90, 0, angle + 90]) RailConnector();
        }

        translate([0, 0, 0]) 
        linear_extrude(height-7){
            for (angle = [0:360/3:360])
            translate([42 * cos(angle), 42 * sin(angle), 0]) rotate(a=[0,0,angle + 90])
            union(){
                // For the nut / écrou
                square([5.8, 2.9], center = true);
                // For the screw / vis
                translate([0,5,0]) square([(2.85 + .3), 10], center = true);    
            }
        }
        
        // BUG when slicing in PrusaSlicer.
        if(hole){
            poshole = 39;
            for(k=[12, 132, 252],
                i=[5:10:height - 8],
                j=[k:90/8:90 + k]){
                translate([poshole*cos(j), poshole*sin(j), i]) rotate([0,90,j ]) linear_extrude(15){
                    circle(r = 1.6, $fn=6);
                }
                translate([poshole*cos(j+6), poshole*sin(j+6), i + 5]) rotate([0,90,j+6 ]) linear_extrude(15){
                    circle(r = 1.6, $fn=6);
                }
            }
        }
    }
}