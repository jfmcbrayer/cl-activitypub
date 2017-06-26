(defpackage :CLAP.ACTIVITIES
  (:use :CL :CL-JSON :CLAP.CORE)
  (:export accept tentative-accept
           add arrive
           create))
(in-package :CLAP.ACTIVITIES)

(defclass accept (clap.core:activity) ())
(defclass tentative-accept (accept) ())
(defclass invite (clap.core:activity) ())
(defclass reject (clap.core:activity) ())
(defclass tentative-reject (reject) ())

(defclass travel (clap.core:intransitive-activity) ())
(defclass arrive (clap.core:intransitive-activity) ())

(defclass create (clap.core:activity) ())
(defclass delete (clap.core:activity) ())
(defclass undo (clap.core:activity) ())
(defclass update (clap.core:activity) ())

(defclass add (clap.core:activity) ())
(defclass remove (clap.core:activity) ())
(defclass move (clap.core:activity) ())

(defclass follow (clap.core:activity) ())
(defclass ignore (clap.core:activity) ())
(defclass like (clap.core:activity) ())
(defclass announce (clap.core:activity) ())
(defclass block (ignore) ())
(defclass flag (clap.core:activity) ())
(defclass dislike (clap.core:activity) ())

(defclass join (clap.core:activity) ())
(defclass leave (clap.core:activity) ())

(defclass view (clap.core:activity) ())
(defclass listen (clap.core:activity) ())
(defclass read (clap.core:activity) ())

(defclass question (clap.core:intransitive-activity)
  (one-of :accessor one-of :initarg :one-of)
  (any-of :accessor any-of :initarg :any-of)
  (closed :accessor closed :initarg :closed))

