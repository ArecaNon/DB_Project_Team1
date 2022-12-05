Team1-phase4.zip파일에 
"zip 파일을 해제한 뒤, zip 파일에 포함된 파일들만으로 실행이 가능하여야 함."
을 만족시키기 위한 파일들을 묶어서 저장해두었습니다.

Team1-phase4.zip파일에 
Team1_Phase2-1.sql은 테이블을 만드는 파일과,
Team1_Phase2-2.sql는 튜플을 넣는 파일을 넣었습니다.
html, jsp를 tomcat으로 이용하여 만든 웹사이트에서 실행할 파일은 teample_1.zip로 만들어 넣었습니다.

-phase4 동작방법
먼저 첨부한 pahse2의 TABLE과 INSERT를 teamproject/comp322의 오라클 계정을 만들고 거기에서(권한 부여 필수) 실행시켜야 정상적으로 작동함
start.html이 시작 페이지 입니다.
로그인(login.html) or 회원가입(signup.html)으로 되어 있고 글자 클릭시 페이지로 이동
일반 회원은 로그인 성공시 메뉴(menu.html)로 넘어가고 실패시 다시 로그인 페이지로 이동
회원가입 페이지(signup.html)에서 가입을 하면 customer 테이블에 자동으로 저장, 추가로 차량 등록이 Y일시 CAR 테이블에도 정보 저장
관리자는 관리자 로그인 성공시 관리자 전용 메뉴(adminmenu.html)로 넘어감

관리자 전용 메뉴에서는 4가지 기능을 수행할 수 있습니다.
-Insert(insert.html)-> 원하는 테이블에 정보를 삽입할 수 있는 기능, 테이블의 atrribute 순으로 input칸에 입력하면 삽입가능
정확한 순서가 지켜지지 않았을시 에러 반환
-Delete(delete.html)-> 각 테이블에 지정된 atrribute에 대한 값을 입력받아 삭제하는 기능, 지정된 atrribute를 볼수 있게 구현
-Search Table(search_table.html)-> 원하는 테이블을 골라 전체 항목들을 볼 수 있게한 기능, 후에 tuple의 갯수도 출력
-EXIT-> 맨 처음 초기 페이지(start.html)로 넘어가게 됩니다.

일반 회원 전용 메뉴(menu.html)에는 예약 진행, 예약 조회,예약 취소, 가게 검색, 할인 정보, 차량 등록, 차량 확인 카테고리 구현 -> 클릭시 페이지 이동
-예약 진행(reservation.html)-> 가게 예약 정보 입력 -> 주차 예약 여부 결정 -> 중복인 값이 있나 체크후 없으면 디비에 데이터 저장 
-예약 조회(checkreservation.html)-> 고객의 RRN 입력-> 가게 예약과 주차 예약 통합 조회 -> 조회 메뉴에서 예약취소 메뉴로 바로가기 버튼 구현
-예약 취소(cancelreservation.html)-> 고객 번호 입력받고 가계 예약과 주차 예약을 삭제하고
예약한 테이블과 예약한 주차 공간을 빈좌석으로 수정하는 기능 구현
-차량 등록(check_car.html)-> 회원가입할때 등록하지 않았을수도 있으니 추가로 차량 등록 기능 구현
-가게 검색(searchstore.html) , 할인 정보(discountinfo.html) -> 간단하게 등록된 테이블에서 정보 검색 기능 구현
-차량 확인(check_car.html)-> 고객 RRN을 입력받아서 등록되어있는 차량 출력, 없을 시 없다고 출력

-실행 환경
강의 자료 pdf에 나오는 환경을 따라서 구성하였습니다.

