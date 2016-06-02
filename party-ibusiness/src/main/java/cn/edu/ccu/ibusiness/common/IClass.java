package cn.edu.ccu.ibusiness.common;

import cn.edu.ccu.model.common.ClassModel;
import cn.edu.ccu.model.common.XiModel;

import java.util.List;

/**
 * Created by kuangye on 2016/5/16.
 */
public interface IClass {

    List<ClassModel> select();

    List<ClassModel> getByXiId(Integer id);

    ClassModel getById(Integer id);



    boolean add(ClassModel classModel);

    boolean edit(ClassModel classModel);

    boolean delete(Integer id);
}
