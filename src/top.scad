modelB=true; //raspi model B?
countersink = true; //countersink screwmount?
thickness=1.2; //wall thickness
drill=1.25; //screwmount drill

width= modelB ? 78 : 58;
depth=8.6;
height=49;
radius=3.5;
$fn = 64; //number of faces on a circle

difference()
{
    union()
    {
        //create outline
        difference()
        {
            union()
            {
                //walls and floor                 
                translate([-radius,0,0])
                    cube([width+2*radius,height,depth]);
                translate([0,-radius,0])
                    cube([width,height+2*radius,depth]);
            }
            
            //carve hollow
            translate([-radius+thickness,-radius+thickness,thickness+3])	//3mm filler on "top"
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
                
     //make room for components
     if(modelB)
     {
         //add slot for usb ports
         translate([width+radius-16,-radius+2,depth-16])
            cube([16,14,16]);
         translate([width+radius-16,-radius+20,depth-16])
            cube([16,14,16]);
         
         //add slot for network
         translate([width+radius-19.5,-radius+37.5,depth-16])
            cube([19.5,17,16]);
     }
    else
    {
        //add slot for usb port
        translate([width-12+radius,height-15-(24-radius),depth-8])
            cube([12,15,8]);
    }
    
    //add slot for audio jack
    translate([42+radius,height-13+radius,depth-7])
        cube([9,13,7]);
    
    //add slot for hdmi
    translate([17.5+radius,height-12+radius,depth-7])
        cube([16,12,7]);
    
    //add slot for usb power
    translate([6-radius,height-6-(-radius),depth-3])
        cube([10,6,3]);
    
    //add slot for status leds
    translate([-radius,height-7-(43-radius),depth-1])
        cube([2,7,1]);
    
    //add slot for connector
    translate([-0.5+radius,height-7-(height-radius),0])
        cube([52,7,depth]);
    
	//add slot for display header
    translate([1-radius,height-24-(-radius+16),depth-7])
        cube([5,24,7]);
    
    //add slot for camera header
    translate([36+radius,height-23-(-radius),depth-6])
        cube([5,23,6]);
}

   