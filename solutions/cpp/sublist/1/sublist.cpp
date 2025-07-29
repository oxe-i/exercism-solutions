#include "sublist.h"

namespace sublist {
    auto is_contained(const List& fst, const List& snd) 
    {
        if (not fst.node) return true;
        if (not snd.node) return false;
        if (*fst.node == *snd.node) return is_contained(*fst.tail, *snd.tail);
        return false;
    }

    auto is_sublist(const List& fst, const List& snd) 
    {
        if (not fst.node) return true;
        if (not snd.node) return false;
        if (is_contained(fst, snd)) return true;
        return is_sublist(fst, *snd.tail);
    }

    auto is_superlist(const List& fst, const List& snd)
    {
        return is_sublist(snd, fst);
    }

    auto is_equal(const List& fst, const List& snd) -> bool
    {
        if (not fst.node and not snd.node) return true;
        if (not fst.node or not snd.node) return false;
        return *fst.node == *snd.node and is_equal(*fst.tail, *snd.tail);
    }

    auto sublist(List fst, List snd) -> sublist::List_comparison 
    {
        if (is_equal(fst, snd)) 
            return sublist::List_comparison::equal;        
        if (is_sublist(fst, snd)) 
            return sublist::List_comparison::sublist;        
        if (is_superlist(fst, snd)) 
            return sublist::List_comparison::superlist;
        
        return sublist::List_comparison::unequal;
    }
}
