package longLaya.utils
{
	import longLaya.utils.Maths;
	import laya.utils.Color;
	/**
	 * 有关颜色的操作
	 * rgbSplit		将一个颜色值拆分成r g b 单个颜色值
	 * rgb2hsb		rgb 颜色转换成 hsb颜色
	 * hsb2rgb		hsb 颜色转换成 rgb颜色
	 * 
	 * 
	 * @author 王乐
	 * @time 2017/1/2 12:54
	 */
	public class Colors
	{
		
		/**
		 * 将一个颜色值拆分成r g b 单个颜色值
		 * @param	color rgb颜色 格式:"#ff0000"  "#f00"
		 * @return 	rgb的Object对象  值为十进制
		 * 			obj
		 * 			{
		 *				R:255,
		 * 				G:232,
		 * 				B:12
		 *			}
		 */
		public static function rgbSplit(color:String):Object
		{
			if (color.length == 4)
			{
				color = "#" + color.charAt(1) + color.charAt(1) + color.charAt(2) + color.charAt(2) + color.charAt(3) + color.charAt(3) 
			}
			
			var rgb_R:uint = Color.create("#" + color.toString().substr(1, 2)).numColor;
			var rgb_G:uint = Color.create("#" + color.toString().substr(3, 2)).numColor;
			var rgb_B:uint = Color.create("#" + color.toString().substr(5, 2)).numColor;
			
			var obj:Object = 
			{
				R:rgb_R,
				G:rgb_G,
				B:rgb_B
			}
			
			return obj;
		}
		
		/**
		 * 将 rgb 三种单独颜色值组合成 一个完整的color值
		 * @param	R	可以是十进制数 如 255 也可以是十六进制数 如 0xff
		 * @param	G	可以是十进制数 如 255 也可以是十六进制数 如 0xff
		 * @param	B	可以是十进制数 如 255 也可以是十六进制数 如 0xff
		 * @return	整合后的颜色值  #ff0000
		 */
		public static function rgbMerge(R:uint, G:uint, B:uint):String
		{
			var rgb_r:String = R.toString(16)
			var rgb_g:String = G.toString(16)
			var rgb_b:String = B.toString(16)
			
			if (rgb_r.length == 1)
			{
				rgb_r = "0" + rgb_r;
			}
			
			if (rgb_g.length == 1)
			{
				rgb_g = "0" + rgb_g;
			}
			
			if (rgb_b.length == 1)
			{
				rgb_b = "0" + rgb_b;
			}
			
			//trace(rgb_r, rgb_g, rgb_b);
			
			return ("#" + rgb_r + rgb_g + rgb_b);
		}
		
		/**
		 * rgb 颜色转换成 hsb颜色
		 * @param	color rgb颜色 格式:"#ff0000"
		 * @return	hsb颜色数组 [h,s,b]; s b 精确到0.01;
		 */
		public static function rgb2hsb(color:String):Array
		{
			var rgb:Object = rgbSplit(color);
			
			var rgb_R:int = rgb.R;
			var rgb_G:int = rgb.G;
			var rgb_B:int = rgb.B;
			
			var arr:Array = [rgb_R, rgb_G, rgb_B];
			var max:int = Arrays.max(arr);
			var min:int = Arrays.min(arr);
			
			var hsb_H:Number;
			var hsb_S:Number;
			var hsb_B:Number;
			
			if (min == max)
			{
				hsb_H = 0;
			}
			else if (max == rgb_R && rgb_G >= rgb_B)
			{
				hsb_H = 60 * ((rgb_G - rgb_B) / (max - min));
			}
			else if (max == rgb_R && rgb_G < rgb_B)
			{
				hsb_H = 60 * ((rgb_G - rgb_B) / (max - min)) + 360;
			}
			else if (max == rgb_G)
			{
				hsb_H = 60 * ((rgb_B - rgb_R) / (max - min)) + 120;
			}
			else if (max == rgb_B)
			{
				hsb_H = 60 * ((rgb_R - rgb_G) / (max - min)) + 240;
			}
			
			if (max == 0) 
			{
				hsb_S = 0;  
			} 
			else 
			{
				hsb_S = Maths.floor(1 - (min / max),0.01);  
			}  
			
			hsb_B = Maths.floor(max / 255, 0.01);
			
			hsb_H = hsb_H >= 360 ? 0:hsb_H;
			
			//trace(hsb_H, hsb_S, hsb_B);
			
			return [hsb_H, hsb_S, hsb_B];
		}
		
		/**
		 * hsb 颜色值转换成 rgb 颜色值
		 * @param	hsb_H	0~360
		 * @param	hsb_S	0~1
		 * @param	hsb_B	0~1
		 * @return	rgb的R G B三个通道值的数组 十进制表示  可以通过rgbMerge方法 将其合并成一个完整的颜色值
		 */
		public static function hsb2rgb(hsb_H:Number, hsb_S:Number, hsb_B:Number):Array
		{
			var rgb_R:Number;
			var rgb_G:Number;
			var rgb_B:Number;
			
			hsb_H = (hsb_H >= 360) ? 0 : hsb_H;  
			
			if (hsb_S == 0)
			{
				rgb_R = hsb_B * 255;
				rgb_G = hsb_B * 255;
				rgb_B = hsb_B * 255;
			}
			else
			{
				var i:Number = Math.floor(hsb_H / 60) % 6;
				var f:Number = hsb_H / 60 - i;
				var p:Number = hsb_B * (1 - hsb_S);
				var q:Number = hsb_B * (1 - hsb_S * f);
				var t:Number = hsb_B * (1 - hsb_S * (1 - f));
				switch (i)
				{
					case 0 :
						rgb_R = hsb_B,rgb_G = t,rgb_B = p;
						break;
					case 1 :
						rgb_R = q;
						rgb_G = hsb_B;
						rgb_B = p;
						break;
					case 2 :
						rgb_R = p;
						rgb_G = hsb_B;
						rgb_B = t;
						break;
					case 3 :
						rgb_R = p;
						rgb_G = q;
						rgb_B = hsb_B;
						break;
					case 4 :
						rgb_R = t;
						rgb_G = p;
						rgb_B = hsb_B;
						break;
					case 5 :
						rgb_R = hsb_B;
						rgb_G = p;
						rgb_B = q;
						break;
				}
				rgb_R = rgb_R * 255;
				rgb_G = rgb_G * 255;
				rgb_B = rgb_B * 255;
			}
			
			//trace(rgb_R.toString(16),rgb_G.toString(16),rgb_B.toString(16))
			return [parseInt(rgb_R),parseInt(rgb_G),parseInt(rgb_B)];
		}
	}
}