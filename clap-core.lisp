(defpackage :CLAP.CORE
  (:use :CL :CL-JSON)
  (:export object link collection ordered-collection
           collection-page ordered-collection-page
           activity intransitive-activity
           actor as-json))
(in-package :CLAP.CORE)

(defclass object ()
  ((attachment :accessor attachment :initarg :attachment)
   (attributedTo :accessor attributedTo :initarg :attributedTo)
   (audience :accessor audience :initarg :audience)
   (atcontext :accessor atcontext :initarg :atcontext
              :initform "https://www.w3e.org/ns/activitystreams")
   (content :accessor context :initarg :context)
   (name :accessor name :initarg :name)
   (end-time :accessor end-time :initarg :end-time)
   (generator :accessor generator :initarg :generator)
   (icon :accessor icon :initarg :icon)
   (image :accessor image :initarg :image)
   (in-reply-to :accessor in-reply-to :initarg :i-reply-to)
   (location :accessor location :initarg :location)
   (preview :accessor preview :initarg :preview)
   (published :accessor preview :initarg :published)
   (replies :accessor replies :initarg :replies)
   (start-time :accessor start-time :initarg :start-time)
   (summary :accessor summary :initarg :summary)
   (tag :accessor tag :initarg :tag)
   (updated :accessor updated :initarg :updated)
   (url :accessor url :initarg :url)
   (to :accessor to :initarg :to)
   (bto :accessor bto :initarg :bto)
   (cc :accessor cc :initarg :cc)
   (bcc :accessor bcc :initarg :bcc)
   (media-type :accessor media-type :initarg :media-type)
   (duration :accessor duration :initarg :duration)
   (object-type :reader object-type :initform "Object"
                :allocation :class)))

(defclass link ()
  ((href :accessor href :initarg :href)
   (rel :initarg :rel :accessor rel)
   (media-type :accessor media-type :initarg :media-type)
   (name :accessor name :initarg :name)
   (hreflang :accessor hreflang :initarg :hreflang :initform "en")
   (height :accessor height :initarg :height)
   (width :accessor width :initarg :width)
   (preview :accessor preview :initarg :preview)
   (object-type :reader object-type :initform "Link"
                :allocation :class)))

(defclass collection (object)
  ((total-items :accessor total-items :initarg :total-items)
   (current :accessor current :initarg :current)
   (first-item :accessor first-item :initarg :first-item)
   (last-item :accessor last-item :initarg :last-item)
   (items :accessor items :initarg :items)))

(defclass ordered-collection (collection) ())

(defclass collection-page (collection)
  ((part-of :accessor part-of :initarg :part-of)
   (next-page :accessor next-page :initarg :next-page)
   (prev-page :accessor prev-page :initarg :prev-page)))

(defclass ordered-collection-page (ordered-collection collection-page)
  ())

(defclass activity (object)
  ((actor :accessor actor :initarg :actor)
   (object :accessor object :initarg :object)
   (target :accessor target :initarg :target)
   (result :accessor result :initarg :result)
   (origin :accessor origin :initarg :origin)
   (instrument :accessor instrument :initarg :instrument)))

;; Intransitive activity should be a subtype of activity, but
;; we couldn't remove the object property
(defclass intransitive-activity (object)
    ((actor :accessor actor :initarg :actor)
     (target :accessor target :initarg :target)
     (result :accessor result :initarg :result)
     (origin :accessor origin :initarg :origin)
     (instrument :accessor instrument :initarg :instrument)))


(defmethod as-json ((object object) &optional stream)
  (cl-json:encode-json object stream))
