;;;; package.lisp

(defpackage #:clap-entities
  (:use #:CL #:JSON-MOP)
  (:export object link collection ordered-collection
           collection-page ordered-collection-page
           activity intransitive-activity
           actor as-json))


