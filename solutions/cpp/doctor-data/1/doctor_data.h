#ifndef DOCTOR_DATA_H
#define DOCTOR_DATA_H

#include <string>
#include <optional>

namespace star_map {
    enum class System {
        AlphaCentauri,
        EpsilonEridani,
        BetaHydri,
        DeltaEridani,
        Omicron2Eridani,
        Sol
    };
}

namespace heaven {
    
    struct Vessel {
        std::string name;
        unsigned generation;
        unsigned busters;
        star_map::System current_system;

        Vessel(std::string name, unsigned number) :
            name{name},
            generation{number},
            busters{},
            current_system {star_map::System::Sol} {}

        Vessel(std::string name, unsigned number, star_map::System system) :
            name{name},
            generation{number},
            busters{},
            current_system{system} {}

        auto replicate(std::string new_name) -> Vessel {
            return Vessel{new_name, generation + 1, current_system};
        }

        auto make_buster() -> void {
            busters++;
        }

        auto shoot_buster() -> bool {
            if (busters) {
                busters--;
                return true;
            }
            
            return false;
        }
    };

    auto get_older_bob(Vessel vessel1, Vessel vessel2) -> std::string {
        return vessel1.generation < vessel2.generation ? 
                vessel1.name :
                vessel2.name;
    }

    auto in_the_same_system(Vessel vessel1, Vessel vessel2) -> bool {
        return vessel1.current_system == vessel2.current_system;
    }
}

#endif
