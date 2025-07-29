#if !defined(ROBOT_SIMULATOR_H)
#define ROBOT_SIMULATOR_H

#include <utility>
#include <string>

namespace robot_simulator {  
   enum class Bearing : int {    
      NORTH,
      EAST,
      SOUTH,
      WEST
   };

   class Robot {
   private:
      std::pair<int, int> m_position;
      Bearing m_bearing;
   public:
      Robot();
      Robot(std::pair<int, int> position, Bearing bearing);

      auto get_position() const -> std::pair<int, int>;
      auto get_bearing() const -> Bearing;
      auto turn_right() -> void;
      auto turn_left() -> void;
      auto advance() -> void;
      auto execute_sequence(const std::string& commands) -> void;
   };
}  // namespace robot_simulator

#endif // ROBOT_SIMULATOR_H