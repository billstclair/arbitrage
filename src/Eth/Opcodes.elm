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


module Eth.Opcodes exposing (jsonOpcodes, opcodes)

import Eth.Types exposing (JsonOpcode, Opcode)


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
    , ( ( 0x08, "ADDMOD", 8 ), ( "[a,b,N]", "a + b) % N", "Modulo addition operation" ) )
    , ( ( 0x09, "MULMOD", 8 ), ( "[a,b,N]", "(a * b) % N", "Modulo multiplication operation" ) )
    , ( ( 0x0A, "EXP", 10 ), ( "(a, exponent)", "a ** exponent", "Exponential operation" ) )
    , ( ( 0x0B, "SIGNEXTEND", 5 ), ( "[b, x]", "y", "Extend length of two's complement signed integer" ) )
    , ( ( 0x10, "LT", 3 ), ( "[a,b]", "a < b", "Less-than comparison" ) )
    , ( ( 0x11, "GT", 3 ), ( "[a,b]", "a > b", "Greater-than comparison" ) )
    , ( ( 0x12, "SLT", 3 ), ( "[a,b]", "a < b", "Signed less-than comparison" ) )
    , ( ( 0x13, "SGT", 3 ), ( "[a,b]", "a > b", "Signed greater-than comparison" ) )
    , ( ( 0x14, "EQ", 3 ), ( "[a,b]", "a == b", "Equality comparison" ) )
    , ( ( 0x15, "ISZERO", 3 ), ( "[a]", "a==0", "Is-zero comparison" ) )
    , ( ( 0x16, "AND", 3 ), ( "[a,b]", "a & b", "Bitwise AND operation" ) )
    , ( ( 0x17, "OR", 3 ), ( "[a,b]", "a | b", "Bitwise OR operation" ) )
    , ( ( 0x18, "XOR", 3 ), ( "[a,b]", "a ^ b", "Bitwise XOR operation" ) )
    , ( ( 0x19, "NOT", 3 ), ( "[n]", "~n", "Bitwise NOT operation" ) )
    , ( ( 0x1A, "BYTE", 3 ), ( "[i,x]", "y", "Retrieve single byte from word" ) )
    , ( ( 0x1B, "SHL", 3 ), ( "[shift,value]", "value << shift", "Left shift operation" ) )
    , ( ( 0x1C, "SHR", 3 ), ( "[shift,value]", "value >> shift", "Logical right shift operation" ) )
    , ( ( 0x1D, "SAR", 3 ), ( "[shift,value]", "value >> shift", "Arithmetic (signed) right shift operation" ) )
    , ( ( 0x20, "KECCAK256", 30 ), ( "[offset,size]", "hash", "Compute Keccak-256 hash" ) )
    , ( ( 0x30, "ADDRESS", 2 ), ( "[address]", "write current current address at <address>", "Get address of currently executing account" ) )
    , ( ( 0x31, "BALANCE", 100 ), ( "[address]", "balance", "Get balance of the given account" ) )
    , ( ( 0x32, "ORIGIN", 2 ), ( "[address]", "Get execution origination [address]", "write address at <address>" ) )
    , ( ( 0x33, "CALLER", 2 ), ( "[address]", "Get caller address", "write address at <address>" ) )
    , ( ( 0x34, "CALLVALUE", 2 ), ( "", "value", "Get deposited value by the instruction/transaction responsible for this execution" ) )
    , ( ( 0x35, "CALLDATALOAD", 3 ), ( "i", "data[i]", "Get input data of current environment" ) )
    , ( ( 0x36, "CALLDATASIZE", 2 ), ( "", "size", "Get size of input data in current environment" ) )
    , ( ( 0x37, "CALLDATACOPY", 3 ), ( "[destOffset,offset,size", "", "Copy input data in current environment to memory" ) )
    , ( ( 0x38, "CODESIZE", 2 ), ( "", "size", "Get size of code running in current environment" ) )
    , ( ( 0x39, "CODECOPY", 3 ), ( "[destOffset,offset,size]", "", "Copy code running in current environment to memory" ) )
    , ( ( 0x3A, "GASPRICE", 2 ), ( "", "price", "Get price of gas in current environment" ) )
    , ( ( 0x3B, "EXTCODESIZE", 100 ), ( "address", "size", "Get size of an account’s code" ) )
    , ( ( 0x3C, "EXTCODECOPY", 100 ), ( "[address,destOffset,offset,size]", " ", "Copy an account’s code to memory" ) )
    , ( ( 0x3D, "RETURNDATASIZE", 2 ), ( "", "size", "Get size of output data from the previous call from the current environment" ) )
    , ( ( 0x3E, "RETURNDATACOPY", 3 ), ( "[destOffset,offset,size)", "", "Copy output data from the previous call to memory" ) )
    , ( ( 0x3F, "EXTCODEHASH", 100 ), ( "[address]", "hash", "Get hash of an account’s code" ) )
    , ( ( 0x40, "BLOCKHASH", 20 ), ( "[blockNumber]", "hash", "Get the hash of one of the 256 most recent complete blocks" ) )
    , ( ( 0x41, "COINBASE", 2 ), ( "", "address", "Get the block’s beneficiary address" ) )
    , ( ( 0x42, "TIMESTAMP", 2 ), ( "", "timestamp", "Get the block’s timestamp" ) )
    , ( ( 0x43, "NUMBER", 2 ), ( "", "blockNumber", "Get the block’s number" ) )
    , ( ( 0x44, "PREVRANDAO", 2 ), ( "", "prevRandao", "Get the previous block’s RANDAO mix" ) )
    , ( ( 0x45, "GASLIMIT", 2 ), ( "", "gasLimit", "Get the block’s gas limit" ) )
    , ( ( 0x46, "CHAINID", 2 ), ( "", "chainId", "Get the chain ID" ) )
    , ( ( 0x47, "SELFBALANCE", 5 ), ( "", "balance", "Get balance of currently executing account" ) )
    , ( ( 0x48, "BASEFEE", 2 ), ( "", "baseFee", "Get the base fee" ) )
    , ( ( 0x49, "BLOBHASH", 3 ), ( "[index]", "blobVersionedHashesAtIndex", "Get versioned hashes" ) )
    , ( ( 0x4A, "BLOBBASEFEE", 2 ), ( "", "blobBaseFee", "Returns the value of the blob base-fee of the current block" ) )
    , ( ( 0x50, "POP", 2 ), ( "[y]", "", "Remove item from stack" ) )
    , ( ( 0x51, "MLOAD", 3 ), ( "[offset]", "value", "Load word from memory" ) )
    , ( ( 0x52, "MSTORE", 3 ), ( "[offset,value]", "", "Save word to memory" ) )
    , ( ( 0x53, "MSTORE8", 3 ), ( "[offset,value]", "", "Save byte to memory" ) )
    , ( ( 0x54, "SLOAD", 100 ), ( "[key]", "value", "Load word from storage" ) )
    , ( ( 0x55, "SSTORE", 100 ), ( "[key,value]", "", "Save word to storage" ) )
    , ( ( 0x56, "JUMP", 8 ), ( "[counter]", "", "Alter the program counter" ) )
    , ( ( 0x57, "JUMPI", 10 ), ( "[counter,b]", "", "Conditionally alter the program counter" ) )
    , ( ( 0x58, "PC", 2 ), ( "", "counter", "Get the value of the program counter prior to the increment corresponding to this instruction" ) )
    , ( ( 0x59, "MSIZE", 2 ), ( "", "size", "Get the size of active memory in bytes" ) )
    , ( ( 0x5A, "GAS", 2 ), ( "", "gas", "Get the amount of available gas, including the corresponding reduction for the cost of this instruction" ) )
    , ( ( 0x5B, "JUMPDEST", 1 ), ( "", "", "Mark a valid destination for jumps" ) )
    , ( ( 0x5C, "TLOAD", 100 ), ( "[key]", "value", "Load word from transient storage" ) )
    , ( ( 0x5D, "TSTORE", 100 ), ( "[key,value]", "", "Save word to transient storage" ) )
    , ( ( 0x5E, "MCOPY", 3 ), ( "[destOffset,offset,size]", "", "Copy memory areas" ) )
    , ( ( 0x5F, "PUSH0", 2 ), ( "", "0", "Place value 0 on stack" ) )
    , ( ( 0x60, "PUSH1", 3 ), ( "", "value", "Place 1 byte item on stack" ) )
    , ( ( 0x61, "PUSH2", 3 ), ( "", "value", "Place 2 byte item on stack" ) )
    , ( ( 0x62, "PUSH3", 3 ), ( "", "value", "Place 3 byte item on stack" ) )
    , ( ( 0x63, "PUSH4", 3 ), ( "", "value", "Place 4 byte item on stack" ) )
    , ( ( 0x64, "PUSH5", 3 ), ( "", "value", "Place 5 byte item on stack" ) )
    , ( ( 0x65, "PUSH6", 3 ), ( "", "value", "Place 6 byte item on stack" ) )
    , ( ( 0x66, "PUSH7", 3 ), ( "", "value", "Place 7 byte item on stack" ) )
    , ( ( 0x67, "PUSH8", 3 ), ( "", "value", "Place 8 byte item on stack" ) )
    , ( ( 0x68, "PUSH9", 3 ), ( "", "value", "Place 9 byte item on stack" ) )
    , ( ( 0x69, "PUSH10", 3 ), ( "", "value", "Place 10 byte item on stack" ) )
    , ( ( 0x6A, "PUSH11", 3 ), ( "", "value", "Place 11 byte item on stack" ) )
    , ( ( 0x6B, "PUSH12", 3 ), ( "", "value", "Place 12 byte item on stack" ) )
    , ( ( 0x6C, "PUSH13", 3 ), ( "", "value", "Place 13 byte item on stack" ) )
    , ( ( 0x6D, "PUSH14", 3 ), ( "", "value", "Place 14 byte item on stack" ) )
    , ( ( 0x6E, "PUSH15", 3 ), ( "", "value", "Place 15 byte item on stack" ) )
    , ( ( 0x6F, "PUSH16", 3 ), ( "", "value", "Place 16 byte item on stack" ) )
    , ( ( 0x70, "PUSH17", 3 ), ( "", "value", "Place 17 byte item on stack" ) )
    , ( ( 0x71, "PUSH18", 3 ), ( "", "value", "Place 18 byte item on stack" ) )
    , ( ( 0x72, "PUSH19", 3 ), ( "", "value", "Place 19 byte item on stack" ) )
    , ( ( 0x73, "PUSH20", 3 ), ( "", "value", "Place 20 byte item on stack" ) )
    , ( ( 0x74, "PUSH21", 3 ), ( "", "value", "Place 21 byte item on stack" ) )
    , ( ( 0x75, "PUSH22", 3 ), ( "", "value", "Place 22 byte item on stack" ) )
    , ( ( 0x76, "PUSH23", 3 ), ( "", "value", "Place 23 byte item on stack" ) )
    , ( ( 0x77, "PUSH24", 3 ), ( "", "value", "Place 24 byte item on stack" ) )
    , ( ( 0x78, "PUSH25", 3 ), ( "", "value", "Place 25 byte item on stack" ) )
    , ( ( 0x79, "PUSH26", 3 ), ( "", "value", "Place 26 byte item on stack" ) )
    , ( ( 0x7A, "PUSH27", 3 ), ( "", "value", "Place 27 byte item on stack" ) )
    , ( ( 0x7B, "PUSH28", 3 ), ( "", "value", "Place 28 byte item on stack" ) )
    , ( ( 0x7C, "PUSH29", 3 ), ( "", "value", "Place 29 byte item on stack" ) )
    , ( ( 0x7D, "PUSH30", 3 ), ( "", "value", "Place 30 byte item on stack" ) )
    , ( ( 0x7E, "PUSH31", 3 ), ( "", "value", "Place 31 byte item on stack" ) )
    , ( ( 0x7F, "PUSH32", 3 ), ( "", "value", "Place 32 byte (full word) item on stack" ) )
    , ( ( 0x80, "DUP1", 3 ), ( "[value]", "value", "Duplicate 1st stack item" ) )
    , ( ( 0x81, "DUP2", 3 ), ( "[a,b]", "[b,a,b]", "Duplicate 2nd stack item" ) )
    , ( ( 0x82, "DUP3", 3 ), ( "[a,b,c]", "[c,a,b,c]", "Duplicate 3rd stack item" ) )
    , ( ( 0x83, "DUP4", 3 ), ( "[...,value]", "[value,...,value]", "Duplicate 4th stack item" ) )
    , ( ( 0x84, "DUP5", 3 ), ( "[...,value]", "[value,...,value]", "Duplicate 5th stack item" ) )
    , ( ( 0x85, "DUP6", 3 ), ( "[...,value]", "[value,...,value]", "Duplicate 6th stack item" ) )
    , ( ( 0x86, "DUP7", 3 ), ( "[...,value]", "[value,...,value]", "Duplicate 7th stack item" ) )
    , ( ( 0x87, "DUP8", 3 ), ( "[...,value]", "[value,...,value]", "Duplicate 8th stack item" ) )
    , ( ( 0x88, "DUP9", 3 ), ( "[...,value]", "[value,...,value]", "Duplicate 9th stack item" ) )
    , ( ( 0x89, "DUP10", 3 ), ( "[...,value]", "[value,...,value]", "Duplicate 10th stack item" ) )
    , ( ( 0x8A, "DUP11", 3 ), ( "[...,value]", "[value,...,value]", "Duplicate 11th stack item" ) )
    , ( ( 0x8B, "DUP12", 3 ), ( "[...,value]", "[value,...,value]", "Duplicate 12th stack item" ) )
    , ( ( 0x8C, "DUP13", 3 ), ( "[...,value]", "[value,...,value]", "Duplicate 13th stack item" ) )
    , ( ( 0x8D, "DUP14", 3 ), ( "[...,value]", "[value,...,value]", "Duplicate 14th stack item" ) )
    , ( ( 0x8E, "DUP15", 3 ), ( "[...,value]", "[value,...,value]", "Duplicate 15th stack item" ) )
    , ( ( 0x8F, "DUP16", 3 ), ( "[...,value]", "[value,...,value]", "Duplicate 16th stack item" ) )
    , ( ( 0x90, "SWAP1", 3 ), ( "[a,b]", "[b,a]", "Exchange 1st and 2nd stack items" ) )
    , ( ( 0x91, "SWAP2", 3 ), ( "[a,b,c]", "[c,b,a]", "Exchange 1st and 3rd stack items" ) )
    , ( ( 0x92, "SWAP3", 3 ), ( "[a,...,b]", "[b,...,a]", "Exchange 1st and 4th stack items" ) )
    , ( ( 0x93, "SWAP4", 3 ), ( "[a,...,b]", "[b,...,a]", "Exchange 1st and 5th stack items" ) )
    , ( ( 0x94, "SWAP5", 3 ), ( "[a,...,b]", "[b,...,a]", "Exchange 1st and 6th stack items" ) )
    , ( ( 0x95, "SWAP6", 3 ), ( "[a,...,b]", "[b,...,a]", "Exchange 1st and 7th stack items" ) )
    , ( ( 0x96, "SWAP7", 3 ), ( "[a,...,b]", "[b,...,a]", "Exchange 1st and 8th stack items" ) )
    , ( ( 0x97, "SWAP8", 3 ), ( "[a,...,b]", "[b,...,a]", "Exchange 1st and 9th stack items" ) )
    , ( ( 0x98, "SWAP9", 3 ), ( "[a,...,b]", "[b,...,a]", "Exchange 1st and 10th stack items" ) )
    , ( ( 0x99, "SWAP10", 3 ), ( "[a,...,b]", "[b,...,a]", "Exchange 1st and 11th stack items" ) )
    , ( ( 0x9A, "SWAP11", 3 ), ( "[a,...,b]", "[b,...,a]", "Exchange 1st and 12th stack items" ) )
    , ( ( 0x9B, "SWAP12", 3 ), ( "[a,...,b]", "[b,...,a]", "Exchange 1st and 13th stack items" ) )
    , ( ( 0x9C, "SWAP13", 3 ), ( "[a,...,b]", "[b,...,a]", "Exchange 1st and 14th stack items" ) )
    , ( ( 0x9D, "SWAP14", 3 ), ( "[a,...,b]", "[b,...,a]", "Exchange 1st and 15th stack items" ) )
    , ( ( 0x9E, "SWAP15", 3 ), ( "[a,...,b]", "[b,...,a]", "Exchange 1st and 16th stack items" ) )
    , ( ( 0x9F, "SWAP16", 3 ), ( "[a,...,b]", "[b,...,a]", "Exchange 1st and 17th stack items" ) )
    , ( ( 0xA0, "LOG0", 375 ), ( "[offset,size]", "", "Append log record with no topics" ) )
    , ( ( 0xA1, "LOG1", 750 ), ( "[offset,size,topic]", "", "Append log record with one topic" ) )
    , ( ( 0xA2, "LOG2", 1125 ), ( "[offset,size,topic1,topic2]", "", "Append log record with two topics" ) )
    , ( ( 0xA3, "LOG3", 1500 ), ( "[offset,size,topic1,topic2,topic3]", "", "Append log record with three topics" ) )
    , ( ( 0xA4, "LOG4", 1875 ), ( "[offset,size,topic1,topic2,topic3,topic4]", "", "Append log record with four topics" ) )
    , ( ( 0xF0, "CREATE", 32000 ), ( "[value,offset,size]", "address", "Create a new account with associated code" ) )
    , ( ( 0xF1, "CALL", 100 ), ( "[gas,address,value,argsOffset,argsSize,retOffset,retSize]", "success", "Message-call into an account" ) )
    , ( ( 0xF2, "CALLCODE", 100 ), ( "gas,address,value,argsOffset,argsSize,retOffset,retSize]", "success", "Message-call into this account with alternative account’s code" ) )
    , ( ( 0xF3, "RETURN", 0 ), ( "[offset,size]", "", "Halt execution returning output data" ) )
    , ( ( 0xF4, "DELEGATECALL", 100 ), ( "[gas,address,argsOffset,argsSize,retOffset,retSize]", "success", "Message-call into this account with an alternative account’s code, but persisting the current values for sender and value" ) )
    , ( ( 0xF5, "CREATE2", 32000 ), ( "[value,offset,size,salt,address]", "", "Create a new account with associated code at a predictable address" ) )
    , ( ( 0xFA, "STATICCALL", 100 ), ( "[gas,address,argsOffset,argsSize,retOffset,retSize]", "success", "Static message-call into an account" ) )
    , ( ( 0xFD, "REVERT", 0 ), ( "[offset,size]", "", "Halt execution reverting state changes but returning data and remaining gas" ) )
    , ( ( 0xFE, "INVALID", 0 ), ( "", "", "Designated invalid instruction" ) )
    , ( ( 0xFF, "SELFDESTRUCT", 5000 ), ( "[address]", "", "Halt execution and register account for later deletion or send all Ether to address (post-Cancun)" ) )
    ]



-- From https://ethereum-json-rpc.com
-- Sent over the wire with an "id" property to cloudflare-eth.com
-- That is sent back, along with "jsonrpc" and "result", both strings.


jsonOpcodes : List JsonOpcode
jsonOpcodes =
    [ { jsonrpc = "2.0"
      , method = "eth_chainid"
      , name = "CHAINID"
      , params = []
      }
    , { jsonrpc = "2.0"
      , method = "eth_blockNumber"
      , name = "NUMBER"
      , params = []
      }
    , { jsonrpc = "2.0"
      , method = "eth_gasPrice"
      , name = "GASPRICE"
      , params = []
      }
    ]
