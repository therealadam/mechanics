#include "ruby.h"

VALUE Beatles = Qnil;
VALUE print_beatles(VALUE self);

void Init_beatles() {
  Beatles = rb_define_module("Beatles");
  rb_define_singleton_method(Beatles, "print", print_beatles, 0);
}

VALUE print_beatles(VALUE self) {
  VALUE beatles, name, puts, kernel, args;
  int i;

  beatles = rb_ary_new3(4, rb_str_new2("John"), rb_str_new2("Paul"),
                           rb_str_new2("George"), rb_str_new2("Ringo"));
  kernel  = rb_define_module("Kernel");
  puts    = rb_intern("puts");

  for (i = 0; i < RARRAY_LENINT(beatles); i++) {
    args = rb_ary_to_ary(rb_ary_entry(beatles, i));
    rb_apply(kernel, puts, args);
  }

  return Qnil;
}

