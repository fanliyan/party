package cn.edu.ccu.business.common;

import cn.edu.ccu.data.common.ClassModelMapper;
import cn.edu.ccu.data.common.XiModelMapper;
import cn.edu.ccu.ibusiness.common.IClass;
import cn.edu.ccu.ibusiness.common.IXi;
import cn.edu.ccu.model.common.ClassModel;
import cn.edu.ccu.model.common.XiModel;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by kuangye on 2016/5/16.
 */
@Service
public class ClassBusiness implements IClass {


    @Autowired
    private ClassModelMapper classModelMapper;


    //静态化
    private static List<ClassModel> classList = new ArrayList<>();

    /* @PostConstruct */
    protected void init() {
        synchronized (classList) {
            classList = list();
        }
    }

    private  List<ClassModel> list(){
        return classModelMapper.select();
    }


    public  List<ClassModel> select(){
        if(classList.size()<=0){
            this.init();
        }
        return classList;
    }

    public  ClassModel getById(Integer id){
        if(IntegerExtention.hasValueAndMaxZero(id)){
            if(classList.size()<=0){
                this.init();
            }

            for(ClassModel classModel:classList)
                if(classModel.getId().equals(id))
                    return classModel;
        }
        return null;
    }

    public List<ClassModel> getByXiId(Integer id){
        if(IntegerExtention.hasValueAndMaxZero(id)){
            if(classList.size()<=0){
                this.init();
            }

            List<ClassModel> returnList = new ArrayList<>();
            for(ClassModel classModel:classList)
                if(classModel.getXiId().equals(id))
                    returnList.add(classModel);

            return returnList;
        }
        return null;
    }






    public boolean add(ClassModel classModel) {
        if (classModel != null) {

            if (StringExtention.isTrimNullOrEmpty(classModel.getName()))
                throw new BusinessException(ErrorCodeEnum.requestParamError);

            int i = classModelMapper.insertSelective(classModel);

            if (i > 0)
                this.init();

            return i > 0;

        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean edit(ClassModel classModel) {
        if (classModel != null && IntegerExtention.hasValueAndMaxZero(classModel.getId())) {

            int i = classModelMapper.updateByPrimaryKeySelective(classModel);

            if (i > 0)
                this.init();

            return i > 0;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean delete(Integer id) {
        if (IntegerExtention.hasValueAndMaxZero(id)) {

            int i = classModelMapper.deleteByPrimaryKey(id);

            if (i > 0)
                this.init();

            return i > 0;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

}
