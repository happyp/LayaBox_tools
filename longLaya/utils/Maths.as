package 
{
	/**
	 * 定义一些常见的数学方面的方法
	 * 
	 * randomInt			返回一个区间内的一个随机整数
	 * 
	 * 
	 * @author Happyking
	 */
	public class Maths
	{
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
	}
	
}