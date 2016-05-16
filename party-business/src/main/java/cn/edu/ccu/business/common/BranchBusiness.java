package cn.edu.ccu.business.common;

import cn.edu.ccu.data.common.BranchModelMapper;
import cn.edu.ccu.ibusiness.common.IBranch;
import cn.edu.ccu.model.common.BranchModel;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by kuangye on 2016/5/16.
 */
@Service
public class BranchBusiness implements IBranch {


    @Autowired
    private BranchModelMapper branchModelMapper;


    //静态化
    private static List<BranchModel> branchList = new ArrayList<>();

    /* @PostConstruct */
    protected void init() {
        synchronized (branchList) {
            branchList = list();
        }
    }

    private  List<BranchModel> list(){
        return branchModelMapper.select();
    }


    public  List<BranchModel> select(){
        if(branchList.size()<=0){
            this.init();
        }
        return branchList;
    }

    public  BranchModel getById(Integer id){
        if(IntegerExtention.hasValueAndMaxZero(id)){
            if(branchList.size()<=0){
                this.init();
            }

            for(BranchModel branchModel:branchList)
                if(branchModel.getId().equals(id))
                    return branchModel;
        }
        return null;
    }

    public BranchModel getByDepartmentId(Integer id){
        if(IntegerExtention.hasValueAndMaxZero(id)){
            if(branchList.size()<=0){
                this.init();
            }

            for(BranchModel branchModel:branchList)
                if(branchModel.getDepartmentId().equals(id))
                    return branchModel;
        }
        return null;
    }
}
