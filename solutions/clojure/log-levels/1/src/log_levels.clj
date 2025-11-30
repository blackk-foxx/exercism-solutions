(ns log-levels
  (:require [clojure.string :as str]))

(defn message
  "Takes a string representing a log line
   and returns its message with whitespace trimmed."
  [s]
  (let [message-start (+ 2 (str/index-of s "]:"))]
    (str/trim (subs s message-start))
    )
  )

(defn log-level
  "Takes a string representing a log line
   and returns its level in lower-case."
  [s]
  (let [begin (+ 1 (str/index-of s "[")) 
        end (str/index-of s "]")]
    (str/lower-case (subs s begin end))
    )
  )

(defn reformat
  "Takes a string representing a log line and formats it
   with the message first and the log level in parentheses."
  [s]
  (str (message s) " (" (log-level s) ")")
  )
