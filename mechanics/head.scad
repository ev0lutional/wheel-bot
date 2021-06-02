STL = true;
include <constant.scad>;

use <headtop.scad>;
use <asset.scad>;
use <connector.scad>;
use <./library/threads-library-by-cuiso-v1.scad>;

//translate([0, 0, 0]) HeadTop();

//translate([0, 25, 13]) rotate(a=[0,0,180]) Ping();
//translate([-25, 0, 13]) rotate(a=[0,0,90]) Micro();
//translate([25, 0, 13]) rotate(a=[0,0,-90]) Micro();




// To attach headtop
//for(i=[-90:360/3:360]) translate([31.7*cos(i),31.7*sin(i),31])rotate([180,0,i+90]) Bolt(11);

HeadMiddle();
//translate([0,0,-20+4]) HeadBottom();
//Design();

module Design(){
    difference(){
        union(){
        HeadMiddle();
        translate([0,0,-20+4]) HeadBottom();

        }
        translate([-91/2,0,-30]) cube([91,91,91]);
    }
}


module HeadMiddle(){
    h=45*2;
    z=45*cos(45);
    difference(){
        HeadBase();
        scale([1,.9,.90]) sphere(r = 42);
      
        //To reduce the thinkness at the bottom of the sphere
        //#translate([0,0,-10]) scale([.99,.99,1]) sphere(r = 42);
        
        //Back cut
        //translate([0,-91/2,0]) cube([70, 30, 39], center=true);
        
        //Top cut
        // Don't understand why z+6.3
        translate([0,0,z+6.3]) cube([91, 91, h/4], center=true);

        //Eyes
        translate([45*cos(90),45*sin(90),13])  rotate(a=[85,0,0]) Eyes(20);
        
        //Holes to attach headtop
        for(i=[-90:360/3:360])
        translate([31.5*cos(i),31.5*sin(i),10])
        rotate([0,0,i+90])
        cylinder(20, 3.2/2, 3.2/2);
        
        //Holes for ears
        translate([-44,0,12]) scale([.25,1,.75]) sphere(13);
        translate([44,0,12]) scale([.25,1,.75]) sphere(13);
        
        translate([-50, 0, 12]) rotate([0,90,0])
        linear_extrude(height = 100){
            translate([0, 0]) circle(r = (6+.1) / 2, $fn=180);
            translate([5.25, 6]) square([1.8, 3.4], center=true);
            translate([5.25, -6]) square([1.8, 3.4], center=true);
        }
        translate([-80/2, 0, 11]) rotate([0,90,0])
        linear_extrude(height = 80){
            square([8.5, 15.2], center=true);
        }
        
        //Attach to headbottom
        translate([0, 0, -18]) thread_for_nut(diameter=81, length=7);
    }
   
    // To attach headtop
    for(i=[-90:360/3:360])
    translate([31.5*cos(i),31.5*sin(i),26.9])
    rotate([-90,0,i+90])
    InnerConnector();
    
    //Support for microphones
    union(){
        difference(){
            translate([0, 0, 5]) cube([83,20,2], center=true);
            translate([14, 0, 3]) cylinder(5,(2.85+.1)/2, (2.85+.1)/2);
            translate([-14, 0, 3]) cylinder(5,(2.85+.1)/2, (2.85+.1)/2);
        }
        
        difference(){
            translate([0, 0, -38]) sphere(50);
            translate([0, 0, -38]) sphere(48);
            translate([0,0,16]) cube([100,30,20], center=true);
            translate([0,60,0]) cube([100,100,100], center=true);  
            translate([0,-60,0]) cube([100,100,100], center=true);
            translate([0,0,-62]) cube([100,100,100], center=true);
        }
    }
}        

module Eyes(height = 11){
    ping = (16.2 + .1)/2;
    hcsr04 = (15.9 + .1)/2;
    union(){
        linear_extrude(height){
        translate([-9/2 - ping,0,0]) circle(ping);
        translate([9/2+ping,0,0]) circle(ping);
        translate([-10.2/2 - hcsr04,0,0]) circle(hcsr04);
        translate([10.2/2 + hcsr04,0,0]) circle(hcsr04);
            
        }
    }
}

module HeadBottom(){
    union(){
        difference(){
            translate([0,0,-5])
     linear_extrude(height=4, scale=39/36){
                difference(){
                    circle(r=36);
                    circle(r=33.5);
                }
                
            }
        }
        
        //To attach to headmiddle
        difference(){
            translate([0,0,-2]) thread_for_screw(diameter=81, length=5);
            translate([0,0,-5]) cylinder(10, 36,36); 
        }
 
        // For ball bearing
        difference(){
            translate([-.1,0,-7])
            linear_extrude(height=3){
                difference(){
                    circle(r=34);
                    circle(r=18);
          
                for(i=[-90:360/3:360])
                    translate([21.5*cos(i),21.5*sin(i),0])
                    // Bolt: 2.9 mm diameter
                    circle(r=2.9/2+0.1);
                }
            }
            
            //To attach the neck
            for(i=[-90:360/3:360])
            translate([21.5*cos(i),21.5*sin(i),-4.5])
            scale([1.01, 1.01, 1]) Nut();
        }
        
        translate([.1,0,-7])
        rotate_extrude(angle=360){
            translate([35.9,0,0])
            rotate([0,0,90]) 
            difference(){
                    square([3,3]);
                    circle(r=2.05);
            }
        }
    }  
}

module HeadBase(){
    h=45*2;
    z=45*cos(45);
    difference(){
        hull(){    
            sphere(r = 45);
            translate([42*cos(90),42*sin(90),13]) rotate(a=[85,0,0]) Eyes(11);
        }
        
        //Bottom cut
        translate([0, 0, -h+50]) cube([91, 91, 45], center = true);
    }
    //Ears
    translate([-42,0,12]) scale([.25,1,.75]) sphere(15);
    translate([42,0,12]) scale([.25,1,.75]) sphere(15);
    
    // Flower for the noose
    translate([-6, 47, 0]) rotate([90,0,0])linear_extrude(5){
        text("\u273F",size="20",font="OpenSymbol");
    }
}