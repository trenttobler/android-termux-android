-----------------------------------------------------------------------------
-- |
-- Module      :  System.Posix.Signals
-- Copyright   :  (c) The University of Glasgow 2002
-- License     :  BSD-style (see the file libraries/base/LICENSE)
-- 
-- Maintainer  :  libraries@haskell.org
-- Stability   :  provisional
-- Portability :  non-portable (requires POSIX)
--
-- POSIX signal support
--
-----------------------------------------------------------------------------

                                                                              
                                                                             

                         


                          


                              


                                 


                        


                                


                          


                            


                         


                           


                           


                         


                          


                         


                                


                                


                              


                           


                                


                          


                        


                          


                          


                          


                         


                          


                             


                                


                         


                          


                               


                         


                          


                       


                           


                          


                         


                          


                          


                            


                             


                                


                            


                             


                               


                          


                           


                            


                           


                          


                          


                           


                          


                           


                          


                          


                          


                               


                          


                         


                          


                          


                           


                            


                           


                             


                            


                          


                         


                              


                         


                                


                         


                            


                                


                                 


                                


                          


                                   


                              


                          


                           


                           


                         


                                


                            


                             


                                   


                          


                         


                          


                          


                         


                             


                                


                           


                          


                               


                         


                            


                           


                           


                          


                           


                           


                          


                          


                          


                          


                           


                           


                           


                           


                           


                           


                           


                          


                           


                           


                           


                           


                           


                          


                           


                           


                             


                           


                           


                             


                           


                           


                           


                               


                               


                                                        


                                                                                     


                                                                                    
                             

                                                         


                                                        


                                                        


                                                  


                                                   


                                                       


                                                      
                          

                                                       


                                                          


                                                      


                                                           


                                                      


                                                         


                                                         


                                                         


                                                   


                                                         


                                                       


                                                       


                                                         


                                                         


                                                         


                                                          


                                                         


                                                        


                                                               


                                                             


                                                           


                                                              


                                                            


                                                             
                              

                                                            


                                                           


                                                            


                                                              


                                                           


                                                          


                                                   


                                                       


                                                                                                         


                                                                                         
                        

                                                         


                                                        


                                                   


                                                        
                         

                                                         


                                                          
                           

                                                          
                           

                                  


                                   


                                                     
                         

                                     


                                     


                                        


                                      


                                       


                                      


                                      


                                      


                                    


                                         


                                         


                                     


                                          


                                       


                                        


                                      


                                      


                                          


                                       


                                      


                                            


                                             


                                       


                                        


                                        


                                         


                                       


                                      


                                          


                                          


                                              


                                             


                                              


                                                   


                                               


                                        


                                       
                         

                                                                              


                                              


                                                          


                                                          


                                            


                                           


                                                      


                                                                           


                                                            
                           

                                                                       
                              

                                                 
                         

                                                            
                  

                                                       
                  

                                                
                  



module System.Posix.Signals (

  -- * The Signal type
  Signal,

  -- * Specific signals
  nullSignal,
  internalAbort, sigABRT,
  realTimeAlarm, sigALRM,
  busError, sigBUS,
  processStatusChanged, sigCHLD,
  continueProcess, sigCONT,
  floatingPointException, sigFPE,
  lostConnection, sigHUP,
  illegalInstruction, sigILL,
  keyboardSignal, sigINT,
  killProcess, sigKILL,
  openEndedPipe, sigPIPE,
  keyboardTermination, sigQUIT,
  segmentationViolation, sigSEGV,
  softwareStop, sigSTOP,
  softwareTermination, sigTERM,
  keyboardStop, sigTSTP,
  backgroundRead, sigTTIN,
  backgroundWrite, sigTTOU,
  userDefinedSignal1, sigUSR1,
  userDefinedSignal2, sigUSR2,

  pollableEvent, sigPOLL,

  profilingTimerExpired, sigPROF,
  badSystemCall, sigSYS,
  breakpointTrap, sigTRAP,
  urgentDataAvailable, sigURG,
  virtualTimerExpired, sigVTALRM,
  cpuTimeLimitExceeded, sigXCPU,
  fileSizeLimitExceeded, sigXFSZ,

  -- * Sending signals
  raiseSignal,
  signalProcess,
  signalProcessGroup,







  -- * Signal sets
  SignalSet,
  emptySignalSet, fullSignalSet, 
  addSignal, deleteSignal, inSignalSet,

  -- * The process signal mask
  getSignalMask, setSignalMask, blockSignals, unblockSignals,

  -- * The alarm timer
  scheduleAlarm,

  -- * Waiting for signals
  getPendingSignals,

  awaitSignal,







  -- MISSING FUNCTIONALITY:
  -- sigaction(), (inc. the sigaction structure + flags etc.)
  -- the siginfo structure
  -- sigaltstack()
  -- sighold, sigignore, sigpause, sigrelse, sigset
  -- siginterrupt

  ) where

