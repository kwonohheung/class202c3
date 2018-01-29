package com.ohhoonim.product.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.ohhoonim.dao.ProductDao;
import com.ohhoonim.product.service.ProductService;
import com.ohhoonim.ptnr.service.PtnrService;
import com.ohhoonim.stock.service.StockService;
import com.ohhoonim.vo.ProductVo;
import com.ohhoonim.vo.PtnrVo;
import com.ohhoonim.vo.StockVo;

@Service("productService")
public class ProductServiceImpl implements ProductService {
	private static final Logger LOGGER = Logger.getLogger(ProductService.class);
	@Resource(name = "productDao")
	ProductDao productDao;	
	@Resource(name = "stockService")
	StockService stockService;
	@Resource(name = "ptnrService")
	PtnrService ptnrService;
	
	
	@Override
	public List<ProductVo> selectProductList(ProductVo vo) {

		return productDao.selectProduct(vo);
	}
	
	@Override
	public int insertProduct(ProductVo pvo, StockVo svo, PtnrVo ptnrVo) {
		
		int counter=0;

		LOGGER.debug("검증과정시작");	

		if (productDupChk(pvo) != true || stockService.stockDupChk(svo) != true) {					
			counter = 1;
			//productId pk 검증 product/stock 테이블에서 각각 검증				
		}else if (ptnrService.ptnrDupChk(ptnrVo) == true) {
			counter = 2;			
			//ptnrId가 ptnr테이블에 있는지 검증
			//중복체크 로직이므로 해당 값이 false 일때만 작동해야한다.		
		}else {			
			//검증이 끝나면 이제 넣을차례다.
			LOGGER.debug("넣기시작");
			productDao.insertProduct(pvo);
			LOGGER.debug("Product 넣기완료");
			stockService.insertStock(svo);
			LOGGER.debug("Stock 넣기완료");
			counter = 0;			
		}
		
		LOGGER.debug(productDupChk(pvo));
		LOGGER.debug(stockService.stockDupChk(svo));
		
		LOGGER.debug("검증과정끝");
		LOGGER.debug("상태코드값" + counter);	
		return counter;
	}

	@Override
	public int updateProduct(ProductVo pvo, StockVo svo, PtnrVo ptnrVo) {
		int counter=0;

		LOGGER.debug("검증과정시작");
		
			if (productDupChk(pvo) == true || stockService.stockDupChk(svo) == true) {					
				counter = 1;
				//productId pk 검증 product/stock 테이블에서 각각 검증
				//주의 해당 로직은 insert와 반대다. 중복이 있어야만 작동..
			
			}else if (ptnrService.ptnrDupChk(ptnrVo) == true) {
				counter = 2;
				//ptnrId가 ptnr테이블에 있는지 검증
				//중복체크 로직이므로 해당 값이 false 일때만 작동해야한다.							
			}else {
				LOGGER.debug("넣기시작");
				productDao.updateProduct(pvo);
				LOGGER.debug("Product 넣기완료");
				stockService.updateStock(svo);
				LOGGER.debug("Stock 넣기완료");	
				counter = 0;
				//검증이 끝나면 이제 넣을차례다.
			}
			
		LOGGER.debug(productDupChk(pvo));
		LOGGER.debug(stockService.stockDupChk(svo));
		
		LOGGER.debug("검증과정끝");
		LOGGER.debug("상태코드값" + counter);	
		return counter;		
	}

	@Override
	public int deleteProduct(ProductVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ProductVo productDetail(ProductVo vo) {		
		return productDao.productDetail(vo);
	}

	@Override
	public Map<String,String> productDetailMap(ProductVo vo) {		
		
		Map<String,String> productDetailMap = productDao.productDetailMap(vo);
		
		return productDetailMap;
	}
	
	@Override
	public String pIdGenerator(ProductVo vo) {
		
		String counter = String.format("%05d", productCounter(vo) + 1);
		String ctgrId=vo.getProductId();
		StringBuffer pId = new StringBuffer();
		pId.append(ctgrId);
		pId.append(counter);
		LOGGER.debug(pId);
		
		
		return pId.toString();
	}
	
	@Override
	public int productCounter(ProductVo vo) {

		return productDao.productCounter(vo);
	}

	@Override
	public boolean productDupChk(ProductVo pvo) {
		//DB에 없다면 True 아니면 False
		LOGGER.debug("들어온 pid값" + pvo.getProductId());
	
		int counter = productCounter(pvo);

		if (counter == 0) {
			return true;

		} else {
			return false;
		}

	}



	@Override
	public List<ProductVo> selectProductB(ProductVo pvo) {
		
		return productDao.selectProductB(pvo);
	}



}
