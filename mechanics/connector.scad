use <constant.scad>;
use <asset.scad>;
use <link.scad>;

InnerConnector();
//translate([0,-10,0]) OuterConnector();
//translate([20,0,0]) RailConnector();


//Design();
//Demo();

//AddThreeInnerConnectors();

module Design(){
    color("green") difference(){
        union(){
            InnerConnector();
            OuterConnector();
        }
        translate([-2.5,0,0]) cube([5,15,15], center = true);
    }
    translate([0,-4.25,0]) rotate(a=[-90,0,0]) Bolt(10);
    translate([0,3.5,0]) rotate(a=[90,90,0]) Nut();
    color("blue") translate([2.8,0,0]) Link(20);
    color("blue") translate([-2.8,0,0]) Link(20);
}

module InnerConnector(){
    color("gray")    
    difference(){
        Connector();
        translate([0,-5,0]) rotate(a=[0,0,0]) cube([12, 10, 12], center = true);
        
        // For the link
      //  translate([-2.8,0,0]) rotate(a=[0,0,0]) cube([2.1, 2, 10], center = true);
        //translate([2.8,0,0]) rotate(a=[0,0,0]) cube([2.1, 2, 10], center = true);
    }
}

module OuterConnector(){
    color("gray")
    difference(){
        Connector();
        translate([0, 5, 0]) rotate(a=[0,0,0]) cube([12, 10, 12], center = true);
   
        // For the link
     //   translate([-2.8,0,0]) rotate(a=[0,0,0]) cube([2.1, 2, 10], center = true);
      //  translate([2.8,0,0]) rotate(a=[0,0,0]) cube([2.1, 2, 10], center = true);
    }
}


module RailConnector(){
    color("gray") rotate(a=[0,0,180])
    difference(){
        union(){
            Connector();
            translate([0, -5.7/2, -4]) rotate(a=[0,0,0]) cube([10, 5.7, 2], center = true);
        }
        translate([0, 5, 0]) rotate(a=[0,0,0]) cube([12, 10, 12], center = true);
    }
}


module Connector(){
    union(){
        
        // The inner connector should be attach to each part
        difference(){
            translate([0, 4.2, -4]) rotate(a=[0,0,0]) cube([10, 5.7, 2], center = true);
            
            // Little hole to push the nut
            translate([0,3.5,-7]) rotate(a=[0,0,0]) cylinder(8,1.5,1.5);
        }
        
        difference(){
            hull(){
                sphere(5);
                linear_extrude(height = 6.5, center = true){
                    translate([0,2.2,0]) circle(4.8);
                }
            }
            
            // For the bolt
            translate([0,-2.5,0]) rotate(a=[90,0,0]) cylinder(4,2.8,2.8);
            translate([0,0,0]) rotate(a=[90,0,0]) cylinder(15,3.2/2,3.2/2, center = true);
            
            // For the nut
            translate([0,3.5,0.7]) rotate(a=[0,0,0]) cube([5.8, 2.9, 8], center = true);
           
            // Little hole to push the nut
            translate([0,3.5,-7]) rotate(a=[0,0,0]) cylinder(8,1.5,1.5);
        }
    }
}

module AddThreeInnerConnectors(radius = 46){
    // Three inner connectors to attach other parts
    translate([radius*cos(0),radius*sin(0),0]) rotate(a=[0,0,90]) InnerConnector();
    translate([radius*cos(120),radius*sin(120),0]) rotate(a=[0,0,-149]) InnerConnector();   
    translate([radius*cos(-120),radius*sin(-120),0]) rotate(a=[0,0,-30]) InnerConnector();  
}

module AddThreeHolesForInnerConnector(radius = 46){
    position = radius - 3.5;
    translate([position *cos(0)   , position *sin(0)   , -7]) cylinder(8,1.5,1.5);
    translate([position *cos(120) , position *sin(120) , -7]) cylinder(8,1.5,1.5);   
    translate([position *cos(-120), position *sin(-120), -7]) cylinder(8,1.5,1.5);
}

module AddThreeRailConnectors(radius = 46){
    // Three connectors to attach the body to basehead
    translate([radius*cos(0),radius*sin(0),0]) rotate(a=[0,0,90]) RailConnector();
    translate([radius*cos(120),radius*sin(120),0]) rotate(a=[0,0,-149]) RailConnector();   
    translate([radius*cos(-120),radius*sin(-120),0]) rotate(a=[0,0,-30]) RailConnector();
}