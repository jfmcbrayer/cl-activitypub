;;;; package.lisp

(defpackage #:clap-entities
  (:use #:cl #:yason #:alexandria)
  (:export ap-object link actor collection ordered-collection
           collection-page ordered-collection-page
           activity intransitive-activity
           actor as-json as-json-string from-json)
    (:export accept tentative-accept
           invite reject tentative-reject
           travel arrive
           create delete-activity
           undo update
           add remove-activity move
           follow ignore-activity
           like announce
           block-activity flag
           dislike
           join leave
           view listen-activity read-activity
           question)
      (:export application
           person
           group
           organization)
      (:export article audio
               document image
               video note
               page event
               place
               profile
               tombstone
               mention))


