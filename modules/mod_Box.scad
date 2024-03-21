// License: cc-by-sa-4.0 Author: holm / Christian Müller (https://mueller.network)

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