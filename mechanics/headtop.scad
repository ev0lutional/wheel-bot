include <constant.scad>;
use <asset.scad>;
use <head.scad>;

HeadTop();
//translate([-15,3,32]) rotate([0,155,0]) LDR();
//translate([15,3,32]) rotate([0,-155,0]) LDR();

//translate([49*sin(25),-3,49*cos(25)]) rotate(a=[180,25,0]) Bolt(h=9);
//translate([-(52*sin(25)),-3,52*cos(25)]) rotate(a=[180,-25,0]) Bolt(h=9);
/*
difference(){
translate([43*sin(25),-3,43*cos(25)]) rotate(a=[0,25,0]) Antenna();
    translate([0,-4,10]) cube([40,40,40]);
}
*/

//translate([-(45*sin(25)),-3,45*cos(25)]) rotate(a=[0,-25,0]) Antenna();

module HeadTop(){
    h=45*2;
    z=45*cos(45);
    union() {

        difference(){
           translate([-15,27,32.5]) rotate(a=[90,0,0]) cylinder(10, 7/2, 7/2);
           translate([-15,35,32.5]) rotate(a=[90,0,0]) cylinder(20, 5/2, 5/2);
        }
        
        difference(){
            translate([15,27,32.5]) rotate(a=[90,0,0]) cylinder(10, 7/2, 7/2);
            translate([15,35,32.5]) rotate(a=[90,0,0]) cylinder(20, 5/2, 5/2);
        }
        
        difference() {
            HeadBase();;
   
            translate([15,35,32.5]) rotate(a=[90,0,0]) cylinder(20, 5/2, 5/2);
            translate([-15,35,32.5]) rotate(a=[90,0,0]) cylinder(20, 5/2, 5/2);
            
            //Holes for the LDR PCB
            translate([-16.5,0,36]) rotate([0,155,0])
            linear_extrude(15){
                offset(r=1) square([14, 33], center=true);
            }
            translate([16.5,0,36]) rotate([0,-155,0])
            linear_extrude(15){
                offset(r=1) square([14, 33], center=true);
            }
            
            translate([0,0,z-h/1.8]) cube([95, 95, h], center=true);
            
            // Holes to attach antenna and LDR
            translate([10*sin(25),-3,10*cos(25)]) rotate(a=[0,25,0]) cylinder(40,(2.85+.1)/2,(2.85+.1)/2);
            translate([-(10*sin(25)),-3,10*cos(25)]) rotate(a=[0,-25,0]) cylinder(40,(2.85+.1)/2,(2.85+.1)/2);
            
            translate([43*sin(25),-3,43*cos(25)]) rotate(a=[0,25,0]) cylinder(2,6.2/2,6.2/2);
            translate([-(43*sin(25)),-3,43*cos(25)]) rotate(a=[0,-25,0]) cylinder(2,6.2/2,6.2/2);
            
            //To attach the head
            translate([0,0,z-4]) linear_extrude(height=10){
                for(i=[-90:360/3:360])
                translate([31.5*cos(i),31.5*sin(i),0])
                circle(r=(5+.1)/2, $fn=180);
            }                     
            translate([0,0,z-10]) linear_extrude(height=30){
                for(i=[-90:360/3:360])
                translate([31.5*cos(i),31.5*sin(i),0])
                // Bolt: 2.9 mm diameter
                circle(r=(2.85+.1)/2);
            }    
        }  
    }
}

module Antenna(){
    difference(){
        union(){
            translate([0,0,3+2.5]) sphere(4);
            cylinder(3, 6/2, 6/2);
        }
        translate([0,0, 4]) cylinder(8, (5+.1)/2, (5+.1)/2);
        translate([0,0,-1]) cylinder(15, (2.85+.1)/2, (2.85+.1)/2);
    }
}  