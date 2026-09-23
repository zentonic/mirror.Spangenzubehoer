// License: cc-by-sa-4.0 Author: holm / Christian Müller (https://mueller.network)
//
// Schiebebox: Box mit eingeschobenem, einrastendem Schiebedeckel.
//
// Mechanik
//   Der Deckel ist eine Platte der Dicke deckel_d, deren obere Kanten mit
//   kante_r gerundet sind. Er liegt in einer Nut, die nut_tiefe weit in die
//   Seitenwände greift (Auflage). Die Nutoberkante liegt `ueberstand` über
//   dem Rand. Der Rand schneidet dadurch in die Kantenrundung und greift um
//   `hinterschnitt` über den Deckel: Der Deckel rastet ein und wird durch
//   flächigen Druck gehalten. Nut und Deckel haben per Default kein Spiel
//   (Presssitz); `spiel` verkleinert nur den Deckel.
//
//   ueberstand = kante_r - sqrt(kante_r^2 - (kante_r - hinterschnitt)^2)
//
// Koordinaten
//   Außenumriss in [0,laenge] x [0,breite], Boden auf z=0, Rand bei z=hoehe.
//   Geöffnet wird zur Seite x=0; der Deckel gleitet entlang -x heraus.
//
// Umriss
//   Ohne Kind: Rechteck laenge x breite mit Eckradius `rundung`.
//   Mit 2D-Kind: das Kind ist der Außenumriss. Die Nut ist zur Öffnung hin
//   gerade durchgezogen; wird der Umriss zur Öffnung hin schmaler, schneidet
//   die Nut dort durch die Wand (sb_restwand() zeigt das).
//
// Benutzung
//   P = sb_param(laenge=60, breite=25, hoehe=20, wand=2.5, rundung=4);
//   difference() { union() { sb_koerper(P); /* Innenausbau */ } sb_nut(P); }
//   translate([0, 40, 0]) sb_deckel(P);          // Druckposition
//   // mit Umriss: sb_koerper(P) mein_umriss(); usw. für alle sb_-Module

function sb_param(laenge, breite, hoehe, wand, rundung,
                  deckel_d=3, kante_r=1, hinterschnitt=0.4,
                  nut_tiefe=undef, rest_ende=undef, spiel=0) =
  let(
    nt = is_undef(nut_tiefe) ? wand/2 : nut_tiefe,
    re = is_undef(rest_ende) ? wand-nt : rest_ende
  )
  assert(wand > 0 && rundung > 0, "wand und rundung müssen > 0 sein")
  assert(hinterschnitt >= 0 && hinterschnitt < kante_r,
         "hinterschnitt muss in [0, kante_r) liegen")
  assert(deckel_d > kante_r, "deckel_d muss größer als kante_r sein")
  assert(nt > 0 && nt < wand, "nut_tiefe muss in (0, wand) liegen")
  assert(re > 0 && re < wand, "rest_ende muss in (0, wand) liegen")
  assert(spiel >= 0, "spiel muss >= 0 sein")
  [["laenge",laenge], ["breite",breite], ["hoehe",hoehe], ["wand",wand],
   ["rundung",rundung], ["deckel_d",deckel_d], ["kante_r",kante_r],
   ["hinterschnitt",hinterschnitt], ["nut_tiefe",nt], ["rest_ende",re],
   ["spiel",spiel]];

function sb(P, k) = P[search([k], P)[0]][1];

// Abgeleitete Maße
function sb_ueberstand(P) =
  let(r = sb(P,"kante_r"), h = sb(P,"hinterschnitt"))
  r - sqrt(r*r - (r-h)*(r-h));
function sb_nut_oben(P)  = sb(P,"hoehe") + sb_ueberstand(P);
function sb_nut_unten(P) = sb_nut_oben(P) - sb(P,"deckel_d");
function sb_restwand_seite(P) = sb(P,"wand") - sb(P,"nut_tiefe");

// Umriss um `rundung` geschrumpft (Kern für die Kugel-Minkowski)
module sb_kern(P) {
  $sb_n = is_undef($sb_n) ? $children : $sb_n;  // Umriss-Kind vorhanden?
  r = sb(P,"rundung");
  if ($sb_n > 0) offset(r=-r) children();
  else translate([r,r]) square([sb(P,"laenge")-2*r, sb(P,"breite")-2*r]);
}

module sb_halbkugel(r) {
  intersection() {
    sphere(r);
    translate([-r,-r,0]) cube([2*r,2*r,r]);
  }
}

