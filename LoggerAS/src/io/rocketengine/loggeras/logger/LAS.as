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

package io.rocketengine.loggeras.logger
{
	import flash.utils.getQualifiedClassName;
	
	import io.rocketengine.loggeras.logger.interfaces.ILASLogger;
	import io.rocketengine.loggeras.logger.interfaces.ILASTarget;

	/**
	 * LoggerASLoggerFactory
	 * Author: Tilman Griesel <https://github.com/TilmanGriesel/> 
	 */
	public class LAS
	{
		//--------------------------------------------------------------------------
		//
		//  Instance Properties
		//
		//--------------------------------------------------------------------------
		
		public static var VERSION:String = '1.5';
		
		private static var _registeredLogTargets:Vector.<ILASTarget> = new Vector.<ILASTarget>;
		private static var _filteredClasses:Vector.<String> = new Vector.<String>;
		private static var _invertClassFilter:Boolean;
		private static var _logLevel:uint = LASLogLevel.ALL;
		
		private static var _stats:LASLogStats = new LASLogStats();
		private static var _debugMsgCount:int;
		private static var _infogMsgCount:int;
		private static var _warnMsgCount:int;
		private static var _errorMsgCount:int;
		private static var _fatalMsgCount:int;
		
		//--------------------------------------------------------------------------
		//
		//  API
		//
		//--------------------------------------------------------------------------

		/**
		 * Define log level
		 */
		public static function logLevel(level:uint):void
		{
			_logLevel = level;
		}
		
		/**
		 * Add a new log target
		 */
		public static function addTarget(target:ILASTarget):void
		{
			_registeredLogTargets.push(target);
		}
		
		/**
		 * Add classes to filter. After adding a class filter, only filtered classes will be shown in the normal case. 
		 * If you want to invert the class filter to exclude given classes, you can use the "invertClassFilter = true" setter. 
		 * Posible values: MyClass or "com.pack.example::MyClass"
		 */
		public static function filterClasses(... args):void
		{
			for(var i:int = 0; i < args.length; i++)
			{
				if(args[i] is Class)
				{
					_filteredClasses.push(getQualifiedClassName(args[i]));		
				}
				else
				{
					_filteredClasses.push(args[i]);
				}
			}
		}
		
		/**
		 * Invert the class filter
		 */
		public static function set invertClassFilter(value:Boolean):void
		{
			_invertClassFilter = value;
		}

		public static function get invertClassFilter():Boolean
		{
			return _invertClassFilter;
		}
		
		/**
		 * Get a new LoggerAS logger
		 * @param class name
		 */
		public static function getLogger(input:*):ILASLogger
		{
			var classname:String = getQualifiedClassName(input as Class);
			return new LASLogger(classname, onMessage);
		}
		
		/**
		 * Handle log messages
		 */
		public static function onMessage(item:LASLogItem):void
		{	
			if(itemLevelIsAllowed(item.level))
			{
				if(!_invertClassFilter && isFilteredClass(item.fqcn) || _invertClassFilter && !isFilteredClass(item.fqcn))
				{
					updateLogStats(item.level);
					for each(var target:ILASTarget in _registeredLogTargets)
					{
						target.log(item);
					}
				}				
			}
			item.dispose();
			item = null;
		}
		
		public static function get stats():LASLogStats
		{
			return _stats;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Class Methods
		//
		//--------------------------------------------------------------------------
		
		private static function itemLevelIsAllowed(level:int):Boolean
		{
			if(level >= _logLevel) return true;
			else return false; 
		}
		
		private static function isFilteredClass(fqcn:String):Boolean
		{
			// if nothing added return immediately
			if(_filteredClasses.length == 0) return true;
			// check if gived class name is on the filter list
			for each(var ffqcn:String in _filteredClasses)
			{
				if(ffqcn == fqcn) return true;
			}
			// if nobody returned this method we can return false
			return false;
		}
		
		private static function updateLogStats(level:int):void
		{
			_stats.messages++;
			switch(level)
			{
				case LASLogLevel.DEBUG: _stats.debugMessages++; break;
				case LASLogLevel.INFO:  _stats.infoMessages++; break;
				case LASLogLevel.WARN:  _stats.warnMessages++; break;
				case LASLogLevel.ERROR: _stats.errorMessages++; break;
				case LASLogLevel.FATAL: _stats.fatalMessages++; break;
				default: break;
			}
		}
	}
}