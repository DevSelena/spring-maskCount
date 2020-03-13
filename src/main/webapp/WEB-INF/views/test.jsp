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
<link rel="shortcut icon" href="../resources/01.png">
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
	<script>
// * 지도 그리기 시작
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center : new kakao.maps.LatLng(35.158052, 129.059196), //지도의 중심좌표.
			level : 3
		//지도의 레벨(확대, 축소 정도)
		};

		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
// * 지도 그리기 끝

// * 마커의 이벤트 시작
		function makeClickListener(map, marker, infowindow, content,addr,state,created_at,stock_at) {
			return function() {
				$('#contentM').remove();
				$('#addrM').remove();
				$('#stateM').remove();
				$('#created_atM').remove();
				$('#stock_atM').remove();
				
				
				
				$('#content').append("<strong id ='contentM'>"+content+"</strong>");
				$('#addr').append("<strong id ='addrM'>"+addr+"</strong>");
				$('#state').append("<strong id ='stateM'>"+state+"</strong>");
				$('#created_at').append("<strong id ='created_atM'>"+created_at+"</strong>");
				$('#stock_at').append("<strong id ='stock_atM'>"+stock_at+"</strong>");
				infowindow.open(map, marker);
			};
		}

		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
		function makeOverListener(map, marker, infowindow) {
			return function() {
				infowindow.open(map, marker);
			};
		}

		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow) {
			return function() {
				infowindow.close();
			};
		}
// * 마커 이벤트 끝

// * 주소 팝업 시작

	function findAddr() {
        new daum.Postcode({
            oncomplete: function(data) {
            	var roadAddr = data.roadAddress; // 도로명 주소 변수
               	document.getElementById("findAddr").value = roadAddr;
            	close();
               }
        }).open();
    }
// * 주소 팝업 끝


      


