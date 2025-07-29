#ifndef PLAY_H
#define PLAY_H

#include <optional>
#include <memory>
#include <vector>
#include <cctype>

namespace play { 
    template <typename T>
    class List
    {
    private:
        std::optional<T> node;
        std::shared_ptr<List<T>> tail;
    public:
        List() : node{}, tail{} {}
        List(T elem) : node{elem}, tail{new List<T>{}} {}
        List(const T* arr) : node{}, tail{} 
        {
            if (arr[0] != '\0') 
            {
                node = arr[0];
                tail = std::make_shared<List<T>>(arr + 1);
            }
        }

        List(const T* arr, std::size_t size) : node{}, tail{}
        {
            if (size)
            {
                node = arr[0];
                tail = std::make_shared<List<T>>(arr + 1, size - 1);
            }
        }

        List(T elem, const List<T>& list) : 
            node{elem}, 
            tail{new List<T>{list}} {}

        List(const std::vector<T>& vec) :
            node{},
            tail{}
        {
            if (not vec.empty())
            {
                *this = List{std::data(vec), vec.size()};
            }
        }

        template <std::size_t N>
        List(T arr[N]) : node{}, tail{} 
        {
            if constexpr (N > 0) 
            {
                node = arr[0];
                tail = std::make_shared<List<T>>(arr + 1);
            }
        }
      
        template <typename... Other>
        List(T fst, T snd, Other... other) : 
            node{fst}, 
            tail{new List<T>{snd, other...}} {}

        friend auto is_empty(const List<T>& list) -> bool
        {
            return not list.node.has_value();
        }

        friend auto car(const List<T>& list) -> T
        {
            return list.node.value();
        }

        friend auto cdr(const List<T>& list) -> List<T>
        {
            return not list.tail ? list : *list.tail;
        }
    };

    using String = List<char>;

    List(const char*) -> String;

    template <typename T>
    static auto operator==(const List<T>& fst, const List<T>& snd) -> bool
    {
        if (is_empty(fst) and is_empty(snd)) return true;
        if (is_empty(fst) or is_empty(snd)) return false;
        return car(fst) == car(snd) and cdr(fst) == cdr(snd);
    }

    static auto operator==(const String& fst, const String& snd) -> bool
    {
        if (is_empty(fst) and is_empty(snd)) return true;
        if (is_empty(fst) or is_empty(snd)) return false;
        return car(fst) == car(snd) and cdr(fst) == cdr(snd);
    }

    template <typename T>
    auto size(const List<T>& list) -> std::size_t
    {
        return is_empty(list) ? 0 : 1 + size(cdr(list));
    }

    template <typename T, typename... Other>
    auto append(const List<T>& fst, const List<T>& snd, Other... other) -> List<T>
    {
        if constexpr (sizeof...(Other))
        {
            if (is_empty(fst)) return append(snd, other...);
            if (is_empty(snd)) return append(fst, other...);
            return {car(fst), append(cdr(fst), snd, other...)};
        }
        else
        {
            if (is_empty(fst)) return snd;
            if (is_empty(snd)) return fst;
            return {car(fst), append(cdr(fst), snd)};
        }   
    }

    template <typename T, typename Morph>
    auto fmap(Morph morph, const List<T>& list) -> List<T>
    {
        if (is_empty(list)) return {};
        return append<T>({morph(car(list))}, fmap(morph, cdr(list)));
    }

    template <typename T>
    auto contains(const List<T>& list, T elem) -> bool
    {
        if (is_empty(list)) return false;
        return car(list) == elem or contains(cdr(list), elem);
    }

    template <typename T>
    auto contains(const List<T>& list, const List<T>& sublist) -> bool
    {
        if (is_empty(sublist)) return true;
        if (is_empty(list)) return false;
        if (car(list) == car(sublist) and 
            begins(cdr(sublist), cdr(list)))
            return true;
        return contains(cdr(list), sublist);
    }

    template <typename T>
    auto begins(const List<T>& fst, const List<T>& snd) -> bool
    {
        if (is_empty(fst)) return true;
        if (is_empty(snd)) return false;
        return car(fst) == car(snd) and begins(cdr(fst), cdr(snd));
    }

    template <typename T>
    auto ends(const List<T>& fst, const List<T>& snd) -> bool
    {
        const auto size_fst = size(fst), size_snd = size(snd);
        if (size_fst > size_snd) return false;
        if (size_fst == size_snd) return fst == snd;
        return fst == drop(size_snd - size_fst, snd);       
    }

    template <typename T, typename Fun, typename Acc = T>
    auto foldl(Fun fun, const List<T>& list, Acc initial = Acc{}) -> Acc
    {
        if (is_empty(list)) return initial;
        return foldl(fun, cdr(list), fun(initial, car(list)));
    }

    template <typename Pred, typename T>
    auto slice(Pred pred, const List<T>& list) -> List<List<T>>
    {
        if (is_empty(list)) return {};
        if (pred(car(list))) 
            return List<List<T>>{List<T>{}, list};

        const auto sliced_tail = slice(pred, cdr(list));

        if (is_empty(sliced_tail)) return {};
        return append<List<T>>(
            append<T>(car(list), car(sliced_tail)),
            cdr(sliced_tail)
        );
    }

    template <typename T>
    auto take(std::size_t length, const List<T>& list) -> List<T>
    {
        if (is_empty(list) or length == 0) return {};
        return append({car(list)}, take(length - 1, cdr(list)));
    }

    template <typename T>
    auto drop(std::size_t length, const List<T>& list) -> List<T>
    {
        if (is_empty(list)) return {};
        if (length == 0) return list;
        return drop(length - 1, cdr(list));
    }

namespace {
    constexpr auto space_delimiter = [](char x) -> bool {return std::isspace(x);};
}

    template <typename Pred = decltype(space_delimiter), typename T = char>
    auto extract(const List<T>& text, Pred pred = space_delimiter) -> List<String>
    {
        if (is_empty(text)) return {};
        const auto first_word = slice(pred, text);
        if (is_empty(cdr(first_word))) return {text};
        return append(
            {car(first_word)},
            extract(drop(1, car(cdr(first_word))))
        );
    }

    template <typename T = char>
    auto phrase(const List<List<T>>& words, const List<T>& delimiter = String{" "}) -> List<T>
    {
        if (is_empty(words)) return {};
        return foldl(
                [delimiter](const List<T>& acc, const List<T>& word)
                {
                    return append(acc, delimiter, word);
                },
                cdr(words),
                car(words));
    }
}

#endif