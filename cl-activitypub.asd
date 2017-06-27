;;;; cl-activitypub.asd

(asdf:defsystem #:cl-activitypub
  :description "An ActivityPub implementation"
  :author "Jason McBrayer <jmcbray@carcosa.net>"
  :license "AGPLv3"
  :serial t
  :depends-on ("json-mop")
  :components ((:file "package")
               (:file "cl-activitypub")
               (:file "clap-core")
               (:file "clap-activities")
               (:file "clap-actors")
               (:file "clap-objects")))