import Prelude -- necessary to get dependencies right

import Foreign
import Foreign.C
import System.IO.Unsafe
import System.Posix.Types
import System.Posix.Internals


-- WHOLE FILE...






-- -----------------------------------------------------------------------------
-- Specific signals

type Signal = CInt

nullSignal :: Signal
nullSignal = 0

sigABRT   :: CInt
sigABRT   = 6
sigALRM   :: CInt
sigALRM   = 14
sigBUS    :: CInt
sigBUS    = 7
sigCHLD   :: CInt
sigCHLD   = 17
sigCONT   :: CInt
sigCONT   = 18
sigFPE    :: CInt
sigFPE    = 8
sigHUP    :: CInt
sigHUP    = 1
sigILL    :: CInt
sigILL    = 4
sigINT    :: CInt
sigINT    = 2
sigKILL   :: CInt
sigKILL   = 9
sigPIPE   :: CInt
sigPIPE   = 13
sigQUIT   :: CInt
sigQUIT   = 3
sigSEGV   :: CInt
sigSEGV   = 11
sigSTOP   :: CInt
sigSTOP   = 19
sigTERM   :: CInt
sigTERM   = 15
sigTSTP   :: CInt
sigTSTP   = 20
sigTTIN   :: CInt
sigTTIN   = 21
sigTTOU   :: CInt
sigTTOU   = 22
sigUSR1   :: CInt
sigUSR1   = 10
sigUSR2   :: CInt
sigUSR2   = 12
sigPOLL   :: CInt
sigPOLL   = 29
sigPROF   :: CInt
sigPROF   = 27
sigSYS    :: CInt
sigSYS    = 31
sigTRAP   :: CInt
sigTRAP   = 5
sigURG    :: CInt
sigURG    = 23
sigVTALRM :: CInt
sigVTALRM = 26
sigXCPU   :: CInt
sigXCPU   = 24
sigXFSZ   :: CInt
sigXFSZ   = 25

internalAbort ::Signal
internalAbort = sigABRT

realTimeAlarm :: Signal
realTimeAlarm = sigALRM

busError :: Signal
busError = sigBUS

processStatusChanged :: Signal
processStatusChanged = sigCHLD

continueProcess :: Signal
continueProcess = sigCONT

floatingPointException :: Signal
floatingPointException = sigFPE

lostConnection :: Signal
lostConnection = sigHUP

illegalInstruction :: Signal
illegalInstruction = sigILL

keyboardSignal :: Signal
keyboardSignal = sigINT

killProcess :: Signal
killProcess = sigKILL

openEndedPipe :: Signal
openEndedPipe = sigPIPE

keyboardTermination :: Signal
keyboardTermination = sigQUIT

segmentationViolation :: Signal
segmentationViolation = sigSEGV

softwareStop :: Signal
softwareStop = sigSTOP

softwareTermination :: Signal
softwareTermination = sigTERM

keyboardStop :: Signal
keyboardStop = sigTSTP

backgroundRead :: Signal
backgroundRead = sigTTIN

backgroundWrite :: Signal
backgroundWrite = sigTTOU

userDefinedSignal1 :: Signal
userDefinedSignal1 = sigUSR1

