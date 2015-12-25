countersink = false;     //countersink screwmount?
vesa=true;              //vesa mount? configure in vesa.scad and export as stl
modelB=false;           //raspi model B?
thickness=1.6;          //wall thickness
radius=3.5;             //screwmount radius
drill=1.25;              //screwmount drill


height=49;
width= modelB ? 85 : 58;
depth=thickness+2.5;
$fn = 64; //number of faces on a circle

difference()
{
    union()
    {
        //create walls
        difference()
        {

            union()
            {
                if(vesa)
                    translate([width/2,height/2,0])
                        import("vesa.stl");
                translate([-radius,0,0])
                    cube([width+2*radius,height,depth]);
                translate([0,-radius,0])
                    cube([width,height+2*radius,depth]);
                translate([width,height,0])
                    cylinder(depth,radius,radius);
                translate([width,0,0])
                    cylinder(depth,radius,radius);
                }
            translate([-radius+thickness,-radius+thickness,thickness])
                cube([width+2*(radius-thickness),height+2*(radius-thickness),depth]);
        }
        
        //add the mounting brackets
        cylinder(depth,radius,radius);
        translate([0,height,0])
            cylinder(depth,radius,radius);
        translate([58,height,0])
            cylinder(depth,radius,radius);
        translate([58,0,0])
            cylinder(depth,radius,radius);
    }

    //drill holes
    cylinder(depth,drill,drill);
    translate([0,height,0])
        cylinder(depth,drill,drill);
    translate([58,height,0])
        cylinder(depth,drill,drill);
    translate([58,0,0])
        cylinder(depth,drill,drill);
    
    //countersink
    if(countersink)
    {
        cylinder(drill,drill*2,drill);
        translate([0,height,0])
            cylinder(drill,drill*2,drill);
        translate([width,height,0])
            cylinder(drill,drill*2,drill);
        translate([width,0,0])
            cylinder(drill,drill*2,drill);
    }    
    
    //add slot for microsd
    translate([-radius,21-radius,depth-2])
        cube([16,15,2]);
}