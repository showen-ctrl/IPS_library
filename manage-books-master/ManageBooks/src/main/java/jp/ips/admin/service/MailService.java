package jp.ips.admin.service;

public interface MailService {
    void sendSimpleMail(String to, String subject, String content);
    void processReturnReminder();
    void processResReminder();
}
