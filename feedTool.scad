r_in = 65/2;
thick = 4;

l = 200;
TL1 = 25;

ttt = 12.3;      //药片直径

module ttt_box(thick){
    cube(size=[20, thick, 20]);
    cube(size=[thick, 20, 20]);
    cube(size=[20, 20, thick]);

    translate([0, 0, 20]) {
        difference(){
            cube(size=[20, 20, thick]);

            translate([20-thick*2-4, thick, 0]) {
                cube(size=[4, 20-thick*2, thick]);
            }
        }
    }

    translate([20-thick, 0, 0]) {
        cube(size=[thick, 20, 20]);
    }

    translate([0, 20-thick, 0]) {
        cube(size=[20, thick, 20]);
    }
}

cube(size=[l, 5, thick*2]);
translate([l, -5*2, 0]) {
    cube(size=[5, 5*3, thick*2]);
    translate([-TL1, -5, 0]) {
            cube(size=[TL1+5, 5, thick*2]);
    }
}
translate([l-75, 0, 0]) {
    cube(size=[5, 5*3, thick*2]);
    translate([0, 5*3, 0]) {
        cube(size=[30, 5, thick*2]);
    }
}

difference(){
    ttt_box(2);
    thick=2;
    for (j=[0:4]) {
        for (i=[0:2]) {
            translate([thick+thick*3*i, 0, thick+j*thick*2]) {
                cube(size=[thick*2, 20, thick]);
            }       
        }
    }
    for (j=[0:4]) {
        for (i=[0:2]) {
            translate([thick, thick+thick*3*i, thick+j*thick*2]) {
                cube(size=[20,thick*2, thick]);
            }       
        }
    }
    j=0;
    for (j=[0:3]) {
        for (i=[0:1]) {
            translate([thick+thick*3*i, thick+j*thick*2, 0]) {
               # cube(size=[thick, thick, 20+2*thick]);
            }       
        }
    }
}


translate([r_in*2, r_in*1.8, 0]) {
    difference(){
        cylinder(r=r_in+thick, h=5);
        cylinder(r=r_in, h=5);
    }
}