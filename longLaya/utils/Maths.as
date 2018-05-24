package longLaya.utils
{
	/**
	 * 定义一些常见的数学方面的方法
	 * 
	 * randomInt			返回一个区间内的一个随机整数
	 * asDegrees			将一个弧度值转化为角度值
	 * asRadians			将一个角度值转化为弧度值
	 * round				取近似值 (四舍五入)
	 * floor				取近似值 (去尾)
	 * ceil					取近似值 (进一)
	 * 
	 * 
	 * @author Happyking
	 * @time 2018.5.9
	 */
	public class Maths
	{
		private static const RADTODEG:Number = 180 / Math.PI;
		private static const DEGTORAD:Number = Math.PI / 180;
		
		/**
		 * 1.返回一个区间内[min, max]的一个随机整数(包括边界)
		 * @param min 最小值限定
		 * @param max 最大值限定
		 * @return int 返回一个随机数
		 */
		public static function randomInt(min:int,max:int):int
		{
			return parseInt(Math.random() * (max - min + 1) + min);
		}
		
		
		/**
		 * 将一个弧度值转化为角度值
		 * 
		 * @param radians 以弧度为单位的角度值
		 * @return 以角度为单位的角度值
		 */
		public static function asDegrees( radians:Number ):Number
		{
			return radians * RADTODEG;
		}
		
		/**
		 * 将一个角度值转化为弧度值
		 * 
		 * @param degrees 以角度为单位的角度值
		 * @return 以弧度为单位的角度值
		 */
		public static function asRadians( degrees:Number ):Number
		{
			return degrees * DEGTORAD;
		}
		
		
		/**
		 * 取近似值 (四舍五入) 如:
		 * 
		 * trace(Maths.round(Math.PI)); 			// 显示: 3
		 * trace(Maths.round(Math.PI, .01)); 		// 显示: 3.14
		 * trace(Maths.round(Math.PI, .0001)); 		// 显示: 3.1416
		 * 
		 * @param	nNumber				求近似值得数
		 * @param	nRoundToInterval	精确的位数   可选的值 1  0.1   0.01   0.001 等等
		 * @return  返回近似值
		 */
		public static function round(nNumber:Number, nRoundToInterval:Number = 1):Number 
		{
			return Math.round(nNumber / nRoundToInterval) / (1/nRoundToInterval);
		}
		
		/**
		 * 取近似值 (去尾) 如:
		 * 
		 * trace(Maths.floor(Math.PI)); 			// 显示: 3
		 * trace(Maths.floor(Math.PI, .01)); 		// 显示: 3.14
		 * trace(Maths.floor(Math.PI, .0001)); 		// 显示: 3.1415
		 * 
		 * @param	nNumber				求近似值得数
		 * @param	nRoundToInterval	精确的位数   可选的值 1  0.1   0.01   0.001 等等
		 * @return  返回近似值
		 */
		public static function floor(nNumber:Number, nRoundToInterval:Number = 1):Number 
		{
			return Math.floor(nNumber / nRoundToInterval) / (1/nRoundToInterval);
		}
		
		/**
		 * 取近似值 (进一) 如:
		 * 
		 * trace(Maths.ceil(Math.PI)); 				// 显示: 4
		 * trace(Maths.ceil(Math.PI, .01)); 		// 显示: 3.15
		 * trace(Maths.ceil(Math.PI, .0001));	 	// 显示: 3.1416
		 * 
		 * @param	nNumber				求近似值得数
		 * @param	nRoundToInterval	精确的位数   可选的值 1  0.1   0.01   0.001 等等
		 * @return  返回近似值
		 */
		public static function ceil(nNumber:Number, nRoundToInterval:Number = 1):Number 
		{
			return Math.ceil(nNumber / nRoundToInterval) / (1/nRoundToInterval);
		}
	}
	
}