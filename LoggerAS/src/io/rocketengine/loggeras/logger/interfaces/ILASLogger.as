// The MIT License (MIT)
//
// Copyright (c) 2014 Tilman Griesel - <http://rocketengine.io> <http://github.com/TilmanGriesel>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//	
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//		
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//	SOFTWARE.

package io.rocketengine.loggeras.logger.interfaces
{
	/**
	 * ILoggerASLogger
	 * Author: Tilman Griesel <https://github.com/TilmanGriesel/> 
	 */
	public interface ILASLogger
	{
		/**
		 * Log debug message (level id: 2)
		 */
		function debug(... argArray):void;
		
		/**
		 * Log info message via info (level id: 4)
		 */
		function info(... argArray):void;
		
		/**
		 * Log info message via log (level id: 4)
		 */
		function log(... argArray):void;
		
		/**
		 * Log warn message (level id: 8)
		 */
		function warn(... argArray):void;
		
		/**
		 * Log error message (level id: 16)
		 */
		function error(... argArray):void;
		
		/**
		 * Log fatal message (level id: 32)
		 */
		function fatal(... argArray):void;
	}
}