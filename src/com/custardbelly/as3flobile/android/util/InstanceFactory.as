package com.custardbelly.as3flobile.android.util
{
	import flash.utils.getDefinitionByName;

	public class InstanceFactory
	{
		public static function getInstance( className:String ):*
		{
			try
			{
				var clazz:Class = getDefinitionByName( className ) as Class;
				return new clazz();
			}
			catch( e:Error )
			{
				return null;
			}
			return null;
		}
	}
}