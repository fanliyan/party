package cn.edu.ccu.ibusiness.statistic;

import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.common.TableModel;

import java.util.List;

/**
 * Created by kuangye on 2016/4/30.
 */
public interface IStatistic {


    List<TableModel> getCourseCountTopStudent(SplitPageRequest splitPageRequest);

    List<TableModel> getCourseWatchCount();


//    List<TableModel> getExamTopStudent(Integer roleId, Integer examId, SplitPageRequest splitPageRequest);

}
