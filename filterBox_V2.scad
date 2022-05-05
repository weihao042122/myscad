mink_r = 2;
long_in = 120-mink_r*2;
width_in = 75-mink_r*2;
height_in = 50;
thick = 3;
gap = 5.0;
let_width = 17;

r1 = 7.6/2;
r0 = r1 - 0.8;
r2 = r1 + 4;
r3 = r2 + 4;
rh = 20;
pipe_top_h = 10;

top_thick = 2.8;
pipe_out_l = 15;
pipe_out_h = 30;

module mink_cube(x,y,z,r){
    minkowski()
    {
        cube(size=[x, y, z/2]);
        cylinder(r=r, h=z/2, $fn=200);
    }
}

module box_body()
{
    difference(){
        mink_cube(long_in, width_in, height_in+let_width, mink_r);
        translate([thick, thick, thick]) {
            cube([long_in-thick*2, width_in-thick*2, height_in+let_width]);
        }
        pipe_out_su(r0, r1, pipe_out_l);
        pipe_out2_su(r0, r1, pipe_out_l);
    }
    offset = thick+2+gap;

    difference(){
        translate([-offset, 10, 0]){
            mink_cube(offset, (offset+width_in)*4/7, (height_in+let_width)/2, mink_r);
        }
        translate([-gap-mink_r, 5, -1]){
            cube(size=[gap, (width_in), let_width]);
        }
    }

    difference(){
        translate([10, -offset, 0]){
            mink_cube((offset+long_in)*5/7, (offset), (height_in+let_width)/2, mink_r);
        }

        translate([5, -gap-mink_r, -1]){
            cube(size=[long_in, gap, let_width]);
        }
    }
    translate([thick+r3*2, 0, 10]) {
        cube(size=[2.0, width_in, height_in-10]);
    }

}

module pipe_su(){
    cylinder(r=r0, h=height_in+let_width-pipe_top_h+r0, $fn=200);

    difference(){
        cylinder(r=r2, h=rh, $fn=200);
        cylinder(r=r1, h=rh, $fn=200);
    }
    translate([0, 0, height_in+let_width-pipe_top_h]) {
         rotate([-90, 0, 0]) {
             translate([0, 0, -r0]) {
                cylinder(r=r0, h=width_in-r3*2+r2+r0, $fn=200);
             }
         }
         
    }
}
module pipe_body(){
    cylinder(r=r3, h=rh+thick, $fn=200);
    cylinder(r=r1, h=height_in+let_width-pipe_top_h, $fn=200);
    translate([0, 0, height_in+let_width-pipe_top_h]) {
         cube(size=[r2+0.4, r2+0.4, r2+0.4], center=true);
         rotate([-90, 0, 0]) {
             translate([0, 0, r2/2]) {
                difference(){
                    cylinder(r=r1, h=width_in-r3*2+r2/2, $fn=200);
                    rotate([0, 0, 20]) {
                        for (i=[1:4]) {
                            translate([r0, r1, (r2+r0/2)*i]) {
                                cube(size=[r0*2, r0*2, r0*2], center=true);
                            }
                        }

                    }                    
                }
             }
         }
         
    }
    
}

module pipe(){
    difference(){
        pipe_body();
        pipe_su();
    }
    difference(){
        for (i=[0:2]) {
            translate([0, 0, i*6]) {
                cylinder($fn=200, $fa = 12, $fs = 2, h = 6, r1 = r1, r2 = 8.6/2);
            }
        }
        translate([0, 0, -2]) {
            cylinder(r=r1, h=height_in+let_width, $fn=200); 
        }
    }
}

module box_top(){
    translate([-mink_r-thick-3, -mink_r+2.4, height_in+let_width-top_thick-2.4]) {
        cube(size=[long_in+thick+3, width_in+thick-2.4*2, top_thick]);
    }

    // translate([-mink_r-thick+30, -mink_r+2.4, height_in+let_width-top_thick-3]) {
    //     #cube(size=[long_in+thick+3, width_in+thick-2.4*2, top_thick]);
    // }
}
module pipe_out_su(r0, r1,l){
    translate([long_in-r1-thick*2, width_in-thick*2, pipe_out_h+r1]) {
        rotate([-90, 0, 0]) {
            cylinder(r=r0, h=l+thick*3,$fn=200);
        }
    }
}
module pipe_out(r0, r1, l){
    difference(){
        translate([long_in-r1-thick*2, width_in, pipe_out_h+r1]) {
            rotate([-90, 0, 0]) {
                cylinder(r=r1, h=l,$fn=200);
            }
        }
        pipe_out_su(r0, r1, l);
    }
}

module pipe_out2_su(r0, r1, l){
    difference(){
        translate([long_in-thick*2, width_in-r1-thick*2, height_in+let_width-pipe_top_h+2]) {
            rotate([ 0, 90, 0]) {
                cylinder(r=r0/1.5, h=l+thick*3,$fn=200);
            }
        }
    }
}

module pipe_out_2(r0, r1, l){
    difference(){
        translate([long_in, width_in-r1-thick*2, height_in+let_width-pipe_top_h+2]) {
            rotate([ 0, 90, 0]) {
                cylinder(r=r1/1.5, h=l,$fn=200);
            }
        }
        pipe_out2_su(r0, r1, l);
    }
}

difference(){
    box_body();
    translate([r3+thick, r3+thick, 0]) {
        pipe_body();
    }
    box_top();
}
translate([r3+thick, r3+thick, 0]) {
    pipe();
}
pipe_out(r0, r1, pipe_out_l);
pipe_out_2(r0, r1, 3);
// box_top();