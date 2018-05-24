package longLaya.utils
{
	import longLaya.utils.Maths;
	
	/**
	 * 定义一些常见的数组操作
	 * 
	 * addArrs			将多个数组添加到一个数组中
	 * duplicate		拷贝一个数组
	 * equals			判断 两个 数组是否相等
	 * max				获取一个数组中最大的值 (只针对数值数组)
	 * min				获取一个数组中最小的值 (只针对数值数组)
	 * sum				获取一个数组中所有数值型成员得总和  它会自动排除不是Number类型的成员
	 * average			求一个数组中成员的平均值  (针对 数值型数组)
	 * randomize		将一个数组的成员顺序打乱 并返回新的数组 不会改变原数组的顺序
	 * switchElements	交换数组中两个成员的位子
	 * findMatchIndices	找出数组中 相匹配的所有成员的 序号  并返回包含这些序号的数组
	 * toListTrace		按顺序列出数组的所有的元素 (方便 trace() 数组, 每个元素占一行)
	 * getRandomFromArr	得到数组中任意一个值 
	 * 
	 * @author 王乐
	 * @time 2016/12/8 12:46
	 */
	public class Arrays  
	{
		
		/**
		 * 将多个数组添加到一个数组中
		 * @param	sourceArr  需要扩充的数组
		 * @param	...rest    一个或多个需要被添加的数组
		 * @return  新的被扩充完的数组
		 */
		public static function addArrs(sourceArr:Array, ...rest):Array
		{
			if (sourceArr == null)
			{
				sourceArr = [];
			}
			for (var i:int = 0; i < rest.length; i++)
			{
				for (var j:int = 0; j < rest[i].length; j++)
				{
					sourceArr.push(rest[i][j]);
				}
			}
			
			return sourceArr;
		}
		
		/**
		 * 拷贝一个数组 
		 * @param	oArray       需要拷贝的数组
		 * @param	bRecursive   是否递归复制 ( 主要针对多维数组 )  默认 false 不递归复制,只拷贝一次
		 * @return  返回拷贝的数组
		 */
		public static function duplicate(oArray:Array, bRecursive:Boolean = false):Array
		{
			var oDuplicate:Array;
			if (bRecursive)
			{
				
					oDuplicate = new Array();
					for (var i:Number = 0; i < oArray.length; i++)
					{
						if (oArray[i] is Array)
						{
							oDuplicate[i] = duplicate(oArray[i]);
						}
						else
						{
							oDuplicate[i] = oArray[i];
						}
					}
					return oDuplicate;
				
			
			}
			else
			{
				if (oArray is Array)
				{
					return oArray.concat();
				}
				else
				{
					oDuplicate = new Array();
					for (var sItem:String in oArray)
					{
						oDuplicate[sItem] = oArray[sItem];
					}
					return oDuplicate;
				}
			}
		}
		
		/**
		 * 判断 两个 数组是否相等
		 * @param	aArrayA      数组A
		 * @param	aArrayB      数组B
		 * @param	bNotOrdered  是否忽略排列顺序  默认 false 不忽略排序
		 * @param	bRecursive   是否递归 对于判断二维及二维以上的数组有用  默认 false 不使用递归
		 * @return  false 两数组不相等  true 两数组相等
		 */
		public static function equals(aArrayA:Array, aArrayB:Array, bNotOrdered:Boolean = false, bRecursive:Boolean = false):Boolean
		{
			if (aArrayA.length != aArrayB.length)
			{
				return false;
			}
			var aArrayACopy:Array = aArrayA.concat();
			var aArrayBCopy:Array = aArrayB.concat();
			if (bNotOrdered)
			{
				aArrayACopy.sort();
				aArrayBCopy.sort();
			}
			for (var i:Number = 0; i < aArrayACopy.length; i++)
			{
				if (aArrayACopy[i] is Array && bRecursive)
				{
					if (! equals(aArrayACopy[i],aArrayBCopy[i],bNotOrdered,bRecursive))
					{
						return false;
					}
				}
				else if (aArrayACopy[i] is Object && bRecursive)
				{
					if (! objectEquals(aArrayACopy[i],aArrayBCopy[i]))
					{
						return false;
					}
				}
				else if (aArrayACopy[i] != aArrayBCopy[i])
				{
					return false;
				}
			}
			return true;
		}
		
		/**
		 * 获取一个数组中最大的值 (只针对数值数组)
		 * @param	aArray  需要获取最大值得数组
		 * @return  数组中最大的值
		 */
		public static function max(aArray:Array):Number
		{
			var aCopy:Array = aArray.concat();
			aCopy.sort(Array.NUMERIC);
			var nMaximum:Number = Number(aCopy.pop());
			return nMaximum;
		}
		
		/**
		 * 获取一个数组中最小的值 (只针对数值数组)
		 * @param	aArray  需要获取最小值得数组
		 * @return  数组中最小的值
		 */
		public static function min(aArray:Array):Number
		{
			var aCopy:Array = aArray.concat();
			aCopy.sort(Array.NUMERIC);
			var nMinimum:Number = Number(aCopy.shift());
			return nMinimum;
		}
		
		/**
		 * 获取一个数组中所有数值型成员得总和  它会自动排除不是Number类型的成员
		 * @param	aArray  需要求总和的数组  
		 * @return  返回一个数组中所有数值型成员得总和
		 */
		public static function sum(aArray:Array):Number
		{
			var nSum:Number = 0;
			for (var i:Number = 0; i < aArray.length; i++)
			{
				if (typeof aArray[i] == "number")
				{
					nSum +=  aArray[i];
				}
			}
			return nSum;
		}
		
		/**
		 * 求一个数组中成员的平均值  (针对 数值型数组)
		 * @param	aArray  需要求平均值的数组
		 * @return  数组中成员的平均值
		 */
		public static function average(aArray:Array):Number
		{
			for (var i:int = 0; i < aArray.length; i++)
			{
				trace(typeof aArray[i])
				
				if (typeof aArray[i] != "number" )
				{
					trace("数组中含有非数值型成员")
					return 0
				}
			}
			return sum(aArray) / aArray.length;
		}
		
		/**
		 * 将一个数组的成员顺序打乱 并返回新的数组 不会改变原数组的顺序
		 * @param	aArray  需要打乱顺序的数组
		 * @return  返回新的被打乱顺序的数组
		 */
		public static function randomize(aArray:Array):Array
		{
			var aCopy:Array = aArray.concat();
			var aRandomized:Array = new Array();
			var oElement:Object;
			var nRandom:Number;
			for (var i:Number = 0; i < aCopy.length; i++)
			{
				nRandom = Maths.randomInt(0, aCopy.length - 1);
				
				aRandomized.push(aCopy[nRandom]);
				aCopy.splice(nRandom, 1);
				i--;
			}
			return aRandomized;
		}
		
		/**
		 * 交换数组中两个成员的位子
		 * @param	aArray    需要交换成员位子的数组
		 * @param	nIndexA   成员A在数组中的位置
		 * @param	nIndexB   成员B在数组中的位置
		 */
		public static function switchElements(aArray:Array, nIndexA:Number, nIndexB:Number):void
		{
			var oElementA:Object = aArray[nIndexA];
			var oElementB:Object = aArray[nIndexB];
			aArray.splice(nIndexA, 1, oElementB);
			aArray.splice(nIndexB, 1, oElementA);
		}
		
		/**
		 * 找出数组中 相匹配的所有成员的 序号  并返回包含这些序号的数组
		 * @param	aArray    需要检测的数组
		 * @param	oElement  匹配的元素
		 * @return  包含所有匹配元素的序号数组
		 */
		public static function findMatchIndices(aArray:Array, oElement:*):Array
		{
			var aIndices:Array = new Array();
			var nIndex:Number = aArray.indexOf(oElement);
			
			while (nIndex != -1)
			{
				aIndices.push(nIndex);
				nIndex = aArray.indexOf(oElement,nIndex + 1);
			}
			return aIndices;
		}
		
		
		/**
		 * 按顺序列出数组的所有的元素 (方便 trace() 数组, 每个元素占一行)
		 * @param	oArray  需要列出元素的数组
		 * @return  列出数组的元素的 字符串
		 */
		public static function toListTrace(oArray:Array):String
		{
			var sIndent:String = "";
			
			var sOutput:String = "";
			
			var len:int = oArray.length;
			for (var i:int = 0; i < len; i++)
			{
				sOutput += "** " + i + "\t:\t " + oArray[i].toString() + "\n";
			}
			
			return sOutput;
		}
		
		/**
		 * 得到数组中任意一个值 
		 * @param	arr		 	需要进行运算的数组
		 * @param   isDelete 	是否删除该值 默认 true 删除
		 * @return
		 */
		public static function getRandomFromArr(arr:Array,isDelete:Boolean = true):*
		{
			if (arr.length == 0)
			{
				trace("数组为空")
				return null
			}
			
			var ram:int = Maths.randomInt(0, arr.length - 1);
			var num:* = arr[ram];
			if (isDelete)
			{
				arr.splice(ram, 1);
			}
			
			return num;
			
			
		}
		
		
		
		//------------------------私有函数-----------------------------------------
		private static function objectEquals(oInstanceA:Object, oInstanceB:Object):Boolean
		{
			for (var sItem:String in oInstanceA)
			{
				if (oInstanceA[sItem] is Object)
				{
					if (! objectEquals(oInstanceA[sItem],oInstanceB[sItem]))
					{
						return false;
					}
				}
				else
				{
					if (oInstanceA[sItem] != oInstanceB[sItem])
					{
						return false;
					}
				}
			}
			return true;
		}
	}
	
}