// E3D V6/Lite6 groove mount holder
//
// Designed by Genie Kobayashi
// bitfab - Apr. 2015

$fn=64;

fix_bolt_width = 26; // length between two M3 bolts
push_out = 17; // nozzle location from back plate
groove_width = 6 -0.3; // E3D V6 = 6mm, V5 = 5.6mm, Clone = 5.8mm, MakerGear/J-Head/Prusa MK2 = 4.64mm

ring_dia = 24;
top_dia = 16 +0.3; 
groove_dia = 12 +0.3;
bolt_base_thickness = 5; // under M3 washer

slash_cut = groove_width > 5 ? 1.6 : 1.64; // V6 = 1.6, MakerGear = 1.64

module neck_holder(){
// heat sink
//translate([0, 0, -30])
//	 color([1,1,1]) cylinder(h = 26, r1 =(ring_dia-1)/2, r2 =ring_dia/2);
// heat block
//translate([-20+4.5, -8, -45])
//	 color([1,1,1]) cube([20,16,11.5]);

difference(){
union(){
// body
intersection(){
    translate([-push_out, 0, (6.7+groove_width)/2])rotate([90,0,90])
	cylinder(h = push_out, r =ring_dia/slash_cut, $fn =6);

    translate([-push_out, -ring_dia/2, 0])
	cube([push_out,ring_dia,6.7+groove_width]);
 }
// groove neck outer
	translate([0, 0, 0])
	cylinder(h = 1, r1 =(ring_dia-1)/2, r2 =ring_dia/2);

	translate([0, 0, 1])
	cylinder(h = 4.7+groove_width, r =ring_dia/2);

	translate([0, 0, 5.7+groove_width])
	cylinder(h = 1, r1 =ring_dia/2, r2=(ring_dia-1)/2);

//screw fixings - use washers
hull() {
    translate([-push_out, fix_bolt_width/2, (6.7+groove_width)/2])rotate([90,0,90])
	cylinder(h = push_out+bolt_base_thickness, r =8/2, $fn =32);

    translate([-push_out, -fix_bolt_width/2, (6.7+groove_width)/2])rotate([90,0,90])
	cylinder(h = push_out+bolt_base_thickness, r =8/2, $fn =32);
}

// mark front
intersection(){
	cylinder(h = 6.7+groove_width, r =(ring_dia+2)/2);

union() {
    translate([11, 0, 7.5])rotate([0,90,0])rotate([0,0,90])
	cylinder(h = 5, r =4.5/2, $fn =4);

    translate([11, 0, 5.5])rotate([0,90,0])
	cylinder(h = 5, r =6/2, $fn =32);
  }
 }
}
// groove neck inner
union(){
	translate([0, 0, -0.1])
	cylinder(h = 3.2, r =top_dia/2);

	translate([0, 0, 3])
	cylinder(h = 0+groove_width, r =groove_dia/2);

	translate([0, 0, 3+groove_width])
	cylinder(h = 4, r =top_dia/2);
}

// heat resist
translate([0, 0, 5.5])
for ( i = [0 : 11] )
	{
    rotate( i * 360 / 12)
    translate([0, 4, 0])
	cube([2,11,15], center = true);
	}
//screw holes
    translate([-push_out-1, fix_bolt_width/2, (6.7+groove_width)/2])rotate([90,0,90])
	cylinder(h = 30, r =3.4/2, $fn =32);

    translate([-push_out-1, -fix_bolt_width/2, (6.7+groove_width)/2])rotate([90,0,90])
	cylinder(h = 30, r =3.4/2, $fn =32);

//screw heads
    translate([bolt_base_thickness, fix_bolt_width/2, (6.7+groove_width)/2])rotate([90,0,90])
	cylinder(h = 5, r =8.3/2, $fn =32);

    translate([bolt_base_thickness, -fix_bolt_width/2, (6.7+groove_width)/2])rotate([90,0,90])
	cylinder(h = 5, r =8.3/2, $fn =32);

// mark back
    translate([-push_out-4, 0, 7.5])rotate([0,90,0])rotate([0,0,90])
	cylinder(h = 5, r =4.5/2, $fn =4);

    translate([-push_out-4, 0, 5.5])rotate([0,90,0])
	cylinder(h = 5, r =6/2, $fn =32);
 }
}

// split into two parts
difference(){
	neck_holder();

	translate([0, -20, -3])
	cube([20,41,20]);
}
intersection(){
	translate([1, 0, 0])
	neck_holder();

	translate([1, -20, -3])
	cube([20,41,20]);
}
