fr1 = 7.6/2;     //filterBox 出水口外径
fr0 = fr1 - 0.8;  //filterBox 出水口内径
pipe_out_l = 15; //filterBox 出水口长度

r0 = fr1+0.4;
r1 = r0+0.8;
pl_1 = pipe_out_l;

pl_2 = 50;

$fn = 200;

module connecter1_su(r_in, r_out, l, r1_in, r1_out, l1){

    cylinder(r=r_in, h=l+(r_out-r_in)+r_in );

    translate([r_in, 0, l+r_in+(r_out-r_in)]) {
        rotate([0, 90, 0]) {
            cylinder(r=fr0, h=l1);
        }
    }
}

module connecter1(r_in, r_out, l, r1_in, r1_out, l1){

    cylinder(r=r_out, h=l);
    translate([0, 0, l+r_out]) {
        cube(size=[r_out*2, r_out*2, r_out*2], center=true);
    }

    translate([r_in, 0, l+r_in+(r_out-r_in)]) {
        rotate([0, 90, 0]) {
            cylinder(r=r1_out, h=l1);
        }
    }
}

//卡位
module gap(r_in, r_out, l, r1_in, r1_out, l1){
    translate([r_in, 0, l+r_in+(r_out-r_in)]) {        
        rotate([0, 90, 0]) {
            difference(){
                cylinder(r=r1_out, h=l1);
                translate([-r1_out, 0.4, 0]) {
                    cube(size=[r1_out*2, r1_out, l1]);
  
                }
                translate([-r1_out, -0.4-r1_out, 0]) {
                    cube(size=[r1_out*2, r1_out, l1]);
                }
                translate([-r1_out+0.6, -0.5, 0]) {
                    cube(size=[r1_out*2, 1, l1]);
                }
            }
        }
    }
}

// difference(){
//     connecter1(r0, r1, pipe_out_l-0.8, fr0, fr1+0.4, 50);
//     connecter1_su(r0, r1, pipe_out_l-0.8, fr0, fr1, 50);
    gap(r0, r1, pipe_out_l-0.8, fr0, fr1+0.4, 50);

// }

