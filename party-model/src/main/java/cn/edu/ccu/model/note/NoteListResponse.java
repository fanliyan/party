package cn.edu.ccu.model.note;

import cn.edu.ccu.model.SplitPageResponse;

import java.util.List;

/**
 * Created by Administrator on 2016/4/22.
 */
public class NoteListResponse {

    private List<StudyNoteModel> studyNoteModelList;

    private SplitPageResponse splitPageResponse;


    public List<StudyNoteModel> getStudyNoteModelList() {
        return studyNoteModelList;
    }

    public void setStudyNoteModelList(List<StudyNoteModel> studyNoteModelList) {
        this.studyNoteModelList = studyNoteModelList;
    }

    public SplitPageResponse getSplitPageResponse() {
        return splitPageResponse;
    }

    public void setSplitPageResponse(SplitPageResponse splitPageResponse) {
        this.splitPageResponse = splitPageResponse;
    }
}
