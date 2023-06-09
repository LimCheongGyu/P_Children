
<!-- programBoard/modifyProgramForm.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<%
	String num2 = request.getParameter("num");
	if(num2.equals("null")){
		num2 = "1";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫위드-프로그램 수정</title>
<script type="text/javascript">

	// 파일 업로드 되면 img 태그에 파일 이미지 보이게 하기
   function readURL(input){
      var file = input.files[0]; // 파일 정보
      if(file != ""){
         var reader = new FileReader();
         reader.readAsDataURL(file); // 파일 정보 읽어오기
         reader.onload = function(e){ // 읽기에 성공하면 결과 표시
            $("#preview").attr("src", e.target.result)
         }
         
      }
   }
   
	// 시작 날짜 선택(달력 api)
	$( function() {
	  $( "#datepicker1" ).datepicker();
	} );
   
	// 끝나는 날짜 선택(달력 api)
	$( function() {
	  $( "#datepicker2" ).datepicker();
	} );
     
	// 위치_1 선정될 경우 이에 맞게 위치_2 datalist 추가 기능
   function position_1Selected() {
      let position1 = $("#position1").val();
      $.ajax({
         url: "position1Selected",
         type: "POST", 
         data: JSON.stringify(position1),
         contentType: "application/json; charset=utf-8",
         success: function(data) {
            let htm = "";
            if($("#smallScaleDiv").length > 0) { // 선택 후 수정 시 : 이전 목록 삭제
               $("#smallScaleDiv").empty();
            }
            if(data == "서울") { // 위치_1이 서울일 경우
               alert(data);
               htm += "<datalist id='position_smallScale_list'>"
               htm += "<option value='전체' label='전체'>"
               htm += "<option value='강남구' label='강남구'>"
               htm += "<option value='강동구' label='강동구'>"
               htm += "<option value='강북구' label='강북구'>"
               htm += "<option value='강서구' label='강서구'>"
               htm += "<option value='관악구' label='관악구'>"
               htm += "<option value='광진구' label='광진구'>"
               htm += "<option value='구로구' label='구로구'>"
               htm += "<option value='금천구' label='금천구'>"
               htm += "<option value='노원구' label='노원구'>"
               htm += "<option value='도봉구' label='도봉구'>"
               htm += "<option value='동대문구' label='동대문구'>"
               htm += "<option value='동작구' label='동작구'>"
               htm += "<option value='마포구' label='마포구'>"
               htm += "<option value='서대문구' label='서대문구'>"
               htm += "<option value='서초구' label='서초구'>"
               htm += "<option value='성동구' label='성동구'>"
               htm += "<option value='성북구' label='성북구'>"
               htm += "<option value='송파구' label='송파구'>"
               htm += "<option value='양천구' label='양천구'>"
               htm += "<option value='영등포구' label='영등포구'>"
               htm += "<option value='용산구' label='용산구'>"
               htm += "<option value='은평구' label='은평구'>"
               htm += "<option value='종로구' label='종로구'>"
               htm += "<option value='중구' label='중구'>"
               htm += "<option value='중랑구' label='중랑구'>"
               htm += "<option value='전지역' label='전지역'>"
               htm += "</datalist>"
            }
            if(data == "경기") {  // 위치_1이 경기도일 경우
               alert(data);
               htm += "<datalist id='position_smallScale_list'>"
               htm += "<option value='가평군' label='가평군'>";
               htm += "<option value='고양시 덕양구' label='고양시 덕양구'>";
               htm += "<option value='고양시 일산동구' label='고양시 일산동구'>";
               htm += "<option value='고양시 일산서구' label='고양시 일산서구'>";
               htm += "<option value='과천시' label='과천시'>";
               htm += "<option value='광명시' label='광명시'>";
               htm += "<option value='광주시' label='광주시'>";
               htm += "<option value='구리시' label='구리시'>";
               htm += "<option value='군포시' label='군포시'>";
               htm += "<option value='김포시' label='김포시'>";
               htm += "<option value='남양주시' label='남양주시'>";
               htm += "<option value='동두천시' label='동두천시'>";
               htm += "<option value='부천시' label='부천시'>";
               htm += "<option value='성남시 분당구' label='성남시 분당구'>";
               htm += "<option value='성남시 수정구' label='성남시 수정구'>";
               htm += "<option value='성남시 증원구' label='성남시 증원구'>";
               htm += "<option value='수원시 권선구' label='수원시 권선구'>";
               htm += "<option value='수원시 장안구' label='수원시 장안구'>";
               htm += "<option value='수원시 팔달구' label='수원시 팔달구'>";
               htm += "<option value='수원시 영통구' label='수원시 영통구'>";
               htm += "<option value='시흥시' label='시흥시'>";
               htm += "<option value='안산시 단원구' label='안산시 단원구'>";
               htm += "<option value='안산시 상록구' label='안산시 상록구'>";
               htm += "<option value='안성시' label='안성시'>";
               htm += "<option value='안양시 동안구' label='안양시 동안구'>";
               htm += "<option value='안양시 만안구' label='안양시 만안구'>";
               htm += "<option value='양주시' label='양주시'>";
               htm += "<option value='양평군' label='양평군'>";
               htm += "<option value='여주시' label='여주시'>";
               htm += "<option value='연천군' label='연천군'>";
               htm += "<option value='오산시' label='오산시'>";
               htm += "<option value='용인시 기흥구' label='용인시 기흥구'>";
               htm += "<option value='용인시 수지구' label='용인시 수지구'>";
               htm += "<option value='용인시 처인구' label='용인시 처인구'>";
               htm += "<option value='의왕시' label='의왕시'>";
               htm += "<option value='의정부시' label='의정부시'>";
               htm += "<option value='이천시' label='이천시'>";
               htm += "<option value='파주시' label='파주시'>";
               htm += "<option value='평택시' label='평택시'>";
               htm += "<option value='포천시' label='포천시'>";
               htm += "<option value='하남시' label='하남시'>";
               htm += "<option value='화성시' label='화성시'>";
               htm += "<option value='전지역' label='전지역'>";
               htm += "</datalist>";
            }
            
            $("#smallScaleDiv").append(htm);
         },
         error: function() {
            alert("Error !!")
         }
      })
   }
	
	// 수정 확인 및 제출
	function modifyConfirm(){
		
		if(!confirm('수정하시겠습니까?')){
			return false;
		} else {
			$("#modifyProgramForm").submit();
		}
	}
</script>
<style type="text/css">
h1 {
   text-align: center;
}

.write_form {
   width: 1200px;
   margin: 0 auto;
}
</style>
</head>
<body>
   <%-- <c:import url="../default/header.jsp"/> --%>
   <h1>펫위드-프로그램 수정</h1>
   <br><br>
   <div class="wrap write_form">
      <div class="write_save">
      <table class="table table-striped">
         <form id="modifyProgramForm" action="${contextPath }/programBoard/modifySaveForProgram" enctype="multipart/form-data" method="post">
            <tr>
               <th><b> 작성자 </b><br></th>
               <td><input type="text" name="id" value="${user }" readonly><br></td>
               <th><b> 프로그램 이 름 </b><br></th>
               <td><input type="text" name="title" value="${programBoardDTO.title }"><br></td>
            </tr>
            <tr>
               <th><b> 견 종 </b><br></th>
               <td>
                  <input list="petKind_list" id="petKind" name="petKind" placeholder="견종을 검색해보세요" value="${programBoardDTO.petKind}">
                  <datalist id="petKind_list">
                     <option value="아이누" label="아이누(Ainu)"/>
                     <option value="에어덜테리어" label="에어덜 테리어(Airdale Terrier)"/> 
                     <option value="아카바시" label="아카바시(Akbash dog)"/> 
                     <option value="아펜젤러" label="아펜젤러(Appenzeller)"/> 
                     <option value="오스트리안 캐틀독" label="오스트리안 캐틀독 (Australian Cattle dog)"/> 
                     <option value="오스트랄리안 세퍼드" label="오스트랄리안 세퍼드 (Australian Shepherd)"/> 
                     <option value="오스트리안 테리어" label="오스트리안 테리어(Australian Terrier)"/> 
                     <option value="아자와크" label="아자와크(Azawkh)"/>             
                     <option value="바셑하운드" label="바셑하운드(Basset Hound)"/> 
                     <option value="비글해리어" label="비글해리어(Beagle harrier)"/> 
                     <option value="베드링톤 테리어" label="베드링톤 테리어(Bedlington Terrier)"/> 
                     <option value="벨지언 그리폰" label="벨지언 그리폰(Belgian Griffon)"/>
                     <option value="빌리" label="빌리(Billy)"/> 
                     <option value="블랙러시안테리어" label="블랙러시안테리어(Black Russan Terrier)"/> 
                     <option value="블러드하운드" label="블러드하운드(BloodHound)"/> 
                     <option value="보더_콜리" label="보더 콜리(Border Collie)"/> 
                     <option value="보더_테리어" label="보더 테리어(Border Terrier)"/> 
                     <option value="보르조이" label="보르조이(Borzoi)"/> 
                     <option value="보스턴테리어" label="보스턴테리어(Boston Terrier)"/> 
                     <option value="불마스티프" label="불마스티프(Bullmastiff)"/> 
                     <option value="케언_테리어" label="케언 테리어(Cairn Terrier)"/> 
                     <option value="러프_콜리" label="러프 콜리(Collie)"/>
                     <option value="저먼_세퍼드" label="저먼 세퍼드(German Shepherd)"/>
                     <option value="아이리시_세터" label="아이리시 세터(Irish Setter)"/> 
                     <option value="아이리시_테리어" label="아이리시 테리어(Irish Terrier)"/> 
                     <option value="포메라니안" label="포메라니안 (Pomeranian)"/> 
                     <option value="세인트_버나드" label="세인트 버나드(Saint Bernard)"/> 
                     <option value="스코티시_테리어" label="스코티시 테리어(Scottish Terrier)"/> 
                     <option value="갈고_에스파놀" label="갈고 에스파놀"/> 
                     <option value="고든_세터" label="고든 세터 (Gordon Setter)"/> 
                     <option value="골든_리트리버" label="골든 리트리버"/> 
                     <option value="그레이트_덴" label="그레이트 덴 (Great Dane)"/> 
                     <option value="그레이트_피레니즈" label="그레이트 피레니즈(Great Pyrenees)"/>
                     <option value="그레이하운드" label="그레이하운드 (Greyhound)"/>
                     <option value="꼬똥드툴레아" label="꼬똥드툴레아"/> 
                     <option value="노리치_테리어" label="노리치 테리어 (Norwich Terrier)"/> 
                     <option value="뉴펀들랜드" label="뉴펀들랜드 (Newfoundland)"/> 
                     <option value="닥스훈트" label="닥스훈트"/> 
                     <option value="단디_디몬트" label="단디 디몬트"/> 
                     <option value="달마시안" label="달마시안"/> 
                     <option value="댄디_딘몬트_테리어" label="댄디 딘몬트 테리어 (Dandie Dinmont Terrier)"/> 
                     <option value="댕견" label="댕견"/> 
                     <option value="던커" label="던커"/> 
                     <option value="도고_알젠티노" label="도고 알젠티노"/>
                     <option value="도규_대_보규옥스" label="도규 대 보규옥스"/>
                     <option value="도베르만" label="도베르만 (Dobermann)"/> 
                     <option value="도이치_브라케" label="도이치 브라케"/> 
                     <option value="드레버" label="드레버"/> 
                     <option value="딩고" label="딩고"/> 
                     <option value="라사압소" label="라사압소"/> 
                     <option value="라이카" label="라이카"/> 
                     <option value="래브라도_리트리버" label="래브라도 리트리버 (Labrador Retriever)"/> 
                     <option value="러시안_베어_슈나우져" label="러시안 베어 슈나우져"/> 
                     <option value="로디지아_리지백" label="로디지아 리지백 (Rhodesian Ridgeback)"/> 
                     <option value="로트와일러" label="로트와일러 [Rottweiler]"/>
                     <option value="롯드와일러" label="롯드와일러"/>
                     <option value="마스티프" label="마스티프 (Mastiff)"/> 
                     <option value="말티스" label="말티스"/> 
                     <option value="맨체스터_테리어" label="맨체스터 테리어"/> 
                     <option value="미니어쳐_핀셔" label="미니어쳐 핀셔 (Miniature Pinscher)"/> 
                     <option value="미니어쳐슈나우저" label="미니어쳐슈나우저"/> 
                     <option value="바센지" label="바센지 (Basenji)"/> 
                     <option value="바셋_하운드" label="바셋 하운드 (Basset Houng)"/> 
                     <option value="바이마라너" label="바이마라너 Weimaraner"/> 
                     <option value="방뎅" label="방뎅"/> 
                     <option value="버니즈_마운틴_독" label="버니즈 마운틴 독 (Bernese Mountain Dog)"/>
                     <option value="베들링턴_테리어" label="베들링턴 테리어"/>
                     <option value="베르가마스코" label="베르가마스코"/> 
                     <option value="벨지안_말리노이즈" label="벨지안 말리노이즈"/> 
                     <option value="벨지언_그로넨달" label="벨지언 그로넨달"/> 
                     <option value="보더_테리어" label="보더 테리어"/> 
                     <option value="보더콜리" label="보더콜리"/> 
                     <option value="보르조이" label="보르조이"/> 
                     <option value="보비에_드_플란더스" label="보비에 드 플란더스 (Bouvier Des Flandres)"/> 
                     <option value="보스턴_테리어" label="보스턴 테리어"/> 
                     <option value="복서" label="복서 (Boxer)"/> 
                     <option value="볼롱니즈" label="볼롱니즈"/>
                     <option value="볼조이" label="볼조이"/>
                     <option value="불_마스티프" label="불 마스티프 (Bull Mastiff)"/> 
                     <option value="불_테리어" label="불 테리어 (Bull Terrier)"/> 
                     <option value="불독" label="불독"/> 
                     <option value="불테리어" label="불테리어(Bull Terrier)"/> 
                     <option value="브라코_이탈리아노" label="브라코 이탈리아노"/> 
                     <option value="브뤼셀_그리폰" label="브뤼셀 그리폰 (Brussels Griffon)"/> 
                     <option value="브리어드" label="브리어드 (Briard)"/> 
                     <option value="브리타니_스파니엘" label="브리타니 스파니엘 (Brittany Spaniel)"/> 
                     <option value="블랙_앤_탄_쿤하운드" label="블랙 앤 탄 쿤하운드 (Black & Tan Coonhound)"/>
                     <option value="블러드_하운드" label="블러드 하운드 (Blood hound)"/> 
                     <option value="비글" label="비글"/> 
                     <option value="비숑_프리제" label="비숑 프리제 (Bichon Frise)"/> 
                     <option value="비어디드_콜리" label="비어디드 콜리 (Bearded Collie)"/> 
                     <option value="비즐라" label="비즐라"/> 
                     <option value="빠삐용" label="빠삐용 (Papillion)"/> 
                     <option value="살루키" label="살루키 (Saluki)"/> 
                     <option value="삽살개" label="삽살개"/> 
                     <option value="샤페이" label="샤페이 (Shar-pei)"/> 
                     <option value="세터" label="세터 (Setter)"/>
                     <option value="셔틀랜드쉽독" label="셔틀랜드쉽독"/> 
                     <option value="소프트_코티드_휘튼_테리어" label="소프트 코티드 휘튼 테리어"/> 
                     <option value="슈나우저" label="슈나우저"/> 
                     <option value="스코티쉬_디어하운드" label="스코티쉬 디어하운드 (Scottish Deerhound)"/> 
                     <option value="스코티쉬_테리어" label="스코티쉬 테리어 (Scottish Terrier)"/> 
                     <option value="스키퍼키" label="스키퍼키 (Schipperke)"/> 
                     <option value="스태퍼드쉬어_불_테리어" label="스태퍼드쉬어 불 테리어 (Staffordshire Bull Terrier)"/> 
                     <option value="시바견" label="시바견"/> 
                     <option value="시베리안_허스키" label="시베리안 허스키 (Siberian Husky)"/> 
                     <option value="시츄" label="시츄"/>
                     <option value="실리햄_테리어" label="실리햄 테리어 (Sealyham Terrier)"/>
                     <option value="실키테리어" label="실키테리어"/> 
                     <option value="아메리칸_코카_스파니엘" label="아메리칸 코카 스파니엘"/> 
                     <option value="아메리칸_폭스_하운드" label="아메리칸 폭스 하운드 (American Foxhound)"/> 
                     <option value="아이리쉬_울프하운드" label="아이리쉬 울프하운드"/> 
                     <option value="아이리쉬_테리어" label="아이리쉬 테리어 (Irish Terrier)"/> 
                     <option value="아키타" label="아키타 (Akita)"/> 
                     <option value="아펜핀셔" label="아펜핀셔 (Affenpinscher)"/> 
                     <option value="아프간_하운드" label="아프간 하운드(Afghan hounds)"/>
                     <option value="알래스카_말라뮤트" label="알래스카 말라뮤트 (Alaskan Malamute)"/>
                     <option value="에스키모견" label="에스키모견"/> 
                     <option value="에어데일 테리어" label="에어데일 테리어 (Airedale Terrier)"/> 
                     <option value="엘크하운드" label="엘크하운드"/> 
                     <option value="오스트랄리안_캘피" label="오스트랄리안 캘피"/> 
                     <option value="오스트랄리안_테리어" label="오스트랄리안 테리어 (Australian Terrier)"/> 
                     <option value="오스트레일리안_캐틀_독" label="오스트레일리안 캐틀 독 (Australian Cattle Dog)"/> 
                     <option value="오스트리안_캘피" label="오스트리안 캘피"/> 
                     <option value="올드_잉글리쉬_쉽독" label="올드 잉글리쉬 쉽독"/> 
                     <option value="와이어_폭스_테리어" label="와이어 폭스 테리어"/> 
                     <option value="요크셔테리어" label="요크셔테리어"/>
                     <option value="웨스트하이랜드화이트테리어" label="웨스트하이랜드화이트테리어"/>
                     <option value="웰시코기" label="웰시코기(Welchi Corgi)"/> 
                     <option value="유라시안" label="유라시안"/> 
                     <option value="잉글리쉬_코커_스파니엘" label="잉글리쉬 코커 스파니엘 (English Cocker Spaniel)"/> 
                     <option value="잉글리쉬_쿤_하운드" label="잉글리쉬 쿤 하운드"/> 
                     <option value="재패니스_스피츠" label="재패니스 스피츠 (Japaness Spits)"/> 
                     <option value="재패니즈_친" label="재패니즈 친 (재패니즈 칭)"/> 
                     <option value="잭_러셀_테리어" label="잭 러셀 테리어(Jack Russell Terrier)"/> 
                     <option value="저먼_셰퍼드_독" label="저먼 셰퍼드 독 (German Shepher Dog)"/> 
                     <option value="제주개" label="제주개"/> 
                     <option value="진돗개" label="진돗개"/>
                     <option value="차우_차우" label="차우 차우 (Chow Chow)"/>
                     <option value="차이니즈_크레스티드_독" label="차이니즈 크레스티드 독 (Chinese Crested Dog)"/> 
                     <option value="체서피크_베이_리트리버" label="체서피크 베이 리트리버"/> 
                     <option value="치엔_크랑카이즈" label="치엔 크랑카이즈"/> 
                     <option value="치와와" label="치와와 (Chihuahua)"/> 
                     <option value="카디건_웰시코기" label="카디건 웰시코기"/> 
                     <option value="카우카시안_오브차카" label="카우카시안 오브차카"/> 
                     <option value="캐넌_독" label="캐넌 독"/> 
                     <option value="케리_블루_테리어" label="케리 블루 테리어 (Kerry Blue Terrier)"/> 
                     <option value="케언테리어" label="케언테리어"/> 
                     <option value="케이스혼드" label="케이스혼드 (Keeshond)"/>
                     <option value="케인코르소" label="케인코르소"/>
                     <option value="코몬돌" label="코몬돌 (Komondor)"/> 
                     <option value="콜리" label="콜리"/> 
                     <option value="킹_찰스_스파니엘" label="킹 찰스 스파니엘 (King Charles Spaniel)"/> 
                     <option value="토이푸들" label="토이푸들"/> 
                     <option value="티베탄_스파니엘" label="티베탄 스파니엘 (Tibetan Spaniel)"/> 
                     <option value="티베탄_테리어" label="티베탄 테리어 (Tibetan Terrier)"/> 
                     <option value="퍼그" label="퍼그 (Pug)"/> 
                     <option value="페키니즈" label="페키니즈 (Pekingese)"/> 
                     <option value="펨브록 웰시 코기" label="펨브록 웰시 코기 (Pembroke Welsh Corgi)"/> 
                     <option value="포인터" label="포인터 (Pointer)"/>
                     <option value="폭스테리어" label="폭스테리어"/> 
                     <option value="폭스하운드" label="폭스하운드"/> 
                     <option value="푸들" label="푸들"/> 
                     <option value="풀리" label="풀리 (Puli)"/> 
                     <option value="풍산개" label="풍산개"/> 
                     <option value="프랜치_불독" label="프랜치 불독"/> 
                     <option value="플랑드르_부비에" label="플랑드르 부비에"/> 
                     <option value="피니쉬_스피츠" label="피니쉬 스피츠"/> 
                     <option value="핀란드_하운드" label="핀란드 하운드"/> 
                     <option value="핏불테리어" label="핏불테리어"/>
                     <option value="하바네제" label="하바네제"/>
                     <option value="혹카이도" label="혹카이도 (Hokkaido)"/> 
                     <option value="휘핏" label="휘핏(Whippet)"/>
                     <option value="기타" label="기타"/> 
                  </datalist>
                  </td>
               <th><b> 강아지 이름 </b></th>
               <td><input type="text" name="mateName" value="${programBoardDTO.mateName }"/></td>
            </tr>
            <tr>
               <th> 강아지 사진 </th>
               <td>
					<c:if test="${programBoardDTO.mateImage == 'nan'}">
						<b>이미지가 없습니다...</b>
					</c:if>
					<c:if test="${programBoardDTO.mateImage != 'nan'}">
						<img src="${contextPath }/board/download?file_name=${programBoardDTO.mateImage}" width="200px" height="200px">
					</c:if>
				</td>
               <th> 위치 </th>
               <td>
                  <input list="position_largeScale_list" id="position1" name="position1" onchange="position_1Selected()" value="${programBoardDTO.position1 }" placeholder="위치(시)">
                  <datalist id="position_largeScale_list">
                     <option value="서울" label="서울">
                     <option value="경기" label="경기">
                     <option value="인천" label="인천">
                     <option value="대전" label="대전">
                     <option value="세종" label="세종">
                     <option value="충남" label="충남">
                     <option value="충북" label="충북">
                     <option value="광주" label="광주">
                     <option value="전남" label="전남">
                     <option value="전북" label="전북">
                     <option value="대구" label="대구">
                     <option value="경북" label="경북">
                     <option value="부산" label="부산">
                     <option value="울산" label="울산">
                     <option value="경남" label="경남">
                     <option value="강원" label="강원">
                     <option value="제주" label="제주">
                     <option value="전국" label="전국">
                  </datalist>
                  <br><br>
                  <input list="position_smallScale_list" id="position2" name="position2" value="${programBoardDTO.position2 }" placeholder="위치(구)">
                  
                  <!-- 위치(시) 선택시 위치(구) 내용 나오는 위치 -->
                  <div id="smallScaleDiv"></div>
                  
               </td>
            </tr>
            <tr>
               <th rowspan="3"><b> 내 용 </b></th>
               <td rowspan="3" style="right-padding: 0"><textarea name="content" rows="10" cols="50">${programBoardDTO.content }</textarea></td>
               <th style="left-padding: 0"> 시 작 날 짜 <br><br> 시작 시간 </th>
               <td><input type="text" id="datepicker1" name="startDate" value="${programBoardDTO.startDate}"> <br><br> <input type="time" name="startTime" id="startTime" value="${programBoardDTO.startTime}"></td>
            </tr>
            <tr>
               <th style="left-padding: 0"> 종 료 날 짜 <br><br> 종료 시간</th>
               <td><input type="text" id="datepicker2" name="endDate" value="${programBoardDTO.endDate}"><br><br> <input type="time" name="endTime" id="endTime" value="${programBoardDTO.endTime}"></td>
            </tr>
            <tr>
               <th style="left-padding: 0">프 로 그 램  비 용</th>
               <td colspan="3"><input type="text" name="priceForProgram" id="priceForProgram"  value="${programBoardDTO.priceForProgram }" placeholder="숫자만 입력하세요"/> <b>원</b></td>
               <td><b> 현황</b></td>
               <td>
               	<input list="state_list" type="text" id="state" name="state" value="${programBoardDTO.state }">
               	<datalist id="state_list">
               		<option value="예약 가능" label="예약 가능"/>
               		<option value="승인 대기" label="승인 대기"/>
               		<option value="예약 완료" label="예약 완료"/>	
               	</datalist>
               </td>
            </tr>
            <tr>
               <td colspan="4">
				<c:if test="${user == programBoardDTO.id }">
                  <input type="button" onclick="modifyConfirm()" value="수정 완료"/> &nbsp;
                  <input type="button" value="삭제"/> &nbsp; 
                </c:if>
                  <input type="button" value="글목록" onclick="location.href='${contextPath}/programBoard/programBoardAllList'"/>
               </td>
            </tr>
            <input type="hidden" name="write_no" value="${programBoardDTO.write_no}">
         </form>
      </table>
      </div>
   </div>
   <%-- <c:import url="../default/footer.jsp"/> --%>
</body>
</html>