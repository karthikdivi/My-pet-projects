package com.domain.check;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;

public class DomainCheck {

	public static void main(String args[]) {

		String domainName = "";

		int i = 0;

		try (BufferedReader br = new BufferedReader(new FileReader(
				"brit-a-z.txt"))) {	

			while ((domainName = br.readLine()) != null) {

				i++;
				if (i > 100)
					return;

				try {

					checkDomain(domainName + ".com");
				} catch (UnknownHostException e) {
					// TODO Auto-generated catch block
					System.out
							.println(domainName + "############ Is available");
				}

			}

		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	private static void checkDomain(String domainName)
			throws UnknownHostException {

		InetAddress inetAddress = InetAddress.getByName(domainName);
		// System.out.println(inetAddress.getHostName()+"->"+inetAddress.getHostAddress()
		// );

		inetAddress.getHostName();
		inetAddress.getHostAddress();

	}

}
