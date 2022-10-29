type ModuleName = String
type Version    = String
type ModuleId   = Int
type UserName   = String
type Timestamp  = Int

type Module     = (ModuleId, ModuleName, Version)

type Dependency = (ModuleId, ModuleId)

type Usage      = (ModuleId, UserName, Timestamp)

type Database   = ([Module], [Dependency], [Usage])

-- Gettery
getModuleId :: Module -> ModuleId
getModuleId (x, _, _) = x

getModuleName :: Module -> ModuleName
getModuleName (_, x, _) = x

getVersion :: Module -> Version
getVersion (_, _, x) = x

getUsageMId :: Usage -> ModuleId
getUsageMId (x, _, _) = x

getTimestamp :: Usage -> Timestamp
getTimestamp (_, _, x) = x

getUser :: Usage -> UserName
getUser (_, x, _) = x

-- Funkce pracující s databází
moduleInfo :: ModuleId -> [Module] -> (ModuleName, Version)
moduleInfo i ((x, y, z):t) = if i == x then (y, z) else moduleInfo i t

moduleId :: ModuleName -> Version -> [Module] -> ModuleId
moduleId n v (s:t) = if n == getModuleName s && v == getVersion s then getModuleId s else moduleId n v t

versionsOf :: ModuleName -> [Module] -> [(ModuleId, Version)]
versionsOf n [] = []
versionsOf n (s:t) = func n (s:t) []
 where
 func n [] l = l
 func n (s:t) l = if n == getModuleName s then func n t (l ++ [(getModuleId s, getVersion s)]) else func n t l 

lastUsedModule :: [Usage] -> ModuleId
lastUsedModule [x] = getUsageMId x 
lastUsedModule (x:xs) = func (x:xs) 0 [] 
 where
  func [] t l = head l
  func (x:xs) t l = if (getTimestamp x) >= t then func xs (getTimestamp x) ((getUsageMId x) : l) else func xs t l

lastUserOf :: ModuleId -> [Usage] -> UserName
lastUserOf i (s:t) = func i (s:t) [] 0
 where 
  func i [] l n = head l
  func i (s:t) l n = if i == (getUsageMId s) && (getTimestamp s) >= n then func i t ((getUser s) : l) (getTimestamp s) else func i t l n

insertUsage :: ModuleId -> UserName -> Timestamp
            -> [Usage] -> [Usage]
insertUsage i n t [] = [(i, n, t)]
insertUsage i n t (x:xs) = func i n t (x:xs) []
 where
  func i n t [] l = l
  func i n t (x:xs) l = if i == (getUsageMId x) && n == (getUser x) && t > (getTimestamp x) then l ++ [(i,n,t)] ++ xs
   else if i == (getUsageMId x) && n == (getUser x) && t < (getTimestamp x) then l ++ (x:xs) 
   else if (length [(x:xs)]) == 1 && i /= (getUsageMId x) && n /= (getUser x) then (l ++ (x:xs) ++ [(i,n,t)])
   else func i n t xs (l ++ [x])
  
dependenciesOf :: ModuleId -> [Dependency] -> [ModuleId]
dependenciesOf i ((x,y):t) = func i ((x,y):t) []
 where 
  func i [] l = l
  func i ((x, y):t) l = if i == x then func i t (if y `elem` l then l ++ [] else l ++ [y]) else func i t l

dependingOn :: ModuleId -> [Dependency] -> [ModuleId]
dependingOn i ((x,y):t) = func i ((x,y):t) []
 where
  func i [] l = l
  func i ((x, y):t) l = if i == y then func i t (if x `elem` l then l ++ [] else l ++ [x]) else func i t l

activeSince :: Timestamp -> Database -> [ModuleId]
activeSince = undefined

purgeModule :: ModuleId -> Database -> Database
purgeModule = undefined

-------------------------------------------------------------------------------
--                     S A M P L E    D A T A B A S E                        --
-------------------------------------------------------------------------------

testDB :: Database
testDB = (testModules, testDependencies, testUsage)

testModules :: [Module]
testModules = [ (1, "ghc", "9.0.1"), (2, "xmobar", "0.35.1"), (3, "ghc", "8.4.3")
              , (42, "gcc", "10.3.0"), (66, "git", "2.25.1"), (100, "libc", "2.31")
              , (5, "perl", "5.24") ]

testDependencies :: [Dependency]
testDependencies = [ (2, 1), (100, 42), (66, 42), (66, 5) ]

testUsage :: [Usage]
testUsage = [ (1, "Simon Marlow", 1631009291), (5, "Larry Wall", 1464048000)
            , (2, "Gary Fuchs", 1580443221), (3, "Linus O'Reilly", 1493401234)
            , (5, "Garry Fuchs", 1323491235) ]

