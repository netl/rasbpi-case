countersink = false; //countersink screwmount?
vesa=false; //vesa mount? configure in vesa.scad and export as stl
modelB=true; //raspi model B?
zipties=false; //add holes for zipties
thickness=1.2; //wall thickness
drill=1; //screwmount drill

//these shouldn't need changing
radius=3.5; //screwmount radius
height=49;
width= modelB ? 78 : 58;
depth=thickness+2.5;
$fn = 64; //number of faces on a circle

difference() //finishing touches
{
    union() //add brackets etc
    {
        difference() //make hollow
        {
            union() //main shape
            {
                
                //walls and floor
                translate([-radius,0,0])
                    cube([width+2*radius,height,depth]);
                translate([0,-radius,0])
                    cube([width,height+2*radius,depth]);
                
                //add vesa mount if needed
                if(vesa)
                    translate([width/2,height/2,0])
                        import("../stl/vesa.stl");
            }
                
            //carve hollow
            translate([-radius+thickness,-radius+thickness,thickness])
                cube([width+2*(radius-thickness),height+2*(radius-thickness),depth]);
        }
                                
        //support into corners without mounts
        if(modelB)
            translate([width,0,0])
                difference()
                {
                    
                    //rounded corners
                    for(y = [0,height])
                        translate([0,y,0])
                            difference()
                            {
                                //for(n = [0,thickness]) does not work
                                cylinder(depth,radius,radius);
                                translate([0,0,thickness])
                                    cylinder(depth-thickness,radius-thickness,radius-thickness);
                            }
                        
                        //cleanup inside
                        translate([-radius,-radius+thickness,thickness])
                            cube([radius,height+radius+thickness,depth-thickness]);
                        translate([0,0,thickness])
                            cube([radius-thickness,height,depth-thickness]);
                }
        
        //add the mounting brackets
        for(x = [0,58])
            for(y = [0,height])
                translate([x,y,0])
                    cylinder(depth,radius,radius);
    }

    //drill and countersink mounting brackets
    for(x = [0,58])
            for(y = [0,height])
                translate([x,y,0])
                {
                    cylinder(depth,drill,drill);
                    if(countersink)
                        cylinder(drill,drill*2,drill);
                }
    
    //add slot for microsd
    translate([-radius,21-radius,depth-2])
        cube([16,15,2]);
                
    //holes for zipties
    if(zipties)
    translate([width/2,height/2,0])
    {
        
        //center hole
        translate([-15,-15,0])
            cube([30,30,thickness]);
        
        //edge holes
        for(n = [0 : 3])
            rotate([0,0,90*n])
                translate([height/2,-15,0])
                    cube([6,30,thickness*2]);
    }
}