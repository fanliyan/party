package cn.edu.ccu.business.course;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.data.TransactionManagerName;
import cn.edu.ccu.data.course.CourseModelMapper;
import cn.edu.ccu.data.course.CourseWareModelMapper;
import cn.edu.ccu.data.course.RCourseStudentModelMapper;
import cn.edu.ccu.ibusiness.course.ICourse;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.course.*;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/4/18.
 */
@Service
public class CourseBusiness implements ICourse {


    @Autowired
    private CourseModelMapper courseModelMapper;
    @Autowired
    private RCourseStudentModelMapper rCourseStudentModelMapper;
    @Autowired
    private CourseWareModelMapper courseWareModelMapper;


    public CourseModel selectById(Integer id) {
        if (IntegerExtention.hasValueAndMaxZero(id)) {
            return courseModelMapper.selectByPrimaryKey(id);
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public CourseModel selectDetailById(Integer id) {
        if (IntegerExtention.hasValueAndMaxZero(id)) {

            CourseModel courseModel = courseModelMapper.selectByPrimaryKey(id);

            List<CourseWareModel> courseWareModelList = courseWareModelMapper.selectByCourseId(id);
            courseModel.setCourseWareModelList(courseWareModelList);

            return courseModel;
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public CourseWareModel getWareById(Integer id) {
        if (IntegerExtention.hasValueAndMaxZero(id)) {

            return courseWareModelMapper.selectByPrimaryKey(id);
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public CourseListResponse listByPage(CourseListRequest courseListRequest, boolean withCourseWare) {

        CourseListResponse response = new CourseListResponse();
        Map<String, Object> map = new HashMap<>();

        CourseModel courseModel = courseListRequest.getCourseModel();
        if (courseListRequest.getIds() != null && courseListRequest.getIds().size() > 0) {
            map.put("ids", courseListRequest.getIds());
        }
        if (courseModel != null) {
            if (!StringExtention.isTrimNullOrEmpty(courseModel.getCourseName()))
                map.put("name", courseModel.getCourseName());
            if (IntegerExtention.hasValueAndMaxZero(courseModel.getCourseType()))
                map.put("courseType", courseModel);
        }

        List<CourseModel> courseModelList = courseModelMapper.select(map);

        //插入课件信息
        if (withCourseWare) {
            for (CourseModel model : courseModelList) {
                List<CourseWareModel> courseWareModelList = courseWareModelMapper.selectByCourseId(model.getCourseId());
                model.setCourseWareModelList(courseWareModelList);
            }
        }


        response.setCourseModelList(courseModelList);

        if (courseListRequest.getSplitPageRequest() != null && courseListRequest.getSplitPageRequest().isReturnCount()) {
            int rowCount = courseModelMapper.count(map);
            response.setSplitPageResponse(UtilsBusiness.getSplitPageResponse(
                    rowCount, courseListRequest.getSplitPageRequest().getPageSize(),
                    courseListRequest.getSplitPageRequest().getPageNo()));
        }

        return response;

    }

    public CourseListResponse myCourseList(Integer id) {

        if (IntegerExtention.hasValueAndMaxZero(id)) {
            List<Integer> ids = rCourseStudentModelMapper.selectCourseByStudentId(id);

            if (ids != null && ids.size() > 0) {
                CourseListRequest courseListRequest = new CourseListRequest();
                courseListRequest.setIds(ids);
                courseListRequest.setSplitPageRequest(new SplitPageRequest());

                return this.listByPage(courseListRequest, true);
            }

            return new CourseListResponse();
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


    @Transactional(TransactionManagerName.partyTransactionManager)
    public boolean addCourse(CourseModel courseModel, String[] courseWare) {

        if (courseModel != null) {
            if (StringExtention.isTrimNullOrEmpty(courseModel.getCourseName())) {
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            }
            if (StringExtention.isTrimNullOrEmpty(courseModel.getCourseName())) {
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            }
            if (StringExtention.isTrimNullOrEmpty(courseModel.getTime())) {
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            }
            if (courseModel.getScore() == null || courseModel.getScore() < 0) {
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            }

            if (!IntegerExtention.hasValueAndMaxZero(courseModel.getCourseType())) {
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            }

            int i = courseModelMapper.insertSelective(courseModel);

            //添加课件
            if (i > 0 && courseWare != null && courseWare.length > 0) {
                for (String ware : courseWare) {

                    String url = ware.split("::")[0];
                    String time = ware.split("::")[1];

                    CourseWareModel courseWareModel = new CourseWareModel();
                    courseWareModel.setCourseId(i);
                    courseWareModel.setUrl(url);
                    courseWareModel.setTime(time);
                    courseWareModel.setType(CourseWareType.MP4);
                    courseWareModelMapper.insertSelective(courseWareModel);
                }
            }

            return i > 0;
        }

        return false;
    }

    @Transactional(TransactionManagerName.partyTransactionManager)
    public boolean updateCourse(CourseModel courseModel, String[] courseWare) {

        if (courseModel != null && IntegerExtention.hasValueAndMaxZero(courseModel.getCourseId())) {

            //添加课件
            //先删除
            courseWareModelMapper.deleteByCourseId(courseModel.getCourseId());
            if (courseWare != null && courseWare.length > 0) {
                for (String ware : courseWare) {

                    String url = ware.split("::")[0];
                    String time = ware.split("::")[1];

                    CourseWareModel courseWareModel = new CourseWareModel();
                    courseWareModel.setCourseId(courseModel.getCourseId());
                    courseWareModel.setUrl(url);
                    courseWareModel.setTime(time);
                    courseWareModel.setType(CourseWareType.MP4);
                    courseWareModelMapper.insertSelective(courseWareModel);
                }
            }

            return courseModelMapper.updateByPrimaryKeySelective(courseModel) > 0;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean deleteCourse(Integer id) {

        if (IntegerExtention.hasValueAndMaxZero(id)) {
            return courseModelMapper.deleteByPrimaryKey(id) > 0;
        }

        return false;
    }


    public boolean chooseCourse(Integer studentId, Integer courseId) {

        if (IntegerExtention.hasValueAndMaxZero(studentId) && IntegerExtention.hasValueAndMaxZero(courseId)) {

            //check course exist
            CourseModel courseModel = courseModelMapper.selectByPrimaryKey(courseId);
            if (courseModel != null) {
                RCourseStudentModel rCourseStudentModel = new RCourseStudentModel();
                rCourseStudentModel.setStudentId(studentId);
                rCourseStudentModel.setCourseId(courseId);
                return rCourseStudentModelMapper.insertSelective(rCourseStudentModel) > 0;
            }
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


    public void checkCourse(Integer studentId, Integer courseId) {

        RCourseStudentModelKey rCourseStudentModelKey = new RCourseStudentModel();
        rCourseStudentModelKey.setStudentId(studentId);
        rCourseStudentModelKey.setCourseId(courseId);

        RCourseStudentModel rCourseStudentModel = rCourseStudentModelMapper.selectByPrimaryKey(rCourseStudentModelKey);

        if (rCourseStudentModel == null)
            throw new BusinessException(ErrorCodeEnum.operationError);

    }


}
