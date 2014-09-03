package com.mail.bms;

import java.util.StringTokenizer;

public class Improvement {
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		String time80="3:54:50";		
		String time81="0:37:27";		
		StringTokenizer at = new StringTokenizer(time80,":");
		
		float sec80 = Integer.parseInt(at.nextToken()) * 60 *60  +
				Integer.parseInt(at.nextToken()) * 60 + Integer.parseInt(at.nextToken()); 
		
		
		at = new StringTokenizer(time81,":");
		
		float sec81 = Integer.parseInt(at.nextToken()) * 60 *60  +
				Integer.parseInt(at.nextToken()) * 60 + Integer.parseInt(at.nextToken()); 
		
		
		System.out.println(sec80+" - "+sec81+" = "+ (sec80-sec81));   
		
		
		// System.out.println(((sec81-sec80)/sec80)*100);		
		
		 System.out.println(((sec80-sec81)/sec81)*100);
		
	}

}
