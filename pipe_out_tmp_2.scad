
$fn=200;

module cube_connecter(r0, r1, l){
// r0向下开口，r1向x轴正方向开口
    l_t=(r0>r1?r0:r1)*2;
    //l = l_t+thick;
    difference(){

        translate([-l/2,-l/2,0]){
            cube([l,l,l]);
        }
        cylinder(r=r0, h=l_t);

        rotate([90, 0, 0]) translate([0,l/2,-l/2]){
            cylinder(r=r1, h=l_t);
        }
    }
}
// thick = 1.2;
// // R_out=8/2;
// R_out=pout_r1;
// R0=R_out+thick;
// C01_l = R0*2+thick*2;
// l0=15;
// R1=3.8;
// R1_t=R1+thick;
// l1=40;
// C12_l = R1*2+thick*2;
// R2=3.8;
// R2_t = R2 + thick;
// l2=60;



r1 = 7.6/2;
r0 = r1 - 0.8;

pout_r0 = r0+3;
pout_r1 = pout_r0+1.2;

thick = 0.8;
// R_out=8/2;
// R_out=pout_r1;
R_out=14.8/2;
R0=R_out+thick;
C01_l = R0*2+thick*2;
l0=8;
R1=R_out;
R1_t=R1+thick;
l1=55;
C12_l = R1*2+thick*2;
R2=R_out;
R2_t = R2 + thick;
l2=8;

rotate([0,90,0]) difference(){
    cylinder(r=R0,h=l0);
    cylinder(r=R_out, h=l0);
}
translate([l0+C01_l/2,0,-C01_l/2]) rotate([0,0,90]) cube_connecter(R1, R_out, C01_l);

translate([l0+C01_l/2,0,-C01_l/2]) rotate([0,-180,0]) difference(){
    cylinder(r=R1_t, h=l1);
    cylinder(r=R1, h=l1);
}


translate([l0+C01_l,0,-l1-C01_l/2-C12_l/2]) rotate([90,0,-90]) cube_connecter(R2, R1, R0*2+thick*2);

module ttt_gap(){
    rotate([0, 0, -90]) difference(){
        cylinder(r=R2, h=l2);
        translate([-R2, -R2-1.4, 0]) {
                cube(size=[R2*2, R2*2, l2]);
        }
    }
}
translate([l0+C01_l/2+C12_l/2, 0, -l1-C01_l/2-C12_l/2]) rotate([0, 90, 0]) difference(){
    cylinder(r=R2_t, h=l2);
    cylinder(r=R2, h=l2);
    // ttt_gap();
    // for (i=[1:5]) {
    //     translate([R2/2, -R2/2, i*10]) {
    //         #cube([R2, R2, R2]);    
    //     }
    // }

    // translate([R2/2, -R2/2, 10]) {
    //     cube([R2, R2*2/3, 55]);    
    // }
}
