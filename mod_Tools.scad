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