include <constant.scad>;

translate([3, 3, 0]) HoneyComb(45, 3, 5, 1.5, 2);
    
module HoneyComb(radius, border, size, edge, height){

    // radius : total radius of the surface
    // border : between radius and surface of the honey comb
    // size : diameter of each honey comb (hole)
    // edge : thickness between two hexagone
    // height : thickness / height of the honeycomb 
    
    hexagone = size / 2 ;
    honeycomb = (size + 2*(edge - 1)) / 2;
         
    union() {
         
        difference() {  
            translate([0, 0, -4]) cylinder(h = height, r = radius, center = true); 
            translate([0, 0, -4]) cylinder(h = height + 3, r = radius - border, center = true); 
        }

        difference() {
            translate([0, 0, -4]) cylinder(h = height, r = radius, center = true);
            // /!\ Y axis of Openscad
            for (d=[-radius:honeycomb + hexagone:radius]){
                alpha=asin(d/(radius));
                c=(radius)*cos(alpha);
                
                // /!\ X axis of Openscad                
                for (y=[0:10 * honeycomb / 3:c]){
                    translate([d , y , -4]) rotate(a=[0,0,30]) cylinder($fn=6, h = height + 3, r = hexagone, center = true);
                   translate([d , -y, -4]) rotate(a=[0,0,30]) cylinder($fn=6, h = height + 3, r = hexagone, center = true);
                }
                for (y=[-honeycomb*2:10 * honeycomb / 3:c]){
                    cell_offset_x = 2.95 * honeycomb / 3;
                    cell_offset_y = 0.90 * honeycomb / 3;
                   translate([d + cell_offset_x, y + cell_offset_y, -4]) rotate(a=[0,0,30]) cylinder($fn=6, h = height + 3, r = hexagone, center = true);
                    translate([d + cell_offset_x, -y - cell_offset_y, -4]) rotate(a=[0,0,30]) cylinder($fn=6,h = height + 3, r = hexagone, center = true);
                }
            }  
        }
    }
}