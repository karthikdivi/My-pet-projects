package com.mail.bms;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail {

	public static void main(String[] args) {

		List<String> toList = new ArrayList<String>();
		toList.add("karthik4153@gmail.com");
		toList.add("Rakesh.Kumar@jda.com");

		sendMail(toList, "TO multiple emails", "Delivery to multiple emails");
	}

	static void sendMail(List<String> toList, String subtext, String bodyText) {

		final String username = MailProperties.userName;
		final String password = MailProperties.pwd;

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("fromemail@gmail.com"));
			for (String toEmail : toList) {
				message.addRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));				
			}
			message.setSubject(subtext);
			message.setText(bodyText);
			Transport.send(message);			
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}

	}

}
