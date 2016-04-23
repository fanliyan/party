package cn.edu.ccu.model.note;

import cn.edu.ccu.model.SplitPageRequest;

/**
 * Created by Administrator on 2016/4/22.
 */
public class NoteListRequest {

    private boolean withStudent;
    //审核模式
    private boolean review;

    private StudyNoteModel studyNoteModel;

    private SplitPageRequest splitPageRequest;


    public boolean isReview() {
        return review;
    }

    public void setReview(boolean review) {
        this.review = review;
    }

    public boolean isWithStudent() {
        return withStudent;
    }

    public void setWithStudent(boolean withStudent) {
        this.withStudent = withStudent;
    }

    public StudyNoteModel getStudyNoteModel() {
        return studyNoteModel;
    }

    public void setStudyNoteModel(StudyNoteModel studyNoteModel) {
        this.studyNoteModel = studyNoteModel;
    }

    public SplitPageRequest getSplitPageRequest() {
        return splitPageRequest;
    }

    public void setSplitPageRequest(SplitPageRequest splitPageRequest) {
        this.splitPageRequest = splitPageRequest;
    }
}
