script "CoreFieldHtmlText"
/*
Copyright (C) 2015 LiveCode Ltd.

This file is part of LiveCode.

LiveCode is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License v3 as published by the Free
Software Foundation.

LiveCode is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

You should have received a copy of the GNU General Public License
along with LiveCode.  If not see <http://www.gnu.org/licenses/>.  */

private function q pString
   replace "'" with quote in pString
   return pString
end q

on TestSurrogateRoundtrip
   create stack "Test"
   set the defaultStack to "Test"

   create field "TestField"

   set the htmlText of field "TestField" to "<p>&#78730;</p>"
   TestAssert "htmlText roundtrips surrogates", the htmlText of field "TestField" is "<p>&#78730;</p>"

   set the htmlText of field "TestField" to "<p metadata='&#78730;'></p>"
   TestAssert "htmlText roundtrips surrogates in paragraph metadata", the htmlText of field "TestField" is q("<p metadata='&#78730;'></p>")

   set the htmlText of field "TestField" to "<p><span metadata='&#78730;'>a</span></p>"
   TestAssert "htmlText roundtrips surrogates in span metadata", the htmlText of field "TestField" is q("<p><span metadata='&#78730;'>a</span></p>")

   set the htmlText of field "TestField" to "<p><img src='1000' char='&#78730;'></p>"
   TestAssert "htmlText roundtrips surrogates in imageSource char", the htmlText of field "TestField" is q("<p><img src='1000' char='&#78730;'></p>")

   delete stack "Test"
end TestSurrogateRoundtrip
