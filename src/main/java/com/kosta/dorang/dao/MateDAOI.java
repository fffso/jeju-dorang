package com.kosta.dorang.dao;

import java.util.List;

import com.kosta.dorang.dto.Mate;
import com.kosta.dorang.dto.MateApply;
import com.kosta.dorang.dto.MateComments;
import com.kosta.dorang.dto.MateCommentsUser;
import com.kosta.dorang.dto.MateCriteria;
import com.kosta.dorang.dto.MateJoinMateApply;
import com.kosta.dorang.dto.Notice;

public interface MateDAOI {
	public void insertMate(Mate m) throws Exception; 
	public List<Mate> getMateListViewSort(MateCriteria cri) throws Exception;//목록
	public Mate selectMate(int mate_code)throws Exception; //조회
	public void updateMate(Mate m)throws Exception;//수정
	public void deleteMate(int mate_code)throws Exception;//삭제
	public int insertApplyMate(MateApply mp)throws Exception; //신청
	public MateApply selectApplyMate(int mate_code,Long user_code) throws Exception; 
	public MateApply selectApplyMateByMateCode(int mate_code) throws Exception; 
	public void deleteApplyMate(int mate_code)throws Exception;
	public List<MateComments> selectMateCommListByMateCode(int mate_code) throws Exception;
	public void deleteMateCommListByMateCode(int mate_code)throws Exception;
	public String selectMateNickName(int mate_code) throws Exception;
	public List<String> selectApplyMateResult(Long user_code) throws Exception; 
	public List<MateCommentsUser> selectMateReplyListByMateCode(int mate_code) throws Exception; //응심이꺼
	public int insertMateReply(MateComments mateComments); //응심이꺼
	public int totalCount();
	public int totalmyCount(Long user_code, MateCriteria cri);
	public void mateCount(int mate_code) throws Exception;
	List<Mate> getmyMateListViewSort(Long user_code,MateCriteria cri) throws Exception;
	public void deleteMateReply(int comment_code) throws Exception; //응심이거
	public MateCommentsUser selectOneMateReply(int comment_code) throws Exception; //응심이꺼
	public void updateMateReply(MateComments mateComments) throws Exception; //응심이꺼
	public void insertMateReplyNotice(long mateWriter,String noticeContent, int comment_code) throws Exception; //응심이꺼
	public void insertMateApplyNotice(long mate_writer, String mateApplyContent, int mate_Application_code, String result) throws Exception;
	public int updateWithMateApplyAccept(int mate_application_code) throws Exception;
	public MateJoinMateApply selectMateApplyByMateApplyCode(int mate_application_code) throws Exception;
	public void insertWithMateApplyAccept(long user_code, String content, int mate_application_code,String result) throws Exception;
	public void updateNoticeBymateApplicationCode(int mate_application_code) throws Exception;
	public int updateWithMateApplyRefuse(int mate_application_code) throws Exception;
	public void insertWithMateApplyRefuse(long user_code, String content, int mate_application_code, String result) throws Exception;
	public void updateMateWithJoinCount(int mate_code) throws Exception;
	
}
