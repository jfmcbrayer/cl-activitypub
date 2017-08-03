(in-package "clap-tests")

(defvar *basic-object* (make-instance 'clap-entities:note
                                   :id "https://example.com/obs/foo"
                                   :image "https://example.com/images/foo"
                                   :content "This is a note."
                                   :to '("https://example.com/PUBLIC")))
(defparameter *activity-object*
  (make-instance 'clap-entities:activity
                 :summary "Sally did something to a note"
                 :actor (make-instance 'clap-entities:person
                                       :name "Sally")
                 :object (make-instance 'clap-entities:note
                                        :name "A Note")))
(defparameter *activity-json-string*
  "{
  \"@context\":\"https://www.w3e.org/ns/activitystreams\",
  \"type\":\"Activity\",
  \"summary\":\"Sally did something to a note\",
  \"object\":
  {
    \"@context\":\"https://www.w3e.org/ns/activitystreams\",
    \"type\":\"Note\",
    \"name\":\"A Note\"
  },
  \"actor\":
  {
    \"@context\":\"https://www.w3e.org/ns/activitystreams\",
    \"type\":\"Person\",
    \"name\":\"Sally\"
  }
}")

(plan 2)

(is (clap-entities:as-json-string *basic-object*)
    "{
  \"@context\":\"https://www.w3e.org/ns/activitystreams\",
  \"type\":\"Note\",
  \"content\":\"This is a note.\",
  \"image\":\"https://example.com/images/foo\",
  \"to\":[\"https://example.com/PUBLIC\"]
}")

(is (clap-entities:as-json-string *activity-object*) *activity-json-string*)

(finalize)
