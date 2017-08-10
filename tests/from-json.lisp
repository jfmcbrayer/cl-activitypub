(in-package "clap-tests")

(plan 4)

(let ((activity-result (clap-entities:from-json *activity-json-string*)))

  (is activity-result  *activity-object*)
  (is (slot-value activity-result 'clap-entities::object-type) "Activity")
  (is (slot-value activity-result 'clap-entities::summary)
      "Sally did something to a note")
  (is (type-of (slot-value activity-result 'clap-entities::actor))
      'clap-entities:actor)
)
(finalize)
