// License: cc-by-sa-4.0 Author: holm / Christian Müller (https://mueller.network)

module Box() {
  // Innenmaße (global): Wand und Boden sind wall/2 dick
  innen = wall/2;
  stegdicke = 1;
  stegfuss = innen-0.5;                  // Stege stecken 0.5 im Boden
  quersteg_x = innen+11;
  zyl_x = quersteg_x+5.5;

// Box
  difference() {
    // Box
    translate([sphere,sphere,sphere])
    box();  
    
    // Obere harte Kante
    translate([-1,-1,vollehoehe])
    color("blue",0.7)
    cube([vollebreite+2,vollelaenge+2,sphere+1]);
  }
  
  // Hauptsteg
  difference() {
    //Hauptsteg: mittig, beidseitig 0.1 in der Wand
    translate([innen-0.1,(vollelaenge-stegdicke)/2,stegfuss]) 
    color("yellow")
    cube([vollebreite-wall+0.2,stegdicke,hoehe-0.7]);
    
    // Durchgriff
    translate([vollebreite/2+3.55,vollelaenge*0.5+2.5,vollehoehe-3])
    rotate([90,0,0])
    scale([2.25,1])
    cylinder(h=5,r=8.5);    
  }
  // Quersteg 1
  difference() {
    translate([quersteg_x,innen,stegfuss]) 
    color("magenta")
    cube([1,(vollelaenge-wall)/2+0.1,hoehe-0.7]); 
    
    // Durchgriff
    translate([quersteg_x-2.5,innen+3.5,vollehoehe/2])
    rotate([0,90,0])
    cylinder(h=4,r=2);}
      
  // Zyl gebraucht 2/2
  translate([zyl_x,vollelaenge/2-4/2,stegfuss]) 
    color("cyan")
    cylinder(h=vollehoehe-1.2-stegfuss, r1=3, r2=1.8);
}
  
module grundbox() {
  // Box
  color("purple",0.7)
  roundbox(breite,laenge,hoehe);

  // Halter: steht global auf z=0, unabhängig von der Rundung
  difference() {
    translate([-1-sphere,laenge/2,3.5-sphere])
    color("yellow")
    cube([10,4,7],true);
    rotate([270,0,0])
    translate([-2.75-sphere,sphere-3.4,laenge/2])
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
