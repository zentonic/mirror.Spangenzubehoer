// License: cc-by-sa-4.0 Author: holm / Christian Müller (https://mueller.network)
//
// Beispiel: Schiebebox mit Kapsel-Umriss (Halbkreise an beiden Enden)

laenge = 70;
breite = 24;
hoehe = 16;
wand = 2;
rundung = 3;
deckel_d = 2.6;
hinterschnitt = 0.4;
restwand_zeigen = false;

$fn = 48;
P = sb_param(laenge=laenge, breite=breite, hoehe=hoehe, wand=wand,
             rundung=rundung, deckel_d=deckel_d, hinterschnitt=hinterschnitt);

include <../modules/mod_Schiebebox.scad>;

module kapsel() {
  hull() {
    translate([breite/2, breite/2]) circle(d=breite);
    translate([laenge-breite/2, breite/2]) circle(d=breite);
  }
}

difference() {
  sb_koerper(P) kapsel();
  sb_nut(P) kapsel();
}

translate([0, breite+8, 0]) sb_deckel(P) kapsel();

if (restwand_zeigen) translate([0,0,-2]) sb_restwand(P) kapsel();
