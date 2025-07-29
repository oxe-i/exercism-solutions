#if !defined(CIRCULAR_BUFFER_H)
#define CIRCULAR_BUFFER_H

#include <optional>
#include <stdexcept>
#include <type_traits>

namespace circular_buffer {
    template <typename T>
    class circular_buffer
    {
    private:
        struct Node 
        {
            std::optional<T> node;
            Node* next;

            ~Node() 
            {
                node.reset();
                next = nullptr;
            }
        };
        
        Node* const values;
        Node* m_read;
        Node* m_write;
    public:
        ~circular_buffer() 
        {
            if (values) delete[] values;
            m_read = nullptr;
            m_write = nullptr;
        }

        circular_buffer(std::size_t size) :
            values{new Node[size]},
            m_read{&values[0]},
            m_write{&values[0]}
        {
            for (std::size_t i = 0; i < size - 1; ++i)
                values[i].next = &values[i + 1];
            values[size - 1].next = &values[0];
        }

        auto read()
        {
            if (not m_read->node)
                throw std::domain_error("can't read from an empty buffer.");
            
            const auto answer = m_read->node.value();
            m_read->node.reset();
            m_read = m_read->next;
            return answer;
        }

        auto write(T val)
        {
            if (m_write->node)
                throw std::domain_error("can't write to a full buffer.");
            
            if constexpr (std::is_scalar_v<T>)
                m_write->node = val;
            else
                m_write->node = std::move(val);

            m_write = m_write->next;
        }

        auto clear()
        {
            while (m_read->node)
            {
                m_read->node.reset();
                m_read = m_read->next;
            }
            m_write = m_read;
        }

        auto overwrite(T val)
        {
            if (not m_write->node)
            {
                write(val);
                return;
            }

            if constexpr (std::is_scalar_v<T>)
                m_read->node = val;
            else
                m_read->node = std::move(val);
                
            m_read = m_read->next;
        }

    };
}  // namespace circular_buffer

#endif // CIRCULAR_BUFFER_H