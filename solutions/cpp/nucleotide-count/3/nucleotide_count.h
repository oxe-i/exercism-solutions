#if !defined(NUCLEOTIDE_COUNT_H)
#define NUCLEOTIDE_COUNT_H

#include <string_view>
#include <array>
#include <map>
#include <stdexcept>

namespace nucleotide_count 
{
   
constexpr auto adenine = 'A';
constexpr auto cytosine = 'C';
constexpr auto guanine = 'G';
constexpr auto thymine = 'T';

struct nucleotide_map
{
   std::array<std::pair<char, int>, 4> m_map 
   {
      std::pair{adenine, 0},
      {cytosine, 0},
      {guanine, 0},
      {thymine, 0}
   };

   constexpr auto& operator[](char nucleotide)
   {
      if (nucleotide == adenine) return m_map[0].second;
      if (nucleotide == cytosine) return m_map[1].second;
      if (nucleotide == guanine) return m_map[2].second;
      if (nucleotide == thymine) return m_map[3].second;
      throw std::invalid_argument("nucleotide invalid.");
   }

   constexpr auto& operator[](char nucleotide) const
   {
      if (nucleotide == adenine) return m_map[0].second;
      if (nucleotide == cytosine) return m_map[1].second;
      if (nucleotide == guanine) return m_map[2].second;
      if (nucleotide == thymine) return m_map[3].second;
      throw std::invalid_argument("nucleotide invalid.");
   }
};

using std_map = std::map<char, int>;

constexpr auto operator==(const std_map& map1, const nucleotide_map& map2)
{
   if (const auto adenine_freq = map2[adenine]; 
      adenine_freq and map1.at(adenine) != adenine_freq) 
      return false;
   if (const auto cytosine_freq = map2[cytosine]; 
      cytosine_freq and map1.at(cytosine) != cytosine_freq) 
      return false;
   if (const auto guanine_freq = map2[guanine]; 
      guanine_freq and map1.at(guanine) != guanine_freq) 
      return false;
   if (const auto thymine_freq = map2[thymine]; 
      thymine_freq and map1.at(thymine) != thymine_freq) 
      return false;
   return true;
}

constexpr auto valid_nucleotide(char nucleotide)
{
   switch (nucleotide)
   {
      case adenine:
      case cytosine:
      case guanine:
      case thymine:
         return true;
      default:
         return false;
   }
}

constexpr auto count(std::string_view dna) -> nucleotide_map
{
   auto map = nucleotide_map{};
   for (const auto nucleotide : dna)
   {
      if (not valid_nucleotide(nucleotide)) 
         throw std::invalid_argument("nucleotide must be 'A', 'C', 'G' or 'T'.");
      map[nucleotide]++;
   }
   return map;
}
}  // namespace nucleotide_count

#endif // NUCLEOTIDE_COUNT_H