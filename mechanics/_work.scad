include <constant.scad>;
use <connector.scad>;
height = 40; ball = 2.25; hole = true;

   difference(){
            union(){
                //+2 due to the offset
                translate([37 + 2, 0 + 2, 0]) rotate([0,0,20]) offset(r=2){
                    square([45 - 37 - 3.70, 5 - 3.70]);
                }
                
                translate([38, 3, 0]) hull(){
                    square([7, 4]);
                    square([7, 5]);
                    translate([0, 3.5, 0]) circle(1);   
                }        
            }
            translate([37-.2,ball + 1,0]) circle(r=ball + .1);
        }

        difference(){           
            translate([37, 7,0]) square([8, height - 7]);
            translate([22.59,13.5,0]) Sector(16, [50, -25], 80);  
        }

module OldHole(height = 40){
    union(){
        for(k=[12, 132, 252],
            i=[5:10:height - 8],
            j=[k:90/8:90 + k]){
                    translate([41*cos(j), 41*sin(j), i]) rotate([0,90,j ]) cylinder(h = 15, r = 1.6, $fn=6, center = true);
                    translate([41*cos(j+6), 41*sin(j+6), i + 5]) rotate([0,90,j+6 ]) cylinder(h = 15, r = 1.6, $fn=6, center = true);
        }
    }
}



module Sector(radius, angles, fn = 24) {
    /*    
    radius = 20;
    angles = [45, 135];
    fn = 24;
    */
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}
