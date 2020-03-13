<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>seoha</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">



<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<link rel="shortcut icon" href="../resources/static/images/01.png">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row m-1">
			<div class="input-group col-sm-12">
				<input id = "findAddr" onclick="findAddr()" type="text" class="form-control"
					placeholder="주소를 입력해주세요.">
				
				<div class="input-group-append">
					<button id="search" class="btn btn-info">찾 기</button>
				</div>
			</div>
		</div>
	</div>
	<div class="row m-3">
		<div class="col-sm-6">
				<div id="map" style="width: 100%; height: 100%;"></div>
			</div>
		<div class="col-sm-6 ">
			<div class="bg-light col-12 p-2">
				<form>
					<h3>판매처 정보</h3>
					<div class="form-group m-5">
						<i class="fas fa-first-aid">&nbsp판매처 : </i><label id="content"></label><br/>
						<i class="fas fa-map-marker-alt">&nbsp주 소 : </i><label id="addr"></label><br/>
						<i class="fas fa-people-carry">&nbsp재고 상태 : </i><label id="state"></label><br/>
						<i class="fas fa-clock">&nbsp데이터 생성 일자 : </i><label id="created_at"></label><br/>
						<i class="fas fa-clock">&nbsp입고 예정 시간 : </i><label id="stock_at"></label><br/>
					</div>
				</form>
			</div>
			<br/>
			<br/>
			<br/>
			
			<div class="bg-light col-12 p-2">
				<form>
					<h3>마스크 5부제 Q&A</h3>
					<br />
					<div class="form-group p-5">
						<i class="fas fa-comment-dots"></i><label>무슨 요일에 구매할 수 있을까?</label><br/>
						<i class="far fa-grin"></i><label>출생연도 끝자리 1.6-월요일 2.7-화요일 3.8-수요일 4.9-목요일 5.0-금요일</label><br/>
						<p>*주말은 주중 미구매자 구매 가능</p>
						<i class="fas fa-comment-dots"></i><label>몇개씩 살 수 있나?</label><br/>
						<i class="far fa-grin"></i><label>1주일(월~일) 최대 2개만 가능</label><br/>
						<p>*개수 제한은 주별로 리셋</p>
						<p>*이번주에 못 샀다고 다음 주에 한도가 4개로 늘지 않음</p>
						<i class="fas fa-comment-dots"></i><label>확인은 어떻게하나?</label><br/>
						<i class="far fa-grin"></i><label>성인:신분증(주민등록증,운전면허증,여권 등)지참</label><br/>
						<p>*외국인 : 본인이 직접 건강보험증과 외국인등록증을 함께 제시</p>
						<i class="fas fa-comment-dots"></i><label>부모가 자녀 마스크를 살 수 있나?</label><br/>
						<i class="far fa-grin"></i><label>대리 구매는 원칙적으로 금지</label>
						<p>*미성년자 : 본인만 가면 여권/학생증/주민등록등본등으로 본인 확인.부모(법정대리인)와 함께 가면 부모 신분증과 주민등록등본 제시해야함</p>
						<p>*장애인 : 대리인이 장애인등록증 지참하면 구매 가능</p>
						<i class="fas fa-comment-dots"></i><label>대형마트나 편의점에선 못사나?</label><br/>
						<i class="far fa-grin"></i><label>사실상 사기 어렵다. 생산량의 80%를 약국, 읍면 우체국, 하나로마트 등 공적 판매처에서 판매하기 때문</label>
						<p>자료 : 기획재정부 </p>
					</div>
				</form>
			</div>
				
			</div>
			
		</div>








	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f04f63bc7ba3988d60d8cdd3f8221ebf&libraries=services,clusterer,drawing"></script>
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
<script src="../resources/static/js/maskCount.js"></script>
	<br/>
	<div class="jumbotron text-center" >
		<p>Create by seoha Tel +01038204030</p>
		<p>email mooo4030@naver.com</p>
	</div>
</body>
</html>