userDefinedSignal2 :: Signal
userDefinedSignal2 = sigUSR2


pollableEvent :: Signal
pollableEvent = sigPOLL


profilingTimerExpired :: Signal
profilingTimerExpired = sigPROF

badSystemCall :: Signal
badSystemCall = sigSYS

breakpointTrap :: Signal
breakpointTrap = sigTRAP

urgentDataAvailable :: Signal
urgentDataAvailable = sigURG

virtualTimerExpired :: Signal
virtualTimerExpired = sigVTALRM

cpuTimeLimitExceeded :: Signal
cpuTimeLimitExceeded = sigXCPU

fileSizeLimitExceeded :: Signal
fileSizeLimitExceeded = sigXFSZ

-- -----------------------------------------------------------------------------
-- Signal-related functions

-- | @signalProcess int pid@ calls @kill@ to signal process @pid@ 
--   with interrupt signal @int@.
signalProcess :: Signal -> ProcessID -> IO ()
signalProcess sig pid 
 = throwErrnoIfMinus1_ "signalProcess" (c_kill (fromIntegral pid) sig)

foreign import ccall unsafe "kill"
  c_kill :: CPid -> CInt -> IO CInt


-- | @signalProcessGroup int pgid@ calls @kill@ to signal 
--  all processes in group @pgid@ with interrupt signal @int@.
signalProcessGroup :: Signal -> ProcessGroupID -> IO ()
signalProcessGroup sig pgid 
  = throwErrnoIfMinus1_ "signalProcessGroup" (c_killpg (fromIntegral pgid) sig)

foreign import ccall unsafe "killpg"
  c_killpg :: CPid -> CInt -> IO CInt

-- | @raiseSignal int@ calls @kill@ to signal the current process
--   with interrupt signal @int@. 
raiseSignal :: Signal -> IO ()
raiseSignal sig = throwErrnoIfMinus1_ "raiseSignal" (c_raise sig)





foreign import ccall unsafe "raise"
  c_raise :: CInt -> IO CInt












































































-- -----------------------------------------------------------------------------
-- Alarms

-- | @scheduleAlarm i@ calls @alarm@ to schedule a real time
--   alarm at least @i@ seconds in the future.
scheduleAlarm :: Int -> IO Int
scheduleAlarm secs = do
   r <- c_alarm (fromIntegral secs)
   return (fromIntegral r)

foreign import ccall unsafe "alarm"
  c_alarm :: CUInt -> IO CUInt






















-- -----------------------------------------------------------------------------
-- Manipulating signal sets

newtype SignalSet = SignalSet (ForeignPtr CSigset)

emptySignalSet :: SignalSet
emptySignalSet = unsafePerformIO $ do
  fp <- mallocForeignPtrBytes sizeof_sigset_t
  throwErrnoIfMinus1_ "emptySignalSet" (withForeignPtr fp $ c_sigemptyset)
  return (SignalSet fp)

fullSignalSet :: SignalSet
fullSignalSet = unsafePerformIO $ do
  fp <- mallocForeignPtrBytes sizeof_sigset_t
  throwErrnoIfMinus1_ "fullSignalSet" (withForeignPtr fp $ c_sigfillset)
  return (SignalSet fp)

infixr `addSignal`, `deleteSignal`
addSignal :: Signal -> SignalSet -> SignalSet
addSignal sig (SignalSet fp1) = unsafePerformIO $ do
  fp2 <- mallocForeignPtrBytes sizeof_sigset_t
  withForeignPtr fp1 $ \p1 ->
    withForeignPtr fp2 $ \p2 -> do
      copyBytes p2 p1 sizeof_sigset_t
      throwErrnoIfMinus1_ "addSignal" (c_sigaddset p2 sig)
  return (SignalSet fp2)

deleteSignal :: Signal -> SignalSet -> SignalSet
deleteSignal sig (SignalSet fp1) = unsafePerformIO $ do
  fp2 <- mallocForeignPtrBytes sizeof_sigset_t
  withForeignPtr fp1 $ \p1 ->
    withForeignPtr fp2 $ \p2 -> do
      copyBytes p2 p1 sizeof_sigset_t
      throwErrnoIfMinus1_ "deleteSignal" (c_sigdelset p2 sig)
  return (SignalSet fp2)

