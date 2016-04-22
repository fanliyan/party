package cn.edu.ccu.school.utils;

import java.lang.annotation.*;

@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface AuthMethod {
	boolean mustLogin() default true;
	
	int permissionId() default 0;
}