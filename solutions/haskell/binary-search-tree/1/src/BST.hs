module BST
    ( BST
    , bstLeft
    , bstRight
    , bstValue
    , empty
    , fromList
    , insert
    , singleton
    , toList
    ) where

import Data.List (foldl')

data BST a = Leaf | Node a (BST a) (BST a)
      deriving (Eq, Show)

bstLeft :: BST a -> Maybe (BST a)
bstLeft Leaf = Nothing
bstLeft (Node _ l _) = Just l

bstRight :: BST a -> Maybe (BST a)
bstRight Leaf = Nothing
bstRight (Node _ _ r) = Just r

bstValue :: BST a -> Maybe a
bstValue Leaf = Nothing
bstValue (Node v _ _) = Just v

empty :: BST a
empty = Leaf

fromList :: Ord a => [a] -> BST a
fromList xs = foldl' (\x y -> insert y x) Leaf xs

insert :: Ord a => a -> BST a -> BST a
insert x Leaf = Node x Leaf Leaf
insert x (Node y l r) = if x <= y then Node y (insert x l) r
                        else Node y l (insert x r)

singleton :: a -> BST a
singleton x = Node x Leaf Leaf

toList :: BST a -> [a]
toList Leaf = []
toList (Node v l r) = toList l ++ (v: toList r)
