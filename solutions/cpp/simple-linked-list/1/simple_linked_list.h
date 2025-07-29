#if !defined(SIMPLE_LINKED_LIST_H)
#define SIMPLE_LINKED_LIST_H

#include <cstddef>
#include <memory>

namespace simple_linked_list {

class List {
public:
    List() = default;
    ~List() = default;

    List(const List&) = delete;
    List& operator=(const List&) = delete;
    List(List&&) = default;
    List& operator=(List&&) = default;

    std::size_t size() const;
    void push(int entry);
    int pop();
    void reverse();

private:
    struct Node {
        Node(int data) : data{data}, next{} {};
        int data;
        std::shared_ptr<Node> next;
    };

    std::shared_ptr<Node> head;
    std::shared_ptr<Node> tail;
    std::size_t current_size;
};

}  // namespace simple_linked_list

#endif
