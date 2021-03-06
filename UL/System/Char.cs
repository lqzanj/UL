﻿namespace System
{
    public struct Char
    {
        public static readonly char MaxValue = 0xFFFF;
        public static readonly char MinValue = 0;


        public extern static Char Parse(string value);

        public extern override string ToString();

        public static bool TryParse(string value, out Char v)
        {
            try
            {
                v = Parse(value);
                return true;
            }
            catch (Exception e)
            {
                v = '\0';
                return false;
            }
        }
    }
}
