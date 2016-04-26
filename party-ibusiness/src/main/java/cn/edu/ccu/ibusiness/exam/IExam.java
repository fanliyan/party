package cn.edu.ccu.ibusiness.exam;

import cn.edu.ccu.model.exam.ExamListRequest;
import cn.edu.ccu.model.exam.ExamListResponse;
import cn.edu.ccu.model.exam.ExamModelWithBLOBs;

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
}
