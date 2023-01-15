package jp.ips.admin.exception;

import jp.ips.admin.enumeration.ExceptionEnum;
import lombok.Data;

@Data
public class ServiceException extends RuntimeException {
    private Integer code;

    public ServiceException(ExceptionEnum exceptionEnum) {
        super(exceptionEnum.getMessage());
        this.code = exceptionEnum.getCode();
    }
}