// * 지도 이동시키기 시작
			
		
	$('#search').on('click', function() {
		//주소를 기준으로 지도 이동 시작 
		var center = document.getElementById("findAddr").value;
		var geocoder = new kakao.maps.services.Geocoder();
	 	geocoder.addressSearch(center, function(result, status) {
       	    // 정상적으로 검색이 완료됐으면 
       	     if (status === kakao.maps.services.Status.OK) {
       	    	var lat = result[0].y;
       	    	var lng = result[0].x;
       	   		var coords = new kakao.maps.LatLng(lat, lng);
       	     	map.setCenter(coords);
		
			
       	  	var myurl = 'https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByGeo/json?lat='+lat+'&lng='+lng+'&m=5000';
    			$.ajax({
    			url : myurl,
    			type : 'GET'
    		}).done(function(r) {
    			// * 마커 이미지 생성 시작
    			var greenSrc = 'https://cdn2.iconfinder.com/data/icons/basic-thin-line-color/21/09_1-512.png',
   				imageSize = new kakao.maps.Size(34, 39), 
       		    imageOption = {offset: new kakao.maps.Point(27, 69)};
    
    			var yellowSrc ='https://cdn2.iconfinder.com/data/icons/ecology-filled-line-4/88/pin_electric_power_energy_point_station_charge-512.png',
   				imageSize = new kakao.maps.Size(34, 39),
       		    imageOption = {offset: new kakao.maps.Point(27, 69)};
  
    			var graySrc = 'https://cdn3.iconfinder.com/data/icons/social-media-tools/30/map_point-512.png',
   				imageSize = new kakao.maps.Size(34, 39), 
       		    imageOption = {offset: new kakao.maps.Point(27, 69)}; 
       		    
    			
    			var redSrc = 'https://cdn2.iconfinder.com/data/icons/basic-thin-line-color/21/09_2-512.png', 
    		    imageSize = new kakao.maps.Size(34, 39), 
    		    imageOption = {offset: new kakao.maps.Point(27, 69)}; 
    		    
	   		    var xSrc='https://cdn0.iconfinder.com/data/icons/web/512/e52-512.png',
   		    	imageSize = new kakao.maps.Size(34, 39), 
       		    imageOption = {offset: new kakao.maps.Point(27, 69)};
	       		   
    		    var markergreenSrc = new kakao.maps.MarkerImage(greenSrc, imageSize, imageOption);
    		    var markeryellowSrc = new kakao.maps.MarkerImage(yellowSrc, imageSize, imageOption);
    		    var markergraySrc = new kakao.maps.MarkerImage(graySrc, imageSize, imageOption);
    		    var markerredSrc = new kakao.maps.MarkerImage(redSrc, imageSize, imageOption);
    		    var markerxSrc = new kakao.maps.MarkerImage(xSrc, imageSize, imageOption);
    		    
    		    //* 마커이미지생성 끝
    		
    			console.log(r);
    			
    			var plentys = [];
    			var somes = [];
    			var fews = [];
    			var emptys = [];
    			var breakks = [];
    			
    			for (i =0 ; i<r.count ; i++){
	   				var latM = r.stores[i].lat;
	   				var lngM = r.stores[i].lng;
	    				if(r.stores[i].remain_stat == 'plenty'){
							console.log(r.stores[i].name+'녹색/100개 이상');
							var plenty = {
	    						content : r.stores[i].name, addr : r.stores[i].addr, 
	    						remain_stat : r.stores[i].remain_stat, 
	    						created_at : r.stores[i].created_at,stock_at : r.stores[i].stock_at, 
	    						latlng : new kakao.maps.LatLng(latM,lngM)};
							plentys.push(plenty);
					}
					if(r.stores[i].remain_stat == 'some'){
						console.log(r.stores[i].name+'노랑/30~99개');
						var some = {
	    						content : r.stores[i].name, addr : r.stores[i].addr, 
	    						remain_stat : r.stores[i].remain_stat, 
	    						created_at : r.stores[i].created_at,stock_at : r.stores[i].stock_at, 
	    						latlng : new kakao.maps.LatLng(latM,lngM)};
						somes.push(some);
					}
					if(r.stores[i].remain_stat == 'few'){
						console.log(r.stores[i].name+'빨강/2개~30개');
						var few = {
	    						content : r.stores[i].name, addr : r.stores[i].addr, 
	    						remain_stat : r.stores[i].remain_stat, 
	    						created_at : r.stores[i].created_at,stock_at : r.stores[i].stock_at, 
	    						latlng : new kakao.maps.LatLng(latM,lngM)};
						fews.push(few);
					}
					if(r.stores[i].remain_stat == 'empty'){
						console.log(r.stores[i].name+'회식/없음');
						var empty = {
	    						content : r.stores[i].name, addr : r.stores[i].addr, 
	    						remain_stat : r.stores[i].remain_stat, 
	    						created_at : r.stores[i].created_at,stock_at : r.stores[i].stock_at, 
	    						latlng : new kakao.maps.LatLng(latM,lngM)};
						emptys.push(empty);
					}
					if(r.stores[i].remain_stat == 'break'){
						console.log(r.stores[i].name+'판매중지');
						var breakk = {
	    						content : r.stores[i].name, addr : r.stores[i].addr, 
	    						remain_stat : r.stores[i].remain_stat, 
	    						created_at : r.stores[i].created_at,stock_at : r.stores[i].stock_at, 
	    						latlng : new kakao.maps.LatLng(latM,lngM)};
						breakks.push(breakk);
					}
	    			
    			} 
    			
    			
    		    for (var i = 0; i < plentys.length; i++) {
    				// 마커를 생성합니다
    				var content = plentys[i].content;
    				var addr = plentys[i].addr;
    				var remain_stat = plentys[i].remain_stat;
    				var created_at = plentys[i].created_at;
    				var stock_at = plentys[i].stock_at;
    				var state='100개 이상';

    				var marker = new kakao.maps.Marker({
    					map : map, // 마커를 표시할 지도
    					position : plentys[i].latlng, // 마커의 위치
    					clickable : true,
    					image: markergreenSrc
    				});

    				// 마커에 표시할 인포윈도우를 생성합니다 
    				var infowindow = new kakao.maps.InfoWindow({
    					content : plentys[i].content
    				// 인포윈도우에 표시할 내용
    				});

    				// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    				// 이벤트 리스너로는 클로저를 만들어 등록합니다 
    				// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    				kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(
    						map, marker, infowindow));
    				kakao.maps.event.addListener(marker, 'click', makeClickListener(
    						map, marker, infowindow,content,addr,state,created_at,stock_at));
    				kakao.maps.event.addListener(marker, 'mouseout',
    						makeOutListener(infowindow));
    			} 
    			
    		    for (var i = 0; i < somes.length; i++) {
    				// 마커를 생성합니다
    				var content = somes[i].content;
    				var addr = somes[i].addr;
    				var remain_stat = somes[i].remain_stat;
    				var created_at = somes[i].created_at;
    				var stock_at = somes[i].stock_at;
    				var state='30~100개 미만';

    				var marker = new kakao.maps.Marker({
    					map : map, // 마커를 표시할 지도
    					position : somes[i].latlng, // 마커의 위치
    					clickable : true,
    					image: markeryellowSrc
    				});

    				// 마커에 표시할 인포윈도우를 생성합니다 
    				var infowindow = new kakao.maps.InfoWindow({
    					content : somes[i].content
    				// 인포윈도우에 표시할 내용
    				});

    				// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    				// 이벤트 리스너로는 클로저를 만들어 등록합니다 
    				// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    				kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(
    						map, marker, infowindow));
    				kakao.maps.event.addListener(marker, 'click', makeClickListener(
    						map, marker, infowindow,content,addr,state,created_at,stock_at));
    				kakao.maps.event.addListener(marker, 'mouseout',
    						makeOutListener(infowindow));
    			} 
    		    
    		    for (var i = 0; i < fews.length; i++) {
    				// 마커를 생성합니다
    				var content = fews[i].content;
    				var addr = fews[i].addr;
    				var remain_stat = fews[i].remain_stat;
    				var created_at = fews[i].created_at;
    				var stock_at = fews[i].stock_at;
    				var state='2~30개 미만';

    				var marker = new kakao.maps.Marker({
    					map : map, // 마커를 표시할 지도
    					position : fews[i].latlng, // 마커의 위치
    					clickable : true,
    					image: markergraySrc
    				});

    				// 마커에 표시할 인포윈도우를 생성합니다 
    				var infowindow = new kakao.maps.InfoWindow({
    					content : fews[i].content
    				// 인포윈도우에 표시할 내용
    				});

    				// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    				// 이벤트 리스너로는 클로저를 만들어 등록합니다 
    				// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    				kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(
    						map, marker, infowindow));
    				kakao.maps.event.addListener(marker, 'click', makeClickListener(
    						map, marker, infowindow,content,addr,state,created_at,stock_at));
    				kakao.maps.event.addListener(marker, 'mouseout',
    						makeOutListener(infowindow));
    			} 
    		    
    		    for (var i = 0; i < emptys.length; i++) {
    				// 마커를 생성합니다
    				var content = emptys[i].content;
    				var addr = emptys[i].addr;
    				var remain_stat = emptys[i].remain_stat;
    				var created_at = emptys[i].created_at;
    				var stock_at = emptys[i].stock_at;
    				var state='0~1개';

    				var marker = new kakao.maps.Marker({
    					map : map, // 마커를 표시할 지도
    					position : emptys[i].latlng, // 마커의 위치
    					clickable : true,
    					image: markerredSrc
    				});

    				// 마커에 표시할 인포윈도우를 생성합니다 
    				var infowindow = new kakao.maps.InfoWindow({
    					content : emptys[i].content
    				// 인포윈도우에 표시할 내용
    				});

    				// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    				// 이벤트 리스너로는 클로저를 만들어 등록합니다 
    				// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    				kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(
    						map, marker, infowindow));
    				kakao.maps.event.addListener(marker, 'click', makeClickListener(
    						map, marker, infowindow,content,addr,state,created_at,stock_at));
    				kakao.maps.event.addListener(marker, 'mouseout',
    						makeOutListener(infowindow));
    			} 
    		    
    		    for (var i = 0; i < breakks.length; i++) {
    				// 마커를 생성합니다
    				var content = breakks[i].content;
    				var addr = breakks[i].addr;
    				var remain_stat = breakks[i].remain_stat;
    				var created_at = breakks[i].created_at;
    				var stock_at = breakks[i].stock_at;
    				var state='100개 이상';

    				var marker = new kakao.maps.Marker({
    					map : map, // 마커를 표시할 지도
    					position : breakks[i].latlng, // 마커의 위치
    					clickable : true,
    					image: markerxSrc
    				});

    				// 마커에 표시할 인포윈도우를 생성합니다 
    				var infowindow = new kakao.maps.InfoWindow({
    					content : breakks[i].content
    				// 인포윈도우에 표시할 내용
    				});

    				// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    				// 이벤트 리스너로는 클로저를 만들어 등록합니다 
    				// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    				kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(
    						map, marker, infowindow));
    				kakao.maps.event.addListener(marker, 'click', makeClickListener(
    						map, marker, infowindow,content,addr,state,created_at,stock_at));
    				kakao.maps.event.addListener(marker, 'mouseout',
    						makeOutListener(infowindow));
    			} 
    		    
    		    
    		    
    			
    			
    			
    			
    			
    				
    
    				
    				
    				
    				/* if(r.stores[i].remain_stat == 'plenty'){
					console.log(r.stores[i].name+'녹색/100개 이상');
					plentys.push(new kakao.maps.LatLng(latM, lngM))
				}
				if(r.stores[i].remain_stat == 'some'){
					console.log(r.stores[i].name+'노랑/30~99개');
					somes.push(new kakao.maps.LatLng(latM, lngM))
				}
				if(r.stores[i].remain_stat == 'few'){
					console.log(r.stores[i].name+'빨강/2개~30개');
					fews.push(new kakao.maps.LatLng(latM, lngM))
				}
				if(r.stores[i].remain_stat == 'empty'){
					console.log(r.stores[i].name+'회식/없음');
					emptys.push(new kakao.maps.LatLng(latM, lngM))
				}
				if(r.stores[i].remain_stat == 'break'){
					breakks.push(new kakao.maps.LatLng(latM, lngM))
				} */
				
				
				
    			
    			
