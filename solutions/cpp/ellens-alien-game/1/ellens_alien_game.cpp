#include <cstddef>

namespace targets {
   class Alien {
   public:
     int x_coordinate;
     int y_coordinate;
     
     Alien(int x, int y) :
         x_coordinate{x},
         y_coordinate{y},
         health{3}
         {}

     auto get_health() const -> int {
         return health;
     }

     auto hit() -> bool {
         if (health) {
             --health;
         }
         return true;
     }

     auto is_alive() -> bool {
         return health > 0;
     }

     auto teleport(int new_x, int new_y) -> bool {
         x_coordinate = new_x;
         y_coordinate = new_y;
         return true;
     }

     auto collision_detection(Alien other) -> bool {
         return x_coordinate == other.x_coordinate and
             y_coordinate == other.y_coordinate;
     }
     
   private:
     std::size_t health;
   };
}  // namespace targets