package com.multi.jdbc.b_basic.view;

import javax.swing.*;
import java.sql.*;

public class BoardDao {
	
	public BoardDto selectOne(int no) {
		
		System.out.println("BoardDto의 selectOne() 메소드 호출, no : " + no);
		// 1차 확인
		
		
		BoardDto rsDto = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		
		try {
			
			// 1.Jdbc driver 등록 처리 : 해당 database 벤더 사가 제공하는 클래스 등록
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("1. 드라이버 설정 성공..");
			
			
			String url = "jdbc:oracle:thin:@//localhost:1521/XE";
			String user = "scott";
			String password = "tiger";
			con = DriverManager.getConnection(url, user, password);
			System.out.println("2. db연결 성공.");
			
			// 오토커밋을 false로 설정
			con.setAutoCommit(false);
			System.out.println("3. 오토커밋 설정 비활성화.");
			
			// sql문 만들기 , preparedstatement :준비된 문장 만들기
			String sql = "select * from BOARD where no = ?";
			ps = con.prepareStatement(sql); // 처리 된 행 수
			
			// ?에 입력될 순서대로 잘 매핑시키기
			ps.setInt(1, no);
			
			System.out.println("4. sql문 객체 생성 성공");
			
			rs = ps.executeQuery(); //ps 객체 실행, 쿼리실행, 반환값(변경된 행의 수) 넘어옴 받아줌.
			
			if (rs.next()) {
				
				// https://www.tutorialspoint.com/jdbc/jdbc-data-types.htm
				
				rsDto = new BoardDto();
				rsDto.setNo(rs.getInt("no"));
				rsDto.setTitle(rs.getString("title"));
				rsDto.setContent(rs.getString("content"));
				rsDto.setWriter(rs.getInt("writer"));
				
				System.out.println("5. sql문 실행.");
				
				
			}
			
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
			if (con != null) {
				try {
					con.rollback(); // 예외 발생 시 롤백
				} catch (SQLException ex) {
					ex.printStackTrace();
					
				}
				System.out.println("트랜잭션 롤백.");
			}
			
			
		} finally {
			try {
				ps.close(); // 먼저닫기
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
				
				
			}
			
			
		}
		
		
		return rsDto;
	}
	
	public void insert(BoardDto boardDto) {
		
		
		System.out.println("테이블에 데이터 삽입");
		
		
		BoardDto rsDto = null;
		Connection con = null;
		PreparedStatement ps = null;
		int rs = 0;
		
		
		try {
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("1. 드라이버 설정 성공..");
			
			
			String url = "jdbc:oracle:thin:@//localhost:1521/XE";
			String user = "scott";
			String password = "tiger";
			con = DriverManager.getConnection(url, user, password);
			System.out.println("2. db연결 성공.");
			
			// 오토커밋을 false로 설정
			con.setAutoCommit(false);
			System.out.println("3. 오토커밋 설정 비활성화.");
			
			// sql문 만들기 , preparedstatement :준비된 문장 만들기
			
			/*String sql = "insert into BOARD(no, title, content, writer) values(BOARD_SEQ.nextval, ?, ?, ?)"; 시퀀스 넣기*/
			
			String sql = "insert into BOARD(no, title, content, writer) values(?, ?, ?, ?)";
			ps = con.prepareStatement(sql); // 처리 된 행 수
			
			// ?에 입력될 순서대로 잘 매핑시키기
			ps.setInt(1, boardDto.getNo());
			ps.setString(2, boardDto.getTitle());
			ps.setString(3, boardDto.getContent());
			ps.setInt(4, boardDto.getWriter());
			
			System.out.println("4. sql문 객체 생성 성공");
			
			rs = ps.executeUpdate();
			
			System.out.println(rs + "개 업데이트 완료!!");
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
			if (con != null) {
				try {
					con.rollback(); // 예외 발생 시 롤백
				} catch (SQLException ex) {
					ex.printStackTrace();
					
				}
				System.out.println("트랜잭션 롤백.");
			}
			
			
		} finally {
			try {
				ps.close(); // 먼저닫기
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
				
				
			}
			
			
		}
		
		
	}
	
	public void delete(int no1) {
		
		BoardDto rsDto = null;
		Connection con = null;
		PreparedStatement ps = null;
		int rs = 0;
		
		
		try {
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("1. 드라이버 설정 성공..");
			
			
			String url = "jdbc:oracle:thin:@//localhost:1521/XE";
			String user = "scott";
			String password = "tiger";
			con = DriverManager.getConnection(url, user, password);
			System.out.println("2. db연결 성공.");
			
			// 오토커밋을 false로 설정
			con.setAutoCommit(false);
			System.out.println("3. 오토커밋 설정 비활성화.");
			
			rsDto = selectOne(no1);
			
			if (rsDto != null) {
				String sql = "delete from BOARD where no = ?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, no1);
				
				ps.executeUpdate();
				System.out.println("4. sql문 실행 후 삭제 완료");
				
				
			} else {
				JOptionPane.showMessageDialog(null, "해당하는 게시글이 없습니다.");
				
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
			if (con != null) {
				try {
					con.rollback(); // 예외 발생 시 롤백
				} catch (SQLException ex) {
					ex.printStackTrace();
					
				}
				System.out.println("트랜잭션 롤백.");
			}
			
			
		} finally {
			try {
				ps.close(); // 먼저닫기
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
				
				
			}
		}
	}
}
