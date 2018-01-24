(in-package #:clap-entities)

(defclass ap-base ()
  ((atcontext :accessor atcontext :initarg :atcontext
              :initform "https://w3c.org/ns/activitystreams")
   (name :accessor name :initarg :name) ;; String
   (media-type :accessor media-type :initarg :media-type) ;; String (Mime media-type)
   (object-type :reader object-type) ;; URI 
   ))

(defclass ap-object (ap-base)
  ((id :accessor id :initarg :id :initform nil) ;; URI
   (attachment :accessor attachment :initarg :attachment) ;; Object or Link
   (attributed-to :accessor attributed-to :initarg :attributed-to) ;; Object or Link
   (audience :accessor audience :initarg :audience) ;; Object or Link
   (content :accessor content :initarg :content) ;; String (HTML)
   (context :accessor context :initarg :context) ;; Object or Link
   (end-time :accessor end-time :initarg :end-time) ;; DateTime
   (generator :accessor generator :initarg :generator) ;; Object or Link
   (icon :accessor icon :initarg :icon) ;; Image or Link
   (image :accessor image :initarg :image) ;; Image or Link
   (in-reply-to :accessor in-reply-to :initarg :in-reply-to) ;; Object or Link
   (location :accessor location :initarg :location) ;; Object or Link
   (preview :accessor preview :initarg :preview) ;; Object or Link
   (published :accessor published :initarg :published) ;; DateTime
   (replies :accessor replies :initarg :replies) ;; Collection
   (source :accessor source :initarg :source) ;; String (markdown or other)
   (start-time :accessor start-time :initarg :start-time) ;; DateTime
   (summary :accessor summary :initarg :summary) ;; String (HTML)
   (tag :accessor tag :initarg :tag) ;; Object or Link
   (updated :accessor updated :initarg :updated) ;; DateTime
   (url :accessor url :initarg :url) ;; URI or Link
   (to :accessor to :initarg :to) ;; Object or Link
   (bto :accessor bto :initarg :bto) ;; Object or Link
   (cc :accessor cc :initarg :cc) ;; Object or Link
   (bcc :accessor bcc :initarg :bcc) ;; Object or Link
   (duration :accessor duration :initarg :duration) ;; xsd:Duration
   (object-type :reader object-type :initform "Object") ;; URI
   ))

(defclass link (ap-base)
  ((href :accessor href :initarg :href) ;; URI
   (rel :initarg :rel :accessor rel) ;; String  (HTML5 link relation)
   (hreflang :accessor hreflang :initarg :hreflang :initform "en") ;; String (Language tag)
   (height :accessor height :initarg :height) ;; non-negative-integer
   (width :accessor width :initarg :width) ;; non-negative-integer
   (preview :accessor preview :initarg :preview) ;; Link or Object
   (object-type :reader object-type :initform "Link") ;; URI
   ))

;; Actor is defined in ActivityPub, not ActivityStreams2.
(defclass actor (ap-object)
  ((inbox :accessor inbox :initarg :inbox) ;; OrderedCollection
   (outbox :accessor outbox :initarg :outbox) ;; OrderedCollection
   (following :accessor following :initarg :following) ;; Collection
   (followers :accessor followers :initarg :followers) ;; Collection
   (liked :accessor liked :initarg :liked) ;; Collection
   (object-type :reader object-type :initform "Actor")))

(defclass collection (ap-object)
  ((total-items :accessor total-items :initarg :total-items) ;; non-negative-integer
   (current :accessor current :initarg :current) ;; CollectionPage or Link
   (first-item :accessor first-item :initarg :first-item) ;; CollectionPage or Link
   (last-item :accessor last-item :initarg :last-item) ;; CollectionPage or Link
   (items :accessor items :initarg :items) ;; Object, Link, or ordered list of
                                           ;; objects or links
   (object-type :reader object-type :initform "Collection")))

(defclass ordered-collection (collection)
  ((object-type :reader object-type :initform "OrderedCollection")))

(defclass collection-page (collection)
  ((part-of :accessor part-of :initarg :part-of) ;; Collection or Link
   (next-page :accessor next-page :initarg :next-page) ;; CollectionPage
   (prev-page :accessor prev-page :initarg :prev-page) ;; CollectionPage
   (object-type :reader object-type :initform "CollectionPage")))

(defclass ordered-collection-page (ordered-collection collection-page)
  ((object-type :reader object-type :initform "OrderedCollectionPage")))

(defclass activity (ap-object)
  ((actor :accessor actor :initarg :actor) ;; Object or Link
   (object :accessor object :initarg :object) ;; Object or Link
   (target :accessor target :initarg :target) ;; Object or Link
   (result :accessor result :initarg :result) ;; Object or Link
   (origin :accessor origin :initarg :origi) ;; Object or Link
   (instrument :accessor instrument :initarg :instrument) ;; Object or Link
   (object-type :reader object-type :initform "Activity")))

;; Intransitive activity should be a subtype of activity, but
;; we couldn't remove the object property
(defclass intransitive-activity (ap-object)
    ((actor :accessor actor :initarg :actor)
     (target :accessor target :initarg :target)
     (result :accessor result :initarg :result)
     (origin :accessor origin :initarg :origi)
     (instrument :accessor instrument :initarg :instrument)
     (object-type :accessor object-type :initform "IntransitiveActivity")))

(defun clap-encode-element (object slot key)
  (if (slot-boundp object slot)
      (typecase (slot-value object slot)
        (standard-object
         (with-object-element (key)
           (with-object () (encode-slots (slot-value object slot)))))
        (t
         (yason:encode-object-element key (slot-value object slot))))))

(defmethod yason:encode-slots progn ((object ap-object))
  (yason:encode-object-element "@context" (atcontext object))
  (yason:encode-object-element "type" (object-type object))
  (clap-encode-element object 'attachment "attachment")
  (clap-encode-element object 'attributed-to "attributedTo")
  (clap-encode-element object 'audience "audience")
  (clap-encode-element object 'content "content")
  (clap-encode-element object 'context "context")
  (clap-encode-element object 'name "name")
  (clap-encode-element object 'end-time "endTime")
  (clap-encode-element object 'generator "generator")
  (clap-encode-element object 'icon "icon")
  (clap-encode-element object 'image "image")
  (clap-encode-element object 'in-reply-to "inReplyTo")
  (clap-encode-element object 'location "location")
  (clap-encode-element object 'preview "preview")
  (clap-encode-element object 'published "published")
  (clap-encode-element object 'replies "replies")
  (clap-encode-element object 'start-time "startTime")
  (clap-encode-element object 'summary "summary")
  (clap-encode-element object 'tag "tag")
  (clap-encode-element object 'updated "updated")
  (clap-encode-element object 'url "url")
  (clap-encode-element object 'to "to")
  (clap-encode-element object 'bto "bto")
  (clap-encode-element object 'cc "cc")
  (clap-encode-element object 'bcc "bcc")
  (clap-encode-element object 'media-type "mediaType")
  (clap-encode-element object 'duration "duration"))

(defmethod yason:encode-slots progn ((link link))
  (yason:encode-object-element "@context" (atcontext link))
  (yason:encode-object-element "type" (object-type link))
  (clap-encode-element link 'href "href")
  (clap-encode-element link 'rel "rel")
  (clap-encode-element link 'media-type "mediaType")
  (clap-encode-element link 'hreflang "hreflang")
  (clap-encode-element link 'height "height")
  (clap-encode-element link 'width "width")
  (clap-encode-element link 'preview "preview"))

(defmethod yason:encode-slots progn ((actor actor))
  (clap-encode-element actor 'inbox "inbox")
  (clap-encode-element actor 'outbox "outbox")
  (clap-encode-element actor 'following "following")
  (clap-encode-element actor 'followers "followers")
  (clap-encode-element actor 'liked "liked"))

(defmethod yason:encode-slots progn ((coll collection))
  (clap-encode-element coll 'total-items "totalItems")
  (clap-encode-element coll 'current "current")
  (clap-encode-element coll 'first-item "firstItem")
  (clap-encode-element coll 'last-item "lastItem")
  (clap-encode-element coll 'items "items"))

(defmethod yason:encode-slots progn ((page collection-page))
  (clap-encode-element page 'part-of "partOf")
  (clap-encode-element page 'next-page "nextPage")
  (clap-encode-element page 'prev-page "prevPage"))


(defmethod yason:encode-slots progn ((activity activity))
  (clap-encode-element activity 'object "object")
  (clap-encode-element activity 'actor "actor")
  (clap-encode-element activity 'result "result")
  (clap-encode-element activity 'origin "origin")
  (clap-encode-element activity 'instrument "instrument"))
(defmethod yason:encode-slots progn ((activity intransitive-activity))
  (clap-encode-element activity 'object "object")
  (clap-encode-element activity 'actor "actor")
  (clap-encode-element activity 'result "result")
  (clap-encode-element activity 'origin "origin")
  (clap-encode-element activity 'instrument "instrument"))


(defgeneric as-json (object &optional stream)
  (:documentation "Represent the object as JSON, output to stream."))

(defgeneric as-json-string (object)
  (:documentation "Represent the object as JSON, output to string"))

(defmethod as-json ((object ap-object) &optional (stream *standard-output*))
    (yason:with-output (stream :indent t)
      (yason:encode-object object)))

(defmethod as-json-string ((object ap-object))
  (yason:with-output-to-string* (:indent t)
    (yason:encode-object object)))

(defmethod as-json ((link link) &optional (stream *standard-output*))
  (yason:with-output (stream :indent t)
    (yason:encode-object link)))

(defmethod as-json-string ((link link))
  (yason:with-output-to-string* (:indent t)
    (yason:encode-object link)))

(defmacro hash-to-slot (key hashtable object slot)
  `(if (gethash ,key ,hashtable)
       (setf (slot-value ,object ,slot) (gethash ,key ,hashtable))))

(defun from-json (json-string)
  (let* ((result-map (yason:parse json-string))
         (object-type (alexandria:ensure-gethash "type" result-map "Object"))
         (base-object (object-type-string-to-object object-type)))
    base-object))

(defun object-type-string-to-object (type-string)
  (cond
    ((string-equal type-string "Object") (make-instance 'ap-object))
    ((string-equal type-string "Link") (make-instance 'link))
    ((string-equal type-string "Actor") (make-instance 'actor))
    ((string-equal type-string "Collection")
     (make-instance 'collection))
    ((string-equal type-string "OrderedCollection")
     (make-instance 'ordered-collection))
    ((string-equal type-string "CollectionPage")
     (make-instance 'collection-page))
    ((string-equal type-string "OrderedCollectionPage")
     (make-instance 'ordered-collection-page))
    ((string-equal type-string "Activity") (make-instance 'activity))
    ((string-equal type-string "IntransitiveActivity")
     (make-instance 'intransitive-activity))
    ((string-equal type-string "Accept") (make-instance 'accept))
    ((string-equal type-string "TentativeAccept") (make-instance
                                                   'tentative-accept))
    ((string-equal type-string "Invite") (make-instance 'invite))
    ((string-equal type-string "Reject") (make-instance 'reject))
    ((string-equal type-string "TentativeReject") (make-instance
                                                   'tentative-reject))
    ((string-equal type-string "Travel") (make-instance 'travel))
    ((string-equal type-string "Arrive") (make-instance 'arrive))
    ((string-equal type-string "Create") (make-instance 'create))
    ((string-equal type-string "Delete") (make-instance 'delete-activity))
    ((string-equal type-string "Undo") (make-instance 'undo))
    ((string-equal type-string "Update") (make-instance 'update))
    ((string-equal type-string "Add") (make-instance 'add))
    ((string-equal type-string "Remove") (make-instance 'remove-activity))
    ((string-equal type-string "Move") (make-instance 'move))
    ((string-equal type-string "Follow") (make-instance 'follow))
    ((string-equal type-string "Ignore") (make-instance 'ignore-activity))
    ((string-equal type-string "Like") (make-instance 'like))
    ((string-equal type-string "Announce") (make-instance 'announce))
    ((string-equal type-string "Block") (make-instance 'block-activity))
    ((string-equal type-string "Flag") (make-instance 'flag))
    ((string-equal type-string "Dislike") (make-instance 'dislike))
    ((string-equal type-string "Join") (make-instance 'join))
    ((string-equal type-string "Leave") (make-instance 'leave))
    ((string-equal type-string "View") (make-instance 'view))
    ((string-equal type-string "Listen") (make-instance 'listen-activity))
    ((string-equal type-string "Read") (make-instance 'read-activity))
    ((string-equal type-string "Question") (make-instance 'question))
    ((string-equal type-string "Application") (make-instance 'application))
    ((string-equal type-string "Person") (make-instance 'person))
    ((string-equal type-string "Group") (make-instance 'group))
    ((string-equal type-string "Organization") (make-instance 'organization))
    (t nil)))
