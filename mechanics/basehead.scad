include <constant.scad>;
use <asset.scad>;
use <connector.scad>;

//Test();
// BUG in PrusaSlicer when hole = true. OK with Cura.
BaseHead(ball = 2.25, hole = false, height = 40);

module Test(){
    difference(){
        BaseHead(ball = 2.25, hole = true, height = 50);
        //translate([0,0,50+20]) cube([200,200,100], center = true);
        translate([100,0,0]) cube([200,200,100], center = true);
    }
    for (angle = [0:360/3:360])
    translate([41 * cos(angle), 41 * sin(angle), (50 - 8) / 2]) rotate(a=[-90,0,angle + 90])
    Bolt();
}

module BaseHead(ball = 2.25, hole = false, height = 20){
    if(height < 20) {height = 20;}
    union(){ // Probleme with PrusaSlicer that add a layer at the top !!! when hole is true            
      
        // Connectors to attach bottomtop
        for (angle = [0:360/3:360])
        translate([48 * cos(angle), 48 * sin(angle), 0]) rotate(a=[90,0,angle + 90]) RailConnector();

            /*    // To attach body
                for (angle = [0:360/3:360])
                translate([41 * cos(angle), 41 * sin(angle), (height - 8) / 2]) rotate(a=[0,0,angle + 90])
                cube([8, 8, height - 8], center = true);
*/

difference(){
    translate([0, 0, height]) rotate([180,0,0]) rotate_extrude(angle=360){
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
    }


            // To attach body
            for (angle = [0:360/3:360])
            translate([41 * cos(angle), 41 * sin(angle), height / 2 - 10]) rotate(a=[0,0,angle + 90])
            union(){
                // For the nut / écrou
                cube([5.8, 2.9, 20], center = true);
                // For the screw / vis
                translate([0,5,0]) cube([(2.85 + .3), 10, 20], center = true);     
            }
   
            // Holes
            if(hole){     
                Hole();
            }
        }
    }
}  

module Hole(height = 40){
    union(){
        for(k=[12, 132, 252],
            i=[5:10:height - 26],
            j=[k:90/8:90 + k]){
            translate([35*cos(j), 35*sin(j), i]) rotate([0,90,j ]) linear_extrude(15){
                circle(r = 1.6, $fn=6);
            }
            translate([35*cos(j+6), 35*sin(j+6), i + 5]) rotate([0,90,j+6 ]) linear_extrude(15){
                circle(r = 1.6, $fn=6);
            }
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