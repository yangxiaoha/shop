package com.zpt.shop.common.pojo;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
/**
 * 功能说明:
 * 
 * MyTime.java
 *
 * Original Author: 林敏,2016年6月1日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public class MyTime {	
		
	public static String getNowFormatDate() {		
		Calendar nowtime = Calendar.getInstance();  
		String year = String.format("%04d", nowtime.get(Calendar.YEAR)); 
		String month = String.format("%02d", nowtime.get(Calendar.MONTH)+1);
		String day = String.format("%02d", nowtime.get(Calendar.DATE));
        String hour = String.format("%02d", nowtime.get(Calendar.HOUR));
        String minute = String.format("%02d", nowtime.get(Calendar.MINUTE));
        String second = String.format("%02d", nowtime.get(Calendar.SECOND)); 
        String time = year + month + day + hour + minute + second; 
		return time.substring(2, time.length());
	}
	
	/**
	 * 获取当前日期yyyy-MM-dd HH:mm:ss
	 * @return Date
	 * @throws Exception 
	 */
	public static Date getCurrTime() throws Exception {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return df.parse(df.format(new Date()));
	}
	
	/** 
     * 两个时间相差距离多少天多少小时多少分多少秒 
     * @param str1 时间参数 1 格式：1990-01-01 12:00:00 
     * @param str2 时间参数 2 格式：2009-01-01 12:00:00 
     * @return String 返回值为：xx天xx小时xx分xx秒 
     */  
    public static long[] getDistanceTime(String str1, String str2) { 
    	long[] timeArray = new long[4];   
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
        Date one;  
        Date two;  
        long day = 0;  
        long hour = 0;  
        long min = 0;  
        long sec = 0;  
        try {  
            one = df.parse(str1);  
            two = df.parse(str2);  
            long time1 = one.getTime();  
            long time2 = two.getTime();  
            long diff ;  
            if(time1<time2) {  
                diff = time2 - time1;  
            } else {  
                diff = time1 - time2;  
            }  
            day = diff / (24 * 60 * 60 * 1000);  
            hour = (diff / (60 * 60 * 1000) - day * 24);  
            min = ((diff / (60 * 1000)) - day * 24 * 60 - hour * 60);  
            sec = (diff/1000-day*24*60*60-hour*60*60-min*60);  
        } catch (ParseException e) {  
            e.printStackTrace();  
        } 
        timeArray[0] = day;
        timeArray[1] = hour;
        timeArray[2] = min;
        timeArray[3] = sec;
        return timeArray;  
    }  
	
}
