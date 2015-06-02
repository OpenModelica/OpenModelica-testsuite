AC_PREREQ([2.63])
AC_INIT([OpenModelica-testsuite], [1.0], [https://trac.openmodelica.org/OpenModelica],[openmodelica],[https://openmodelica.org])

AC_SUBST(OMBUILDDIR_)

cp common/install-sh common/config.guess common/config.sub ./

AC_ARG_WITH(OMBUILDDIR, AS_HELP_STRING([--with-OMBUILDDIR], [Relative path to the build directory containing the omc executable]),[OMBUILDDIR_="$withval"],[OMBUILDDIR_="../../build"])

AC_CONFIG_FILES([rtest],[chmod +x rtest])
AC_OUTPUT(Makefile)
