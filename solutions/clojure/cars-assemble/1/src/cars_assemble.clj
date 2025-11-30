(ns cars-assemble)

(def default-rate 221)

(defn in-range
  [low, high, value]
  (and (<= low value) (<= value high))
  )

(defn yield
  [speed]
  (cond (= speed 0) 0
        (in-range 1 4 speed) 1.0
        (in-range 5 8 speed) 0.90
        (= speed 9) 0.80
        :else 0.77
    )
  )

(defn production-rate
  "Returns the assembly line's production rate per hour,
   taking into account its success rate"
  [speed]
  (* speed (* (yield speed) default-rate))
  )

(defn working-items
  "Calculates how many working cars are produced per minute"
  [speed]
  (int (/ (production-rate speed) 60))
  )
