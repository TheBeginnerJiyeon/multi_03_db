package com.multi.jdbc.b_basic.view;

import com.multi.jdbc.b_basic.model.dao.MemberDao;
import com.multi.jdbc.b_basic.model.dto.MemberDto;

import javax.swing.*;

public class MemberUITest4 {    // 회원 한 명 검색
    public static void main(String[] args) {
        String id = JOptionPane.showInputDialog("아이디 입력");

        MemberDao dao = new MemberDao();
        MemberDto dto = dao.selectOne(id);

        System.out.println(dto);
        JOptionPane.showMessageDialog(null, dto);
    }
}
