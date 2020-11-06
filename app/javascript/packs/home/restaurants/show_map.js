"use strict";


let map_canvas = document.getElementById("map_canvas");
let latitude = Number(document.getElementById("latitude").value);
let longitude = Number(document.getElementById("longitude").value);
let gps_fixed = document.getElementById("gps_fixed");
let point =  { lat: latitude, lng: longitude};
let map;
let gps_marker = null;
let directionsService = new google.maps.DirectionsService();
let directionsRenderer = new google.maps.DirectionsRenderer({suppressMarkers: true}); //suppressMarkers: true // デフォルトのマーカーを削除
let directionsServiceWork = new google.maps.DirectionsService();
let directionsRendererWork = new google.maps.DirectionsRenderer({suppressMarkers: true,
      polylineOptions: {
      strokeColor: '#00ff7f',
      strokeOpacity: 0.6,
      strokeWeight: 5}
}); //suppressMarkers: true // デフォルトのマーカーを削除
let marker = null;

gps_fixed.addEventListener('click', function() {
  show_current_location();
});


  console.log(point);
  map = new google.maps.Map(map_canvas, {
    center: point,
    zoom: 17,
    mapTypeControl: false,
    zoomControl: true,
    streetViewControl: false,
  });

//マーカーをデフォルトセット
    marker = new google.maps.Marker({
    position: point,
    map: map,
    title: document.getElementById("restaurant_name").innerHTML,
    animation: google.maps.Animation.DROP,
  });



// イベント
function show_current_location(){

  console.log('clickイベント');
  if (!navigator.geolocation) {
      alert('GoogleのGeolocationサービスが使用できません。');
      return;
  };
  console.log('clickイベント２');
  navigator.geolocation.getCurrentPosition(function(position) {
    let lat = position.coords.latitude;
    let lng =  position.coords.longitude;
    let latlng = {lat: lat, lng: lng};
    let center_position = new google.maps.LatLng(lat,lng);
        let image = new google.maps.MarkerImage(
            '../../../../assets/source-bluedot.png',
            null, // size
            null, // origin
            new google.maps.Point( 8, 8 ), // anchor (move to center of marker)
            new google.maps.Size( 17, 17 ) // scaled size (required for Retina display icon)
        );
    console.log(latlng);

    map.setCenter(center_position)
    // アイコンクリア
    if (gps_marker !== null){
        gps_marker.setMap(null);
    };
    gps_marker = new google.maps.Marker({
      flat: true,//・・・・・・アイコンにtrueで影を付けない
      icon: image,
      position: latlng,
      map: map,
      optimized: false,
      animation: google.maps.Animation.DROP,
      title: "現在地",
      visible: true
    });
    //     marker.setMap(null);
    // ルート描画
    getRoute(latlng);
    getRouteWork(latlng);
    // 距離描画
    getDestance(lat,lng);
    getDestanceWork(lat,lng);
    // 表示
        let mapinfo = document.getElementById('mapinfo');
        mapinfo.classList.remove('display-none');
  },
  function () {
  alert("現在地が取得できませんでした。");
  return;
  });
};

//ルート描画用
function getRoute(latlng){
  let request = {
    origin: latlng, //入力地点の緯度、経度
    destination: point, //到着地点の緯度、経度
    travelMode: google.maps.DirectionsTravelMode.DRIVING //ルートの種類
  }
  directionsService.route(request,function(result, status){
    directionsRenderer.setDirections(result); //取得した情報をset
    directionsRenderer.setMap(map); //マップに描画
  });
}

//ルート描画用
function getRouteWork(latlng){
  let request = {
    origin: latlng, //入力地点の緯度、経度
    destination: point, //到着地点の緯度、経度
    travelMode: google.maps.DirectionsTravelMode.WALKING //ルートの種類
  }
  directionsServiceWork.route(request,function(result, status){
    directionsRendererWork.setDirections(result); //取得した情報をset
    directionsRendererWork.setMap(map); //マップに描画
  });
}

// 距離取得
function getDestance(gpslat,gpslng){

  // DistanceMatrix サービスを生成
  let distanceMatrixService = new google.maps.DistanceMatrixService();

  // 出発点
  let origns = [new google.maps.LatLng(gpslat, gpslng)];
  // 到着点
  let destinations = [new google.maps.LatLng(latitude, longitude)];

  // DistanceMatrix の実行
  distanceMatrixService.getDistanceMatrix({
    origins: origns, // 出発地点
    destinations: destinations, // 到着地点
    travelMode: google.maps.TravelMode.DRIVING, // 車モード or 徒歩モード
    unitSystem: google.maps.UnitSystem.METRIC,
    avoidHighways: ture,
    avoidTolls: false
    // drivingOptions: { // 車モードの時のみ有効
    //   departureTime: new Date('2017/5/5 10:00:00'), // 2017年5月5日
    //   trafficModel: google.maps.TrafficModel.BEST_GUESS // 最適な検索
    // }
  }, function(response, status) {
    if (status == google.maps.DistanceMatrixStatus.OK) {

      // 出発地点と到着地点の住所（配列）を取得
      var origins = response.originAddresses;
      var destinations = response.destinationAddresses;

      // 出発地点でループ
      for (var i=0; i<origins.length; i++) {
        // 出発地点から到着地点への計算結果を取得
        var results = response.rows[i].elements;

        // 到着地点でループ
        for (var j = 0; j<results.length; j++) {
          // var from = origins[i]; // 出発地点の住所
          // var to = destinations[j]; // 到着地点の住所
          document.getElementById("distance").innerText = '距離：' + results[j].distance.text + '　'; // 距離
          document.getElementById("duration").innerText = '時間：' + results[j].duration.text; // 時間
          // console.log("{},{},{},{}", from,  to, duration, distance);
        }
      }
    }
  });
}

// 距離取得
function getDestanceWork(gpslat,gpslng){

  // DistanceMatrix サービスを生成
  let distanceMatrixService = new google.maps.DistanceMatrixService();

  // 出発点
  let origns = [new google.maps.LatLng(gpslat, gpslng)];
  // 到着点
  let destinations = [new google.maps.LatLng(latitude, longitude)];

  // DistanceMatrix の実行
  distanceMatrixService.getDistanceMatrix({
    origins: origns, // 出発地点
    destinations: destinations, // 到着地点
    travelMode: google.maps.TravelMode.WALKING, // 車モード or 徒歩モード
    unitSystem: google.maps.UnitSystem.METRIC,
    avoidHighways: false,
    avoidTolls: false
    // drivingOptions: { // 車モードの時のみ有効
    //   departureTime: new Date('2017/5/5 10:00:00'), // 2017年5月5日
    //   trafficModel: google.maps.TrafficModel.BEST_GUESS // 最適な検索
    // }
  }, function(response, status) {
    if (status == google.maps.DistanceMatrixStatus.OK) {

      // 出発地点と到着地点の住所（配列）を取得
      var origins = response.originAddresses;
      var destinations = response.destinationAddresses;

      // 出発地点でループ
      for (var i=0; i<origins.length; i++) {
        // 出発地点から到着地点への計算結果を取得
        var results = response.rows[i].elements;

        // 到着地点でループ
        for (var j = 0; j<results.length; j++) {
          // var from = origins[i]; // 出発地点の住所
          // var to = destinations[j]; // 到着地点の住所
          document.getElementById("distance-work").innerText = '距離：' + results[j].distance.text + '　'; // 距離
          document.getElementById("duration-work").innerText = '時間：' + results[j].duration.text; // 時間
          // console.log("{},{},{},{}", from,  to, duration, distance);
        }
      }
    }
  });
}

