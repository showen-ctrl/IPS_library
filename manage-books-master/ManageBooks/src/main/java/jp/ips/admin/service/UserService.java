package jp.ips.admin.service;

import jp.ips.admin.pojo.User;


public interface UserService {
    User checkUser(User user);

    User checkManager(User user);
}
