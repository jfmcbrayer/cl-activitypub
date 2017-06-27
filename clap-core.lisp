(defpackage :CLAP.CORE
  (:use :CL :JSON-MOP :YASON)
  (:export object link collection ordered-collection
           collection-page ordered-collection-page
           activity intransitive-activity
           actor as-json))
(in-package :CLAP.CORE)

(defclass object ()
  ((attachment :accessor attachment :initarg :attachment
               :json-key "attachment")
   (attributed-to :accessor attributed-to :initarg :attributed-to
                 :json-key "attributedTo")
   (audience :accessor audience :initarg :audience
             :json-key "audience")
   (atcontext :accessor atcontext :initarg :atcontext
              :initform "https://www.w3e.org/ns/activitystreams"
              :json-key "@context")
   (content :accessor content :initarg :content
            :json-key "content")
   (context :accessor context :initarg :context
            :json-key "context")
   (name :accessor name :initarg :name
         :json-key "name")
   (end-time :accessor end-time :initarg :end-time
             :json-key "endTime")
   (generator :accessor generator :initarg :generator
              :json-key "generator")
   (icon :accessor icon :initarg :icon :json-key "icon")
   (image :accessor image :initarg :image :json-key "image")
   (in-reply-to :accessor in-reply-to :initarg :in-reply-to
                :json-key "inReplyTo")
   (location :accessor location :initarg :location
             :json-key "location")
   (preview :accessor preview :initarg :preview
            :json-key "preview")
   (published :accessor published :initarg :published
              :json-key "published")
   (replies :accessor replies :initarg :replies
            :json-key "replies")
   (start-time :accessor start-time :initarg :start-time
               :json-key "startTime")
   (summary :accessor summary :initarg :summary
            :json-key "summary")
   (tag :accessor tag :initarg :tag :json-key "tag")
   (updated :accessor updated :initarg :updated
            :json-key "updated")
   (url :accessor url :initarg :url :json-key "url")
   (to :accessor to :initarg :to :json-key "to")
   (bto :accessor bto :initarg :bto :json-key "bto")
   (cc :accessor cc :initarg :cc :json-key "cc")
   (bcc :accessor bcc :initarg :bcc :json-key "bcc")
   (media-type :accessor media-type :initarg :media-type
               :json-key "mediaType")
   (duration :accessor duration :initarg :duration
             :json-key "duration")
   (object-type :reader object-type :initform "Object"
                :json-key "type"))
  (:metaclass json-serializable-class))

(defclass link ()
  ((href :accessor href :initarg :href :json-key "href")
   (rel :initarg :rel :accessor rel :json-key "rel")
   (media-type :accessor media-type :initarg :media-type
               :json-key "mediaType")
   (name :accessor name :initarg :name :json-key "name")
   (hreflang :accessor hreflang :initarg :hreflang :initform "en"
             :json-key "hreflang")
   (height :accessor height :initarg :height :json-key "height")
   (width :accessor width :initarg :width :json-key "width")
   (preview :accessor preview :initarg :preview)
   (context :accessor context :initarg :context
            :json-key "context")
   (atcontext :accessor atcontext :initarg :atcontext
              :initform "https://www.w3e.org/ns/activitystreams"
              :json-key "@context")
   (object-type :reader object-type :initform "Link"
                :json-key "type"))
  (:metaclass json-serializable-class))

(defclass collection (object)
  ((total-items :accessor total-items :initarg :total-items
                :json-key "totalItems")
   (current :accessor current :initarg :current
            :json-key "current")
   (first-item :accessor first-item :initarg :first-item
               :json-key "firstItem")
   (last-item :accessor last-item :initarg :last-item
              :json-key "lastItem")
   (items :accessor items :initarg :items
          :json-key "items"))
  (:metaclass json-serializable-class))

(defclass ordered-collection (collection) ()
  (:metaclass json-serializable-class))

(defclass collection-page (collection)
  ((part-of :accessor part-of :initarg :part-of
            :json-key "partOf")
   (next-page :accessor next-page :initarg :next-page
              :json-key "nextPage")
   (prev-page :accessor prev-page :initarg :prev-page
              :json-key "prevPage"))
  (:metaclass json-serializable-class))

(defclass ordered-collection-page (ordered-collection collection-page)
  ()
  (:metaclass json-serializable-class))

(defclass activity (object)
  ((actor :accessor actor :initarg :actor :json-key "actor")
   (object :accessor object :initarg :object :json-key "object")
   (target :accessor target :initarg :target :json-key "target")
   (result :accessor result :initarg :result :json-key "result")
   (origin :accessor origin :initarg :origin :json-key "origin")
   (instrument :accessor instrument :initarg :instrument
               :json-key "instrument"))
  (:metaclass json-serializable-class))

;; Intransitive activity should be a subtype of activity, but
;; we couldn't remove the object property
(defclass intransitive-activity (object)
    ((actor :accessor actor :initarg :actor :json-key "actor")
     (target :accessor target :initarg :target :json-key "target")
     (result :accessor result :initarg :result :json-key "result")
     (origin :accessor origin :initarg :origin :json-key "origin")
     (instrument :accessor instrument :initarg :instrument
                 :json-key "instrument"))
  (:metaclass json-serializable-class))


(defmethod as-json ((object object))
  (encode object))

(defmethod as-json ((link link))
  (encode link))
