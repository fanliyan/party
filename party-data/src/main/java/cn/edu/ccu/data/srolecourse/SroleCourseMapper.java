package cn.edu.ccu.data.srolecourse;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.srolecourse.SroleCourse;

import java.util.List;
import java.util.Map;

/**
 * Created by Fanliyan on 2016/10/29.
 */
@PartyDB
public interface SroleCourseMapper {
        public List selectCoruseId(int sroleId) throws Exception;

        public int deleteSroleCourse(int sroleId) throws Exception;

        public int insertSroleCourse(SroleCourse sroleCourse) throws Exception;
}
