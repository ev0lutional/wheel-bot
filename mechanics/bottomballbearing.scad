/*
30/08/2020 - Add gear with involute_gears.scad from MCAD
https://github.com/openscad/MCAD
See https://www.thingiverse.com/thing:3575
for explanations see the forum post :
http://forum.openscad.org/Tentative-basic-documentation-for-gear-td13121.html
For minor corrections:
https://www.thingiverse.com/thing:3561972
*/


/*
https://engineerdog.com/2017/01/07/a-practical-guide-to-fdm-3d-printing-gears/
https://www.instructables.com/A-Practical-Guide-to-FDM-3D-Printing-Gears/

Voir l'outil de génération en ligne :
Bien mais payant !
https://geargenerator.com/#200,200,100,6,0,0,0,1,1,10,2.5,4,25,0,0,0,0,0,0,1,3,722

Très bien
http://joostn.github.io/OpenJsCad/


Other informations about gear and 3D printing :
- for 2:1, 15:31 (and not 15:30)
- tooth ratio between be between 0.2 and 5
- minimum 9 with 25 deg pressure angle --> best for 3D printing

Finally for the gear, use Inskape and Extension > Rendu > Engrenage
Utiliser les chemins qui permettent des opérations booléennes. Appuyer sur F2, cliquer sur le cercle et l'engrenage
Pour exporter un objet uniquement :
1) Propriétés du document > Redimensionner la page au contenu, cliquer sur le bouton Ajuster la page au dessin ou à la sélection
2) dans Zone de vue, dans X, indiquer la moitié de la largeur et dans Y, la moitié de la hauteur

and import the SVG

BEST : gears.scad
https://github.com/chrisspen/gears
*/

//https://www.thingiverse.com/thing:3575/files
//use <parametric_involute_gear_v5.1.scad>;

include <constant.scad>;
use <asset.scad>;
use <library/gears.scad>;
use <bottomballbearing_pinion.scad>;

BottomBallBearing();

//Demo();

module Demo(){
    difference(){
        union(){
            BottomBallBearing();
            translate([0, 0, -30]) rotate(a=[180,-90,0]) Servo();
        }
        translate([10, 10, -150]) cube([50,50,200]);
    }
   
    bevel_gear_pair(modul=1, gear_teeth=61, pinion_teeth=25, axis_angle=90, tooth_width=5, gear_bore=49, pinion_bore=4, pressure_angle = 25, helix_angle=20, together_built=true, draw_gear = false, draw_pinion = true);
    
}

module BottomBallBearing(){
    union(){
        translate([0,0,-6.1])
        linear_extrude(height=3.1){
            difference(){
                circle(r=34);
                circle(r=18);
      
            for(i=[0:360/4:360])
                translate([21.5*cos(i),21.5*sin(i),0])
            // Bolt: 2.9 mm diameter
            circle(r=2.9/2+0.1);
            }
        }
      
        translate([0,0,-3.1])
        rotate([0,180,0]) 
        rotate_extrude(angle=360){
            translate([36,0,0])
            rotate([0,0,90]) 
            difference(){
                    square([3,3]);
                    translate([-0.1,-0.1,0])
                    circle(r=2.05);
            }
    
        }
        /*
        translate([0,0,-6])
        linear_extrude(height=.9){
            difference(){
                circle(r=36);
                circle(r=30);
      
            for(i=[0:360/4:360])
                translate([31*cos(i),31*sin(i),0])
            /// Bolt: 2.9 mm diameter
            circle(r=2.9/2+0.1);
            }
        }*/
        translate([0, 0, -6]) rotate(a=[0,-180,0])    
        bevel_gear_pair(modul=1, gear_teeth=61, pinion_teeth=25, axis_angle=90, tooth_width=5, gear_bore=49, pinion_bore=2.4*2, pressure_angle = 25, helix_angle=20, together_built=false, draw_gear = true, draw_pinion = false);
    }
}