package cn.edu.ccu.manage.utils;

import java.lang.annotation.*;

@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface AuthController {
	int moduleId() default 0;
}
 

 