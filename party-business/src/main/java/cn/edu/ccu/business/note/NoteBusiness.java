package cn.edu.ccu.business.note;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.business.word.SensitiveWordsBusiness;
import cn.edu.ccu.data.note.StudyNoteModelMapper;
import cn.edu.ccu.ibusiness.note.INote;
import cn.edu.ccu.ibusiness.word.ISensitiveWords;
import cn.edu.ccu.model.SplitPageResponse;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.note.NoteListRequest;
import cn.edu.ccu.model.note.NoteListResponse;
import cn.edu.ccu.model.note.NoteStatus;
import cn.edu.ccu.model.note.StudyNoteModel;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/4/22.
 */
@Service
public class NoteBusiness implements INote {

    @Autowired
    private StudyNoteModelMapper studyNoteModelMapper;

    public NoteListResponse listByPage(NoteListRequest noteListRequest) {

        NoteListResponse response = new NoteListResponse();

        Map<String, Object> map = new HashMap<>();
        UtilsBusiness.pubMapforSplitPage(noteListRequest.getSplitPageRequest(), map);


        StudyNoteModel studyNoteModel = noteListRequest.getStudyNoteModel();
        if (studyNoteModel != null) {
            if (studyNoteModel.getStudentId() != null) {
                map.put("studentId", studyNoteModel.getStudentId());
            }
            if (studyNoteModel.getStatus() != null) {
                map.put("status", studyNoteModel.getStatus());
            }
        }

        //审核模式只看未审核 和 通过的
        if (noteListRequest.isReview()) {
            map.put("review", 1);
        }

        List<StudyNoteModel> studyNoteModelList;
        if (noteListRequest.isWithStudent()) {
            studyNoteModelList = studyNoteModelMapper.selectWithStudent(map);

        } else {
            studyNoteModelList = studyNoteModelMapper.select(map);
        }

        response.setStudyNoteModelList(studyNoteModelList);

        if (noteListRequest.getSplitPageRequest() != null && noteListRequest.getSplitPageRequest().isReturnCount()) {
            int rowCount = studyNoteModelMapper.count(map);

            SplitPageResponse pageResponse = UtilsBusiness.getSplitPageResponse(
                    rowCount, noteListRequest.getSplitPageRequest().getPageSize(), noteListRequest.getSplitPageRequest().getPageNo());
            response.setSplitPageResponse(pageResponse);
        }

        return response;
    }

