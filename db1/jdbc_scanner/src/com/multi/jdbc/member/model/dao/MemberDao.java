package com.multi.jdbc.member.model.dao;

import com.multi.jdbc.common.exception.MemberException;
import com.multi.jdbc.member.model.dto.Member;

import java.io.FileReader;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Properties;

import static com.multi.jdbc.common.JDBCTemplate.close;

public class MemberDao {
	
	private Properties prop = null;
	
	
	public MemberDao() {
		try {
			prop = new Properties();
			prop.load(new FileReader("resources/query.properties"));
			//  prop.loadFromXML(new FileInputStream("mapper/query.xml"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public ArrayList<Member> selectAll(Connection conn) throws MemberException {
		
		ArrayList<Member> list = null;
		
		
		Statement stmt = null;// 실행할 쿼리
		ResultSet rset = null;// Select 한후 결과값 받아올 객체
		
		//String sql = "SELECT * FROM MEMBER";// 자동으로 세미콜론을 붙여 실행되므로 붙히지않는다
		String sql = prop.getProperty("selectAll");
		try {// 3. 쿼리문을 실행할 statement 객체 생성
			stmt = conn.createStatement();
			
			// 4.쿼리문 전송, 실행결과를 ResultSet 으로 받기
			rset = stmt.executeQuery(sql);
			
			// 5. 받은결과값을 객체에 옮겨서 저장하기
			
			list = new ArrayList<Member>();
			
			while (rset.next()) {
				
				Member m = new Member();
				m.setUserId(rset.getString("USERID"));
				m.setPassword(rset.getString("PASSWORD"));
				m.setUserName(rset.getString("USERNAME"));
				m.setGender(rset.getString("GENDER"));
				m.setAge(rset.getInt("AGE"));
				m.setEmail(rset.getString("EMAIL"));
				m.setPhone(rset.getString("PHONE"));
				m.setAddress(rset.getString("ADDRESS"));
				m.setHobby(rset.getString("HOBBY"));
				m.setEnrollDate(rset.getDate("ENROLLDATE"));
				
				list.add(m);
			}
		} catch (
				SQLException e) {
			// TODO Auto-generated catch block
			//  e.printStackTrace();
			//   throw new MemberException("selectAll 에러 : " + e.getMessage());
			throw new MemberException("selectAll 에러 : " + e.getMessage());
		} finally {
			close(rset);
			close(stmt);
		}
		return list;
	}
	
	
	public Member selectOne(Connection conn, String memberId) throws MemberException {
		
		Member m = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
		
		
		String sql = prop.getProperty("selectOne");
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, memberId);
			
			rset = ps.executeQuery();
			
			
			while (rset.next()) {
				
				m = new Member();
				m.setUserId(rset.getString("USERID"));
				m.setPassword(rset.getString("PASSWORD"));
				m.setUserName(rset.getString("USERNAME"));
				m.setGender(rset.getString("GENDER"));
				m.setAge(rset.getInt("AGE"));
				m.setEmail(rset.getString("EMAIL"));
				m.setPhone(rset.getString("PHONE"));
				m.setAddress(rset.getString("ADDRESS"));
				m.setHobby(rset.getString("HOBBY"));
				m.setEnrollDate(rset.getDate("ENROLLDATE"));
				
			}
		} catch (SQLException e) {
			// e.printStackTrace();
			throw new MemberException("selectOne 에러 : " + e.getMessage());
		} finally {
			close(rset);
			close(ps);
		}
		return m;
		
		
	}
	
	public int insertMember(Connection conn, Member m) throws MemberException {
		
		Member member = null;
		PreparedStatement ps = null;
		int result = 0;
		
		
		// insertMember=INSERT INTO MEMBER VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)
		/*private String userId;
		private String password;
		private String userName;
		private String gender;
		private int age;
		private String email;
		private String phone;
		private String address;
		private String hobby;
		private Date enrollDate;*/
		String sql = prop.getProperty("insertMember");
		try {
			String userId = m.getUserId();
			String password = m.getPassword();
			String userName = m.getUserName();
			String gender = m.getGender();
			int age = m.getAge();
			String email = m.getEmail();
			String phone = m.getPhone();
			String address = m.getAddress();
			String hobby = m.getHobby();
			
			
			ps = conn.prepareStatement(sql);
			
			
			ps.setString(1, userId);
			ps.setString(2, password);
			ps.setString(3, userName);
			ps.setString(4, gender);
			ps.setInt(5, age);
			ps.setString(6, email);
			ps.setString(7, phone);
			ps.setString(8, address);
			ps.setString(9, hobby);
			
			
			result = ps.executeUpdate();
			
			
		} catch (Exception e) {
			// e.printStackTrace();
			throw new MemberException("insertMember 에러 : " + e.getMessage());
		} finally {
			close(ps);
			// 커넥션은 여기서 종료 안 함
		}
		
		return result;
	}
	
	public int updateMember(Connection conn, Member m) throws MemberException {
		
		Member member = null;
		PreparedStatement ps = null;
		int result = 0;
		
		// updateMember=UPDATE MEMBER SET PASSWORD = ? , EMAIL = ?, PHONE = ?, ADDRESS = ? WHERE USERID=?
		String sql = prop.getProperty("updateMember");
		try {
			
			ps = conn.prepareStatement(sql);
			
			String password = m.getPassword();
			String email = m.getEmail();
			String phone = m.getPhone();
			String address = m.getAddress();
			String userId = m.getUserId();
			
			ps.setString(1, password);
			ps.setString(2, email);
			ps.setString(3, phone);
			ps.setString(4, address);
			ps.setString(5, userId);
			
			
			result = ps.executeUpdate();
			
			
		} catch (Exception e) {
			// e.printStackTrace();
			throw new MemberException("updateMember에러 : " + e.getMessage());
			
		}
		
		finally {
			close(ps);
		}
		return result;
		
	}
	
	public int deleteMember(Connection conn, String memberId) throws MemberException {
		
		PreparedStatement ps = null;
		int result = 0;
		
		// deleteMember=DELETE FROM MEMBER WHERE USERID=?
		String sql = prop.getProperty("deleteMember");
		try {
			
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, memberId);
			
			result = ps.executeUpdate();
		} catch (Exception e) {
			// e.printStackTrace(); 
			throw new MemberException("deleteMember에러 : " + e.getMessage());
			// 멤버로 바꿀 수도, 더 큰 exception으로 할 수도 있음
			
		} finally {
			close(ps);
		}
		return result;
	
	
	
	}
	
	
	
	
	
	
}
