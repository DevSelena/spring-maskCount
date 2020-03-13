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
            	var roadAddr = data.roadAddress;
               	document.getElementById("findAddr").value = roadAddr;
            	close();
               }
        }).open();
    }
// * 주소 팝업 끝


      


// * 지도 이동시키기 시작
			
		
	$('#search').on('click', function() {
		var center = document.getElementById("findAddr").value;
		var geocoder = new kakao.maps.services.Geocoder();
	 	geocoder.addressSearch(center, function(result, status) {
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
    			var greenSrc = 'https://cdn2.iconfinder.com/data/icons/colored-flags/154/green-flag-512.png',
   				imageSize = new kakao.maps.Size(34, 39), 
       		    imageOption = {offset: new kakao.maps.Point(27, 69)};
    
    			var yellowSrc ='https://cdn2.iconfinder.com/data/icons/colored-flags/154/yellow-flag-512.png',
   				imageSize = new kakao.maps.Size(34, 39),
       		    imageOption = {offset: new kakao.maps.Point(27, 69)};
  
    			var graySrc = 'https://cdn2.iconfinder.com/data/icons/colored-flags/154/black-flag-512.png',
   				imageSize = new kakao.maps.Size(34, 39), 
       		    imageOption = {offset: new kakao.maps.Point(27, 69)}; 
       		    
    			var redSrc = 'https://cdn2.iconfinder.com/data/icons/colored-flags/154/red-flag-512.png', 
    		    imageSize = new kakao.maps.Size(34, 39), 
    		    imageOption = {offset: new kakao.maps.Point(27, 69)}; 
    		    
	   		    var xSrc='https://cdn0.iconfinder.com/data/icons/web/512/e52-512.png',
   		    	imageSize = new kakao.maps.Size(35, 35), 
       		    imageOption = {offset: new kakao.maps.Point(27, 69)};
	       		   
    		    var markergreenSrc = new kakao.maps.MarkerImage(greenSrc, imageSize, imageOption);
    		    var markeryellowSrc = new kakao.maps.MarkerImage(yellowSrc, imageSize, imageOption);
    		    var markergraySrc = new kakao.maps.MarkerImage(graySrc, imageSize, imageOption);
    		    var markerredSrc = new kakao.maps.MarkerImage(redSrc, imageSize, imageOption);
    		    var markerxSrc = new kakao.maps.MarkerImage(xSrc, imageSize, imageOption);
    		    
    			var plentys = [];
    			var somes = [];
    			var fews = [];
    			var emptys = [];
    			var breakks = [];
    			
    			for (i =0 ; i<r.count ; i++){
	   				var latM = r.stores[i].lat;
	   				var lngM = r.stores[i].lng;
	    				if(r.stores[i].remain_stat == 'plenty'){
							var plenty = {
	    						content : r.stores[i].name, addr : r.stores[i].addr, 
	    						remain_stat : r.stores[i].remain_stat, 
	    						created_at : r.stores[i].created_at,stock_at : r.stores[i].stock_at, 
	    						latlng : new kakao.maps.LatLng(latM,lngM)};
							plentys.push(plenty);
					}else if(r.stores[i].remain_stat == 'some'){
						var some = {
	    						content : r.stores[i].name, addr : r.stores[i].addr, 
	    						remain_stat : r.stores[i].remain_stat, 
	    						created_at : r.stores[i].created_at,stock_at : r.stores[i].stock_at, 
	    						latlng : new kakao.maps.LatLng(latM,lngM)};
						somes.push(some);
					}else if(r.stores[i].remain_stat == 'few'){
						var few = {
	    						content : r.stores[i].name, addr : r.stores[i].addr, 
	    						remain_stat : r.stores[i].remain_stat, 
	    						created_at : r.stores[i].created_at,stock_at : r.stores[i].stock_at, 
	    						latlng : new kakao.maps.LatLng(latM,lngM)};
						fews.push(few);
					}else if(r.stores[i].remain_stat == 'empty'){
						var empty = {
	    						content : r.stores[i].name, addr : r.stores[i].addr, 
	    						remain_stat : r.stores[i].remain_stat, 
	    						created_at : r.stores[i].created_at,stock_at : r.stores[i].stock_at, 
	    						latlng : new kakao.maps.LatLng(latM,lngM)};
						emptys.push(empty);
					}else if(r.stores[i].remain_stat == 'break'){
						var breakk = {
	    						content : r.stores[i].name, addr : r.stores[i].addr, 
	    						remain_stat : r.stores[i].remain_stat, 
	    						created_at : r.stores[i].created_at,stock_at : r.stores[i].stock_at, 
	    						latlng : new kakao.maps.LatLng(latM,lngM)};
						breakks.push(breakk);
					}
	    			
    			} 
    			
    			
    		    for (var i = 0; i < plentys.length; i++) {
    	
    				var content = plentys[i].content;
    				var addr = plentys[i].addr;
    				var remain_stat = plentys[i].remain_stat;
    				var created_at = plentys[i].created_at;
    				var stock_at = plentys[i].stock_at;
    				var state='100개 이상';

    				var marker = new kakao.maps.Marker({
    					map : map,
    					position : plentys[i].latlng, // 마커의 위치
    					clickable : true,
    					image: markergreenSrc
    				});

    		
    				var infowindow = new kakao.maps.InfoWindow({
    					content : plentys[i].content
    
    				});

    				kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(
    						map, marker, infowindow));
    				kakao.maps.event.addListener(marker, 'click', makeClickListener(
    						map, marker, infowindow,content,addr,state,created_at,stock_at));
    				kakao.maps.event.addListener(marker, 'mouseout',
    						makeOutListener(infowindow));
    			} 
    			
    		    for (var i = 0; i < somes.length; i++) {
    				var content = somes[i].content;
    				var addr = somes[i].addr;
    				var remain_stat = somes[i].remain_stat;
    				var created_at = somes[i].created_at;
    				var stock_at = somes[i].stock_at;
    				var state='30~100개 미만';

    				var marker = new kakao.maps.Marker({
    					map : map, 
    					position : somes[i].latlng, 
    					clickable : true,
    					image: markeryellowSrc
    				});

    
    				var infowindow = new kakao.maps.InfoWindow({
    					content : somes[i].content

    				});


    				kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(
    						map, marker, infowindow));
    				kakao.maps.event.addListener(marker, 'click', makeClickListener(
    						map, marker, infowindow,content,addr,state,created_at,stock_at));
    				kakao.maps.event.addListener(marker, 'mouseout',
    						makeOutListener(infowindow));
    			} 
    		    
    		    for (var i = 0; i < fews.length; i++) {

    				var content = fews[i].content;
    				var addr = fews[i].addr;
    				var remain_stat = fews[i].remain_stat;
    				var created_at = fews[i].created_at;
    				var stock_at = fews[i].stock_at;
    				var state='2~30개 미만';

    				var marker = new kakao.maps.Marker({
    					map : map,
    					position : fews[i].latlng,
    					clickable : true,
    					image: markergraySrc
    				});


    				var infowindow = new kakao.maps.InfoWindow({
    					content : fews[i].content

    				});


    				kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(
    						map, marker, infowindow));
    				kakao.maps.event.addListener(marker, 'click', makeClickListener(
    						map, marker, infowindow,content,addr,state,created_at,stock_at));
    				kakao.maps.event.addListener(marker, 'mouseout',
    						makeOutListener(infowindow));
    			} 
    		    
    		    for (var i = 0; i < emptys.length; i++) {
    				var content = emptys[i].content;
    				var addr = emptys[i].addr;
    				var remain_stat = emptys[i].remain_stat;
    				var created_at = emptys[i].created_at;
    				var stock_at = emptys[i].stock_at;
    				var state='1개 이하';

    				var marker = new kakao.maps.Marker({
    					map : map, 
    					position : emptys[i].latlng,
    					clickable : true,
    					image: markerredSrc
    				});

   
    				var infowindow = new kakao.maps.InfoWindow({
    					content : emptys[i].content

    				});

   
    				kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(
    						map, marker, infowindow));
    				kakao.maps.event.addListener(marker, 'click', makeClickListener(
    						map, marker, infowindow,content,addr,state,created_at,stock_at));
    				kakao.maps.event.addListener(marker, 'mouseout',
    						makeOutListener(infowindow));
    			} 
    		    
    		    for (var i = 0; i < breakks.length; i++) {
    				var content = breakks[i].content;
    				var addr = breakks[i].addr;
    				var remain_stat = breakks[i].remain_stat;
    				var created_at = breakks[i].created_at;
    				var stock_at = breakks[i].stock_at;
    				var state='판매 중지';

    				var marker = new kakao.maps.Marker({
    					map : map, 
    					position : breakks[i].latlng,
    					clickable : true,
    					image: markerxSrc
    				});
    				var infowindow = new kakao.maps.InfoWindow({
    					content : breakks[i].content
    				});

    				kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(
    						map, marker, infowindow));
    				kakao.maps.event.addListener(marker, 'click', makeClickListener(
    						map, marker, infowindow,content,addr,state,created_at,stock_at));
    				kakao.maps.event.addListener(marker, 'mouseout',
    						makeOutListener(infowindow));
    			} 
    		}).fail(function(r) {
    			alert('실패');
    		});
    			
       	     }
       	});
	 	
	
		
	});