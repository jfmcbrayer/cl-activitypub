(in-package :clap-entities)

(defclass accept (activity) ())
(defclass tentative-accept (accept) ())
(defclass invite (activity) ())
(defclass reject (activity) ())
(defclass tentative-reject (reject) ())

(defclass travel (intransitive-activity) ())
(defclass arrive (intransitive-activity) ())

(defclass create (activity) ())
(defclass delete-activity (activity) ())
(defclass undo (activity) ())
(defclass update (activity) ())

(defclass add (activity) ())
(defclass remove-activity (activity) ())
(defclass move (activity) ())

(defclass follow (activity) ())
(defclass ignore-activity (activity) ())
(defclass like (activity) ())
(defclass announce (activity) ())
(defclass block-activity (ignore) ())
(defclass flag (activity) ())
(defclass dislike (activity) ())

(defclass join (activity) ())
(defclass leave (activity) ())

(defclass view (activity) ())
(defclass listen-activity (activity) ())
(defclass read-activity (activity) ())

(defclass question (intransitive-activity)
  ((one-of :accessor one-of :initarg :one-of)
   (any-of :accessor any-of :initarg :any-of)
   (closed :accessor closed :initarg :closed)))

