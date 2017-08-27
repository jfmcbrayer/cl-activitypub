;;;; cl-activitypub.asd

(asdf:defsystem "cl-activitypub"
  :description "An ActivityPub implementation"
  :author "Jason McBrayer <jmcbray@carcosa.net>"
  :license "AGPLv3"
  :serial t
  :depends-on ("yason")
  :components ((:file "package")
               (:file "cl-activitypub")
               (:module "entities"
                :serial t
                :components
                ((:file "package")
                 (:file "core")
                 (:file "activities")
                 (:file "actors")
                 (:file "objects"))))
  :in-order-to ((test-op (test-op cl-activitypub-test))))

(asdf:defsystem "cl-activitypub-test"
  :depends-on ("cl-activitypub"
               :prove)
  :defsystem-depends-on (:prove-asdf)
  :serial t
  :components
  ((:module "tests"
    :serial t
    :components
    ((:file "package")
     (:test-file "to-json")
     (:test-file "from-json"))))
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run) :prove) c)))
