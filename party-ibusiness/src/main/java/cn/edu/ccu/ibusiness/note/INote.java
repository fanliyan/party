package cn.edu.ccu.ibusiness.note;

import cn.edu.ccu.model.note.NoteListRequest;
import cn.edu.ccu.model.note.NoteListResponse;
import cn.edu.ccu.model.note.StudyNoteModel;

/**
 * Created by kuangye on 2016/4/22.
 */
public interface INote {

    NoteListResponse listByPage(NoteListRequest noteListRequest);

    StudyNoteModel getById(Integer id);
    StudyNoteModel getByIdAndCheckStatus(Integer id) ;

    StudyNoteModel getByIdAndStudentId(Integer id,Integer studentId);

    boolean addNote(StudyNoteModel studyNoteModel);

    boolean updateNote(StudyNoteModel studyNoteModel);

    boolean deleteNote(Integer id, Integer studentId);

    boolean sendToReview(Integer id);

    boolean changeToPublish(Integer id);

    boolean changeToRefuse(Integer id);

    boolean changeToOwn(Integer id);

}
