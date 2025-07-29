#if !defined(CIRCULAR_BUFFER_H)
#define CIRCULAR_BUFFER_H

#include <vector>
#include <cstddef>
#include <stdexcept>

namespace circular_buffer {
    template<typename T>
    class circular_buffer {
    private:
        std::vector<T> buffer;
        std::size_t old_index;
        std::size_t new_index;
        std::size_t num_of_elements;

        auto update_index(std::size_t& index) -> void;
    public:
        circular_buffer() = delete;
        circular_buffer(std::size_t size);

        auto read() -> T;
        auto write(T value) -> void;
        auto clear() -> void;
        auto overwrite(T value) -> void;
    };

    template<typename T>
    auto circular_buffer<T>::update_index(std::size_t& index) -> void {
        if (index < buffer.size() - 1)
        {
            index++;
        }
        else
        {
            index = 0;
        }         
    }

    template<typename T>
    circular_buffer<T>::circular_buffer(std::size_t size) : buffer(size, T{}), old_index{}, new_index{}, num_of_elements{} {}

    template<typename T>
    auto circular_buffer<T>::clear() -> void {
        num_of_elements = 0;
    }

    template<typename T>
    auto circular_buffer<T>::read() -> T {
        if (not num_of_elements)
        {
            throw std::domain_error("can't read from an empty buffer.");
        }

        auto value = std::move(buffer.at(old_index));

        update_index(old_index);

        num_of_elements--;

        return value;
    }

    template<typename T>
    auto circular_buffer<T>::write(T value) -> void {
        if (num_of_elements == buffer.size())
        {
            throw std::domain_error("can't write to a full buffer.");
        }

        buffer.at(new_index) = std::move(value);

        update_index(new_index);

        num_of_elements++;
    }

    template<typename T>
    auto circular_buffer<T>::overwrite(T value) -> void {
        if (num_of_elements == buffer.size())
        {
            buffer.at(old_index) = std::move(value);

            update_index(old_index);
        }
        else
        {
            write(value);
        }
    }
}  // namespace circular_buffer

#endif // CIRCULAR_BUFFER_H