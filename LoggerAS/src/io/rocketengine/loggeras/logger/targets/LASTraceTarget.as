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

package io.rocketengine.loggeras.logger.targets
{
	import io.rocketengine.loggeras.logger.LASLogItem;
	import io.rocketengine.loggeras.logger.LASLogLevel;
	import io.rocketengine.loggeras.logger.interfaces.ILASTarget;

	/**
	 * LoggerASTraceTarget
	 * Author: Tilman Griesel <https://github.com/TilmanGriesel/> 
	 */
	public class LASTraceTarget implements ILASTarget
	{
		//--------------------------------------------------------------------------
		//
		//  Instance Properties
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Initialization
		//
		//--------------------------------------------------------------------------
		
		public function LASTraceTarget()
		{
		}

		//--------------------------------------------------------------------------
		//
		//  API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Procced log item
		 * @param some log item
		 * @param time past since the first log entry made
		 */
		public function log(item:LASLogItem):void
		{
			traceOutItem(item);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------
		
		private function traceOutItem(item:LASLogItem):void
		{
			// create output string
			var output:String = '';
			output += '[' + item.time + 'ms] ';
			output += '[' + LASLogLevel.getByID(item.level) + '] ';
			output += '[' + item.fqcn + '] ';
			output += item.message;
			
			// trace out
			trace(output);
		}
	}
}