// License: cc-by-sa-4.0 Author: holm / Christian Müller (https://mueller.network)

module roundbox(w,h,d) {
  minkowski(){
    cube([w,h,d]);
    sphere(sphere);
  }
}

module mirror_copy(v = [0, 1, 0]) {
    children();
    mirror(v) children();
}