vesa=100; //mm
drill=2.5; //radius, not diameter

l=sqrt(pow(drill*3,2)/2);
radius=(drill*3)*(vesa/2-l)/l;
$fn = 64; //number of faces on a circle

difference()
{
    union()
    {
        cylinder(3,radius+drill*3,radius+drill*3);
        for(x = [-1,1])
            for(y = [-1,1])
            translate([x*vesa/2,y*vesa/2,0])
                    cylinder(3,drill*3,drill*3);
    }
    for(x = [-1,1])
    {
        translate([x*vesa,0,0])
            cylinder(3,radius,radius);
        translate([0,x*vesa,0])
                    cylinder(3,radius,radius);
        for(y = [-1,1])
        {
            translate([x*vesa/2,y*vesa/2,0])
                    cylinder(4,drill,drill);


        }
    }
}