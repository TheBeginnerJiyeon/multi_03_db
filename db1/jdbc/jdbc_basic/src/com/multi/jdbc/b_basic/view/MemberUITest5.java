package com.multi.jdbc.b_basic.view;

import com.multi.jdbc.b_basic.model.dao.MemberDao;
import com.multi.jdbc.b_basic.model.dto.MemberDto;

import javax.swing.*;

public class MemberUITest5 {    // 로그인
    public static void main(String[] args) {
        String id = JOptionPane.showInputDialog("아이디 입력");
        String pw = JOptionPane.showInputDialog("비밀번호 입력");

        MemberDao dao = new MemberDao();
        MemberDto dto = new MemberDto();
        dto.setId(Integer.parseInt(id));
        dto.setPw(pw);
        MemberDto rsDto = dao.login(dto);

        System.out.println(rsDto);
        // 어떤 경우에 로그인 실패 출력
        if(rsDto == null) {
            System.out.println("로그인 실패");
        }
        // 아닐 때 로그인 성공 출력
        else {
            System.out.println("로그인 성공");
        }
    }
}
