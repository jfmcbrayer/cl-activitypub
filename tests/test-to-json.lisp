(in-package "clap-tests")

(defvar *my-object* (make-instance 'clap-entities:note
                                   :id "https://example.com/obs/foo"
                                   :image "https://example.com/images/foo"
                                   :content "This is a note."
                                   :to '("https://example.com/PUBLIC")))
(is (clap-entities:as-json-string *my-object*)
    "{
  \"@context\":\"https://www.w3e.org/ns/activitystreams\",
  \"type\":\"Note\",
  \"content\":\"This is a note.\",
  \"image\":\"https://example.com/images/foo\",
  \"to\":[\"https://example.com/PUBLIC\"]
}")
