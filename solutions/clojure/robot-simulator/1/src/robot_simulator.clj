(ns robot-simulator)

(defn robot
  [position bearing]
  {:bearing bearing :coordinates position}
  )

(def bearings
  [:north :east :south :west]
  )

(defn offset-for-bearing [bearing]
  (cond
    (= :north bearing) {:x 0, :y 1}
    (= :east bearing)  {:x 1, :y 0}
    (= :south bearing) {:x 0, :y -1}
    (= :west bearing)  {:x -1, :y 0}
    )
  )

(defn bump-bearing [direction bearing]
  (let [next-bearing-index (+ direction (.indexOf bearings bearing))]
    (cond 
      (< next-bearing-index 0) :west
      (> next-bearing-index 3) :north
      :else (get bearings next-bearing-index)
      )
    )
  )

(defn translate [position offset]
  (let [x (:x position) y (:y position) 
        dx (:x offset) dy (:y offset)]
    {:x (+ x dx), :y (+ y dy)})
  )
  
(defn rotate [direction robot]
  (let [bearing (:bearing robot)
        position (:coordinates robot)]
    {:bearing (bump-bearing direction bearing)
     :coordinates position}
    )
  )

(defn advance [robot]
  (let [bearing (:bearing robot)
        position (:coordinates robot)]
    {:bearing bearing
     :coordinates (translate position (offset-for-bearing bearing))}
    )
  )

(defn execute
  [command robot]
  (cond
    (= \L command) (rotate -1 robot)
    (= \R command) (rotate 1 robot)
    :else (advance robot)    
    )
  )

(defn simulate
  [commands robot]
  (if (= commands "") robot 
    (simulate (subs commands 1) (execute (get commands 0) robot))
    )
  )
