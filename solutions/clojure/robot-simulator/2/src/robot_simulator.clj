(ns robot-simulator)

(defn robot
  [position bearing]
  {:bearing bearing :coordinates position})

(def bearings
  [:north :east :south :west])

(defn offset-for-bearing [bearing]
  (case bearing
    :north {:dx  0  :dy  1}
    :east  {:dx  1  :dy  0}
    :south {:dx  0  :dy -1}
    :west  {:dx -1  :dy  0}))

(defn bump-circular [direction limit value]
  (let [next-value (+ direction value)]
    (cond
      (< next-value 0) (- limit 1)
      (>= next-value limit) 0
      :else next-value)))
      
(defn bump-bearing [direction bearing]
  (let [index (.indexOf bearings bearing)
        limit (count bearings)]
    (get bearings (bump-circular direction limit index))))

(defn translate [{:keys [dx dy]} {:keys [x y]}]
  {:x (+ x dx) :y (+ y dy)})
  
(defn rotate [direction robot]
  (update robot :bearing (partial bump-bearing direction)))

(defn advance [robot]
  (let [offset (offset-for-bearing (:bearing robot))]
    (update robot :coordinates (partial translate offset))))

(defn execute
  [command robot]
  (case command
    \L (rotate -1 robot)
    \R (rotate 1 robot)
    \A (advance robot)))

(defn simulate
  [commands robot]
  (if (= commands "") robot 
    (recur (subs commands 1) (execute (get commands 0) robot))))
