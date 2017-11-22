﻿namespace System
{
    public struct Double
    {
        public const double Epsilon = 4.94065645841247e-324;
        public const double MaxValue = 1.79769313486231e308;
        public const double MinValue = -1.79769313486231e308;

        public extern static Double Parse(string value);

        public extern override string ToString();

        public static bool TryParse(string value, out Double v)
        {
            try
            {
                v = Parse(value);
                return true;
            }
            catch (Exception e)
            {
                v = 0;
                return false;
            }
        }
    }
}
