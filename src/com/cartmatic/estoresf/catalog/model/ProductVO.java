package com.cartmatic.estoresf.catalog.model;

import java.util.List;

/**
 * 产品VO
 * @author User
 *
 */
public class ProductVO {

	private Integer productId;
	
	private String productName;
	
	private String media;
	
	private List<String> medias;
	
	private Integer pageCount;

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getMedia() {
		return media;
	}

	public void setMedia(String media) {
		this.media = media;
	}

	public List<String> getMedias() {
		return medias;
	}

	public void setMedias(List<String> medias) {
		this.medias = medias;
	}

	public Integer getPageCount() {
		return pageCount;
	}

	public void setPageCount(Integer pageCount) {
		this.pageCount = pageCount;
	}
	
	
}
