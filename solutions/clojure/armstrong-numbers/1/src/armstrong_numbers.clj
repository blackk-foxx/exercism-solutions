(ns armstrong-numbers)

(defn get-digits
  [num]
  (if (= 0 num) '() (cons (mod num 10) (get-digits (bigint (/ num 10)))))
  )

(defn pow [base exp] (reduce * (repeat exp base)))

(defn armstrong?
  "Returns true if the given number is an Armstrong number; otherwise, returns false"
  [num]
  (let [digits (get-digits num)]
    (= num (reduce + (map (fn [d] (pow d (count digits))) digits)))
    )
  )
