package cn.edu.ccu.business.course;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.data.course.CourseTypeModelMapper;
import cn.edu.ccu.ibusiness.course.ICourseType;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.course.CourseTypeListRequest;
import cn.edu.ccu.model.course.CourseTypeListResponse;
import cn.edu.ccu.model.course.CourseTypeModel;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by kuangye on 2016/4/19.
 */
@Service
public class CourseTypeBusiness implements ICourseType {


    @Autowired
    private CourseTypeModelMapper courseTypeModelMapper;


    public CourseTypeModel selectById(Integer id) {
        if (IntegerExtention.hasValueAndMaxZero(id)) {
            return courseTypeModelMapper.selectByPrimaryKey(id);
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


    public CourseTypeListResponse listByPage(CourseTypeListRequest courseTypeListRequest) {

        Map<String, Object> map = new HashMap<>();
        CourseTypeModel courseTypeModel = courseTypeListRequest.getCourseTypeModel();
        if(courseTypeModel!=null){
            if (!StringExtention.isTrimNullOrEmpty(courseTypeModel.getName())) {
                map.put("name", courseTypeModel.getName());
            }
        }

        SplitPageRequest pageRequest = courseTypeListRequest.getSplitPageRequest();
        UtilsBusiness.pubMapforSplitPage(pageRequest, map);

        int totalSize = courseTypeModelMapper.count(map);
        List<CourseTypeModel> list = courseTypeModelMapper.select(map);

        CourseTypeListResponse response = new CourseTypeListResponse();
        response.setSplitPageResponse(UtilsBusiness.getSplitPageResponse(totalSize, pageRequest.getPageSize(), pageRequest.getPageNo()));
        response.setCourseTypeModelList(list);
        return response;
    }

    public List<CourseTypeModel> list() {
        return courseTypeModelMapper.select(null);
    }

    public boolean addCourseType(CourseTypeModel courseTypeModel) {

        if (courseTypeModel != null) {
            if (StringExtention.isTrimNullOrEmpty(courseTypeModel.getName())) {
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            }

            return courseTypeModelMapper.insertSelective(courseTypeModel) > 0;
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean updateCourseType(CourseTypeModel courseTypeModel) {

        if (courseTypeModel != null && IntegerExtention.hasValueAndMaxZero(courseTypeModel.getId())) {

            return courseTypeModelMapper.updateByPrimaryKeySelective(courseTypeModel) > 0;
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean deleteCourseType(Integer id) {
        if (IntegerExtention.hasValueAndMaxZero(id)) {

            return courseTypeModelMapper.deleteByPrimaryKey(id) > 0;
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }
}
