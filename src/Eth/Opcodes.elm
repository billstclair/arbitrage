---------------------------------------------------------------------
--
-- Opcodes.elm
-- Ethereum VM opcodes.
-- Copyright (c) 2024 Bill St. Clair <billstclair@gmail.com>
-- Some rights reserved.
-- Distributed under the MIT License
-- See LICENSE
--
----------------------------------------------------------------------


module Eth.Opcodes exposing (opcodes)

import Eth.Types exposing (Opcode)


opcodePairToOpcode : ( ( Int, String, Int ), ( String, String, String ) ) -> Opcode
opcodePairToOpcode ( ( opcode, name, gas ), ( input, output, description ) ) =
    { opcode = opcode
    , name = name
    , gas = gas
    , input = input
    , output = output
    , description = description
    }


opcodes : List Opcode
opcodes =
    List.map opcodePairToOpcode opcodesList


opcodesList : List ( ( Int, String, Int ), ( String, String, String ) )
opcodesList =
    [ ( ( 0x00, "STOP", 0 ), ( "", "", "Halts execution" ) )
    , ( ( 0x01, "ADD", 3 ), ( "[a, b]", "a + b", "Addition operation" ) )
    , ( ( 0x02, "MUL", 5 ), ( "[a, b]", "a * b", "Multiplication operation" ) )
    , ( ( 0x03, "SUB", 3 ), ( "[a,b]", "a - b", "Subtraction operation" ) )
    , ( ( 0x04, "DIV", 5 ), ( "[a,b]", "a // b", "Integer division operation" ) )
    , ( ( 0x05, "SDIV", 5 ), ( "[a,b]", "a // b", "Signed integer division operation (truncated)" ) )
    , ( ( 0x06, "MOD", 5 ), ( "[a,b]", "a % b", "Modulo remainder operation" ) )
    , ( ( 0x07, "SMOD", 5 ), ( "[a,b]", "a % b", "Signed modulo remainder operation" ) )
    , ( ( 0x08, "ADDMOD", 8 ), ( "[a,b,N]", "(a + b) % N", "Modulo addition operation" ) )
    , ( ( 0x09, "MULMOD", 8 ), ( "[a,b,N]", "(a * b) % N", "Modulo multiplication operation" ) )
    , ( ( 0x0A, "EXP", 10 ), ( "(a, exponent)", "a ** exponent", "Exponential operation" ) )
    , ( ( 0x0B, "SIGNEXTEND", 5 ), ( "[b, x]", "y", "Extend length of two’s complement signed integer" ) )
    ]



