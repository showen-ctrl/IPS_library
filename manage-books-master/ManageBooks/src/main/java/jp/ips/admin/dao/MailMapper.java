package jp.ips.admin.dao;

import jp.ips.admin.pojo.MailDetail;

import java.util.List;

public interface MailMapper {
    // 还书提醒
    List<MailDetail> returnReminder();

    List<MailDetail> resReminder();
}
