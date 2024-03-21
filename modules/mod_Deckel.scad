// License: cc-by-sa-4.0 Author: holm / Christian Müller (https://mueller.network)

module Deckel(griff=false,spiegel=false,kante=false) {
  translate([0,vollelaenge/2,0])
  difference() {
    union() {
      mirror_copy()
      translate([0,-vollelaenge/2,0])
      Deckelhaelfte(kante,spiegel);
    }
    if(griff) {
      scale([0.75,1.25,1])
      difference() {
        translate([8,0,vollehoehe-0.3])
        color("red")
        cylinder(h=0.5,r=6);
        translate([10.5,0,vollehoehe-0.3])
        color("blue")
        cylinder(h=1,r=5.5);
        translate([7.5,0-6.5,vollehoehe-0.3])
        color("magenta")
        cube([9,13,0.5]);
        //cube(4,true);
      }
      scale([0.75,1.25,1])
      difference() {
        translate([13,0,vollehoehe-0.3])
        color("red")
        cylinder(h=1,r=6);
        translate([15.5,0,vollehoehe-0.3])
        color("blue")
        cylinder(h=1,r=5.5);
        translate([12.5,0-6.5,vollehoehe-0.3])
        color("magenta")
        cube([9,13,0.5]);
        //cube(4,true);
      }
    }
  }
}

module Deckelhaelfte(kante=false,spiegel=false) {
  difference() {
    // Deckelplatte
    translate([0,rundung/3,vollehoehe-wall/2])
    color("lime")
    cube([vollebreite-rundung/3,(vollelaenge-2*rundung/3)/2,wall/2+.1]);
    
    // Winkel 1
    translate([-1,rundung/3,vollehoehe-wall/2])
    color("brown")
    rotate([65,0,0])
    cube([vollebreite-rundung/3+2,wall,wall/2+1]);
        
    // Winkel 2
    translate([vollebreite-rundung/3*2,vollelaenge-2*rundung/3+wall,vollehoehe])
    color("brown")
    rotate([-65,0,-90])
    cube([vollebreite-rundung/3+2,wall,wall/2+1]);
    
    // Winkel 3
    translate([vollebreite-rundung/3-wall/2-1,-2,vollehoehe-wall/2-1])
    color("red")
    rotate([45,0,45])
    cube([10,wall,wall/2+1]);
    
    // Spiegel
    if(spiegel) {
      translate([11.5,5,vollehoehe-wall/2+1.5])
      color("lightblue")
      cube([vollebreite-rundung/3-16,vollelaenge-17.5,wall/2+1]);
    }
    
    // Kante
    if(kante) {
      translate([-1,-3.3,vollehoehe-wall/2])
      color("brown")
      cube([vollebreite-rundung/3+2,wall,wall/2+1]);
      
      translate([vollebreite+3.3,0,vollehoehe-wall/2])
      color("brown")
      rotate([0,0,90])
      cube([vollelaenge/2,wall,wall/2+1]);
        
      translate([0.5,0,vollehoehe-wall/2-1])
      color("brown")
      rotate([0,0,90])
      cube([vollelaenge/2,wall,wall/2+2]);
    }
  }
}

