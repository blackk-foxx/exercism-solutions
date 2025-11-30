(ns bob)
(require '[clojure.string :as string])


(defn is-shouting? [s]
  (and
    (every? Character/isUpperCase (filter Character/isLetter (seq s)))
    (some Character/isLetter (seq s))
    )
  )

(defn is-question? [s] (= \? (last (seq s))))

(defn is-silence? [s] (or (= s "") (every? Character/isSpace (seq s))))


(defn response-for [s] ;; <- arglist goes here
  (let [trimmed-s (string/trim s)]
    (cond
      (and (is-shouting? trimmed-s) (is-question? trimmed-s)) 
        "Calm down, I know what I'm doing!"
      (is-shouting? trimmed-s) "Whoa, chill out!"
      (is-question? trimmed-s) "Sure."
      (is-silence? trimmed-s) "Fine. Be that way!"
      :else "Whatever."
      )
    )
)
