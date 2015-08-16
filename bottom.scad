thickness=0.8;
radius=3.5;
drill=0.95;
height=49;
width=58;
depth=thickness+2;

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
            }
            translate([-radius+thickness,-radius+thickness,thickness])
                cube([width+2*(radius-thickness),height+2*(radius-thickness),depth]);
        }
        
        //add the mounting brackets
        cylinder(depth,radius,radius,$fn = 64);
        translate([0,height,0])
            cylinder(depth,radius,radius,$fn = 64);
        translate([width,height,0])
            cylinder(depth,radius,radius,$fn = 64);
        translate([width,0,0])
            cylinder(depth,radius,radius,$fn = 64);
    }

    //drill holes
    cylinder(depth,drill,drill,$fn = 64);
    translate([0,height,0])
        cylinder(depth,drill,drill,$fn = 64);
    translate([width,height,0])
        cylinder(depth,drill,drill,$fn = 64);
    translate([width,0,0])
        cylinder(depth,drill,drill,$fn = 64);
    
    //add slot for microsd
    translate([-radius,21-radius,depth-2])
        cube([16,15,2]);
}