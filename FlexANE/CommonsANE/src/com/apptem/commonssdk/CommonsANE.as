package com.apptem.commonssdk
{
	import flash.events.EventDispatcher;
	import flash.external.ExtensionContext;
	
	/**
	 * 公共ANE接口
	 * Emck AppTem.com
	 */
	public class CommonsANE extends EventDispatcher
	{
		private var extContext:ExtensionContext = null;		// 保存外部扩展实例
		public static var Instance:CommonsANE;				// 当前对象CommonsANE的单实例
		
		/**
		 * CommonsANE 初始化
		 */
		public function CommonsANE()
		{
			super();
			if (extContext == null) {
				// 创建本地化接口
				extContext = ExtensionContext.createExtensionContext("com.apptem.CommonsANE", null);
				// 调用本地化接口初始化方法
				if ((extContext.call(Constants.SDKInit) as Boolean) == false) {	// 调用iOS接口初始化
					trace("初始化CommonsANE接口失败");
				}
			}
		}
		
		/**
		 * 获取Apple IDFA
		 * @return 成功返回IDFA字符串
		 */
		public function GetIDFA():String
		{
			return extContext.call(Constants.GetIDFA) as String;
		}
		
		/**
		 * 获取OpenUUID
		 * @return 成功返回OpenUUID字符串
		 */
		public function GetOpenUUID():String
		{
			return extContext.call(Constants.GetOpenUUID) as String;
		}

		/**
		 * 初始化CommonsANE实例,仅在启动时调用一次即可
		 * @return 返回CommonsANE的单实例
		 */
		public static function Init():CommonsANE
		{
			if (Instance == null) Instance = new CommonsANE();
			trace("Init CommonsANE...");
			return Instance;
		}
	}
}