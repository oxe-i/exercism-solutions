(ns bird-watcher)

(def last-week 
  [0 2 5 3 7 8 4]
  )

(defn today [birds]
  (last birds)
  )

(defn inc-bird [birds]
  (assoc birds (- (count birds) 1) (inc (today birds)))
  )

(defn day-without-birds? [birds]
  (not-every? (fn [x] (not= x 0)) birds)
  )

(defn n-days-count [birds n]
  (reduce (fn [x y] (+ x y)) (take n birds))
  )

(defn busy-days [birds]
  (count (filter (fn [x] (>= x 5)) birds))
  )

(defn odd-week? [birds]
  (loop [xs birds result 1 answer true]
    (if (and xs answer)
      (let [x (first xs)]
        (recur (next xs) (if (= result 1) 0 1) (= x result))) answer))
  )
