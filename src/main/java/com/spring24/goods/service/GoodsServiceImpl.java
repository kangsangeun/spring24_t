package com.spring24.goods.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring24.goods.dao.GoodsDAO;
import com.spring24.goods.vo.GoodsVO;
import com.spring24.goods.vo.ImageFileVO;

@Service("goodsService")
@Transactional(propagation=Propagation.REQUIRED)
public class GoodsServiceImpl implements GoodsService{
	@Autowired
	private GoodsDAO goodsDAO;
	
	public Map<String,List<GoodsVO>> listGoods() throws Exception {
		Map<String,List<GoodsVO>> goodsMap=new HashMap<String,List<GoodsVO>>();
		
		List<GoodsVO> goodsList=goodsDAO.selectGoodsList("drink");
		goodsMap.put("drink",goodsList);
		
		goodsList=goodsDAO.selectGoodsList("snack");
		goodsMap.put("snack",goodsList);
		
		goodsList=goodsDAO.selectGoodsList("noodle");
		goodsMap.put("noodle",goodsList);
		
		goodsList=goodsDAO.selectGoodsList("dairy");
		goodsMap.put("dairy",goodsList);
		
		goodsList=goodsDAO.selectGoodsList("sandwich");
		goodsMap.put("sandwich",goodsList);
		
		goodsList=goodsDAO.selectGoodsList("etc");
		goodsMap.put("etc",goodsList);
		
		return goodsMap;
	}
	
	public Map goodsDetail(String _goods_id) throws Exception {
		Map goodsMap=new HashMap();
		GoodsVO goodsVO = goodsDAO.selectGoodsDetail(_goods_id);
		goodsMap.put("goodsVO", goodsVO);
		List<ImageFileVO> imageList =goodsDAO.selectGoodsDetailImage(_goods_id);
		goodsMap.put("imageList", imageList);
		return goodsMap;
	}
	
	public List<String> keywordSearch(String keyword) throws Exception {
		List<String> list=goodsDAO.selectKeywordSearch(keyword);
		return list;
	}
	
	public List<GoodsVO> searchGoods(String searchWord) throws Exception{
		List goodsList=goodsDAO.selectGoodsBySearchWord(searchWord);
		return goodsList;
	}
	
	
//	   public List<GoodsVO> allGoodsList() throws Exception{
//		      List allgoodsList=goodsDAO.allGoodsList();
//		      return allgoodsList;
//		   }
	
}
