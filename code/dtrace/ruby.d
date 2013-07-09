::rb_obj_alloc:object-create
{
  @rbmem["create"]= count();
}

::garbage_collect:object-free
{
  @rbmem["free"] = count();
}

pid$target::malloc:entry
{
  @rbmem["malloc"] = count();
}

END { printa(@rbmem); }

