include <constant.scad>;
use <asset.scad>;
use <connector.scad>;

Body();

module Body() {
    union(){
        translate([0, 0, 5]) AddThreeRailConnectors(37);
        difference(){
            linear_extrude(height=2){
                difference(){
                    circle(r=36.5);
                    
                    // To attach to basehead
                    for (angle = [0:360/3:360])
                    translate([40 * cos(angle), 40 * sin(angle)   , 0]) rotate(a=[0,0,angle + 90]) square([5.8+2+2+.4, 2.9+2+2+.4], center = true);    
                    
                    // First hole for wiring
                   hull(){
                        offset(r = 2) translate([-5, -28, 0]) square([17, 2]);
                        offset(r = 2) translate([0, -20, 0]) square([25, 2]);
                        offset(r = 2) translate([-24, -20, 0]) square([25, 2]);
                    }
                   
                    // Second hole for wiring
                    mirror([0,1,0])
                   hull(){
                        offset(r = 2) translate([-5, -28, 0]) square([17, 2]);
                        offset(r = 2) translate([0, -20, 0]) square([25, 2]);
                        offset(r = 2) translate([-24, -20, 0]) square([25, 2]);
                    }
                    
                    // For the pinion
                    translate([-30.5, -12.5, 0])
                    offset(r=2){
                        square([3, 25]);
                    }
                    
                    // For the servo
                    translate([-17.5, -5.75, 0]) square([4, 11.5]);
                                        
                    // Two small holes to attach the servo
                    translate([-8, -9, 0]) circle(r=2);
                    translate([-8, 9, 0]) circle(r=2);
                    
                    
                    // For the power pack
                    translate([9, -10, -2]) rotate(a=[0,0,0]) 
                    offset(r=1){
                        square([20, 20]);
                    }
                }
            }
        }
    }
}