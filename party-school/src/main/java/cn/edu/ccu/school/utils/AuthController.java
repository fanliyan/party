package cn.edu.ccu.school.utils;

import java.lang.annotation.*;

@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface AuthController {
	int moduleId() default 0;
}
 

 