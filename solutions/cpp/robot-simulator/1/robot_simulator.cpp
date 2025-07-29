#include "robot_simulator.h"

namespace robot_simulator {
   Robot::Robot() : m_position{}, m_bearing{Bearing::NORTH} {}

   Robot::Robot(std::pair<int, int> position, Bearing bearing) :
        m_position{std::move(position)}, 
        m_bearing{std::move(bearing)} {}

   auto Robot::get_position() const -> std::pair<int, int> {
       return m_position;
   }

   auto Robot::get_bearing() const -> Bearing {
       return m_bearing;
   }

   auto Robot::turn_right() -> void {
       switch (m_bearing) {
           case Bearing::NORTH:
             m_bearing = Bearing::EAST;
             break;
           case Bearing::EAST:
             m_bearing = Bearing::SOUTH;
             break;
           case Bearing::SOUTH:
             m_bearing = Bearing::WEST;
             break;
           case Bearing::WEST:
             m_bearing = Bearing::NORTH;
             break;
       }
   }

   auto Robot::turn_left() -> void {
       switch (m_bearing) {
           case Bearing::NORTH:
             m_bearing = Bearing::WEST;
             break;
           case Bearing::EAST:
             m_bearing = Bearing::NORTH;
             break;
           case Bearing::SOUTH:
             m_bearing = Bearing::EAST;
             break;
           case Bearing::WEST:
             m_bearing = Bearing::SOUTH;
             break;
       }
   }

   auto Robot::advance() -> void {
       switch (m_bearing) {
         case Bearing::NORTH:
           m_position.second++;
           break;
         case Bearing::SOUTH:
           m_position.second--;
           break;
         case Bearing::EAST:
           m_position.first++;
           break;
         case Bearing::WEST:
           m_position.first--;
           break;
       }
   }

   auto Robot::execute_sequence(const std::string& commands) -> void{
       for (const auto& command : commands) {
           switch (command) {
               case 'R':
                  turn_right();
                  break;
               case 'L':
                  turn_left();     
                  break;
               case 'A':
                  advance();     
                  break;
            }
        }
    }
}  // robot_simulator
