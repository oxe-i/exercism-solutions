{-# LANGUAGE InstanceSigs #-} 

module LinkedList
    ( LinkedList
    , datum
    , fromList
    , isNil
    , new
    , next
    , nil
    , reverseLinkedList
    , toList
    ) where

import Data.Foldable (Foldable)

data LinkedList a = Empty | Node a (LinkedList a)
   deriving (Eq, Show)

instance Foldable LinkedList where
   foldr :: (a -> b -> b) -> b -> LinkedList a -> b
   foldr _ acc Empty = acc
   foldr f acc (Node x xs) = f x (foldr f acc xs)

instance Functor LinkedList where
   fmap :: (a -> b) -> LinkedList a -> LinkedList b
   fmap _ Empty = Empty
   fmap f (Node x xs) = Node (f x) (fmap f xs)

instance Semigroup (LinkedList a) where
   (<>) :: LinkedList a -> LinkedList a -> LinkedList a
   Empty <> x2 = x2
   x1 <> Empty = x1
   (Node x1 xs) <> x2 = Node x1 (xs <> x2)

instance Monoid (LinkedList a) where
   mempty :: LinkedList a
   mempty = Empty

datum :: LinkedList a -> a
datum Empty = undefined
datum (Node x xs) = x

fromList :: [a] -> LinkedList a
fromList [] = Empty
fromList (x:xs) = Node x (fromList xs)

isNil :: LinkedList a -> Bool
isNil Empty = True
isNil _ = False

new :: a -> LinkedList a -> LinkedList a
new x linkedList = Node x (linkedList)

next :: LinkedList a -> LinkedList a
next Empty = undefined
next (Node x xs) = xs

nil :: LinkedList a
nil = Empty

reverseLinkedList :: LinkedList a -> LinkedList a
reverseLinkedList = foldr helper Empty
  where helper x acc = acc <> (new x Empty)

toList :: LinkedList a -> [a]
toList = foldr (:) []
