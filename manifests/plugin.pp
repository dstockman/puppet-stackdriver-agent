define stackdriver::plugin(){
  $pclass = "::stackdriver::plugin::${name}"

  if ! defined($pclass) {
    fail("Unknown Stackdriver Agent plugin ${name}")
  } else {
    contain $pclass

  }
}
