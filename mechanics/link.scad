include <constant.scad>;
use <connector.scad>;

//rotate(a=[90,0,0]) Link(200);

AddThreeInnerConnectors();
AddThreeLinks();

module Link(lenght = 10){
    color("lightgray")
    linear_extrude(height = lenght, center = true){
        offset(r=.2){
        square(size = [1.6, 1.6], center = true);
        }
    }
}

module AddThreeLinks(height = 150, radius = 46){
    // Three inner connectors to attach other parts
    translate([radius*cos(0),radius*sin(0 + 3.5),0]) rotate(a=[0,0,90]) Link(height);
    translate([radius*cos(0),radius*sin(0 - 3.5),0]) rotate(a=[0,0,90]) Link(height);
    
    translate([radius*cos(120 + 3.5),radius*sin(120 + 3.5),0]) rotate(a=[0,0,-149]) Link(height);
    translate([radius*cos(120 - 3.5),radius*sin(120 - 3.5),0]) rotate(a=[0,0,-149]) Link(height);
    
    translate([radius*cos(-120 + 3.5),radius*sin(-120 + 3.5),0]) rotate(a=[0,0,-30]) Link(height);
    translate([radius*cos(-120 - 3.5),radius*sin(-120 - 3.5),0]) rotate(a=[0,0,-30]) Link(height);
}
