package cn.edu.ccu.ibusiness.srolecourse;


import java.util.List;
import java.util.Map;

/**
 * Created by Fanliyan on 2016/10/29.
 */
public interface ISroleCourse {
    public List selectCourseId(int sroleId) throws Exception;

    public Map addOrEdit(List<Integer> courseIds, int sroleId) throws Exception;

}
