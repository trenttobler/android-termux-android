-----------------------------------------------------------------------------
-- |
-- Module      :  System.Info
-- Copyright   :  (c) The University of Glasgow 2001
-- License     :  BSD-style (see the file libraries/base/LICENSE)
-- 
-- Maintainer  :  libraries@haskell.org
-- Stability   :  experimental
-- Portability :  portable
--
-- Information about the characteristics of the host 
-- system lucky enough to run your program.
--
-----------------------------------------------------------------------------

module System.Info
   (
       os,		    -- :: String
       arch,		    -- :: String
       compilerName,	    -- :: String
       compilerVersion	    -- :: Version
   ) where

import Prelude
import Data.Version

-- | The version of 'compilerName' with which the program was compiled
-- or is being interpreted.
compilerVersion :: Version
compilerVersion = Version {versionBranch=[maj,min], versionTags=[]}
  where (maj,min) = compilerVersionRaw `divMod` 100

-- | The operating system on which the program is running.
os :: String

-- | The machine architecture on which the program is running.
arch :: String

-- | The Haskell implementation with which the program was compiled
-- or is being interpreted.
compilerName :: String

compilerVersionRaw :: Int














                                                                                                            







                                                      












                                                         











os = "linux"
arch = "x86_64"
compilerName = "hugs"
compilerVersionRaw = 0  -- ToDo




