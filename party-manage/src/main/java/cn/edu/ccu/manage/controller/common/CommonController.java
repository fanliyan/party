package cn.edu.ccu.manage.controller.common;

import cn.edu.ccu.ibusiness.common.IArea;
import cn.edu.ccu.ibusiness.common.ICity;
import cn.edu.ccu.ibusiness.common.INation;
import cn.edu.ccu.ibusiness.common.IProvince;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.model.common.AreaModel;
import cn.edu.ccu.model.common.CityModel;
import cn.edu.ccu.model.common.NationModel;
import cn.edu.ccu.model.common.ProvinceModel;
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
 * Created by Administrator on 2016/4/17.
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


    @RequestMapping(value = "/nationlist", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> nationList(HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        Map<String, Object> map = new HashMap<>();

        map.put("citylist",  iNation.selectNationList());

        map.put("success",true);

        return map;
    }

    @RequestMapping(value = "/citylistbyprovince", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> cityListByProvince(@RequestParam("code") String code, HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        Map<String, Object> map = new HashMap<>();

        map.put("citylist", iCity.selectCityListByProvinceCode(code));

        map.put("success",true);
        return map;
    }

    @RequestMapping(value = "/arealistbycity", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> areaListByCity(@RequestParam("code") String code, HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        Map<String, Object> map = new HashMap<>();

        map.put("arealist",  iArea.selectAreaListByCityCode(code));

        map.put("success",true);

        return map;
    }


    @RequestMapping(value = "/getcityandprovince", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> getCityAndProvince(@RequestParam("code") String code, HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {

        Map<String, Object> map = new HashMap<>();

        CityModel cityModel = iCity.getCityByCode(code);
        ProvinceModel provinceModel = iProvince.getProvinceByCode(cityModel.getProvincecode());

        map.put("city", cityModel);
        map.put("province", provinceModel);

        map.put("citylist",iCity.selectCityList());
        map.put("arealist",iArea.selectAreaList());

        map.put("success",true);
        return map;
    }

    @RequestMapping(value = "/getprovince", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> getProvince(@RequestParam("code") String code, HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {

        Map<String, Object> map = new HashMap<>();

        ProvinceModel provinceModel = iProvince.getProvinceByCode(code);

        map.put("province", provinceModel);

        map.put("citylist",iCity.selectCityList());
        map.put("arealist",iArea.selectAreaList());

        map.put("success",true);
        return map;
    }

    @RequestMapping(value = "/getcity", method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object> getCity(@RequestParam("code") String code, HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {

        Map<String, Object> map = new HashMap<>();

        List<CityModel> cityModelList = iCity.selectCityListByProvinceCode(code);

        map.put("citylist",cityModelList);
        map.put("arealist",iArea.selectAreaList());

        map.put("success",true);
        return map;
    }


}
