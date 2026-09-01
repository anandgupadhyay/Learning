{\rtf1\ansi\ansicpg1252\cocoartf2870
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 // 1. DEFINING THE TYPES\
struct StructPoint \{\
    var x: Int\
    var y: Int\
    \
    // Structs need 'mutating' if a method changes internal state\
    mutating func moveX(by amount: Int) \{\
        self.x += amount\
    \}\
\}\
\
class ClassPoint \{\
    var x: Int\
    var y: Int\
    \
    init(x: Int, y: Int) \{\
        self.x = x\
        self.y = y\
    \}\
    \
    // Classes do NOT need any special keyword to change internal state\
    func moveX(by amount: Int) \{\
        self.x += amount\
    \}\
\}\
\
// ==========================================\
// 2. STRUCT MUTABILITY BEHAVIOR (Value Type)\
// ==========================================\
\
var mutableStruct = StructPoint(x: 10, y: 20)\
mutableStruct.x = 15 // \uc0\u9989  Allowed: The instance is a 'var'\
\
let immutableStruct = StructPoint(x: 10, y: 20)\
// immutableStruct.x = 15 \
// \uc0\u10060  ERROR: Cannot assign to property: 'immutableStruct' is a 'let' constant\
\
// --- Copying a Struct ---\
var structA = StructPoint(x: 1, y: 1)\
var structB = structA // A unique, independent copy is made!\
structB.x = 99        // Only changes structB\
\
print(structA.x) // Prints: 1  (Unchanged)\
print(structB.x) // Prints: 99 \
\
\
// ===========================================\
// 3. CLASS MUTABILITY BEHAVIOR (Reference Type)\
// ===========================================\
\
let constantClass = ClassPoint(x: 10, y: 20)\
constantClass.x = 15 // \uc0\u9989  Allowed! Even though the variable is a 'let' constant,\
                     // the underlying instance properties (var x) can still be modified.\
\
// constantClass = ClassPoint(x: 5, y: 5) \
// \uc0\u10060  ERROR: Cannot assign to value: 'constantClass' is a 'let' constant \
// (You cannot point 'constantClass' to a completely new ClassPoint object)\
\
// --- Copying a Class Reference ---\
let classA = ClassPoint(x: 1, y: 1)\
let classB = classA // Both classA and classB point to the exact same object in memory!\
classB.x = 99       // Modifying classB alters the shared data\
\
print(classA.x) // Prints: 99 (Changed!)\
print(classB.x) // Prints: 99\
}