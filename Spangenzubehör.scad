// Definitions
// *********************

detailgrad = 45;
wandstaerke = 5;
deckelstaerke = 2;
rundung = 4;
vollebreite = 60;
vollelaenge = 25;
vollehoehe = 20;

// Prozessvariablen
{
  wall = wandstaerke;
  $fn = detailgrad;
  sphere = rundung;
  breite = vollebreite-2*sphere;
  laenge = vollelaenge-2*sphere;
  hoehe = vollehoehe-sphere;
}

difference() {
  Box();
  Deckel();
}

scale([1,0.999,0.999])
translate([0, vollelaenge+10,-vollehoehe+wall/2]) {
  Deckel(griff=true,spiegel=true,kante=true);
}

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

module Box() {
// Box
  difference() {
    // Box
    translate([sphere,sphere,sphere])
    box();  
    
    // Obere harte Kante
    translate([0,0,vollehoehe])
    color("blue",0.7)
    cube([vollebreite,vollelaenge,sphere]);
  }
  
  // Hauptsteg
  difference() {
    //Hauptsteg
    translate([wall/2,vollelaenge*0.5,wall/2-0.5]) 
    color("yellow")
    cube([vollebreite-wall+0.1,1,hoehe-0.7]);
    
    // Durchgriff
    translate([vollebreite/2+3.55,vollelaenge*0.5+2.5,17])
    rotate([90,0,0])
    scale([2.25,1])
    cylinder(h=5,r=8.5);    
  }
  // Quersteg 1
  difference() {
    translate([13.5,wall/2,wall/2-0.5]) 
    color("magenta")
    cube([1,(vollelaenge-wall)/2+0.1,hoehe-0.7]); 
    
    // Durchgriff
    translate([11,wall*1.2,10])
    rotate([0,90,0])
    cylinder(h=4,r=2);}
      
  // Zyl gebraucht 2/2
  translate([19,vollelaenge/2-4/2,wall/2-0.5]) 
    color("cyan")
    cylinder(h=16.8, r1=3, r2=1.8);
}
  
module grundbox() {
  // Box
  color("purple",0.7)
  roundbox(breite,laenge,hoehe);

  // Halter
  difference() {
    translate([-5,laenge/2,-0.5])
    color("yellow")
    cube([10,4,7],true);
    rotate([270,0,0])
    translate([-6.75,0.6,laenge/2])
    color("green")
    cylinder(h=7,d=4,center=true);
  }
}

module box() {
  difference() {
    grundbox();
  
    // Innenausschnitt
    translate([wall/2,wall/2,wall/2])
    color("red",0.7)
    roundbox(breite-wall,laenge-wall,hoehe);

  }
}

module roundbox(w,h,d) {
  minkowski(){
    cube([w,h,d]);
    sphere(sphere);
  }
}

module mirror_copy(v = [0, 1, 0]) {
    children();
    mirror(v) children();
}