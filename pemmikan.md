# 🤖🥩 OpenSCAD: Spangenzubehör-Döschen mit Schiebedeckel
> Stand: 2026-09-24 01:10 — Claude.ai via Claude Code (CLI)

## STAND

ROLLE: v00 auf Opus, thinking an

- PCR 2026-09-24 01:10: Pemmikan aktuell, Issues #6–#9 und #11 geschlossen. Release-Schritt offen: `~/bin/release` würde `v2.0.0-rc.3` erzeugen (v-Präfix, ohne cliff.toml, Inhalt nur Doku seit rc.2)
- `main` = `fcb2c0d`, Tag `2.0.0-rc.2` (signiert), Forgejo-Release als Vorabversion mit STL
- **Nächster Schritt (Holm, „morgen")**: Testdruck rc.2 → bei Erfolg PCR/Release **2.0.0 final** — [#10](https://forgejo.mueller.network/Zentonic/Spangenzubehoer/issues/10)
- Branches bleiben nach Merge stehen (Holm): `fix/6-ki-layoutfix`, `fix/7-hauptsteg-zurueck`, `feat/8-schiebebox`, `feat/9-stl-rc2`
- Kein `dev`-Branch, kein CHANGELOG/cliff.toml: Merges gehen `--no-ff` direkt in `main`

## Funktion der Geometrie (Holm 2026-09-23) — Funktionsmaße, keine Kosmetik

| Teil | Funktion | Maß |
|---|---|---|
| Langes Fach (y > Hauptsteg) | Wachsstreifen, Einheitsgröße | **9,0 mm Passmaß** |
| Kurzes Fach (y < Hauptsteg, x > Quersteg) | Griff Interdentalbürste (TePe Original Pink ISO 0) | 10 mm, **bewusst lose** |
| Loch Ø4 im Quersteg | Bürstenspitze ragt in die kleine Kammer, Konus ragt ins Loch | – |
| Kleine Kammer | Zahnspangengummis | – |
| Kegel „Zyl gebraucht" | Abstreifsteg für gebrauchte Gummis (z. B. beim Essen) | Fuß bündig zur Stegseite |
| Deckelmulde | Spiegelklebefolie (Amazon) | 0,5 mm tief |
| Deckel | **Presssitz ohne Spiel**: robustes Schieben, Arretieren durch flächigen Druck | – |

TePe-Bürste, aus Fotos geschätzt (Referenz Dose + Produktbild): Länge ≈ 46 mm, Platte ≈ 13 × 16 mm, Kragen Ø ≈ 7 mm.

## Schiebedeckel-Mechanik (`modules/mod_Schiebebox.scad`, #8)

- Deckel: Platte `deckel_d` mit oben gerundeten Kanten `kante_r`, liegt auf einer Auflage `nut_tiefe` in den Seitenwänden
- Arretierung: Nutoberkante = Rand + `ueberstand`, `ueberstand = kante_r − sqrt(kante_r² − (kante_r − hinterschnitt)²)`; der Rand greift um `hinterschnitt` über die Kantenrundung
- Spangendose: `deckel_d=3`, `kante_r=1`, `hinterschnitt=0.4` (→ Überstand 0,2), `nut_tiefe = wand − rundung/3` und `rest_ende = 0.7·wand` (bewährte Presssitzwerte)
- Umriss: Rechteck oder 2D-Kind (`beispiele/Kapsel.scad`). Bei runden Enden läuft die Wand am Öffnungsende spitz aus → `sb_restwand()` markiert das
- Die alte Rechnung (bis rc.1) passte nur zufällig: Hinterschnitt verschwand bei Deckelstärke +0,5, Nut fest 2,5 unter Rand, Breite an `rundung/3`, Restwand am Nutende ≈ 0,9 mm

## Parameter (Customizer / `Spangenzubehör.json`)

- `wandstaerke` = reale Wanddicke (2,5), intern `wall = 2·wandstaerke`
- `deckelstaerke` = reale Deckeldicke (3); bis rc.1 bedeutete der Wert die Platte ohne Wölbung (2)
- Sätze: „Standardwerte des Designs" (= `.scad`-Defaults, STL-Grundlage) und „Variante 75 mm"

## Verlauf

| Issue | Inhalt |
|---|---|
| #6 | Layoutprüfung + Parametrierung (Halter, Stege, Kegel, Deckellänge, JSON) |
| #7 | Hauptsteg zurück auf 10/9 (Zentrierung in #6 war Fehlurteil) |
| #8 | Bibliothek `mod_Schiebebox`, Spangendose darauf umgestellt |
| #9 | STL `2.0.0-rc.2` |

## Offen

- [#10](https://forgejo.mueller.network/Zentonic/Spangenzubehoer/issues/10) Testdruck → 2.0.0 final
- Alte lokale Arbeitskopie mit Branch `Deckelkram`, Stash und Klammer-Fix-Commit (Details im Flotten-Inventar): unangetastet, Holm entscheidet
- Prüfwerkzeug: OpenSCAD per `nix shell nixpkgs#openscad-unstable` (2026.02, `--backend=manifold`)
