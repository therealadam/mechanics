BEGIN { printf("I am %s\n", execname); }

:::method-entry
{
  printf("%s %s %s %d\\n", copyinstr(arg0), copyinstr(arg1), copyinstr(arg2), arg3);
}

ruby$target:::cmethod-entry
{
  printf("%s %s %s %d\\n", copyinstr(arg0), copyinstr(arg1), copyinstr(arg2), arg3);

}
END { printf("FIN\n"); }

