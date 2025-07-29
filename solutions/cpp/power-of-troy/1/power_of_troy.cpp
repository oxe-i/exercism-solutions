#include "power_of_troy.h"

namespace troy {
    auto give_new_artifact(human& receiver, std::string name) -> void
    {
        receiver.possession = std::make_unique<artifact>(name);
    }
    
    auto exchange_artifacts(std::unique_ptr<artifact>& first, std::unique_ptr<artifact>& second) -> void
    {
        std::swap(first, second);
    }
    
    auto manifest_power(human& receiver, std::string name) -> void
    {
        receiver.own_power = std::make_shared<power>(name);
    }
    
    auto use_power(const human& caster, human& target) -> void
    {
        target.influenced_by = caster.own_power;
    }
    
    auto power_intensity(const human& caster) -> int
    {
        return caster.own_power.use_count();
    }
}  // namespace troy
