// License: cc-by-sa-4.0 Author: holm / Christian Müller (https://mueller.network)

module Deckel(griff=false,spiegel=false,kante=false,ausschnitt=0,versatz=0) {
  translate([0,vollelaenge/2,0])
  difference() {
    union() {
      mirror_copy()
      translate([0,-vollelaenge/2,0])
      Deckelhaelfte(kante=kante,spiegel=spiegel,ausschnitt=ausschnitt,versatz=versatz);
    }
    if(griff) {
      scale([0.75,1.25,1])
      difference() {
        translate([8,0,vollehoehe+0.125])
        color("red")
        cylinder(h=1,r=6);
        translate([10.5,0,vollehoehe+0.125])
        color("blue")
        cylinder(h=1,r=5.5);
        translate([7.5,0-6.5,vollehoehe+0.125])
        color("magenta")
        cube([9,13,1]);
        //cube(4,true);
      }
      scale([0.75,1.25,1])
      difference() {
        translate([13,0,vollehoehe+0.125])
        color("red")
        cylinder(h=1,r=6);
        translate([15.5,0,vollehoehe+0.125])
        color("blue")
        cylinder(h=1,r=5.5);
        translate([12.5,0-6.5,vollehoehe+0.125])
        color("magenta")
        cube([9,13,1]);
        //cube(4,true);
      }
    }
  }
}

module Deckelhaelfte(kante=false,spiegel=false,ausschnitt=0,versatz=0) {
  difference() {
    // Deckelplatte
    
    translate([0,rundung/3,vollehoehe-2-ausschnitt])
    // color("lime")
    // cube([vollebreite-rundung/3,(vollelaenge-2*rundung/3)/2,wall/2+.1]);
    color("indigo")
    translate ([0-versatz,0,-2.5])
    minkowski(convexity=20) {
      cube([vollebreite-wall*0.75+versatz,(vollelaenge-2*rundung/3)/2,deckelstaerke]);
      //cube([40,15,1.5]);
      color("magenta")
      difference() {
        translate([1,1,2])
        sphere(1);
        translate([0,0,0])
        cube([2,2,2],false);
      }
    }
    
    // Spiegel
    if(spiegel) {
      translate([11.5,5,vollehoehe-deckelstaerke/2+1])
      color("lightblue")
      cube([vollebreite-rundung/3-16,vollelaenge/2-3,wall/2+1]);
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

