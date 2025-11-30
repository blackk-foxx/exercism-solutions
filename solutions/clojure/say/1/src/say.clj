(ns say (:require [clojure.math :as math]))


(def ones-and-teens ["", 
            "one",
            "two",
            "three",
            "four",
            "five",
            "six",
            "seven",
            "eight",
            "nine",
            "ten",
            "eleven",
            "twelve",
            "thirteen",
            "fourteen",
            "fifteen",
            "sixteen",
            "seventeen",
            "eighteen",
            "nineteen"])

(def tens ["",
           "ten",
           "twenty",
           "thirty",
           "forty",
           "fifty",
           "sixty",
           "seventy",
           "eighty",
           "ninety"])

(def thousand-powers ["",
                "thousand",
                "million",
                "billion"])

(defn join [sep s1 s2]
  (if (> (count s2) 0) 
    (apply str [s1, sep, s2])
    s1
    )
  )

(declare say)

(defn say-with-scale [num scale scale-word]
  (let [head (say (int (/ num scale))) 
        tail (say (mod num scale))]
    (if (> (count head) 0)
      (join " " (str head " " scale-word) tail) 
      tail
      )
    )
  )

(defn say-big [num]
  (cond
    (< num 1000) (say-with-scale num 100 "hundred")
    (< num (math/pow 1000 4))
      (let [order (int (/ (math/log10 num) 3))
            scale (bigint (math/pow 1000 order))
            scale-word (get thousand-powers order)] 
          (say-with-scale num scale scale-word)
        )
    :else (throw (IllegalArgumentException. "out of range"))
    )
  )

(defn say [num]
  (cond
    (< num 0) (throw (IllegalArgumentException. "out of range"))
    (< num 20) (get ones-and-teens num)
    (< num 100) (join "-" (get tens (int (/ num 10))) (say (mod num 10)))
    :else (say-big num)
    )
  )

(defn number [num] ;; <- arglist goes here
  (if (= num 0) "zero" (say num))
  )
