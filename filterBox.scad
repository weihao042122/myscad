long_in = 110;
width_in = 80;
height_in = 50;
thick = 4;
let_width = 17;

r1 = 7.4/2;
r0 = r1 - 1;

module box_top(){
    translate([thick/2-thick, thick/2, height_in-1]) {
        cube(size=[long_in+thick*2, width_in+thick, 3]);
    }
}

module box_body() {

    difference() {
        cube(size=[long_in+thick*2, width_in+thick*2, height_in+thick*2]);
        translate([thick, thick, thick]) {
            cube(size=[long_in, width_in, height_in+thick*2]);
        }

        for (i=[0:4]) {
            translate([thick*6, i*thick*3+thick*6, -thick]) {
                rotate([30, 0, 0]) {
                    cube(size=[long_in-thick*8, thick, thick*3]);
                }
            }
        }
    }
    rotate([-90, 0, 0]) {
        translate([20, -height_in+10, thick]) {
            difference(){
                h = width_in+thick*2+15;
                cylinder(r=r1, h=h, $fn=200);
                cylinder(r=r0, h=h+4, $fn=200);
            }
    
        }
        for (i=[0:2]) {
            translate([20, -height_in+10, thick*2+width_in+i*6]) {
                cylinder($fn=200, $fa = 12, $fs = 2, h = 6, r1 = 8.2/2, r2 = r1, center = false);
            }
        }
    }
}
module box() {
    difference(){
        box_body();
        rotate([-90, 0, 0]) {
            translate([20, -height_in+10, thick]) {
                    h = width_in+thick*2+25;
                    cylinder(r=r0, h=h+4, $fn=200);
        
            }

            translate([20, -height_in+r0/2+4, thick+18]){
                cube(size=[6, 6, 6]);
            }
            translate([20, -height_in+r0/2+4, thick+18+20]){
                cube(size=[6, 6, 6]);
            }
            translate([20, -height_in+r0/2+4, thick+18+40]){
                cube(size=[6, 6, 6]);
            }
        }
        box_top();
    }
}
module box_let(){
    rotate([0, 90, 0]) {
        cube(size=[let_width, width_in+thick*2, thick]);
        translate([0, thick*2, thick+thick]) {
            cube(size=[let_width, width_in, thick]);
        }

        translate([0, 0, thick+thick]) {
            cube(size=[let_width, thick, long_in]);
        }
        translate([0, thick+thick, thick+thick]) {
            cube(size=[let_width, thick, long_in]);
        }
    }
}


box();
box_let();

// box_top();