/*     			console.log(plentys.length);
    			console.log(somes.length);
    			console.log(fews.length);
    			console.log(emptys.length);
    			console.log(breakks.length); */
    	
    		/* 	for (var i = 0; i < positions.length; i++) {
    				// 마커를 생성합니다
    				var content = positions[i].content;
    				var addr = positions[i].addr;
    				var remain_stat = positions[i].remain_stat;
    				var created_at = positions[i].created_at;
    				var stock_at = positions[i].stock_at;
    				
    				var state='';
    				
    				if(remain_stat =='empty'){
    					state = '없음'; 
    				} else if(remain_stat =='few'){
    					state = '2개~30개 미만'; 
    				} else if(remain_stat =='some'){
    					state = '30개~100개 미만'; 
    				} else if(remain_stat =='plenty'){
    					state = '100개 이상'; 
    				} else{
    					state = '알 수 없음'; 
    				}
    				
    				
    				
    				var marker = new kakao.maps.Marker({
    					map : map, // 마커를 표시할 지도
    					position : positions[i].latlng, // 마커의 위치
    					clickable : true
    					image: markerImage
    				});

    				// 마커에 표시할 인포윈도우를 생성합니다 
    				var infowindow = new kakao.maps.InfoWindow({
    					content : positions[i].content
    				// 인포윈도우에 표시할 내용
    				});

    				// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    				// 이벤트 리스너로는 클로저를 만들어 등록합니다 
    				// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    				kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(
    						map, marker, infowindow));
    				kakao.maps.event.addListener(marker, 'click', makeClickListener(
    						map, marker, infowindow,content,addr,state,created_at,stock_at));
    				kakao.maps.event.addListener(marker, 'mouseout',
    						makeOutListener(infowindow));
    			} */
    			//마커를 찾아 찍는 곳
    			
    		}).fail(function(r) {
    			alert('실패');
    		});
    			
       	     }
       	});
	 	//주소를 기준으로 지도 이동 종료
		
	 	
	 	
	 	
		
	});
	</script>

	<br/>
	<div class="jumbotron text-center" >
		<p>Create by seoha Tel +01038204030</p>
		<p>email mooo4030@naver.com</p>
	</div>
</body>
</html>
