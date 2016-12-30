package com.yy.boot.buss.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class PageResult implements Serializable {
	private static final long serialVersionUID = -3004636553771688855L;

	private String code = "0";

	private String message = "success";

	private long total;

	private List<?> rows = new ArrayList<Object>();

	public long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
	}

	public List<?> getRows() {
		return rows == null ? new ArrayList() : rows;
	}

	public void setRows(List<?> rows) {
		this.rows = rows;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String toString() {
		return "PageResult [code=" + code + ", message=" + message + ", total=" + total + ", rows=" + rows + "]";
	}
}
