thickness=1.6;
radius=3.5;
drill=0.85;
height=49;
width=85;
depth=thickness+2.5;
countersink = false;
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
    if(countersink==true)
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