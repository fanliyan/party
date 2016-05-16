package cn.edu.ccu.school.controller;

import cn.edu.ccu.ibusiness.note.INote;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.note.NoteListRequest;
import cn.edu.ccu.model.note.NoteListResponse;
import cn.edu.ccu.model.note.NoteStatus;
import cn.edu.ccu.model.note.StudyNoteModel;
import cn.edu.ccu.model.student.StudentModel;
import cn.edu.ccu.school.utils.AuthController;
import cn.edu.ccu.school.utils.AuthHelper;
import cn.edu.ccu.school.utils.AuthMethod;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by kuangye on 2016/4/22.
 */

@Controller
@RequestMapping("/note")
@AuthController(moduleId = -1)
public class NoteController extends BaseController {

    @Autowired
    private INote iNote;

    //我的笔记
    @AuthMethod
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                             StudyNoteModel studyNoteModel, SplitPageRequest pageRequest) throws Exception {

        ModelAndView mav = super.getModelAndView("note/noteList",httpRequest);
        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);
        NoteListRequest request = new NoteListRequest();
        studyNoteModel.setStudentId(studentModel.getId());
        request.setStudyNoteModel(studyNoteModel);
        pageRequest.setReturnCount(true);
        request.setSplitPageRequest(pageRequest);

        NoteListResponse response = iNote.listByPage(request);
        mav.addObject("response", response);
        mav.addObject("studyNoteModel",studyNoteModel);

        return mav;
    }

    //笔记分享
    @AuthMethod
    @RequestMapping("/sharelist")
    public ModelAndView shareList(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                             String title, SplitPageRequest pageRequest) throws Exception {

        ModelAndView mav = super.getModelAndView("note/noteShareList",httpRequest);

        NoteListRequest request = new NoteListRequest();
        StudyNoteModel studyNoteModel = new StudyNoteModel();
        studyNoteModel.setStatus(NoteStatus.PUBLISH);
        studyNoteModel.setTitle(title);
        request.setStudyNoteModel(studyNoteModel);
        pageRequest.setReturnCount(true);
        request.setSplitPageRequest(pageRequest);
        request.setWithStudent(true);

        NoteListResponse response = iNote.listByPage(request);
        mav.addObject("response", response);
        mav.addObject("studyNoteModel",studyNoteModel);

        return mav;
    }

    //查看
    @AuthMethod
    @RequestMapping("/read/{id}")
    public ModelAndView read(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                                  @PathVariable("id") Integer id) throws Exception {

        ModelAndView mav = super.getModelAndView("note/read",httpRequest);

        StudyNoteModel studyNoteModel = iNote.getByIdAndCheckStatus(id);
        mav.addObject("note", studyNoteModel);

        return mav;
    }



    @AuthMethod
    @RequestMapping("/add")
    public ModelAndView addArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        ModelAndView mav = super.getModelAndView("note/noteEdit",httpRequest);

        return mav;
    }

    @AuthMethod
    @RequestMapping("/edit/{id}")
    public ModelAndView editArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
           @PathVariable("id") Integer id) throws Exception {
        ModelAndView mav = super.getModelAndView("note/noteEdit",httpRequest);

        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);

        mav.addObject("note", iNote.getByIdAndStudentId(id,studentModel.getId()));

        return mav;
    }


    @AuthMethod
    @RequestMapping(value = "/addOrUpdate", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> addOrUpdateArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            StudyNoteModel model) throws Exception {

        Map<String, Object> map = new HashMap<>();
        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);
        model.setStudentId(studentModel.getId());

        boolean i;
        if (httpRequest.getParameter("isUpdate") == null) {
            i = iNote.addNote(model);
        } else {
            i = iNote.updateNote(model);
        }
        map.put("success", i);

        return map;
    }


    @AuthMethod
    @RequestMapping("/del/{id}")
    public
    @ResponseBody
    Map<String, Object> delArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
           @PathVariable("id") Integer id) throws Exception {

        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);

        boolean i = false;
        Map<String, Object> map = new HashMap<>();
        if (IntegerExtention.hasValueAndMaxZero(id)) {
            i = iNote.deleteNote(id,studentModel.getId());
        }
        map.put("success", i);

        return map;
    }

    @AuthMethod
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
                case NoteStatus.REVIEW:
                    i = iNote.sendToReview(id);
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
