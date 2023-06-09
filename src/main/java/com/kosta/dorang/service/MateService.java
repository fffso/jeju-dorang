package com.kosta.dorang.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosta.dorang.dao.MateDAO;
import com.kosta.dorang.dao.MateDAOI;
import com.kosta.dorang.dto.Mate;
import com.kosta.dorang.dto.MateApply;
import com.kosta.dorang.dto.MateComments;
import com.kosta.dorang.dto.MateCommentsUser;
import com.kosta.dorang.dto.MateCriteria;
import com.kosta.dorang.dto.MateJoinMateApply;
import com.kosta.dorang.dto.Notice;

@Service
public class MateService implements MateServiceI {
	
	@Autowired
	private MateDAOI mateDaoI;

	@Autowired
	private MateDAO mateDAO;
	
	@Override
	public void insertMate(Mate m) throws Exception {
		mateDAO.insertMate(m);
	}

	@Override
	public List<Mate> getMateListViewSort(MateCriteria cri) throws Exception {
		return mateDAO.getMateListViewSort(cri);
	
	}
	
	@Override
	public Mate selectMate(int mate_code) throws Exception {
		
		return mateDAO.selectMate(mate_code);
	}

	@Override
	public void updateMate(Mate m) throws Exception {
		 mateDAO.updateMate(m);
		
	}

	@Override
	public void deleteMate(int mate_code) throws Exception {
		mateDAO.deleteMate(mate_code);
	}

	@Override
	public int insertMateApply(MateApply mp) throws Exception {
		int insertCheck=mateDAO.insertApplyMate(mp);
		return insertCheck;
		
	}

	@Override
	public MateApply selectMateApply(int mate_code, Long user_code) throws Exception {
		return mateDAO.selectApplyMate(mate_code, user_code);
	}
	@Override
	public MateApply selectApplyMateByMateCode(int mate_code) throws Exception {
		return mateDAO.selectApplyMateByMateCode(mate_code);
	}
	@Override
	public void deleteApplyMate(int mate_code) throws Exception {
		mateDAO.deleteApplyMate(mate_code);
		
	}
	@Override
	public int totalCount() throws Exception {
		return mateDAO.totalCount();
	}
	@Override
	public int totalmyCount(Long user_code, MateCriteria cri) throws Exception {
		return mateDAO.totalmyCount(user_code,cri);
	}

	@Override
	public void mateCount(int mate_code) throws Exception {
		 mateDAO.mateCount(mate_code);
	}
	
	@Override
	public List<Mate> getmyMateListViewSort(Long user_code,MateCriteria cri) throws Exception {
		return mateDAO.getmyMateListViewSort(user_code,cri);
	}
	@Override
	public List<MateComments> selectMateCommListByMateCode(int mate_code) throws Exception {
		return mateDAO.selectMateCommListByMateCode(mate_code);
	}
	@Override
	public void deleteMateCommListByMateCode(int mate_code) throws Exception {
		mateDAO.deleteMateCommListByMateCode(mate_code);
	}
	@Override
	public List<String> selectApplyMateResult(Long user_code) throws Exception {
		return mateDAO.selectApplyMateResult(user_code);
	}
	@Override
	public String selectMateNickName(int mate_code) throws Exception {
		return mateDAO.selectMateNickName(mate_code);
	}
	
  //응심이 댓글 select
  @Override
	public List<MateCommentsUser> selectMateReplyListByMateCode(int mate_code) throws Exception {
		return mateDaoI.selectMateReplyListByMateCode(mate_code);
	}
  
  	//댓글 insert
	@Override
	public int insertMateReply(MateComments mateComments) {
		int insertCheck=mateDaoI.insertMateReply(mateComments);
		return insertCheck;
		
	}
	 //댓글 delete
	@Override
	public void deleteMateReply(int comment_code) throws Exception {
		mateDaoI.deleteMateReply(comment_code);
		
	}

	//수정 할 댓글 하나 select
	@Override
	public MateCommentsUser selectOneMateReply(int comment_code) throws Exception {
		return mateDaoI.selectOneMateReply(comment_code);
	}

	//댓글 update
	@Override
	public void updateMateReply(MateComments mateComments) throws Exception {
		mateDaoI.updateMateReply(mateComments);
	}

	
	//댓글 알림 insert
	@Override
	public void insertMateReplyNotice(long mateWriter,String noticeContent, int comment_code) throws Exception {
		mateDaoI.insertMateReplyNotice(mateWriter,noticeContent,comment_code);
		
	}

	@Override
	public void insertMateApplyNotice(long mate_writer, String mateApplyContent, int mate_Application_code,String result)
			throws Exception {
		mateDaoI.insertMateApplyNotice(mate_writer,mateApplyContent,mate_Application_code,result);
		
	}

	@Override
	public int updateWithMateApplyAccept(int mate_application_code) throws Exception {
		int updateCheck=mateDaoI.updateWithMateApplyAccept(mate_application_code);
		return updateCheck;
	}

	@Override
	public MateJoinMateApply selectMateApplyByMateApplyCode(int mate_application_code) throws Exception {
		return mateDaoI.selectMateApplyByMateApplyCode(mate_application_code);
	}

	@Override
	public void insertWithMateApplyAccept(long user_code, String content, int mate_application_code,String result) throws Exception {
		mateDaoI.insertWithMateApplyAccept(user_code,content,mate_application_code,result);
		
	}

	@Override
	public void updateNoticeBymateApplicationCode(int mate_application_code) throws Exception {
		mateDaoI.updateNoticeBymateApplicationCode(mate_application_code);
	}

	@Override
	public int updateWithMateApplyRefuse(int mate_application_code) throws Exception {
		int updateCheck=mateDaoI.updateWithMateApplyRefuse(mate_application_code);
		return updateCheck;
	}

	@Override
	public void insertWithMateApplyRefuse(long user_code, String content, int mate_application_code,String result) throws Exception {
		mateDaoI.insertWithMateApplyRefuse(user_code,content,mate_application_code,result);
		
	}

	@Override
	public void updateMateWithJoinCount(int mate_code) throws Exception {
		mateDaoI.updateMateWithJoinCount(mate_code);
		
	}
}
