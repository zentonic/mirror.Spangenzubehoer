// License: cc-by-sa-4.0 Author: holm / Christian Müller (https://mueller.network)

module Box() {
  // Innenmaße (global): Wand und Boden sind wall/2 dick
  innen = wall/2;
  stegdicke = 1;
  stegfuss = innen-0.5;                  // Stege stecken 0.5 im Boden
  // Hauptsteg bewusst aussermittig: Wachsfach (Passmass) schmaler als Buerstenfach
  steg_y = vollelaenge*0.5;
  quersteg_x = innen+11;
  zyl_x = quersteg_x+5.5;

  // Box (Schiebebox-Körper, Nut wird im Hauptfile abgezogen)
  color("purple",0.7)
  sb_koerper(P);

  // Halter mit Öse, steht auf z=0
  difference() {
    translate([-1,vollelaenge/2,3.5])
    color("yellow")
    cube([10,4,7],true);
    translate([-2.75,vollelaenge/2,3.4])
    rotate([270,0,0])
    color("green")
    cylinder(h=7,d=4,center=true);
    sb_innenraum(P);
  }
  
  // Hauptsteg
  difference() {
    //Hauptsteg: beidseitig 0.1 in der Wand
    translate([innen-0.1,steg_y,stegfuss]) 
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
      
  // Zyl gebraucht 2/2: Fuss bündig mit der Stegseite zum Wachsfach
  translate([zyl_x,steg_y+stegdicke-3,stegfuss]) 
    color("cyan")
    cylinder(h=vollehoehe-1.2-stegfuss, r1=3, r2=1.8);
}
