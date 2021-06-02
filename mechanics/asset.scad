$fn = 80;
$fa = 10;

//Ball();
%Bolt(9);
//LDR();
//Micro();
//translate([0,0,10]) Nut();
//Ping();
//translate([10,10, 60]) Power(height = 120);
//Servo();
//Wheel();

module Ball(ball = 16){
    color("yellow") sphere(r=ball / 2);
}

module Bolt(h = 9){
    color("silver")
    union(){
        cylinder(1.55, 5/2, 5/2);
        cylinder(h, 2.85/2, 2.85/2);
    }
}

module LDR(){
    translate([-14.7/2, -27.05/2, -7.9/2]) union(){
        color("blue")
        linear_extrude(height = 1.25){
            difference(){
                square([14.7, 27.05]);
                translate([14.7/2, 7.34]) circle(r = 3.12 / 2, $fn=180);
            }
        }
        color("darkblue")
        linear_extrude(height = 7.90){
            translate([14.7/2, 12.2]) square([6.97, 6.97]);
        }
        color("red")
        translate([14.7/2, 27.05+3, 4.85/2+1]) rotate([90,0,0]) cylinder(3, 4.85/2, 4.85/2);
    }
}

module Micro(){
    translate([-15.2/2, -36.4/2, -(11.63+2.04)/2]) union(){
        color("red")
        linear_extrude(height = 1.25){
            difference(){
                square([15.2, 36.4]);
                translate([15.2/2, 7.3]) circle(r = 3.12 / 2, $fn=180);
                translate([3.2, 36.4 - 5.36]) square([15.2-3.2*2, 5.36]);
            }
        }
        color("blue")
        linear_extrude(height = 11.63){
            translate([0, 10.87]) square([4.33, 9.46]);
        }
        color([.71, .651, .259])
        translate([2.27/2, 12.04, 11.63]) linear_extrude(height = 2.04){
            circle(r = 2.27 / 2, $fn=180);
        }
        color("silver")
        translate([15.2/2, 36.4, 8.5-6/2])  rotate([90,0,0])
        linear_extrude(height = 5.36){
            circle(r = 6 / 2, $fn=180);
        }
        
    }
}

module Nut(){
    color("silver")
    union(){
        linear_extrude(height = 2.4, center = true){
            difference(){
                circle(d = 6.20, $fn=6);    
                circle(r = 2.85 / 2, $fn=180);   
            }
        }
    }
}    

module Ping(){
    // Ping / Parallax : 16,3 mm of diameter   
    union() {
        color("blue")
        cube([45.7, 2, 18.8], center = true);
        
        color("white")
        translate([45.7/2 - 16.3/2 - 2, -15.3/2, 0])
        rotate(a=[90,0,0])
        cylinder(h = 15.3, r = 16.3/2, center = true);

        color("white")
        translate([-45.7/2 + 16.3/2 + 2, -15.3/2, 0])
        rotate(a=[90,0,0])
        cylinder(h = 15.3, r = 16.3/2, center = true);
    }
}

module Power(height = 120) {
    // Li ion power pack: 12 cm x 2 cm x 2 cm
    // Dimension include USB adaptater
    union() {
        color("grey")
        cube([20, 20, height], center = true);          
    }
}

module Sector(radius=20, angles=[45, 135], fn=24) {
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

module Servo() {
// Fitec FS90R
// https://cdn-shop.adafruit.com/product-files/2442/FS90R-V2.0_specs.pdf
    union() {
        color("blue")
        cube([23.2, 12.5, 23], center = true);
        color("white")
        translate([-32.6/2, -12.5 / 2, 23 - 16.4 - 2.4])
        cube([32.6, 12.5, 2.4]);
        color("blue")
        translate([23.2/2-12.5/2, 0, 23/2])   
        cylinder(h = 27.3-23, r = 12.5/2);
        color("white")
        translate([23.2/2-12.5/2, 0, 23/2+27.3-23])   
        cylinder(h = 2, r = 2.4); 
    }
}

module Wheel(){
    // Pololu wheel 8 mm x 60 mm
    //https://www.pololu.com/product/2819
    color("black")
    translate([0,4,0]) rotate([90,0,0])
    union(){
        linear_extrude(height=8){
            difference(){
                circle(r=30);
                circle(r=30-5/2);          
            }            
            for (a = [0:2:360])
            translate([(30)*cos(a), (30)*sin(a), 0]) rotate([0,0,a])
            square([0.5,0.5],center=true); 
        }

        translate([0,0,(8-1)/2])linear_extrude(height=1){
            difference(){
                circle(r=10);
                circle(r=2.5/2);
                translate([6,0,0]) circle(r=2.5/2);
                translate([-6,0,0]) circle(r=2.5/2);
            }
             
            for (a = [0:360/5:360])
            translate([(10+20/2-.35)*cos(a), (10+20/2-0.35)*sin(a), 0]) rotate([0,0,a]) 
            difference(){
                square([20,5],center=true);
                offset(r=1) square([10,1],center=true);
            }
        }
    }
}