    public StudyNoteModel getById(Integer id) {

        if (IntegerExtention.hasValueAndMaxZero(id)) {
            StudyNoteModel studyNoteModel = studyNoteModelMapper.selectByPrimaryKey(id);
            //前台文章会转义
            if (studyNoteModel != null)
                studyNoteModel.setContent(StringEscapeUtils.unescapeHtml4(studyNoteModel.getContent()));

            return studyNoteModel;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public StudyNoteModel getByIdAndCheckStatus(Integer id) {

        if (IntegerExtention.hasValueAndMaxZero(id)) {
            //查询已发布文章
            StudyNoteModel studyNoteModel = studyNoteModelMapper.getByIdWithStudent(id);

            if (studyNoteModel != null) {
                //前台文章会转义
                studyNoteModel.setContent(StringEscapeUtils.unescapeHtml4(studyNoteModel.getContent()));
            } else {
                throw new BusinessException("无此笔记");
            }

            return studyNoteModel;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public StudyNoteModel getByIdAndStudentId(Integer id, Integer studentId) {

        if (IntegerExtention.hasValueAndMaxZero(id)) {
            return studyNoteModelMapper.getByIdAndStudentId(id, studentId);
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean addNote(StudyNoteModel studyNoteModel) {

        if (studyNoteModel != null) {

            if (StringExtention.isTrimNullOrEmpty(studyNoteModel.getTitle()))
                throw new BusinessException("标题不能为空");
            if (StringExtention.isTrimNullOrEmpty(studyNoteModel.getContent()))
                throw new BusinessException("内容不能为空");

            if (SensitiveWordsBusiness.wordsIsSensitive(studyNoteModel.getTitle()))
                throw new BusinessException("请检查标题是否包含铭感内容");
            if (SensitiveWordsBusiness.wordsIsSensitive(studyNoteModel.getContent()))
                throw new BusinessException("请检查内容是否包含铭感内容");

            return studyNoteModelMapper.insertSelective(studyNoteModel) > 0;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean updateNote(StudyNoteModel studyNoteModel) {

        if (studyNoteModel != null && IntegerExtention.hasValueAndMaxZero(studyNoteModel.getId())) {

            if (studyNoteModel.getTitle() != null && SensitiveWordsBusiness.wordsIsSensitive(studyNoteModel.getTitle()))
                throw new BusinessException("请检查标题是否包含铭感内容");

            if (studyNoteModel.getContent() != null && SensitiveWordsBusiness.wordsIsSensitive(studyNoteModel.getContent()))
                throw new BusinessException("请检查内容是否包含铭感内容");

            return studyNoteModelMapper.updateByPrimaryKeySelective(studyNoteModel) > 0;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean deleteNote(Integer id, Integer studentId) {

        if (IntegerExtention.hasValueAndMaxZero(id) && IntegerExtention.hasValueAndMaxZero(studentId)) {

            StudyNoteModel studyNoteModel = studyNoteModelMapper.selectByPrimaryKey(id);

            if (studyNoteModel != null && studyNoteModel.getStudentId().equals(studentId)) {
                return studyNoteModelMapper.deleteByPrimaryKey(id) > 0;
            } else {
                throw new BusinessException("无操作权限");
            }
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean sendToReview(Integer id) {
        return this.changeStatus(id, NoteStatus.REVIEW);
    }

    public boolean changeToPublish(Integer id) {
        return this.changeStatus(id, NoteStatus.PUBLISH);
    }

    public boolean changeToRefuse(Integer id) {
        return this.changeStatus(id, NoteStatus.REFUSE);
    }

    public boolean changeToOwn(Integer id) {
        return this.changeStatus(id, NoteStatus.OWNED);
    }


    private boolean changeStatus(Integer id, byte status) {


        if (IntegerExtention.hasValueAndMaxZero(id)) {

            StudyNoteModel model = studyNoteModelMapper.selectByPrimaryKey(id);

            if (model != null) {

                StudyNoteModel studyNoteModel = new StudyNoteModel();
                studyNoteModel.setId(id);
                studyNoteModel.setStatus(status);

                switch (status) {
                    case NoteStatus.REVIEW:
                        //只有 自有 或 拒绝状态 才能审核
                        if (model.getStatus().equals(NoteStatus.OWNED) || model.getStatus().equals(NoteStatus.REFUSE)) {

                            return studyNoteModelMapper.updateByPrimaryKeySelective(studyNoteModel) > 0;
                        } else {
                            throw new BusinessException("错误的修改状态流程");
                        }
                    case NoteStatus.PUBLISH:
                        //只有 审核 状态 才能发布
                        if (model.getStatus().equals(NoteStatus.REVIEW)) {

                            return studyNoteModelMapper.updateByPrimaryKeySelective(studyNoteModel) > 0;
                        } else {
                            throw new BusinessException("错误的修改状态流程");
                        }
                    case NoteStatus.REFUSE:
                        //无要求
                        return studyNoteModelMapper.updateByPrimaryKeySelective(studyNoteModel) > 0;
                    case NoteStatus.OWNED:
                        // 发布的可以撤回
                        if (model.getStatus().equals(NoteStatus.PUBLISH)) {

                            return studyNoteModelMapper.updateByPrimaryKeySelective(studyNoteModel) > 0;
                        } else {
                            throw new BusinessException("错误的修改状态流程");
                        }
                }
            }
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }
}