// Außenkörper, Kanten mit `rundung` gerundet, Rand hart abgeschnitten
module sb_aussen(P) {
  $sb_n = is_undef($sb_n) ? $children : $sb_n;  // Umriss-Kind vorhanden?
  r = sb(P,"rundung"); H = sb(P,"hoehe");
  intersection() {
    minkowski() {
      translate([0,0,r]) linear_extrude(H) sb_kern(P) children();
      sphere(r);
    }
    translate([-1,-1,-1]) cube([sb(P,"laenge")+2, sb(P,"breite")+2, H+1]);
  }
}

// Innenraum (nach oben offen), Wand und Boden `wand` dick
module sb_innenraum(P) {
  $sb_n = is_undef($sb_n) ? $children : $sb_n;  // Umriss-Kind vorhanden?
  r = sb(P,"rundung"); w = sb(P,"wand");
  translate([0,0,w+r])
  minkowski() {
    linear_extrude(sb(P,"hoehe")) offset(delta=-w) sb_kern(P) children();
    sphere(r);
  }
}

module sb_koerper(P) {
  $sb_n = is_undef($sb_n) ? $children : $sb_n;  // Umriss-Kind vorhanden?
  difference() {
    sb_aussen(P) children();
    sb_innenraum(P) children();
  }
}

// Deckelumriss: Innenraum um nut_tiefe erweitert, zur Öffnung (-x) gerade
// durchgezogen, am geschlossenen Ende rest_ende vor der Außenwand.
// x0 = Anfang (0 für den Deckel, < 0 für die Nut)
module sb_deckel_2d(P, x0=0) {
  $sb_n = is_undef($sb_n) ? $children : $sb_n;  // Umriss-Kind vorhanden?
  r = sb(P,"rundung"); L = sb(P,"laenge"); B = sb(P,"breite");
  d = sb_restwand_seite(P);
  intersection() {
    if ($sb_n > 0)
      // Schub entlang -x (Minkowski mit Strecke, 0,001 mm Breitenzugabe)
      minkowski() {
        if (r > d) offset(r=r-d) sb_kern(P) children();
        else offset(delta=r-d) sb_kern(P) children();
        translate([-2*L,-0.0005]) square([2*L,0.001]);
      }
    else
      // Rechteck: Schub exakt
      union() {
        if (r > d) offset(r=r-d) sb_kern(P);
        else offset(delta=r-d) sb_kern(P);
        translate([-2*L,d]) square([3*L-r,B-2*d]);
      }
    translate([x0,-1]) square([L-sb(P,"rest_ende")-x0, B+2]);
  }
}

// Platte mit gerundeter Oberkante auf 2D-Umriss (Kind 0), Unterseite z=0
module sb_platte(dicke, kr) {
  minkowski() {
    linear_extrude(dicke-kr) offset(delta=-kr) children();
    sb_halbkugel(kr);
  }
}

// Nut: wird vom Körper (samt Innenausbau) abgezogen
module sb_nut(P) {
  $sb_n = is_undef($sb_n) ? $children : $sb_n;  // Umriss-Kind vorhanden?
  translate([0,0,sb_nut_unten(P)])
  sb_platte(sb(P,"deckel_d"), sb(P,"kante_r"))
  sb_deckel_2d(P, x0=-sb(P,"laenge")) children();
}

// Deckel in Druckposition (Unterseite z=0, gleiche x/y wie eingesetzt).
// Eingesetzt: translate([0,0,sb_nut_unten(P)+sb(P,"spiel")]).
module sb_deckel(P) {
  $sb_n = is_undef($sb_n) ? $children : $sb_n;  // Umriss-Kind vorhanden?
  s = sb(P,"spiel");
  sb_platte(sb(P,"deckel_d")-s, sb(P,"kante_r"))
  offset(delta=-s) sb_deckel_2d(P) children();
}

// Wandring auf Nuthöhe: Außenumriss minus Innenraum minus Nut
module sb_wand_2d(P) {
  $sb_n = is_undef($sb_n) ? $children : $sb_n;  // Umriss-Kind vorhanden?
  r = sb(P,"rundung");
  difference() {
    offset(r=r) sb_kern(P) children();
    offset(r=r) offset(delta=-sb(P,"wand")) sb_kern(P) children();
    sb_deckel_2d(P, x0=-sb(P,"laenge")) children();
  }
}

// Diagnose: Wand neben der Nut, die dünner als `min` ist (rot, z=0..1)
module sb_restwand(P, min=0.8) {
  $sb_n = is_undef($sb_n) ? $children : $sb_n;  // Umriss-Kind vorhanden?
  color("red") linear_extrude(1)
  difference() {
    sb_wand_2d(P) children();
    // +0.05: Rundungsrauschen der Offsets nicht als dünn melden
    offset(r=min/2+0.05) offset(r=-min/2) sb_wand_2d(P) children();
  }
}
