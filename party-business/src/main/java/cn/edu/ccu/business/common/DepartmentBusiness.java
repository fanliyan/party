package cn.edu.ccu.business.common;

import cn.edu.ccu.data.common.DepartmentModelMapper;
import cn.edu.ccu.ibusiness.common.IDepartment;
import cn.edu.ccu.model.common.DepartmentModel;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by kuangye on 2016/5/16.
 */
@Service
public class DepartmentBusiness implements IDepartment {

    @Autowired
    private DepartmentModelMapper departmentModelMapper;


    //静态化
    private static List<DepartmentModel> departmentList = new ArrayList<>();

    /* @PostConstruct */
    protected void init() {
        synchronized (departmentList) {
            departmentList = list();
        }
    }

    private  List<DepartmentModel> list(){
        return departmentModelMapper.select();
    }


    public  List<DepartmentModel> select(){
        if(departmentList.size()<=0){
            this.init();
        }
        return departmentList;
    }

    public  DepartmentModel getById(Integer id){
       if(IntegerExtention.hasValueAndMaxZero(id)){
           if(departmentList.size()<=0){
               this.init();
           }

           for(DepartmentModel departmentModel:departmentList)
               if(departmentModel.getId().equals(id))
                   return departmentModel;
       }
        return null;
    }
}
