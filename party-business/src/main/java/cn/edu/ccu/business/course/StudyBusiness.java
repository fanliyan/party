package cn.edu.ccu.business.course;

import cn.edu.ccu.data.study.StudyLogModelMapper;
import cn.edu.ccu.ibusiness.course.ICourse;
import cn.edu.ccu.ibusiness.course.IStudy;
import cn.edu.ccu.model.course.CourseModel;
import cn.edu.ccu.model.course.CourseWareModel;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.study.*;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.LogHelper;
import cn.edu.ccu.utils.common.SecurityHelper;
import cn.edu.ccu.utils.common.cache.LocalStaticCache;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;

/**
 * Created by kuangye on 2016/4/20.
 */
@Service
public class StudyBusiness implements IStudy {

    @Autowired
    private ICourse iCourse;

    @Autowired
    private StudyLogModelMapper studyLogModelMapper;

    private static final String KEY = "^&|study";


    //保存当前课程所有来过的用户（主要作用：用于检查
    private static List<StudyLogModel> allUserList = new ArrayList<>();

    private static final String ONLINE_USERS = "ONLINE_USERS";

    private static final String ONLINE_USERS_COUNT = "ONLINE_USERS_COUNT";

    private static ObjectMapper mapper = new ObjectMapper();


    public String getHashCode(Integer studentId, Integer courseId, Integer wareId) {

        try {
            if (IntegerExtention.hasValueAndMaxZero(studentId)
                    && IntegerExtention.hasValueAndMaxZero(courseId)
                    && IntegerExtention.hasValueAndMaxZero(wareId)) {

                return SecurityHelper.desEncrypt(new Date().getTime() + "-" + studentId + "-" + courseId + "-" + wareId, KEY);

            }
        } catch (Exception e) {
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


    /**
     * 设置在线人员
     */
    @SuppressWarnings("unchecked")
    public void addOnlineList(StudyLogModel studyLogModel) {


        allUserList.add(studyLogModel);

        //需要先查询一次记录 判断是否已经学习完成
        //TODO 已经由 controller处理
        //用户进入记录DB
        studyLogModelMapper.insertSelective(studyLogModel);


        String cacheListString = LocalStaticCache.getLocalStaticCache(ONLINE_USERS);


        if (!StringUtils.isEmpty(cacheListString)) {
            try {
                List<StudyLogModel> cacheList = mapper.readValue(cacheListString, new TypeReference<List<StudyLogModel>>() {
                });

                cacheList.add(studyLogModel);

                cacheListString = mapper.writeValueAsString(cacheList);

                Calendar c = Calendar.getInstance();
                c.add(Calendar.HOUR, 2);
                LocalStaticCache.setLocalStaticCache(ONLINE_USERS, cacheListString, c.getTime());
                LocalStaticCache.setLocalStaticCache(ONLINE_USERS_COUNT, String.valueOf(cacheList.size()), c.getTime());

            } catch (Exception e) {
            }
        } else {
            try {
                //初次进入
                List<StudyLogModel> newList = new ArrayList<>();
                newList.add(studyLogModel);

                cacheListString = mapper.writeValueAsString(newList);

                Calendar c = Calendar.getInstance();
                c.add(Calendar.HOUR, 2);
                LocalStaticCache.setLocalStaticCache(ONLINE_USERS, cacheListString, c.getTime());
                LocalStaticCache.setLocalStaticCache(ONLINE_USERS_COUNT, String.valueOf(newList.size()), c.getTime());

            } catch (Exception e) {
            }
        }
    }

    /**
     * 移除在线人员
     */
    @SuppressWarnings("unchecked")
    public void removeOnlineList(String sessionId) {
        //微信用户退出时删除用户记录(如果不删除则登录时会在前台提示用户已存在)
        Iterator<StudyLogModel> iter1 = allUserList.iterator();
        while (iter1.hasNext()) {
            StudyLogModel record = iter1.next();
            if (record.getSessionId().equals(sessionId)) {
                iter1.remove();
            }
        }
        //缓存
        try {

            String cacheListString = LocalStaticCache.getLocalStaticCache(ONLINE_USERS);
            if (cacheListString != null) {
                List<StudyLogModel> cacheList = mapper.readValue(cacheListString, new TypeReference<List<StudyLogModel>>() {
                });


                if (null != cacheList) {
                    Iterator<StudyLogModel> cacheIter = cacheList.iterator();
                    while (cacheIter.hasNext()) {
                        StudyLogModel record = cacheIter.next();
                        if (record.getSessionId().equals(sessionId)) {

                            //用户退出记录DB
                            //如果已经学习完成则不修改数据 仍为完成状态
                            StudyLogModel model = studyLogModelMapper.selectByPrimaryKey(record.getId());
                            if (!model.getStatus().equals(VideoStudyRequestCode.ON_STOP)) {
                                record.setEndTime(new Date());
                                record.setStatus(VideoStudyRequestCode.END);
                            }
                            studyLogModelMapper.updateByPrimaryKeySelective(record);
                            cacheIter.remove();
                        }
                    }

                    Calendar c = Calendar.getInstance();
                    c.add(Calendar.HOUR, 2);
                    LocalStaticCache.setLocalStaticCache(ONLINE_USERS, cacheListString, c.getTime());
                    LocalStaticCache.setLocalStaticCache(ONLINE_USERS_COUNT, String.valueOf(cacheList.size()), c.getTime());
                }

            }
        } catch (Exception e) {
        }
    }


    /**
     * 获取所有人员
     */
    public List<StudyLogModel> getAllUserList() {
        return allUserList;
    }

    /**
     * 获取在线人员总数
     */
    public int getOnlineCount() {
        int count = 0;
        String obj = LocalStaticCache.getLocalStaticCache(ONLINE_USERS_COUNT);
        if (null != obj) {
            count = Integer.parseInt(obj);
        }
        return count;
    }

    /**
     * 获取在线人员列表
     */
    @SuppressWarnings("unchecked")
    public List<StudyLogModel> getOnlineList() {
        List<StudyLogModel> cacheList = null;
        try {
            String cacheListString = LocalStaticCache.getLocalStaticCache(ONLINE_USERS);
            if (cacheListString != null) {
                cacheList = mapper.readValue(cacheListString, new TypeReference<List<StudyLogModel>>() {
                });
            }
        } catch (Exception e) {
        }
        return cacheList;
    }


    //逻辑业务处理
    public VideoStudyWSResponse pushContent(VideoStudyWSRequest videoStudyWSRequest) {

        VideoStudyWSResponse response = new VideoStudyWSResponse();

        StudyLogModel model = new StudyLogModel();

        for (StudyLogModel studyLogModel : allUserList) {
            if (studyLogModel.getUserId().equals(videoStudyWSRequest.getUserId())) {
                model.setId(studyLogModel.getId());
            }
        }
        if (model.getId() == null)
            response.setCode(0);

        StudyLogModel studyLogModel = studyLogModelMapper.selectByPrimaryKey(model.getId());

        //如果已经学习完成 不需要进行业务处理
        if (studyLogModel.getStatus().equals(VideoStudyRequestCode.ON_STOP)) {
            response.setCode(1);
            return response;
        }

        int i = 0;

        Integer code = videoStudyWSRequest.getCode();
        if (code.equals(VideoStudyRequestCode.START)) {

            //第一次
            model.setStatus(VideoStudyRequestCode.START);

            i = studyLogModelMapper.updateByPrimaryKeySelective(model);

            response.setCode(i);

        } else if (code.equals(VideoStudyRequestCode.END)) {


            if (studyLogModel != null && studyLogModel.getStatus() != null) {

                //为 开始或暂停
                if (studyLogModel.getStatus() != null) {

                    //未结束时设置为结束
                    if (!studyLogModel.getStatus().equals(VideoStudyRequestCode.END)) {
                        //设置结束时间
                        model.setEndTime(new Date());
                        model.setStatus(VideoStudyRequestCode.END);
                        i = studyLogModelMapper.updateByPrimaryKeySelective(model);

                        response.setCode(i);
                    }
                } else {
                    //未开始删除该记录
                    i = studyLogModelMapper.deleteByPrimaryKey(studyLogModel.getId());
                }
            }
        } else if (code.equals(VideoStudyRequestCode.ON_START)) {

            //开始/或恢复
            //第一次开始
            if (videoStudyWSRequest.getMessage().equals("0")) {

                model.setStartTime(new Date());
                model.setStatus(VideoStudyRequestCode.START);
            } else {
                //暂停后开始
                Date pauseTime = new Date(Long.parseLong(videoStudyWSRequest.getMessage()));
                Date nowDate = new Date();

                //TODO 如果暂停 超出了整数范围 ......（需要修改）  一分钟以内暂停就算了（暂时忽略）
                //分钟
                long time = (nowDate.getTime() - pauseTime.getTime()) / 1000 / 60;
                //添加暂停时长
                model.setPausetime((int) time + studyLogModel.getPausetime());
            }
            model.setStatus(VideoStudyRequestCode.START);

            //设置开始时间
            i = studyLogModelMapper.updateByPrimaryKeySelective(model);

            response.setCode(i);

        } else if (code.equals(VideoStudyRequestCode.ON_PAUSE)) {

            //设置暂停状态
            model.setStatus(VideoStudyRequestCode.ON_PAUSE);
            i = studyLogModelMapper.updateByPrimaryKeySelective(model);

        } else if (code.equals(VideoStudyRequestCode.ON_STOP)) {

            //设置完成状态
            model.setEndTime(new Date());
            model.setStatus(VideoStudyRequestCode.ON_STOP);
            i = studyLogModelMapper.updateByPrimaryKeySelective(model);
        }

        response.setCode(i);

        return response;
    }


    public boolean isStudyingOtherThing(Integer courseId, Integer wareId, Integer userId) {


        if (IntegerExtention.hasValueAndMaxZero(courseId)
                && IntegerExtention.hasValueAndMaxZero(wareId)
                && IntegerExtention.hasValueAndMaxZero(userId)) {
            int i = studyLogModelMapper.selectIsInStudy(courseId, wareId, userId);

            if (i > 0) {
                LogHelper.Error(String.format("用户%s学习异常---同时%s个视频", userId, i));
            }

            return i > 0;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


    //查询单门课程进度
    public boolean calculateOneCourseStudy(Integer userId, Integer courseId, Date startTime,Date endTime) {


        //查询课程详情 （包括课件
        CourseModel courseModel = iCourse.selectDetailById(courseId);
//
//        double score = 0;
//        double time = 0;

        int i = 0;

        //获取某个课程的
        List<CourseWareModel> courseWareModelList = courseModel.getCourseWareModelList();
        if (courseWareModelList != null) {
            for (CourseWareModel courseWareModel : courseWareModelList) {

                //查询已学完课件
                List<StudyLogModel> studyLogModelList = studyLogModelMapper.selectLogByCode(
                        courseId, courseWareModel.getId(), userId, VideoStudyRequestCode.ON_STOP,
                        startTime,endTime);
                if (studyLogModelList != null && studyLogModelList.size() > 0) {
//                    time += Double.parseDouble(courseWareModel.getTime());
                    i++;
                }
            }

            //学完全部课程
            if (i == courseWareModelList.size()) {

                return true;
            }
        }

        return false;
    }


    /**
     * 清除缓存
     */
//    public void clearCache(String clearFlag) {
//        LogHelper.info("=================================>进入清除缓存,clearFlag=" + clearFlag);
//        if ("!@#qazwsx123".equals(clearFlag)) {
//            LogHelper.info("=================================>清除缓存开始,clearFlag=" + clearFlag);
//            allContentList.clear();
//            userContentSeqMap.clear();
//            chatContentSeq = new AtomicInteger(0);
//            inBatchesSeqMap.clear();
//            allUserList.clear();
//            questionList.clear();
//            answerList.clear();
//            OCSCacheHelper.deleteKey(OCSCacheKeys.CHAT_ONLINE_USERS);
//            OCSCacheHelper.deleteKey(OCSCacheKeys.CHAT_ONLINE_USERS_COUNT);
//            OCSCacheHelper.deleteKey(OCSCacheKeys.CHAT_BLACKLIST_USERS);
//            OCSCacheHelper.deleteKey(OCSCacheKeys.CHAT_ONLINE_QUESTIONS);
//            OCSCacheHelper.deleteKey(OCSCacheKeys.CHAT_ROLLING_MESSAGE);
//        }
//    }

    /**
     * 由缓存key清除指定缓存
     */
//    public void clearSingleCacheKey(String clearFlag, String cacheKey) {
//        LogHelper.info("=================================>进入清除指定缓存,clearFlag=" + clearFlag + " cacheKey=" + cacheKey);
//        if ("!@#qazwsx123".equals(clearFlag)) {
//            LogHelper.info("=================================>清除缓存开始,clearFlag=" + clearFlag + " cacheKey=" + cacheKey);
//            OCSCacheHelper.deleteKey(cacheKey);
//        }
//    }


    //记录DB
//    private synchronized void insertDB(ChatLecture chatContent) {
//        Thread thread = new Thread(new Runnable() {
//            @Override
//            public void run() {
//                contentTransactionTemplate.execute(new TransactionCallbackWithoutResult() {
//                    @Override
//                    protected void doInTransactionWithoutResult(TransactionStatus paramTransactionStatus) {
//                        try {
//                            ChatLectureModel model = convertChatLectureModel(chatContent);
//                            LectureReviewsModel reviewsModel = convertLectureReviewsModel(chatContent);
//                            chatLectureModelMapper.insert(model);
//                            //小起司的聊天内容和专家的语音不记录到DB
//                            if (!"2".equals(chatContent.getParticipantType()) && !"1".equals(chatContent.getContentType())) {
//                                lectureReviewsModelMapper.insert(reviewsModel);
//                            }
//                        } catch (Exception e) {
//                            throw new BusinessException("保存DB数据处理异常:" + e.getMessage());
//                        }
//                    }
//                });
//            }
//        }
//        );
//        thread.start();
//    }
}
