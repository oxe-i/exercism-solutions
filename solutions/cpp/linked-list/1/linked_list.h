#pragma once

#include <memory>
#include <optional>
#include <stdexcept>

namespace linked_list {
    template <typename T>
    class List
    {
    private:
        std::optional<T> node;
        std::unique_ptr<List<T>> tail;
    public:
        List() : node{}, tail{} {}
        List(T value) : node{value}, tail{} {}
        template <typename... Ts> List(T value, Ts... values) : node{value}, tail{new List<T>{values...}} {}
        
        auto push(T val) {
            if (not node) {
                node = val;
                return;
            }

            if (not tail) {
                tail = std::make_unique<List<T>>(val);
                return;
            }

            tail->push(val);
        }

        auto pop() {
            if (not node) {
                throw std::domain_error("Empty list. Can't return value.");
            }
            
            if (not tail or not tail->node) {
                const auto val = node.value();
                node.reset();
                return val;
            }

            return tail->pop();
        }

        auto shift() {
            if (not node) {
                throw std::domain_error("Empty list. Can't return value.");
            }

            const auto val = node.value();
            node.reset();
            
            if (not tail or not tail->node) return val;
            
            node = tail->node;
            tail = std::move(tail->tail);
            return val;
        }

        auto unshift(T val) {
            tail = std::make_unique<List<T>>(std::move(*this));
            node = val;
        }

        auto count() {
            if (not node) return 0;
            if (not tail or not tail->node) return 1;
            return 1 + tail->count();
        }

        auto erase(T val) {
            if (node and node.value() == val) {
                node.reset();
                if (tail) {
                    node = tail->node;
                    tail = std::move(tail->tail);
                }
                return true;
            }

            if (not tail or not tail->node) return false;

            return tail->erase(val);
        }
    };
}  // namespace linked_list
