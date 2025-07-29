#include "simple_linked_list.h"

#include <stdexcept>

namespace simple_linked_list {

    std::size_t List::size() const {
        return current_size;
    }

    void List::push(int entry) {
        if (current_size) {
            tail->next = std::make_shared<Node>(entry);
            tail = tail->next;
        }
        else {
            head = std::make_shared<Node>(entry);
            tail = head;
        }

        current_size++;
    }

    int List::pop() {
        if (current_size == 0) {
            throw std::domain_error("no value to return.");
        }

        if (current_size == 1) {
            auto value = head->data;

            head = nullptr;
            tail = nullptr;
            current_size--;

            return value;
        }

        auto current_node = head;

        for (std::size_t index {}; index + 2 < current_size; ++index) {
            current_node = current_node->next;
        }

        auto value = tail->data;

        tail = current_node;
        current_size--;

        return value;
    }

    void List::reverse() {
        if (current_size > 1) {         
            auto previous_node = head;
            auto current_node = head->next;

            for (std::size_t index {}; index + 1 < current_size; ++index) {
                auto next_node = current_node->next;

                current_node->next = previous_node;
                previous_node = current_node;
                current_node = next_node;
            }

            tail = head;
            head = previous_node;
        }
    }

}  // namespace simple_linked_list
