package com.demo.domain;

//데이터베이스의 상품테이블을 가상으로 참조
public class ProductVO {
	
	private String productName;
	private double price;
	
	public ProductVO(String productName, double price) {
		super();
		this.productName = productName;
		this.price = price;
	}

	//getter, setter
	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	@Override
	public String toString() {
		return "ProductVO [productName=" + productName + ", price=" + price + "]";
	}
	
	
	
	
}
