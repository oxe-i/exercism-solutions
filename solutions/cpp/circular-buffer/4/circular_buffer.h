#if !defined(CIRCULAR_BUFFER_H)
#define CIRCULAR_BUFFER_H

#include <queue>
#include <stdexcept>

namespace circular_buffer {
    template <typename T>
    class circular_buffer {
        const std::size_t m_size;
        std::queue<T> m_buffer;
    public:
        circular_buffer() = delete;
        circular_buffer(std::size_t size) :
            m_size{size},
            m_buffer{} 
        {
        }

        auto read() {
            if (m_buffer.empty()) throw std::domain_error("can't read from an empty buffer.");
            const auto value = m_buffer.front();
            m_buffer.pop();
            return value;
        }

        auto write(T val) {
            if (m_buffer.size() == m_size) throw std::domain_error("can't write to a full buffer.");
            m_buffer.emplace(val);
        }

        auto clear() { m_buffer = std::queue<T>{}; }

        auto overwrite(T val) {
            if (m_buffer.size() == m_size) m_buffer.pop();
            m_buffer.emplace(val);
        }
    };
}  // namespace circular_buffer

#endif // CIRCULAR_BUFFER_H