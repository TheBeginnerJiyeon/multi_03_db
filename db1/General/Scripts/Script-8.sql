-- CONNECTION: url=jdbc:oracle:thin:@//localhost:1521/XE

-- New script in SYSTEM.
-- Connection Type: dev 
-- Url: jdbc:oracle:thin:@//localhost:1521/XE
-- workspace : C:\Users\dkswl\OneDrive\Documents\code_upload\Auto_window\multi_it\backend\db\db1
-- Date: 2024. 5. 13.
-- Time: 오후 1:41:38


-- 1. 직원의 이름과 이메일, 이메일 길이를 출력하시오
--		  직원명	    이메일		이메일길이
--	ex) 	홍길동 , hong  	  13




-- 2. 2001 AND 2005년에 고용된  직원명과 입사년도, 보너스 값을 출력하시오 
--	그때 보너스 값이 null인 경우에는 0 이라고 출력 되게 만드시오



-- 3. '515' 핸드폰 번호를 사용하지 않는 사람의 수를 출력하시오(뒤에 단위는 명을 붙이시오)



-- 4. 직원명과 입사년월을 2003년 6월 형태로 출력하시오
--	단, 아래와 같이 출력되도록 만들어 보시오
--	    EMP_NAME		HIRE_YY
--	ex) 리사		       1997년 3월



--5 . 부서코드가 50,90인 직원들 중에서 2004년도에 입사한 직원 조회
-- 120(EMPNO)	Matthew Weiss(ENAME)	50(DEPTID)	2004-07-18(HIRE_DATE)  형식으로 출력 



--6 . 직원명, 입사일, 오늘까지의 근무일수 조회 * 주말도 포함 , 소수점 아래는 버림

	
-- 7. 직원들의 입사일로부터 년도만 가지고 각 년도별 입사 인원수를 구하시오
--  아래의 년도에 입사한 인원수를 조회하시오. 마지막으로 전체직원수도 구하시오

--  => to_char, decode, sum 사용
--
--	-------------------------------------------------------------------------
--	 2001년   2002년   2003년   2004년   2005년   2006년   2007년 2008년 전체직원수
--	-------------------------------------------------------------------------




--8. 부서코드가 50이면 총무부, 60이면 기획부, 90이면 영업부로 처리하시오
--   단, 부서코드가 50, 60, 90 인 직원의 정보만 조회함
--  => case 사용
--   부서코드 기준 오름차순 정렬함.



-------------------------------

<btnNewButton 버튼 이벤트>

JButton btnNewButton = new JButton("등록");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				int no = Integer.parseInt(t1.getText());
				String title = t2.getText();
				String content = t3.getText();
				int writer = Integer.parseInt(t4.getText());
				
				
				BoardDto boardDto = new BoardDto();
				
				boardDto.setNo(no);
				boardDto.setTitle(title);
				boardDto.setContent(content);
				boardDto.setWriter(writer);
				
				BoardDao boardDao = new BoardDao();
				int result = boardDao.insert(boardDto);
				
				if (result > 0) {
					JOptionPane.showMessageDialog(null, "게시글 등록 완료");
					
				} else {
					JOptionPane.showMessageDialog(null, "에러발생!!");
				}
				
			}
		});


-----------------------------------

< BoardDao INSERT 메서드>

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



 