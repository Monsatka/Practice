-- Neměňte datové typy
data Trie e a = TNode (Maybe a) [Edge e a]
            deriving (Show, Eq)

type Edge e a = (e, Trie e a)
-- konec datových typů

-- implementujte následující funkce

emptyTrie :: Trie e a
emptyTrie e a = Empty 

isTrieValid :: Ord e => Trie e a -> Bool
isTrieValid = undefined

trieLookup :: Ord e => [e] -> Trie e a -> Maybe a
trieLookup = undefined

trieMember :: Ord e => [e] -> Trie e a -> Bool
trieMember = undefined

trieMapMaybe :: ([e] -> a -> Maybe b) -> Trie e a -> Trie e b
trieMapMaybe = undefined

trieMap :: ([e] -> a -> b) -> Trie e a -> Trie e b
trieMap = undefined

trieFilter :: ([e] -> a -> Bool) -> Trie e a -> Trie e a
trieFilter = undefined

trieToList :: Trie e a -> [([e], a)]
trieToList = undefined

trieMerge :: Ord e => ([e] -> a -> a -> Maybe a) -> Trie e a -> Trie e a -> Trie e a
trieMerge = undefined

singletonTrie :: [e] -> a -> Trie e a
singletonTrie = undefined

trieInsert :: Ord e => [e] -> a -> Trie e a -> Trie e a
trieInsert = undefined

trieDelete :: Ord e => [e] -> Trie e a -> Trie e a
trieDelete = undefined

-- příklady prefixových stromů

trie1 :: Trie Char Integer
trie1 = TNode (Just 42)
        [('a', TNode (Just 16) []),
         ('b', TNode Nothing
               [('b', TNode (Just 1) []),
                ('c', TNode (Just 5) []),
                ('e', TNode (Just 2) [])
               ])
        ]

trie2 :: Trie Char Integer
trie2 = TNode Nothing
        [('m', TNode Nothing
               [('a', TNode Nothing
                      [('p', TNode (Just 42)
                             [('M', TNode (Just 0) [])]),
                       ('x', TNode (Just 1) []),
                       ('y', TNode Nothing
                             [('b', TNode Nothing
                                    [('e', TNode (Just 4) [])])
                             ])
                      ]),
                ('i', TNode Nothing
                      [('n', TNode (Just 2) [])])
               ])
        ]

trie3 :: Trie Char Integer
trie3 = TNode Nothing
        [('m', TNode Nothing
               [('a', TNode Nothing
                      [('p', TNode (Just 42) []),
                       ('x', TNode (Just 1) [])
                      ]),
                ('i', TNode Nothing
                      [('n', TNode (Just 2) [])])
               ])
        ]

trie4 :: Trie Char String
trie4 = TNode (Just "")
        [('a', TNode (Just "hello") []),
         ('b', TNode (Just "")
               [('b', TNode (Just "ahoj") [])])
        ]

