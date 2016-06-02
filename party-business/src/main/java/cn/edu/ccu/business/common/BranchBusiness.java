package cn.edu.ccu.business.common;

import cn.edu.ccu.data.common.BranchModelMapper;
import cn.edu.ccu.ibusiness.common.IBranch;
import cn.edu.ccu.model.common.BranchModel;
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

    private List<BranchModel> list() {
        return branchModelMapper.select();
    }


    public List<BranchModel> select() {
        if (branchList.size() <= 0) {
            this.init();
        }
        return branchList;
    }

    public BranchModel getById(Integer id) {
        if (IntegerExtention.hasValueAndMaxZero(id)) {
            if (branchList.size() <= 0) {
                this.init();
            }

            for (BranchModel branchModel : branchList)
                if (branchModel.getId().equals(id))
                    return branchModel;
        }
        return null;
    }

    public List<BranchModel> getByDepartmentId(Integer id) {
        if (IntegerExtention.hasValueAndMaxZero(id)) {
            if (branchList.size() <= 0) {
                this.init();
            }

            List<BranchModel> returnList = new ArrayList<>();
            for (BranchModel branchModel : branchList)
                if (branchModel.getDepartmentId().equals(id))
                    returnList.add(branchModel);

            return returnList;
        }
        return null;
    }


    public boolean add(BranchModel branchModel) {
        if (branchModel != null) {

            if (StringExtention.isTrimNullOrEmpty(branchModel.getName()))
                throw new BusinessException(ErrorCodeEnum.requestParamError);

            int i = branchModelMapper.insertSelective(branchModel);

            if (i > 0)
                this.init();

            return i > 0;

        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean edit(BranchModel branchModel) {
        if (branchModel != null && IntegerExtention.hasValueAndMaxZero(branchModel.getId())) {

            int i = branchModelMapper.updateByPrimaryKeySelective(branchModel);

            if (i > 0)
                this.init();

            return i > 0;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean delete(Integer id) {
        if (IntegerExtention.hasValueAndMaxZero(id)) {

            int i = branchModelMapper.deleteByPrimaryKey(id);

            if (i > 0)
                this.init();

            return i > 0;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }
}
