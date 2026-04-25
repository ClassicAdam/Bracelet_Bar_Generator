//  Bracelet Bar, v1.0.0
//  By ClassicAdam, 2026
//  https://github.com/ClassicAdam/Bracelet_Bar_Generator
//  https://www.printables.com/@ClassicAdam
//  https://makerworld.com/@ClassicAdam


/*
    This file is part of ClassicAdam's Bracelet Bar.

    ClassicAdam's Bracelet Bar is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    ClassicAdam's Bracelet Bar is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/


//  ====================
//  PARAMETERS
//  ====================

$fn=60;

/* [General Options] */
// Color
color = "#ffffff"; //color
// Design - Round Edge of Base
base_round_edge = true;
// Design - Frame
base_frame = true;
// Design - End Cap
bar_end_cap = true;

/* [Bar Dimensions] */
// Length
holder_length = 140;  //[20:1:200]
// Width / Diameter
holder_width = 40;  //[15:1:100]
// Height (from Base)
height_from_base = 55;  //[40:1:200]

/* [Base Dimensions] */
// Extended Length
base_length = 0;  //[0:0.2:50.0]
// Base Height
base_height = 5;  //[3.0:0.2:20.0]
// Base Width
base_width = 60;  //[40:1:200]


//  ====================
//  MODULES
//  ====================

module bracelet_holder() {
    color(color) {
        translate([0-height_from_base/2,0,1]) {
            bar();
            stem();
            base();
        }
    }
}

module base() {
    translate([height_from_base,0-base_width/2,1]) {
        difference() {
            union() {
                minkowski() {
                    union() {
                        cube([base_height,base_width,holder_length+base_length]);
                        // Round edge
                        if (base_round_edge) {
                            translate([0,base_width/2,holder_length+base_length]) {
                                rotate([0,90,0]) {
                                    scale([0.5,1,1]) {
                                        cylinder(h=base_height, r=base_width/2,$fn=120);
                                    }
                                }
                            }
                        }
                    }
                    sphere(1, $fn=32);
                }
            }
            // Design - Frame
            if (base_frame) {
                difference() {   
                    translate([-10.6,5,20]) {
                        cube([10,base_width-10,holder_length+base_length-25]);
                    }
                    translate([-10,6,21]) {
                        cube([10,base_width-12,holder_length+base_length-27]);
                    }
                }
            }
        }
    }
}

module bar() {
    $fn=120;
    difference() {
        union() {
            cylinder(h=holder_length, r=holder_width/2);
        }
        union() {
            cylinder(h=holder_length, r=holder_width/2-5);
            translate([0,-100,0]) {
                cube([200,200,300]);
            }
        }
    }
    // Rounding edges
    if (bar_end_cap) {
        translate([0,0,holder_length]) {
            rotate([0,0,90]) {
                rotate_extrude(angle=180) {
                    translate([holder_width/2-1.5,0,0]) {
                        circle(3.5);
                    }
                }
            }
        }
        translate([0,holder_width/2-1.5,holder_length]) {
            sphere(3.5);
        }
        translate([0,holder_width/2-2.5,0]) {
            cylinder(h=holder_length, r=2.5);
        }
        translate([0,0-holder_width/2+1.5,holder_length]) {
            sphere(3.5);
        }
        translate([0,0-holder_width/2+2.5,0]) {
            cylinder(h=holder_length, r=2.5);
        }
    }
}

module stem() {
    minkowski() {
        hull() {
            cylinder(h=10, r=holder_width/2-1);
            translate([height_from_base,0-base_width/2,0]) {
                cube([base_height,base_width,15]);
            }
        }
        sphere(1, $fn=32);
    }
}


//  ====================
//  MAIN
//  ====================

bracelet_holder();