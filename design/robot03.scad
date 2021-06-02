/*
29/04/2021 - V3
Modification of the connectors, of the bottom
remove <../mechanic/topbody.scad>;
add <../mechanic/body.scad>;
remove <../mechanic/topbase.scad>;
remove <../mechanic/base.scad>;
add <../mechanic/bottom.scad>;

08/05/2020 - V2
Modification of Topbase after printing:
 - TopBase : honey comb, 
 - TopBase, Base : wheel holes to 10 mm and 2 mm additional space between servo support +/- 30 to +/- 32,  translate Connector by 2 mm/z to take in account the thickness
- Connector, Link : hole 1.25 to 1.3
- Link : increase the thickness

L. Louveau - 18/04/2020
Small robot with a head, a cylinder and a base for two wheels
All dimensions should be considered as mm (millimeter), so easy to 3D print

/!\ Small size difference between HC SR04 and Parallax Ping

http://edutechwiki.unige.ch/fr/Tutoriel_OpenSCAD#rotate

Code begining with # is the debugging mode of OpenSCAD
Can be used also with all modules. # Head();

Limits M3D Micro for printing:
4.6" x 4.3" x 4.5"
11,7 cm x 10,9 cm x 11,4 cm
*/

// From top to bottom of the bot
STL = false;
include <../mechanics/constant.scad>;
use <../mechanics/asset.scad>;
use <../mechanics/connector.scad>;
use <../mechanics/link.scad>;

use <../mechanics/headtop.scad>;
use <../mechanics/head.scad>;
use <../mechanics/bottomballbearing.scad>;
use <../mechanics/bottomballbearing_pinion.scad>;
use <../mechanics/basehead.scad>;
use <../mechanics/neck.scad>;
use <../mechanics/body.scad>;
use <../mechanics/bottom.scad>;

use <../mechanics/library/gears.scad>;

// Smaller the value, better the rendering. To be changed before rendering and exporting to STL

// Increase the speed: override the setup of ../mechanic/constant.scad
$fn = 20; // For STL 180
$fa = 50; // For STL 1

difference(){
    union(){
        translate([0, 0, 15])rotate(a=[0,0, -90])HeadTop();
        color("blue") translate([0, 0, 15])rotate(a=[0,0, -90]) HeadMiddle();
        translate([0, 0, 0])    HeadBottom();
 
        color("cyan", alpha=.4) translate([0, 0, -54])      rotate(a=[0,0,180]) BaseHead(hole = true, height = 40);

        color("cyan", alpha=.4) translate([0, 0, -45]) rotate(a=[0,0,180]) Neck(ball=2.25, hole=false, height=40);
        
        color("blue") translate([0, 0, -4.8]) rotate(a=[0,0, 3])       BottomBallBearing();
        translate([36.5, 0, -7.3]) Ball(4.5);
        
      
        translate([0, 0, -45.75]) rotate(a=[0,0,180]) union(){
            Body();
            translate([-9.75, 0, 13.75]) rotate(a=[0,-90,0]) Servo();
            translate([-31.5, 0, -35]) rotate(a=[180,-90,0]) Pinion();
        }

        //color("yellow", alpha=.4) 
        translate([0, 0, -165]) Bottom();
          
        translate([0, 0, -159]) union(){
            translate([-6, -31, 10]) rotate(a=[90,-5,0]) Servo();
            translate([-6, 31, 10]) rotate(a=[-90,-5,0]) Servo();
        }

        translate([-19, 0, -90]) rotate(a=[0,0,0]) Power(height = 120);
     
        translate([0, 0, -159]) union(){
            translate([-6 + 5, -31 + 80, 10]) Wheel();
            translate([-6 + 5, 31 - 80, 10]) Wheel();
        }
    }
    // Cut the front back
    //translate([-50, 48, -200]) cube([100,68,200]);
    //translate([-100, 0, -200]) cube([60,80,200]);    
    //Cut bearing/head/neck
    //translate([-100, 0, -100]) cube([160,80,200]); 
    //Half cut
    //translate([-100, 0, -200]) cube([200,80,300]);    
    
}

module Bot(){
    /* --------------------------------------------------
    For printing for plan
    Long to render ! 

    And a warning :
    Parsing design (AST generation)...
    Compiling design (CSG Tree generation)...
    Rendering Polygon Mesh using CGAL...
    WARNING: Scaling a 2D object with 0 - removing object
    Rendering cancelled on first warning.
    UI-WARNING: No top level geometry to render

    Remove the texts in 2D, no warning !!!
    Rendering duration: 00:53 - 01:25, 32 min
    */



   union(){
        translate([0, 0, 25])Head();
        translate([0, -27, 38]) rotate(a=[5,0, 0]) Ping();
        translate([0, 0, 0]) BaseHead();
        translate([0, 0, -28]) Body();
        translate([0, 0,-65])  rotate(a=[180,0, 0]) TopBase();
        translate([0, 0, -110]) union(){
            Base();
            translate([0, -13, 23.2/2 + 4]) rotate(a=[0,-90,90]) Servo();
            translate([0, 13, 23.2/2 + 4]) rotate(a=[0,-90,-90]) Servo();
        }
        translate([0, -32.6/4+2.4, -38]) rotate(a=[0,0,90]) Servo();
    }
   
    translate([19, 0, -100]) Power();
}

module TopView(){
 // Top views: 1/2 scale
    translate([-50, 0, 0]) rotate(a=[90,0,0]) scale(v = [0.5, 0.5, 0.5])    BaseHead();
    translate([-50, 0, -60]) rotate(a=[90,0,0]) scale(v = [0.5, 0.5, 0.5]) 
        Body();
    translate([-100, 0, 0])  rotate(a=[90,0, 0]) scale(v = [0.5, 0.5, 0.5]) TopBase();
    translate([-100, 0, -60])rotate(a=[90,0, 0]) scale(v = [0.5, 0.5, 0.5]) Base();

}
/*
color("black")translate([-70, 0, -30]) rotate(a=[90,0,0]) text("BaseHead 1/2", size = 5);
color("black")translate([-70, 0, -90]) rotate(a=[90,0,0]) text("Body 1/2", size = 5);
color("black")translate([-120, 0, -30]) rotate(a=[90,0,0]) text("TopeBase 1/2", size = 5);
color("black")translate([-120, 0, -90]) rotate(a=[90,0,0]) text("Base 1/2", size = 5);
*/