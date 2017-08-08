(in-package "clap-tests")

(plan 1)

(is (clap-entities:from-json *activity-json-string*) *activity-object*)

(finalize)
