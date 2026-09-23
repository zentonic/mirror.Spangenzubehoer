// License: cc-by-sa-4.0 Author: holm / Christian Müller (https://mueller.network)

// Spangendosen-Deckel: Schiebedeckel (mod_Schiebebox) mit Griffmulde und
// Aussparung für Spiegelklebefolie. Druckposition, Oberseite bei z=deckelstaerke.
module Deckel(griff=false,spiegel=false,griff_tiefe=0.375,spiegeltiefe=0.5) {
  oben = sb(P,"deckel_d")-sb(P,"spiel");
  difference() {
    sb_deckel(P);

    if(griff)
    translate([0,vollelaenge/2,0])
    for (x0 = [8, 13]) {
      scale([0.75,1.25,1])
      difference() {
        translate([x0,0,oben-griff_tiefe])
        color("red")
        cylinder(h=1,r=6);
        translate([x0+2.5,0,oben-griff_tiefe])
        color("blue")
        cylinder(h=1,r=5.5);
        translate([x0-0.5,0-6.5,oben-griff_tiefe])
        color("magenta")
        cube([9,13,1]);
      }
    }

    // Spiegel
    if(spiegel) {
      translate([11.5,5,oben-spiegeltiefe])
      color("lightblue")
      cube([vollebreite-rundung/3-16,vollelaenge-10,spiegeltiefe+1]);
    }
  }
}
