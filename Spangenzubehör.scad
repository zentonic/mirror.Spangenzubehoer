// License: cc-by-sa-4.0 Author: holm / Christian Müller (https://mueller.network)

// Definitions
// *********************
//

detailgrad = 40;
wandstaerke = 2.5;    // reale Wanddicke der Box
deckelstaerke = 3;    // reale Dicke des Schiebedeckels
hinterschnitt = 0.4;  // wie weit der Rand über den Deckel greift (Arretierung)
rundung = 4;
vollebreite = 60;
vollelaenge = 25;
vollehoehe = 20;

// Prozessvariablen
{
  wall = 2*wandstaerke;
  $fn = detailgrad;
  // Deckel und Nut haben bewusst kein Spiel: Presssitz für robustes
  // Schieben und Arretieren durch flächigen Druck. Nuttiefe und Restwand
  // am Ende sind die bewährten Werte der Spangendose.
  P = sb_param(laenge=vollebreite, breite=vollelaenge, hoehe=vollehoehe,
               wand=wandstaerke, rundung=rundung,
               deckel_d=deckelstaerke, kante_r=1, hinterschnitt=hinterschnitt,
               nut_tiefe=wandstaerke-rundung/3, rest_ende=0.7*wandstaerke);
  hoehe = vollehoehe-rundung;
}

include <modules/mod_Schiebebox.scad>;
include <modules/mod_Deckel.scad>;
include <modules/mod_Box.scad>;

difference() {
  Box();
  sb_nut(P);
}

scale([1,0.999,0.999])
translate([0, vollelaenge+10, 0]) {
  Deckel(griff=true,spiegel=true);
}
