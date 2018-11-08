package.path = package.path ..';Lua\\?.lua';

function clone(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for key, value in pairs(object) do
            new_table[_copy(key)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

--Create an class.
function class(classname, super)
    local superType = type(super)
    local cls

    if superType ~= "function" and superType ~= "table" then
        superType = nil
        super = nil
    end

    if superType == "function" or (super and super.__ctype == 1) then
        -- inherited from native C++ Object
        cls = {}

        if superType == "table" then
            -- copy fields from super
            for k,v in pairs(super) do cls[k] = v end
            cls.__create = super.__create
            cls.super    = super
        else
            cls.__create = super
        end

        cls.ctor    = function() end
        cls.__cname = classname
        cls.__ctype = 1

        function cls.new(...)
            local instance = cls.__create(...)
            -- copy fields from class to native object
            for k,v in pairs(cls) do instance[k] = v end
            instance.class = cls
            instance:ctor(...)
            return instance
        end

    else
        -- inherited from Lua Object
        if super then
            cls = clone(super)
            cls.super = super
        else
            cls = {ctor = function() end}
        end

        cls.__cname = classname
        cls.__ctype = 2 -- lua
        cls.__index = cls

        function cls.new(...)
            local instance = setmetatable({}, cls)
            instance.class = cls
			instance:ctor(...)
            return instance
        end
    end

    return cls
end

function Construct(obj,constructorName,...)
	local func = obj[constructorName];
	func(obj,...)
	return obj
end

function try(func,...)
	local arg = {...};
	local error,result = pcall( func );
	if (not error) then
		for k,v in pairs(arg) do
			local t = get_type_by_table_name(v.type)
			if t:GetType():IsChildOf_ul_System_Type(result:GetType()) then
				v.func(result);
				break;
			end
		end
	end

	return result;
end

function get_type_by_table_name(name)
	return load("return "..name)();
end

PostfixUnaryHelper = {}
function PostfixUnaryHelper.op_Increment(a,func)
	local temp = clone(a);
	a = a:op_Increment();
	return temp,func(a);
end
function PostfixUnaryHelper.op_Decrement(a,func)
	local temp = clone(a);
	a:op_Decrement();
	return temp,func(a);
end

PrefixUnaryHelper = {}
function PrefixUnaryHelper.op_Increment(a,func)
	a = a:op_Increment();
	return a,func(a);
end
function PrefixUnaryHelper.op_Decrement(a,func)
	a = a:op_Decrement();
	return a,func(a);
end



require "ul.System"
require "ul.System.Object"
require "ul.System.Console"
require "ul.System.Int32"
require "ul.System.Int64"
require "ul.System.String"
require "ul.System.Boolean"
require "ul.System.Test"
require "ul.System.Delegate"
require "ul.System.TestDel"
require "ul.System.Exception"
require "ul.System.Type"
require "ul.System.Type_Metadata"
require "ul.System.Object_Metadata"
require "ul.System.Console_Metadata"
require "ul.System.Int32_Metadata"
require "ul.System.Int64_Metadata"
require "ul.System.String_Metadata"
require "ul.System.Boolean_Metadata"
require "ul.System.Test_Metadata"
require "ul.System.Exception_Metadata"
require "ul.System.Type_Metadata"
require "ul.System.Reflection.Metadata.Type"
require "ul.System.Reflection.Metadata.TypeSyntax"
require "ul.System.Reflection.Metadata.Member"
require "ul.System.Collections.Generic.List"
require "ul.System.Array"
require "ul.System.ArrayT"


function ul.System.TestDel:Invoke(...)
	for i,v in ipairs(self.list.__objs) do                    
		local thisDel = self.list:get_Index(ul.System.Int32.new(i-1));
        thisDel:Invoke(...);
	end

	if(self.__o == nil) then
		self.__method(...)
	else
		self.__method(self.__o,...)
	end
end


function ul.System.TestDel:ctor(...)
	local args = { ... }
	self.__o = args[1];
	self.__method = args[2];
end
function  main( ... )
	ul.System.Test.Run();
end