#if !defined(BINARY_SEARCH_TREE_H)
#define BINARY_SEARCH_TREE_H

#include <memory>
#include <vector>

namespace binary_search_tree {
    
    template<typename T>
    class binary_tree 
    {
    private:             
        T m_data;
        std::unique_ptr<binary_tree<T>> m_left;
        std::unique_ptr<binary_tree<T>> m_right;   

        struct tree_values {
            std::vector<T> tree {};

            auto inorder(const std::unique_ptr<binary_tree<T>>& root_ptr) -> void
            {
                if (not root_ptr)
                    return;

                inorder(root_ptr->left());

                tree.emplace_back(root_ptr->data());

                inorder(root_ptr->right());
            }

            auto operator() (const binary_tree<T>& root)
            {
                tree.clear();

                inorder(root.left());

                tree.emplace_back(root.data());

                inorder(root.right());
            }
        };

        tree_values values {};
    public:
        binary_tree();
        binary_tree(T value);

        auto data() const -> const T&;
        auto left() const -> const std::unique_ptr<binary_tree<T>>&;
        auto right() const -> const std::unique_ptr<binary_tree<T>>&;

        auto insert(T value) -> void;

        auto begin();
        auto end();
    };

    template<typename T>
    binary_tree<T>::binary_tree() : m_data{}, m_left{nullptr}, m_right{nullptr} {}

    template<typename T>
    binary_tree<T>::binary_tree(T value) : m_data{value}, m_left{nullptr}, m_right{nullptr} {}

    template<typename T>
    auto binary_tree<T>::data() const -> const T&
    {
        return m_data;
    }

    template<typename T>
    auto binary_tree<T>::left() const -> const std::unique_ptr<binary_tree<T>>&
    {
        return m_left;
    }

    template<typename T>
    auto binary_tree<T>::right() const -> const std::unique_ptr<binary_tree<T>>&
    {
        return m_right;
    }

    template<typename T>
    auto binary_tree<T>::insert(T value) -> void
    {
        if (not m_left and value <= m_data) {
            m_left = std::make_unique<binary_tree<T>>(value);
            return;
        }

        if (not m_right and value > m_data) {
            m_right = std::make_unique<binary_tree<T>>(value);
            return;
        }

        if (m_left and value <= m_data) {
            m_left->insert(value);
            return;
        }

        if (m_right and value > m_data) {
            m_right->insert(value);
            return;
        }
        
    }

    template<typename T>
    auto binary_tree<T>::begin()
    {
        values(*this);
        return values.tree.begin();
    }

    template<typename T>
    auto binary_tree<T>::end()
    {
        return values.tree.end();
    }
}  // namespace binary_search_tree

#endif // BINARY_SEARCH_TREE_H