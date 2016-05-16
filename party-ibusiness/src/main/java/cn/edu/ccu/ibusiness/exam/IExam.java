package cn.edu.ccu.ibusiness.exam;

import cn.edu.ccu.model.exam.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by kuangye on 2016/4/25.
 */
public interface IExam {

    ExamListResponse splitByPage(ExamListRequest examListRequest);

    ExamModelWithBLOBs getById(Integer id);

    ExamModelWithBLOBs getDetailById(Integer id);


    boolean addExam(ExamModelWithBLOBs examModelWithBLOBs,
                    String[] singleChoiceArray, String[] multipleChoiceArray, String[] tofArray);

    boolean updateExam(ExamModelWithBLOBs examModelWithBLOBs,
                       String[] singleChoiceArray, String[] multipleChoiceArray, String[] tofArray);

    boolean deleteExam(Integer id);



    Map<String,Object> startExam(Integer userId, Integer roleId, Integer examId);

    boolean examEnd(Integer userId, Integer roleId, Integer examId,HttpServletRequest httpRequest);
}
