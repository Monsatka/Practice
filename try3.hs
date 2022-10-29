trie3 :: Trie Char Integer
trie3 = TNode Nothing [
 ('m', TNode Nothing [
 ('a', TNode Nothing [('p', TNode (Just 42) []),
 ('x', TNode (Just 1) [])]),
 ('i', TNode Nothing [('n', TNode (Just 2) [])])]
 )]
