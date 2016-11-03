package cn.edu.ccu.business.srolecourse;

import cn.edu.ccu.data.srolecourse.SroleCourseMapper;
import cn.edu.ccu.ibusiness.srolecourse.ISroleCourse;
import cn.edu.ccu.model.srolecourse.SroleCourse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Fanliyan on 2016/10/29.
 */
@Service
public class SroleCourseBusiness implements ISroleCourse {

    @Autowired
    private SroleCourseMapper sroleCourseMapper;


    @Override
    public List selectCourseId(int sroleId) throws Exception {
       List<Map> courseIdList = sroleCourseMapper.selectCoruseId(sroleId);
        List courseIdIntList = new ArrayList();
        for(Map courseId : courseIdList){
           Integer courseIdInt = (Integer)courseId.get("course_id");
            courseIdIntList.add(courseIdInt);
        }
        return courseIdIntList;
    }

    @Override
    public Map addOrEdit(List<Integer> courseIds, int sroleId) throws Exception {
        Map reMap = new HashMap();
        sroleCourseMapper.deleteSroleCourse(sroleId);
        SroleCourse sroleCourse = new SroleCourse();
        int count = 0;
        for(Integer courseId : courseIds){
            sroleCourse.setCourseId(courseId);
            sroleCourse.setRoleId(sroleId);
            sroleCourseMapper.insertSroleCourse(sroleCourse);
            count++;
        }
        if(count == 0){
            reMap.put("result", false);
        }else if(count > 0){
            reMap.put("result", true);
        }
        return reMap;
    }
}
