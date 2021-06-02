/*
Parameters used by each OpenSCAD files
$fa     default value 12, minimum 0.01
$fs     default value 2, minimum 0.01
*/

if(STL == true){
    /*
    For STL
    */

    $fn = 360;
    $fa = 1;
    $fs = 1;
    echo("3D printing parameters");
} else {
    /*
    Design or rapid rendering
    */

    $fn = 40;
    $fa = 12;
    $fs = 15;
    echo("Design or rapid rendering parameters");
}