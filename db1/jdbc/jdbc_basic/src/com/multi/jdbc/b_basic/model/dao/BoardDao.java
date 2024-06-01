package com.multi.jdbc.b_basic.model.dao;

import com.multi.jdbc.b_basic.model.dto.BoardDto;

import java.sql.*;

//숙제 : 등록 메서드 작성


public class BoardDao {
	public BoardDto selectOne(int no) {
		System.out.println("BoardDao : selectOne no : " + no);
		BoardDto rsDto = null;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("1. 드라이버 설정 성공..");
			
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String user = "scott";
			String password = "tiger";
			con = DriverManager.getConnection(url, user, password);
			System.out.println("2. db연결 성공." + con);
			
			// 오토커밋을 false로 설정
			con.setAutoCommit(false);
			System.out.println("3. 오토 커밋 설정 비활성화.");
			
			// sql문 만들기, prepareStatement 준비된 문장
			String sql = "SELECT * FROM BBS5 WHERE ID = ?";
			ps = con.prepareStatement(sql);
			// ? 에 입력할 순서대로 매핑시키기
			ps.setInt(1, no);
			
			System.out.println("4. sql문 객체 생성 성공.");
			rs = ps.executeQuery();    // ps. 객체 실행, 쿼리 실행, 쿼리 실행 후 반환값 받아주기
			
			// https://www.tutorialspoint.com/jdbc/jdbc-data-types.htm
			if (rs.next()) {
				rsDto = new BoardDto();
				rsDto.setNo(rs.getInt("NO"));
				rsDto.setTitle(rs.getString("TITLE"));
				rsDto.setContent(rs.getString("CONTENT"));
				rsDto.setWriter(rs.getInt("WRITER"));
			}
			System.out.println("5. sql문 전송 성공, 결과1 >> " + rs);
			
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
				e.printStackTrace();
			}
		}
		
		return rsDto;
	}
	
	public int insert(BoardDto boardDto) {
		
		System.out.println("BoardDao : insert boardDto : " + boardDto);
		
		int result = 0;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("1. 드라이버 설정 성공..");
			
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String user = "scott";
			String password = "tiger";
			con = DriverManager.getConnection(url, user, password);
			System.out.println("2. db연결 성공." + con);
			
			// 오토커밋을 false로 설정
			con.setAutoCommit(false);
			System.out.println("3. 오토 커밋 설정 비활성화.");
			
			// sql문 만들기, prepareStatement 준비된 문장
			String sql = "INSERT INTO BBS VALUES(?,?,?,?)";
			ps = con.prepareStatement(sql);
			
			// ? 에 입력할 순서대로 매핑시키기
			// 가져온 DTO 분해
			
			ps.setInt(1, boardDto.getNo());
			ps.setString(2, boardDto.getTitle());
			ps.setString(3, boardDto.getContent());
			ps.setInt(4, boardDto.getWriter());
			
			result = ps.executeUpdate();    // ps. 객체 실행, 쿼리 실행, 쿼리 실행 후 반환값 받아주기
			
			con.commit();
			
			
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
				e.printStackTrace();
			}
		}
		
		return result;
		
		
	}
}
