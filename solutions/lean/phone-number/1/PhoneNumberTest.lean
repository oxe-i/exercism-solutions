import LeanTest
import PhoneNumber

open LeanTest

def phoneNumberTests : TestSuite :=
  (TestSuite.empty "PhoneNumber")
  |>.addTest "cleans the number" (do
      return assertEqual (some "2234567890") (PhoneNumber.clean "(223) 456-7890"))
  |>.addTest "cleans numbers with dots" (do
      return assertEqual (some "2234567890") (PhoneNumber.clean "223.456.7890"))
  |>.addTest "cleans numbers with multiple spaces" (do
      return assertEqual (some "2234567890") (PhoneNumber.clean "223 456   7890   "))
  |>.addTest "invalid when 9 digits" (do
      return assertEqual none (PhoneNumber.clean "123456789"))
  |>.addTest "invalid when 11 digits does not start with a 1" (do
      return assertEqual none (PhoneNumber.clean "22234567890"))
  |>.addTest "valid when 11 digits and starting with 1" (do
      return assertEqual (some "2234567890") (PhoneNumber.clean "12234567890"))
  |>.addTest "valid when 11 digits and starting with 1 even with punctuation" (do
      return assertEqual (some "2234567890") (PhoneNumber.clean "+1 (223) 456-7890"))
  |>.addTest "invalid when more than 11 digits" (do
      return assertEqual none (PhoneNumber.clean "321234567890"))
  |>.addTest "invalid with letters" (do
      return assertEqual none (PhoneNumber.clean "523-abc-7890"))
  |>.addTest "invalid with punctuations" (do
      return assertEqual none (PhoneNumber.clean "523-@:!-7890"))
  |>.addTest "invalid if area code starts with 0" (do
      return assertEqual none (PhoneNumber.clean "(023) 456-7890"))
  |>.addTest "invalid if area code starts with 1" (do
      return assertEqual none (PhoneNumber.clean "(123) 456-7890"))
  |>.addTest "invalid if exchange code starts with 0" (do
      return assertEqual none (PhoneNumber.clean "(223) 056-7890"))
  |>.addTest "invalid if exchange code starts with 1" (do
      return assertEqual none (PhoneNumber.clean "(223) 156-7890"))
  |>.addTest "invalid if area code starts with 0 on valid 11-digit number" (do
      return assertEqual none (PhoneNumber.clean "1 (023) 456-7890"))
  |>.addTest "invalid if area code starts with 1 on valid 11-digit number" (do
      return assertEqual none (PhoneNumber.clean "1 (123) 456-7890"))
  |>.addTest "invalid if exchange code starts with 0 on valid 11-digit number" (do
      return assertEqual none (PhoneNumber.clean "1 (223) 056-7890"))
  |>.addTest "invalid if exchange code starts with 1 on valid 11-digit number" (do
      return assertEqual none (PhoneNumber.clean "1 (223) 156-7890"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [phoneNumberTests]
