package com.multi.jdbc.member.view;

import com.multi.jdbc.member.model.dao.MemberDao;
import com.multi.jdbc.member.model.dto.MemberDto;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.ArrayList;
import java.util.Date;

public class MemberUI5 {
	private static JScrollPane scroll = null;
	
	public static void main(String[] args) {
		// 프로그램 시작하자 마자 db에서 데이터를 가지고 와서
		// 화면을 만들어주고 싶음.
		JFrame f = new JFrame();
		f.setSize(500, 700);
		JPanel p = new JPanel();
		
		MemberDao dao = new MemberDao();
		ArrayList<MemberDto> list = dao.list(); // ArrayList<MemberDTO>
		
		String[] header = {"번호","아이디", "패스워드", "이름", "전화번호","생성날짜"};
		String[][] all = new String[list.size()][6];
		
		if (list.size() == 0) {
			System.out.println("검색결과 없음. ");
		} else {
			System.out.println("검색결과는 전체 " + list.size() + "개 입니다.");
			for (int i = 0; i < all.length; i++) { //13개의 가방,13개의 행  
				all[i][0] = Integer.toString(list.get(i).getNo());
				all[i][1] = list.get(i).getId();
				all[i][2] = list.get(i).getPw();
				all[i][3] = list.get(i).getName();
				all[i][4] = list.get(i).getTel();
				Date date = list.get(i).getCreateDate();
				all[i][5] = date.toString();
			}
		}//else  
		
		String[][] all2 = new String[list.size()][6];
		
		if (list.size() == 0) {
			System.out.println("검색결과 없음. ");
		} else {
			System.out.println("검색결과는 전체 " + list.size() + "개 입니다.");
			for (int i = 0; i < all.length; i++) { //13개의 가방,13개의 행
				
				all2[i][0] = Integer.toString(list.get(i).getNo()) + 1;
				all2[i][1] = list.get(i).getId() + 1;
				all2[i][2] = list.get(i).getPw() + 1;
				all2[i][3] = list.get(i).getName() + 1;
				all2[i][4] = list.get(i).getTel() + 1;
				Date date = list.get(i).getCreateDate();
				all2[i][5] = date.toString() + 1;
				
			}
		}//else  
		
		JButton b = new JButton("테이블 리프레쉬??");
		b.setFont(new Font("궁서", 2, 30));
		JTable table = new JTable(all, header);
		scroll = new JScrollPane(table);
		
		//f.setLayout(new FlowLayout());
		f.add(p, BorderLayout.CENTER);
		p.add(b);
		p.add(scroll);
		
		b.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				p.remove(scroll);
				JTable table2 = new JTable(all2, header);
				scroll = new JScrollPane(table2);
				p.add(scroll);
				p.revalidate(); // 레이아웃을 새로 계산
				p.repaint(); // 컴포넌트를 다시 그림
			}
		});
		
		table.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				
				table.getModel().setValueAt("win", 0, 0);
				table.repaint();
			}
		});
		f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		f.setVisible(true);
	}//main
	
}