{- 10
   LT
   3
   a
   b
   a < b
   Less-than comparison
   11
   GT
   3
   a
   b
   a > b
   Greater-than comparison
   12
   SLT
   3
   a
   b
   a < b
   Signed less-than comparison
   13
   SGT
   3
   a
   b
   a > b
   Signed greater-than comparison
   14
   EQ
   3
   a
   b
   a == b
   Equality comparison
   15
   ISZERO
   3
   a
   a == 0
   Is-zero comparison
   16
   AND
   3
   a
   b
   a & b
   Bitwise AND operation
   17
   OR
   3
   a
   b
   a | b
   Bitwise OR operation
   18
   XOR
   3
   a
   b
   a ^ b
   Bitwise XOR operation
   19
   NOT
   3
   a
   ~a
   Bitwise NOT operation
   1a
   BYTE
   3
   i
   x
   y
   Retrieve single byte from word
   1b
   SHL
   3
   shift
   value
   value << shift
   Left shift operation
   1c
   SHR
   3
   shift
   value
   value >> shift
   Logical right shift operation
   1d
   SAR
   3
   shift
   value
   value >> shift
   Arithmetic (signed) right shift operation
   20
   KECCAK256
   30
   offset
   size
   hash
   Compute Keccak-256 hash
   30
   ADDRESS
   2
   address
   Get address of currently executing account
   31
   BALANCE
   100
   address
   balance
   Get balance of the given account
   32
   ORIGIN
   2
   address
   Get execution origination address
   33
   CALLER
   2
   address
   Get caller address
   34
   CALLVALUE
   2
   value
   Get deposited value by the instruction/transaction responsible for this execution
   35
   CALLDATALOAD
   3
   i
   data[i]
   Get input data of current environment
   36
   CALLDATASIZE
   2
   size
   Get size of input data in current environment
   37
   CALLDATACOPY
   3
   destOffset
   offset
   size
   Copy input data in current environment to memory
   38
   CODESIZE
   2
   size
   Get size of code running in current environment
   39
   CODECOPY
   3
   destOffset
   offset
   size
   Copy code running in current environment to memory
   3a
   GASPRICE
   2
   price
   Get price of gas in current environment
   3b
   EXTCODESIZE
   100
   address
   size
   Get size of an account’s code
   3c
   EXTCODECOPY
   100
   address
   destOffset
   offset
   size
   Copy an account’s code to memory
   3d
   RETURNDATASIZE
   2
   size
   Get size of output data from the previous call from the current environment
   3e
   RETURNDATACOPY
   3
   destOffset
   offset
   size
   Copy output data from the previous call to memory
   3f
   EXTCODEHASH
   100
   address
   hash
   Get hash of an account’s code
   40
   BLOCKHASH
   20
   blockNumber
   hash
   Get the hash of one of the 256 most recent complete blocks
   41
   COINBASE
   2
   address
   Get the block’s beneficiary address
   42
   TIMESTAMP
   2
   timestamp
   Get the block’s timestamp
   43
   NUMBER
   2
   blockNumber
   Get the block’s number
   44
   PREVRANDAO
   2
   prevRandao
   Get the previous block’s RANDAO mix
   45
   GASLIMIT
   2
   gasLimit
   Get the block’s gas limit
   46
   CHAINID
   2
   chainId
   Get the chain ID
   47
   SELFBALANCE
   5
   balance
   Get balance of currently executing account
   48
   BASEFEE
   2
   baseFee
   Get the base fee
   49
   BLOBHASH
   3
   index
   blobVersionedHashesAtIndex
   Get versioned hashes
   4a
   BLOBBASEFEE
   2
   blobBaseFee
   Returns the value of the blob base-fee of the current block
   50
   POP
   2
   y
   Remove item from stack
   51
   MLOAD
   3
   offset
   value
   Load word from memory
   52
   MSTORE
   3
   offset
   value
   Save word to memory
   53
   MSTORE8
   3
   offset
   value
   Save byte to memory
   54
   SLOAD
   100
   key
   value
   Load word from storage
   55
   SSTORE
   100
   key
   value
   Save word to storage
   56
   JUMP
   8
   counter
   Alter the program counter
   57
   JUMPI
   10
   counter
   b
   Conditionally alter the program counter
   58
   PC
   2
   counter
   Get the value of the program counter prior to the increment corresponding to this instruction
   59
   MSIZE
   2
   size
   Get the size of active memory in bytes
   5a
   GAS
   2
   gas
   Get the amount of available gas, including the corresponding reduction for the cost of this instruction
   5b
   JUMPDEST
   1
   Mark a valid destination for jumps
   5c
   TLOAD
   100
   key
   value
   Load word from transient storage
   5d
   TSTORE
   100
   key
   value
   Save word to transient storage
   5e
   MCOPY
   3
   destOffset
   offset
   size
   Copy memory areas
   5f
   PUSH0
   2
   0
   Place value 0 on stack
   60
   PUSH1
   3
   value
   Place 1 byte item on stack
   61
   PUSH2
   3
   value
   Place 2 byte item on stack
   62
   PUSH3
   3
   value
   Place 3 byte item on stack
   63
   PUSH4
   3
   value
   Place 4 byte item on stack
   64
   PUSH5
   3
   value
   Place 5 byte item on stack
   65
   PUSH6
   3
   value
   Place 6 byte item on stack
   66
   PUSH7
   3
   value
   Place 7 byte item on stack
   67
   PUSH8
   3
   value
   Place 8 byte item on stack
   68
   PUSH9
   3
   value
   Place 9 byte item on stack
   69
   PUSH10
   3
   value
   Place 10 byte item on stack
   6a
   PUSH11
   3
   value
   Place 11 byte item on stack
   6b
   PUSH12
   3
   value
   Place 12 byte item on stack
   6c
   PUSH13
   3
   value
   Place 13 byte item on stack
   6d
   PUSH14
   3
   value
   Place 14 byte item on stack
   6e
   PUSH15
   3
   value
   Place 15 byte item on stack
   6f
   PUSH16
   3
   value
   Place 16 byte item on stack
   70
   PUSH17
   3
   value
   Place 17 byte item on stack
   71
   PUSH18
   3
   value
   Place 18 byte item on stack
   72
   PUSH19
   3
   value
   Place 19 byte item on stack
   73
   PUSH20
   3
   value
   Place 20 byte item on stack
   74
   PUSH21
   3
   value
   Place 21 byte item on stack
   75
   PUSH22
   3
   value
   Place 22 byte item on stack
   76
   PUSH23
   3
   value
   Place 23 byte item on stack
   77
   PUSH24
   3
   value
   Place 24 byte item on stack
   78
   PUSH25
   3
   value
   Place 25 byte item on stack
   79
   PUSH26
   3
   value
   Place 26 byte item on stack
   7a
   PUSH27
   3
   value
   Place 27 byte item on stack
   7b
   PUSH28
   3
   value
   Place 28 byte item on stack
   7c
   PUSH29
   3
   value
   Place 29 byte item on stack
   7d
   PUSH30
   3
   value
   Place 30 byte item on stack
   7e
   PUSH31
   3
   value
   Place 31 byte item on stack
   7f
   PUSH32
   3
   value
   Place 32 byte (full word) item on stack
   80
   DUP1
   3
   value
   value
   value
   Duplicate 1st stack item
   81
   DUP2
   3
   a
   b
   b
   a
   b
   Duplicate 2nd stack item
   82
   DUP3
   3
   a
   b
   c
   c
   a
   b
   c
   Duplicate 3rd stack item
   83
   DUP4
   3
   ...
   value
   value
   ...
   value
   Duplicate 4th stack item
   84
   DUP5
   3
   ...
   value
   value
   ...
   value
   Duplicate 5th stack item
   85
   DUP6
   3
   ...
   value
   value
   ...
   value
   Duplicate 6th stack item
   86
   DUP7
   3
   ...
   value
   value
   ...
   value
   Duplicate 7th stack item
   87
   DUP8
   3
   ...
   value
   value
   ...
   value
   Duplicate 8th stack item
   88
   DUP9
   3
   ...
   value
   value
   ...
   value
   Duplicate 9th stack item
   89
   DUP10
   3
   ...
   value
   value
   ...
   value
   Duplicate 10th stack item
   8a
   DUP11
   3
   ...
   value
   value
   ...
   value
   Duplicate 11th stack item
   8b
   DUP12
   3
   ...
   value
   value
   ...
   value
   Duplicate 12th stack item
   8c
   DUP13
   3
   ...
   value
   value
   ...
   value
   Duplicate 13th stack item
   8d
   DUP14
   3
   ...
   value
   value
   ...
   value
   Duplicate 14th stack item
   8e
   DUP15
   3
   ...
   value
   value
   ...
   value
   Duplicate 15th stack item
   8f
   DUP16
   3
   ...
   value
   value
   ...
   value
   Duplicate 16th stack item
   90
   SWAP1
   3
   a
   b
   b
   a
   Exchange 1st and 2nd stack items
   91
   SWAP2
   3
   a
   b
   c
   c
   b
   a
   Exchange 1st and 3rd stack items
   92
   SWAP3
   3
   a
   ...
   b
   b
   ...
   a
   Exchange 1st and 4th stack items
   93
   SWAP4
   3
   a
   ...
   b
   b
   ...
   a
   Exchange 1st and 5th stack items
   94
   SWAP5
   3
   a
   ...
   b
   b
   ...
   a
   Exchange 1st and 6th stack items
   95
   SWAP6
   3
   a
   ...
   b
   b
   ...
   a
   Exchange 1st and 7th stack items
   96
   SWAP7
   3
   a
   ...
   b
   b
   ...
   a
   Exchange 1st and 8th stack items
   97
   SWAP8
   3
   a
   ...
   b
   b
   ...
   a
   Exchange 1st and 9th stack items
   98
   SWAP9
   3
   a
   ...
   b
   b
   ...
   a
   Exchange 1st and 10th stack items
   99
   SWAP10
   3
   a
   ...
   b
   b
   ...
   a
   Exchange 1st and 11th stack items
   9a
   SWAP11
   3
   a
   ...
   b
   b
   ...
   a
   Exchange 1st and 12th stack items
   9b
   SWAP12
   3
   a
   ...
   b
   b
   ...
   a
   Exchange 1st and 13th stack items
   9c
   SWAP13
   3
   a
   ...
   b
   b
   ...
   a
   Exchange 1st and 14th stack items
   9d
   SWAP14
   3
   a
   ...
   b
   b
   ...
   a
   Exchange 1st and 15th stack items
   9e
   SWAP15
   3
   a
   ...
   b
   b
   ...
   a
   Exchange 1st and 16th stack items
   9f
   SWAP16
   3
   a
   ...
   b
   b
   ...
   a
   Exchange 1st and 17th stack items
   a0
   LOG0
   375
   offset
   size
   Append log record with no topics
   a1
   LOG1
   750
   offset
   size
   topic
   Append log record with one topic
   a2
   LOG2
   1125
   offset
   size
   topic1
   topic2
   Append log record with two topics
   a3
   LOG3
   1500
   offset
   size
   topic1
   topic2
   topic3
   Append log record with three topics
   a4
   LOG4
   1875
   offset
   size
   topic1
   topic2
   topic3
   topic4
   Append log record with four topics
   f0
   CREATE
   32000
   value
   offset
   size
   address
   Create a new account with associated code
   f1
   CALL
   100
   gas
   address
   value
   argsOffset
   argsSize
   retOffset
   retSize
   success
   Message-call into an account
   f2
   CALLCODE
   100
   gas
   address
   value
   argsOffset
   argsSize
   retOffset
   retSize
   success
   Message-call into this account with alternative account’s code
   f3
   RETURN
   0
   offset
   size
   Halt execution returning output data
   f4
   DELEGATECALL
   100
   gas
   address
   argsOffset
   argsSize
   retOffset
   retSize
   success
   Message-call into this account with an alternative account’s code, but persisting the current values for sender and value
   f5
   CREATE2
   32000
   value
   offset
   size
   salt
   address
   Create a new account with associated code at a predictable address
   fa
   STATICCALL
   100
   gas
   address
   argsOffset
   argsSize
   retOffset
   retSize
   success
   Static message-call into an account
   fd
   REVERT
   0
   offset
   size
   Halt execution reverting state changes but returning data and remaining gas
   fe
   INVALID
   NaN
   Designated invalid instruction
   ff
   SELFDESTRUCT
   5000
   address
   Halt execution and register account for later deletion or send all Ether to address (post-Cancun)
-}