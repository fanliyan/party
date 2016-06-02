package cn.edu.ccu.school.controller;

import cn.edu.ccu.ibusiness.common.*;
import cn.edu.ccu.model.common.*;
import cn.edu.ccu.school.utils.AuthController;
import cn.edu.ccu.school.utils.AuthMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by kuangye on 2016/4/17.
 */
@Controller
@RequestMapping("/common")
@AuthController(moduleId = -1)
public class CommonController extends BaseController {

    @Autowired
    private INation iNation;
    @Autowired
    private IProvince iProvince;
    @Autowired
    private ICity iCity;
    @Autowired
    private IArea iArea;


    @Autowired
    private IBranch iBranch;

    @Autowired
    private IXi iXi;
    @Autowired
    private IClass iClass;

    //--------------------------------民族-start

    @AuthMethod(mustLogin = false)
    @RequestMapping(value = "/nationlist", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> nationList(HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        Map<String, Object> map = new HashMap<>();

        map.put("citylist", iNation.selectNationList());

        map.put("success", true);

        return map;
    }

    //--------------------------------民族-end


    //--------------------------------省市县-start
    @AuthMethod(mustLogin = false)
    @RequestMapping(value = "/citylistbyprovince", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> cityListByProvince(@RequestParam("code") String code, HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        Map<String, Object> map = new HashMap<>();

        map.put("citylist", iCity.selectCityListByProvinceCode(code));

        map.put("success", true);
        return map;
    }

    @AuthMethod(mustLogin = false)
    @RequestMapping(value = "/arealistbycity", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> areaListByCity(@RequestParam("code") String code, HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        Map<String, Object> map = new HashMap<>();

        map.put("arealist", iArea.selectAreaListByCityCode(code));

        map.put("success", true);

        return map;
    }

    @AuthMethod(mustLogin = false)
    @RequestMapping(value = "/getcityandprovince", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> getCityAndProvince(@RequestParam("code") String code, HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {

        Map<String, Object> map = new HashMap<>();

        AreaModel areaModel = iArea.getAreaByCode(code);

        CityModel cityModel = iCity.getCityByCode(areaModel.getCitycode());
        ProvinceModel provinceModel = iProvince.getProvinceByCode(cityModel.getProvincecode());

        map.put("city", cityModel);
        map.put("province", provinceModel);

        map.put("citylist", iCity.selectCityListByProvinceCode(provinceModel.getCode()));
        map.put("arealist", iArea.selectAreaListByCityCode(cityModel.getCode()));

        map.put("success", true);
        return map;
    }

    @AuthMethod(mustLogin = false)
    @RequestMapping(value = "/getprovince", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> getProvince(@RequestParam("code") String code, HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {

        Map<String, Object> map = new HashMap<>();

        ProvinceModel provinceModel = iProvince.getProvinceByCode(code);

        map.put("province", provinceModel);

        map.put("citylist", iCity.selectCityList());
        map.put("arealist", iArea.selectAreaList());

        map.put("success", true);
        return map;
    }

    @AuthMethod(mustLogin = false)
    @RequestMapping(value = "/getcity", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> getCity(@RequestParam("code") String code, HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {

        Map<String, Object> map = new HashMap<>();

        List<CityModel> cityModelList = iCity.selectCityListByProvinceCode(code);

        map.put("citylist", cityModelList);
        map.put("arealist", iArea.selectAreaList());

        map.put("success", true);
        return map;
    }
    //--------------------------------省市县-end


    //--------------------------------院系班-start

    @AuthMethod(mustLogin = false)
    @RequestMapping(value = "/getxiandclass", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> getxiandclass(@RequestParam("id") Integer id, HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        Map<String, Object> map = new HashMap<>();


        ClassModel classModel = iClass.getById(id);
        XiModel xiModel = iXi.getById(classModel.getXiId());

        List<XiModel> xiList = iXi.getByDepartmentId(xiModel.getDepartmentId());
        List<ClassModel> classList = iClass.getByXiId(xiModel.getId());


        map.put("xi", xiModel);
        map.put("xilist", xiList);
        map.put("classlist", classList);

        map.put("success", true);

        return map;
    }


    @AuthMethod(mustLogin = false)
    @RequestMapping(value = "/getclassbyxi", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> getclassbyxi(@RequestParam("id") Integer id, HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        Map<String, Object> map = new HashMap<>();

        XiModel xiModel = iXi.getById(id);

        List<XiModel> xiList = iXi.getByDepartmentId(xiModel.getDepartmentId());
        List<ClassModel> classList = iClass.getByXiId(xiModel.getId());

        map.put("xi", xiModel);
        map.put("xilist", xiList);
        map.put("classlist", classList);
        map.put("success", true);

        return map;
    }

    @AuthMethod(mustLogin = false)
    @RequestMapping(value = "/getclassbydepartment", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> getclassbydepartment(@RequestParam("id") Integer id, HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        Map<String, Object> map = new HashMap<>();

        map.put("xilist", iXi.getByDepartmentId(id));

        map.put("success", true);

        return map;
    }

    @AuthMethod(mustLogin = false)
    @RequestMapping(value = "/xilistbydepartment", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> xilistbydepartment(@RequestParam("id") Integer id, HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        Map<String, Object> map = new HashMap<>();

        map.put("xilist", iXi.getByDepartmentId(id));

        map.put("success", true);

        return map;
    }

    @AuthMethod(mustLogin = false)
    @RequestMapping(value = "/classlistbyxi", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> classlistbyxi(@RequestParam("id") Integer id, HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        Map<String, Object> map = new HashMap<>();

        map.put("classlist", iClass.getByXiId(id));

        map.put("success", true);

        return map;
    }

    //--------------------------------院系班-end


    //--------------------------------院-党支部级联-start

    @AuthMethod(mustLogin = false)
    @RequestMapping(value = "/getbranch", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> getbranch(@RequestParam("id") Integer id, HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        Map<String, Object> map = new HashMap<>();

        BranchModel branchModel = iBranch.getById(id);

        map.put("branch", branchModel);
        map.put("branchlist", iBranch.getByDepartmentId(branchModel.getDepartmentId()));

        map.put("success", true);

        return map;
    }

    @AuthMethod(mustLogin = false)
    @RequestMapping(value = "/getbranchbydepartment", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> getbranchbydepartment(@RequestParam("id") Integer id, HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        Map<String, Object> map = new HashMap<>();

        map.put("branchlist", iBranch.getByDepartmentId(id));

        map.put("success", true);

        return map;
    }

    @AuthMethod(mustLogin = false)
    @RequestMapping(value = "/branchlistbydepartment", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> branchlistbydepartment(@RequestParam("id") Integer id, HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        Map<String, Object> map = new HashMap<>();

        map.put("branchlist", iBranch.getByDepartmentId(id));

        map.put("success", true);

        return map;
    }

    //--------------------------------院-党支部级联-end

}

