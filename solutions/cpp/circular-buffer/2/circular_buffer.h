#if !defined(CIRCULAR_BUFFER_H)
#define CIRCULAR_BUFFER_H

#include <optional>
#include <cstddef>
#include <stdexcept>

namespace circular_buffer {
    template <typename T>
    class circular_buffer
    {
    private:
        struct List
        {
            std::optional<T> node;
            List* next;
        };

        List* m_read;
        List* m_write;
    public:
        ~circular_buffer()
        {
            auto crt = m_read;

            while (true) 
            {
                auto next = crt->next;
                crt->next = nullptr;
                delete crt;
                if (next == m_read) break;
                crt = next;
            }

            m_read = nullptr;
            m_write = nullptr;
        }

        circular_buffer() = delete;
        circular_buffer(std::size_t size) :
            m_read{},
            m_write{}
        {
            if (size)
            {
                m_read = new List{};
                m_write = m_read;
                size--;           

                auto crt = m_read;
                while (size)
                {
                    crt->next = new List{};
                    crt = crt->next;
                    size--;
                }

                crt->next = m_read;
            }
        }

        auto read()
        {
            if (not m_read or not m_read->node) throw std::domain_error("can't read from an empty buffer.");

            auto value = m_read->node.value();
            m_read->node.reset();
            m_read = m_read->next;

            return value;
        }

        auto write(T val)
        {
            if (not m_write or m_write->node) throw std::domain_error("can't write to a full buffer.");

            m_write->node = val;
            m_write = m_write->next;
        }

        auto clear()
        {
            auto crt = m_read;
            while (crt and crt->node)
            {
                crt->node.reset();
                crt = crt->next;
            }
        }

        auto overwrite(T val)
        {
            if (m_write and not m_write->node) 
            {
                write(val);
                return;
            }
            m_read->node = val;
            m_read = m_read->next;
        }
    };
}  // namespace circular_buffer

#endif // CIRCULAR_BUFFER_H