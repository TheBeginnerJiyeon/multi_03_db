package com.multi.jdbc.member.model.dao;

import com.multi.jdbc.common.DBConnectionMgr;
import com.multi.jdbc.member.model.dto.MemberDto;

import java.sql.*;
import java.util.ArrayList;

public class MemberDao {
	
	Connection con = null;
	DBConnectionMgr pool;
	
	
	public MemberDao() {
		
		
		try {
			pool = DBConnectionMgr.getInstance();
			con = pool.getConnection();
			con.setAutoCommit(false);
		} catch (Exception e) {
			System.out.println("DBConnectionMgr connection error >> ");
		}
		
	}
	
	
	public int insertMember(MemberDto dto) {
		
		int result = 0;
		PreparedStatement ps = null;
		
		try {
			
			// sql문 만들기, prepareStatement 준비된 문장
			String sql = "insert into MEMBER1 values (null,?, ?, ?, ?, now())";
			// 오라클은 seq name.nextval()  //// sysdate
			
			ps = con.prepareStatement(sql);
			
			// ? 에 입력할 순서대로 매핑시키기. ? 순서대로
			ps.setString(1, dto.getId());
			ps.setString(2, dto.getPw());
			ps.setString(3, dto.getName());
			ps.setString(4, dto.getTel());
			
			System.out.println("4. sql문 객체 생성 성공.");
			result = ps.executeUpdate();    // ps. 객체 실행, 쿼리 실행, 쿼리 실행 후 반환값 받아주기
			
			
			System.out.println("5. sql문 전송 성공, 결과1 >> " + result);
			// 트랜잭션 커밋
			if (result >= 1) {
				System.out.println("데이터 입력 완료");
				con.commit();
				System.out.println("6. 트랜잭션 커밋 완료.");
			}
			// Query가 제대로 실행되지 않은 경우
			else {
				System.out.println("데이터 입력 실패");
				con.rollback();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("insert error 발생!!");
			
			try {
				con.rollback(); // 예외 발생 시 롤백
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			System.out.println("트랜잭션 롤백.");
			
			
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			
			pool.freeConnection(con, ps);
			
			
		}
		
		return result;
		
		
	}
	
	
	public int delete(String id) {
		
		int result = 0;
		PreparedStatement ps = null;
		
		try {
			
			// sql문 만들기, prepareStatement 준비된 문장
			String sql = "delete from MEMBER1 where id=?";
			// 오라클은 seq name.nextval()  //// sysdate
			
			ps = con.prepareStatement(sql);
			
			// ? 에 입력할 순서대로 매핑시키기. ? 순서대로
			ps.setString(1, id);
			
			
			System.out.println("4. sql문 객체 생성 성공.");
			result = ps.executeUpdate();    // ps. 객체 실행, 쿼리 실행, 쿼리 실행 후 반환값 받아주기
			
			
			System.out.println("5. sql문 전송 성공, 결과1 >> " + result);
			// 트랜잭션 커밋
			if (result >= 1) {
				System.out.println("데이터 입력 완료");
				con.commit();
				System.out.println("6. 트랜잭션 커밋 완료.");
			}
			// Query가 제대로 실행되지 않은 경우
			else {
				System.out.println("데이터 입력 실패");
				con.rollback();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("delete error 발생!!");
			
			try {
				con.rollback(); // 예외 발생 시 롤백
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			System.out.println("트랜잭션 롤백.");
			
			
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			
			pool.freeConnection(con, ps);
			
			
		}
		
		return result;
		
	}
	
	public int update(MemberDto dto) {
		
		int result = 0;
		PreparedStatement ps = null;
		
		try {
			
			// sql문 만들기, prepareStatement 준비된 문장
			String sql = "update MEMBER1 set tel=? where id=?";
			// 오라클은 seq name.nextval()  //// sysdate
			
			ps = con.prepareStatement(sql);
			
			// ? 에 입력할 순서대로 매핑시키기. ? 순서대로
			ps.setString(2, dto.getId());
			ps.setString(1, dto.getTel());
			
			System.out.println("4. sql문 객체 생성 성공.");
			result = ps.executeUpdate();    // ps. 객체 실행, 쿼리 실행, 쿼리 실행 후 반환값 받아주기
			
			
			System.out.println("5. sql문 전송 성공, 결과1 >> " + result);
			// 트랜잭션 커밋
			if (result >= 1) {
				System.out.println("데이터 입력 완료");
				con.commit();
				System.out.println("6. 트랜잭션 커밋 완료.");
			}
			// Query가 제대로 실행되지 않은 경우
			else {
				System.out.println("데이터 입력 실패");
				con.rollback();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("update error 발생!!");
			
			try {
				con.rollback(); // 예외 발생 시 롤백
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			System.out.println("트랜잭션 롤백.");
			
			
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			
			pool.freeConnection(con, ps);
			
			
		}
		
		return result;
		
	}
	
	public MemberDto selectOne(String id) {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		MemberDto rsDto = null;
		
		
		try {
			
			// sql문 만들기, prepareStatement 준비된 문장
			String sql = "select * from MEMBER1 where id=?";
			// 오라클은 seq name.nextval()  //// sysdate
			
			ps = con.prepareStatement(sql);
			
			// ? 에 입력할 순서대로 매핑시키기. ? 순서대로
			ps.setString(1, id);
			
			System.out.println("4. sql문 객체 생성 성공.");
			rs = ps.executeQuery();    // ps. 객체 실행, 쿼리 실행, 쿼리 실행 후 반환값 받아주기
			
			
			// 트랜잭션 커밋
			if (rs.next()) {
				rsDto = new MemberDto();
				rsDto.setNo(rs.getInt("no"));
				rsDto.setId(rs.getString("id"));
				rsDto.setPw(rs.getString("pw"));
				rsDto.setName(rs.getString("name"));
				rsDto.setTel(rs.getString("tel"));
				rsDto.setCreateDate(rs.getDate("create_Date"));
				
				
			}
			System.out.println("sql 실행 결과 : " + rs);
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("selectOne error 발생!!");
			
			try {
				con.rollback(); // 예외 발생 시 롤백
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			System.out.println("트랜잭션 롤백.");
			
			
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			
			pool.freeConnection(con, ps, rs);
			
			
		}
		return rsDto;
		
	}
	
	
	public ArrayList<MemberDto> list() {
		ArrayList<MemberDto> list = new ArrayList<MemberDto>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		
		try {
			String sql = "select * from MEMBER1";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				
				MemberDto memberDto = new MemberDto();
				memberDto = new MemberDto();
				memberDto.setNo(rs.getInt("no"));
				memberDto.setId(rs.getString("id"));
				memberDto.setPw(rs.getString("pw"));
				memberDto.setName(rs.getString("name"));
				memberDto.setTel(rs.getString("tel"));
				memberDto.setCreateDate(rs.getDate("create_Date"));
				
				list.add(memberDto);
			}
			
		} catch (SQLException e) {
			throw new RuntimeException(e);
			
		} finally {
			pool.freeConnection(con, ps, rs);
		}
		
		
		return list;
		
	}
}
