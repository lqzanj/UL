#pragma once
#include "Object.h"
namespace System
{
class String;
}
namespace System
{
struct Boolean;
}
namespace System{
	struct SByte:public System::Object
	{
		public:
		static 		System::SByte MaxValue;
		public:
		static 		System::SByte MinValue;
		public:
		static System::SByte Parse(Ref<System::String>  value);
		public:
		Ref<System::String> ToString();
		public:
		static System::Boolean TryParse(Ref<System::String>  value,System::SByte  v);
	#include "SByte_ExtHeader.h"
	};
}