inSignalSet :: Signal -> SignalSet -> Bool
inSignalSet sig (SignalSet fp) = unsafePerformIO $
  withForeignPtr fp $ \p -> do
    r <- throwErrnoIfMinus1 "inSignalSet" (c_sigismember p sig)
    return (r /= 0)

-- | @getSignalMask@ calls @sigprocmask@ to determine the
--   set of interrupts which are currently being blocked.
getSignalMask :: IO SignalSet
getSignalMask = do
  fp <- mallocForeignPtrBytes sizeof_sigset_t
  withForeignPtr fp $ \p ->
    throwErrnoIfMinus1_ "getSignalMask" (c_sigprocmask 0 nullPtr p)
  return (SignalSet fp)
   
sigProcMask :: String -> CInt -> SignalSet -> IO ()
sigProcMask fn how (SignalSet set) =
  withForeignPtr set $ \p_set ->
    throwErrnoIfMinus1_ fn (c_sigprocmask how p_set nullPtr)

-- | @setSignalMask mask@ calls @sigprocmask@ with
--   @SIG_SETMASK@ to block all interrupts in @mask@.
setSignalMask :: SignalSet -> IO ()
setSignalMask set = sigProcMask "setSignalMask" (2 :: CInt) set

-- | @blockSignals mask@ calls @sigprocmask@ with
--   @SIG_BLOCK@ to add all interrupts in @mask@ to the
--  set of blocked interrupts.
blockSignals :: SignalSet -> IO ()
blockSignals set = sigProcMask "blockSignals" (0 :: CInt) set

-- | @unblockSignals mask@ calls @sigprocmask@ with
--   @SIG_UNBLOCK@ to remove all interrupts in @mask@ from the
--   set of blocked interrupts. 
unblockSignals :: SignalSet -> IO ()
unblockSignals set = sigProcMask "unblockSignals" (1 :: CInt) set

-- | @getPendingSignals@ calls @sigpending@ to obtain
--   the set of interrupts which have been received but are currently blocked.
getPendingSignals :: IO SignalSet
getPendingSignals = do
  fp <- mallocForeignPtrBytes sizeof_sigset_t
  withForeignPtr fp $ \p -> 
   throwErrnoIfMinus1_ "getPendingSignals" (c_sigpending p)
  return (SignalSet fp)



-- | @awaitSignal iset@ suspends execution until an interrupt is received.
-- If @iset@ is @Just s@, @awaitSignal@ calls @sigsuspend@, installing
-- @s@ as the new signal mask before suspending execution; otherwise, it
-- calls @pause@.  @awaitSignal@ returns on receipt of a signal.  If you
-- have installed any signal handlers with @installHandler@, it may be
-- wise to call @yield@ directly after @awaitSignal@ to ensure that the
-- signal handler runs as promptly as possible.
awaitSignal :: Maybe SignalSet -> IO ()
awaitSignal maybe_sigset = do
  fp <- case maybe_sigset of
    	  Nothing -> do SignalSet fp <- getSignalMask; return fp
    	  Just (SignalSet fp) -> return fp
  withForeignPtr fp $ \p -> do
  c_sigsuspend p
  return ()
  -- ignore the return value; according to the docs it can only ever be
  -- (-1) with errno set to EINTR.
 
foreign import ccall unsafe "sigsuspend"
  c_sigsuspend :: Ptr CSigset -> IO CInt



foreign import ccall unsafe "sigdelset"
  c_sigdelset   :: Ptr CSigset -> CInt -> IO CInt

foreign import ccall unsafe "sigfillset"
  c_sigfillset  :: Ptr CSigset -> IO CInt

foreign import ccall unsafe "sigismember"
  c_sigismember :: Ptr CSigset -> CInt -> IO CInt











foreign import ccall unsafe "sigpending"
  c_sigpending :: Ptr CSigset -> IO CInt



