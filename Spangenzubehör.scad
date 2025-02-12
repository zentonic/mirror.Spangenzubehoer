// License: cc-by-sa-4.0 Author: holm / Christian Müller (https://mueller.network)

// Definitions
// *********************
//

// TODO: Da ich kein Mathe kann, aber die Box gebraucht habe
// habe ich manche der Werte überschrieben und ignoriert.
// Die (Grund-)Box soll aber wieder parametrierbar werden.

detailgrad = 40;
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

include <modules/mod_Deckel.scad>;
include <modules/mod_Tools.scad>;
include <modules/mod_Box.scad>;

difference() {
  Box();
  Deckel(ausschnitt=0.3,versatz=5);
}

scale([1,0.999,0.999])
translate([0, vollelaenge+10,-vollehoehe+wall/2]) {
  Deckel(griff=true,spiegel=true,kante=false);
}


