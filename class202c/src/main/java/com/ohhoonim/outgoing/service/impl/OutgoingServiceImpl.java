package com.ohhoonim.outgoing.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.ohhoonim.dao.OutgoingDao;
import com.ohhoonim.outgoing.service.OutgoingService;
import com.ohhoonim.vo.OutgoingVo;

@Service("outgoingService")
public class OutgoingServiceImpl implements OutgoingService{
	@Resource(name="outgoingDao")
	OutgoingDao outgoingDao;

	@Override
	public int insertOutgoing(OutgoingVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<OutgoingVo> selectOutgoing(OutgoingVo vo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateOutgoing(OutgoingVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteOutgoing(OutgoingVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int ordroutgoingModify(OutgoingVo vo) {
		// TODO Auto-generated method stub
		return outgoingDao.ordroutgoingModify(vo);
	}

	@Override
	public Map<String, Object> getOutgoing(OutgoingVo outgoingvo) {
		
		Map<String,Object> resultVo = outgoingDao.getOutgoing(outgoingvo);
		
		return resultVo;
	}
}
