;;;; cl-activitypub.asd

(asdf:defsystem #:cl-activitypub
  :description "An ActivityPub implementation"
  :author "Jason McBrayer <jmcbray@carcosa.net>"
  :license "AGPLv3"
  :serial t
  :depends-on ("yason" "prove")
  :components ((:file "package")
               (:file "cl-activitypub")
               (:module "entities"
                        :serial t
                        :components
                        ((:file "package")
                        (:file "core")
                        (:file "activities")
                        (:file "actors")
                         (:file "objects")))
               (:module "tests"
                :serial t
                :components
                ((:file "package")
                 (:file "test-to-json")))))
