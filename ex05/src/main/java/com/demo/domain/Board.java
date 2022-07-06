package com.demo.domain;

import java.util.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
public class Board {

	//board_idx, board_name, board_title, board_content, board_date, board_hit
	private Long board_idx;
	private String board_name;
	private String board_title;
	private String board_content;
	private Date board_date;
	private int board_hit;
	
}
