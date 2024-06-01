package com.multi.jdbc.member.controller;

import com.multi.jdbc.common.exception.MemberException;
import com.multi.jdbc.member.model.dto.Member;
import com.multi.jdbc.member.service.MemberService;
import com.multi.jdbc.member.view.MemberMenu;

import java.util.ArrayList;

//  dto에 담기
public class MemberController {
	
	private MemberService memberService = new MemberService();
	
	
	public void selectAll() {
		MemberMenu menu = new MemberMenu();
		ArrayList<Member> list;
		
		try {
			list = memberService.selectAll();
			if (!list.isEmpty()) {
				
				menu.displayMemberList(list);
				
			} else {
				menu.displayNoData();
				
			}
		} catch (MemberException e) {
			new MemberMenu().displayError("회원정보가 입력 안됩니다.");
		}
		
		
	}
	
	public void selectOne(Object memberId) {
		
		MemberMenu menu = new MemberMenu();
		Member m = null;
		try {
			m = memberService.selectOne(memberId.toString());
			if (m != null) {
				menu.displayMember(m);
			} else {
				menu.displayNoData();
				
			}
		} catch (MemberException e) {
			throw new RuntimeException(e);
		}
		
		
	}
	
	
	public void insertMember(Member m) {
		
		int result = 0;
		try {
			result = memberService.insertMember(m);
			if (result > 0) {
				System.out.println("회원정보가 입력됩니다. ");
				new MemberMenu().displaySuccess("회원정보가 입력됩니다.");
				
				
			} else {
				System.out.println("회원정보가 입력 안됩니다. ");
				new MemberMenu().displayNoData();
			}
		} catch (MemberException e) {
			new MemberMenu().displayError("회원정보가 입력 안됩니다.");
		}
		
		
	}
	
	public int updateMember(Member m) {
		
		int result = 0;
		try {
			result = memberService.updateMember(m);
			if (result > 0) {
				System.out.println("회원정보가 수정됩니다. ");
				new MemberMenu().displaySuccess("회원정보가 수정됩니다.");
				
				
			} else {
				System.out.println("회원정보가 수정 안됩니다. ");
				new MemberMenu().displayNoData();
			}
			return result;
		} catch (MemberException e) {
			new MemberMenu().displayError("회원정보가 수정 안됩니다. ");
		}
		
		return result;
	}
	
	public void deleteMember(String memberId) {
		int result = 0;
		
		
		try {
			result = memberService.deleteMember(memberId);
			if (result > 0) {
				
				new MemberMenu().displaySuccess("회원정보가 삭제됩니다.");
				
			} else {
				new MemberMenu().displayNoData();
			}
			
			
		} catch (MemberException e) {
			
			new MemberMenu().displayError("회원 삭제 실패, 관리자에 문의하세요 ");
			// e.printStackTrace();
			
			
		}
		
		
	}
	
	public void exitProgram() {
	
		
		memberService.exitProgram();
	
	
	}
}
