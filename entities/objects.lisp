(defpackage :clap.objects
  (:use :cl :cl-json :clap.core))

(in-package :clap.objects)

(defclass relationship (clap.core:object)
  ((relationship-subject :accessor relationship-subject
                         :initarg :relationship-subject)
   (relationship-object :accessor relationship-object
                        :initarg :relationship-object)))

(defclass article (clap.core:object) ())
(defclass audio (clap.core:object) ())
(defclass document (clap.core:object) ())
(defclass image (clap.core:object) ())
(defclass video (clap.core:object) ())
(defclass note (clap.core:object) ())
(defclass page (document) ())
(defclass event (clap.core:object) ())
(defclass place (clap.core:object)
  ((accuracy :accessor accuracy :initarg :accuracy)
   (altitude :accessor altitude :initarg :altitude)
   (latitude :accessor latitude :initarg :latitude)
   (longitude :accessor longitude :initarg :longitude)
   (radius :accessor radius :initarg :radius)
   (units :accessor units :initarg :units)))
(defclass profile (clap.core:object)
  ((describes :accessor describes :initarg :describes)))
(defclass tombstone (clap.core:object)
  ((former-type :accessor former-type :initarg :former-type)
   (deleted :accessor deleted :initarg :deleted)))

(defclass mention (clap.core:link) ())
