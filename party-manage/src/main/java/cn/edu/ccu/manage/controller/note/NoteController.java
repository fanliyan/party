package cn.edu.ccu.manage.controller.note;

import cn.edu.ccu.ibusiness.note.INote;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.note.NoteListRequest;
import cn.edu.ccu.model.note.NoteListResponse;
import cn.edu.ccu.model.note.NoteStatus;
import cn.edu.ccu.model.note.StudyNoteModel;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2016/4/22.
 */

@Controller
@RequestMapping("/note")
@AuthController(moduleId = 10)
public class NoteController extends BaseController {

    @Autowired
    private INote iNote;

    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                             StudyNoteModel studyNoteModel, SplitPageRequest pageRequest) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        NoteListRequest request = new NoteListRequest();

        request.setStudyNoteModel(studyNoteModel);
        pageRequest.setReturnCount(true);
        request.setSplitPageRequest(pageRequest);

        //审核模式
        request.setWithStudent(true);
        request.setReview(true);

        NoteListResponse response = iNote.listByPage(request);
        mav.addObject("response", response);
        mav.addObject("studyNoteModel",studyNoteModel);

        mav.setViewName("/note/noteList");
        return mav;
    }


    @RequestMapping(value = "/getnote/{id}",method = RequestMethod.GET)
    public
    @ResponseBody
    Map<String, Object>  addArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,@PathVariable("id")Integer id)
            throws Exception {

        Map<String, Object> map = new HashMap<>();
        map.put("note", iNote.getById(id));
        map.put("success",true);
        return map;
    }


    @RequestMapping(value = "/changeStatus/{id}/{status}", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> changeStatus(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            @PathVariable("id") Integer id, @PathVariable("status") byte status) throws Exception {

        boolean i = false;
        Map<String, Object> map = new HashMap<>();
        if (IntegerExtention.hasValueAndMaxZero(id)) {

            switch (status) {
                case NoteStatus.PUBLISH:
                    i = iNote.changeToPublish(id);
                    break;
                case NoteStatus.REFUSE:
                    i = iNote.changeToRefuse(id);
                    break;
                case NoteStatus.OWNED:
                    i = iNote.changeToOwn(id);
                    break;
            }
        }
        map.put("success", i);

        return map;
    }

}
