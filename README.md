# Spangenzubehör

---

> https://forgejo.mueller.network/Zentonic/Spangenzubehoer.git 
> 
> Mirror: https://github.com/zentonic/mirror.Spangenzubehoer.git

---


> License: cc-by-sa-4.0 Author: holm / Christian Müller (https://mueller.network)

3D Druck Vorlage für ein Zubehördöschen mit Schiebedeckel.

Platz für
* Interdentalbürstchen
* frische Gummiringe
* Zahnspangenwachs
* Selbstklebende Spiegelfolie in einer Aussparung im Deckel

[STL-Download](STL/)

## Schiebedeckel für eigene Formen

Der Schiebedeckel steckt als eigenständige Bibliothek in
[`modules/mod_Schiebebox.scad`](modules/mod_Schiebebox.scad): Rechteck mit
Rundung oder beliebiger 2D-Umriss, Arretierung über einen einstellbaren
Hinterschnitt, Presssitz ohne Spiel (optional `spiel`). Beispiel mit
Kapselform: [`beispiele/Kapsel.scad`](beispiele/Kapsel.scad).

```openscad
include <modules/mod_Schiebebox.scad>;
P = sb_param(laenge=60, breite=25, hoehe=20, wand=2.5, rundung=4,
             deckel_d=3, hinterschnitt=0.4);
difference() { sb_koerper(P); sb_nut(P); }
translate([0, 35, 0]) sb_deckel(P);
```

Die Döschen auf [Mastodon](https://social.saarland/@holm/112083961379337663)

![Preview](assets/Spangenzubehör.png "Vorschau")

![Foto](assets/Foto.png "Foto der Entwicklungsstufen")
