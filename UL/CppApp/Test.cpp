﻿#include "stdafx.h"
#include "Test.h"
#include "Object.h"
#include "Int32.h"
#include "Console.h"
#include "Int64.h"
#include "String.h"
void System::Test::Run()
{
	TestInt();
	TestString();
}
void System::Test::TestInt()
{
	System::Int32 a = 5;
	a = System::Int32::op_Addition(a,6);
	System::Console::WriteLine(a);
	a = System::Int32::op_Addition(a,7);
	System::Console::WriteLine(a);
	System::Int64 b = System::Int32::Int64(a);
	System::Console::WriteLine(b);
	System::Console::WriteLine(System::Int32::op_Substraction(a,5));
	System::Console::WriteLine(System::Int32::op_Modulus(a,5));
	System::Console::WriteLine(PostfixUnaryHelper::op_Increment<System::Int32>(a));
	System::Console::WriteLine(PrefixUnaryHelper::op_Increment<System::Int32>(a));
	System::Console::WriteLine(System::Int32::op_UnaryNegation(a));
}
void System::Test::TestString()
{
	Ref<System::String> v = Ref<System::String>(new System::String(_T("你好")));
	System::Console::WriteLine(v);
}
