depth=4;
thickness=2;
radius=3.5;
drill=2;
height=49;
width=58;
difference()
{
    union()
    {
        //add the mounting brackets
            cylinder(depth,radius,radius,$fn = 16);
        translate([0,height,0])
        {
            cylinder(depth,radius,radius,$fn = 16);
            translate([width,0,0])
                cylinder(depth,radius,radius,$fn = 16);
        }
        translate([width,0,0])
            cylinder(depth,radius,radius,$fn = 16);
        
        //add the walls
        translate([thickness-radius,thickness-radius,0])
            cube([width+2*(radius-thickness),height+2*(radius-thickness),thickness]);
        translate([-radius,0,0])
            cube([thickness,height,depth]);
        translate([width+(radius-thickness),0,0])
            cube([thickness,height,depth]);
        translate([0,-radius,0])
            cube([width,thickness,depth]);
        translate([0,height+(radius-thickness),0])
            cube([width,thickness,depth]);
    }
    
    //add the drill holes
    cylinder(depth,drill,drill,$fn = 16);
    translate([0,height,0])
        cylinder(depth,drill,drill,$fn = 16);
    translate([width,height,0])
        cylinder(depth,drill,drill,$fn = 16);
    translate([width,0,0])
        cylinder(depth,drill,drill,$fn = 16);
    
    //add slot for microsd
    translate([-radius,21-radius,depth-2])
        cube([16,15,3]);
}
