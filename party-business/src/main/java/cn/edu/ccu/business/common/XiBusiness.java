package cn.edu.ccu.business.common;

import cn.edu.ccu.data.common.XiModelMapper;
import cn.edu.ccu.ibusiness.common.IXi;
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
public class XiBusiness implements IXi {


    @Autowired
    private XiModelMapper xiModelMapper;


    //静态化
    private static List<XiModel> xiList = new ArrayList<>();

    /* @PostConstruct */
    protected void init() {
        synchronized (xiList) {
            xiList = list();
        }
    }

    private  List<XiModel> list(){
        return xiModelMapper.select();
    }


    public  List<XiModel> select(){
        if(xiList.size()<=0){
            this.init();
        }
        return xiList;
    }

    public  XiModel getById(Integer id){
        if(IntegerExtention.hasValueAndMaxZero(id)){
            if(xiList.size()<=0){
                this.init();
            }

            for(XiModel branchModel:xiList)
                if(branchModel.getId().equals(id))
                    return branchModel;
        }
        return null;
    }

    public List<XiModel> getByDepartmentId(Integer id){
        if(IntegerExtention.hasValueAndMaxZero(id)){
            if(xiList.size()<=0){
                this.init();
            }

            List<XiModel> returnList = new ArrayList<>();
            for(XiModel branchModel:xiList)
                if(branchModel.getDepartmentId().equals(id))
                    returnList.add(branchModel);

            return returnList;
        }
        return null;
    }




    public boolean add(XiModel xiModel) {
        if (xiModel != null) {

            if (StringExtention.isTrimNullOrEmpty(xiModel.getName()))
                throw new BusinessException(ErrorCodeEnum.requestParamError);

            int i = xiModelMapper.insertSelective(xiModel);

            if (i > 0)
                this.init();

            return i > 0;

        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean edit(XiModel xiModel) {
        if (xiModel != null && IntegerExtention.hasValueAndMaxZero(xiModel.getId())) {

            int i = xiModelMapper.updateByPrimaryKeySelective(xiModel);

            if (i > 0)
                this.init();

            return i > 0;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean delete(Integer id) {
        if (IntegerExtention.hasValueAndMaxZero(id)) {

            int i = xiModelMapper.deleteByPrimaryKey(id);

            if (i > 0)
                this.init();

            return i > 0;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }
}
