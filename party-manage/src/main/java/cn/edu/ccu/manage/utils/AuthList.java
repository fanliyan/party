package cn.edu.ccu.manage.utils;

import com.sun.org.apache.xpath.internal.operations.Equals;

/**
 * Created by Administrator on 2016/4/12.
 */
public class AuthList {

    public static final int SUPER_ADMIN = 1;

    public static final int[] UNREMOVABLE_USER = new int[]{
            1,
    };

    public static final int[] UNREMOVABLE_ROLE = new int[]{
            1,
    };

    public static final int[] CANNT_GRANT_ROLE = new int[]{
            1,
    };


    public static boolean contains(int[] array, int id) {

        for (int i : array)
            if (i == id) return true;

        return false;
    }


    public static boolean isSuperAdmin(int id) {

        return Integer.compare(id, AuthList.SUPER_ADMIN) == 0;
    }


}
