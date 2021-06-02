STL = false;
include <constant.scad>;
use <asset.scad>;
use <bottomleft.scad>;
use <bottomright.scad>;
use <bottomfront.scad>;
use <cap.scad>;
use <connector.scad>;
use <library/threads-library-by-cuiso-v1.scad>;

//BottomAll();
Bottom();
//translate([-19, 0, 85]) rotate(a=[0,0,0])Power();
//Demo();


module PrintTest(){
    difference(){
        Bottom();
        //translate([10,0,30]) rotate([0,0,0]) cube([150,150,150], center = true);
        translate([-20,49,40]) rotate([0,0,0]) cube([150,100,100], center = true);
    }
}

module Bottom(){
    union(){
        difference(){
            BottomAll();
            translate([0, 77, 50]) cube([100, 20, 200], center = true);
            translate([0, -77, 50]) cube([100, 20, 200], center = true);
       
            //Front cut
            translate([29, 0, 55]) rotate([0,90,0])
            linear_extrude(24){
                offset(r=5) square([53, 53], center = true);
            }
       
            // Holes to screw left and right parts
            translate([0, 0, 76+10]) rotate([90, 0, 0]) cylinder(300, 1.6, 1.6, center = true);
       
            //Hole to attach BottomFront
            translate([40, 0, 85]) cube([2,10,5], center = true);
        }
    }
}

module Demo(){
    difference(){
        translate([0, 0, 12]) color("yellow") Bottom();
        translate([0,50,50]) rotate([0,0,0]) cube([200,100,150], center = true);
        translate([0,150,50]) rotate([0,0,0]) cube([200,200,100], center = true);
    }
            translate([0, -20, 12]) BottomLeft();
            translate([0, 20, 12]) BottomRight(); 
            translate([50, 0, 0]) BottomFront(); 
            translate([-5.5, -32, 28]) rotate([90,-5,0]) Servo();
            translate([-5.5, 32, 28]) rotate([-90,-5,0]) Servo();
            translate([0, -49, 30]) Wheel();
            translate([0, 49, 30]) Wheel();
            translate([-74, 0, 14]) Ball(16);
            translate([-74, 0, 20]) Cap();
            translate([-19, 0, 85]) rotate(a=[0,0,0])Power();
}

module BottomAll(){
    union(){
        
        // Connectors to attach basehead
        for (angle = [60:360/3:420])
        translate([48 * cos(angle), 48 * sin(angle), 110]) rotate(a=[90,180,angle + 90]) InnerConnector();
                
        difference(){
            hull(){
                translate([0, 0, 70]) cylinder(40, 40, 45);
                hull(){

                    translate([0, 35, 55]) sphere(r=45);
                    translate([0, -35, 55]) sphere(r=45);
                    translate([-80, 0, 12]) sphere(r=12);
                }
            }
            translate([0, 0, 85]) cylinder(26, 44, 38);
            translate([-15, 0, 15]) cylinder(11, 20, 35);
            
            
               // For the nut
            for (angle = [60:360/3:420])
        translate([48 * cos(angle), 48 * sin(angle), 106.7]) rotate(a=[90,180,angle + 90]) cube([5.8, 2.9, 8], center = true);
         
            
            difference(){
                hull(){
                    translate([0, 35, 44+10]) sphere(r=43);
                    translate([0, -35, 44+10]) sphere(r=43);
                    translate([-20, 0, 44+10]) sphere(r=42); 
                }
                
                // Bottom plate
                translate([0, 0, 0+10]) cube([120, 88, 30], center = true);
            }
          
            // Cut for the power
            translate([-19, 0, 10]) linear_extrude(10){offset(r=1){
        square([20, 20], center=true);
            }
        }
            // Holes for the wheels
            translate([0, 0, -2]) linear_extrude(20+10){
               offset(r = 2)  projection() translate([0, -49, 0]) Wheel();
               offset(r = 2)  projection() translate([0, 49, 0]) Wheel();
            }   
       
            // Hole for the ball
            translate([-74, 0, 57]) sphere(11); 
            translate([-74, 0, 30]) cylinder(30, 11, 11);
            translate([-74, 0, 7]) rotate([0, 0, 0]) thread_for_nut(diameter = 20, length=30);
            translate([-74, 0, 2.25]) sphere(8.2);
            translate([-74, 0, 2.25]) cylinder(5, 8.2, 8.2);
            
            // 2 x holes for the servo
            translate([0, 0, -2]) rotate([0,-5, 0]) linear_extrude(15+10){
                offset(delta = .2)
                projection() translate([-5.5, -32, 6+10]) rotate([90,-5,0]) Servo();
                projection() translate([-5.5, 32, 6+10]) rotate([-90,-5,0]) Servo();
            }
        }
    }
}