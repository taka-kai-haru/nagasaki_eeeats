"use strict";


var target = document.getElementById("target");
let latitude = Number(document.getElementById("latitude").value);
let longitude = Number(document.getElementById("longitude").value);
let gps_fixed = document.getElementById("gps_fixed");
let point =  { lat: latitude, lng: longitude};
let map;
let gps_marker = null;
let directionsService = new google.maps.DirectionsService();


// function initMap() {
  console.log(point);
  map = new google.maps.Map(target, {
    center: point,
    zoom: 17,
    mapTypeControl: false,
    zoomControl: true,
    streetViewControl: false,
  });

//マーカーをデフォルトセット
  let marker = new google.maps.Marker({
    position: point,
    map: map,
    title: document.getElementById("restaurant_name").innerHTML,
    animation: google.maps.Animation.DROP,
  });

// };
//
// // InvalidValueError: initMap is not a functionの対応
// window.onload = function () {
//   initMap();
// };

// イベント
gps_fixed.addEventListener('click', (event) => {
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
    console.log(latlng);

    map.setCenter(center_position)
    // アイコンクリア
    if (gps_marker !== null){
        gps_marker.setMap(null);
    };
    gps_marker = new google.maps.Marker({
      position: latlng,
      map: map,
      animation: google.maps.Animation.DROP,
      title: "現在地",
    });
    // ルート描画
    getRoute(latlng);
  },
  function () {
  alert("現在地が取得できませんでした。");
  return;
  });
});

//ルート描画用
function getRoute(latlng){
  let request = {
    origin: latlng, //入力地点の緯度、経度
    destination: point, //到着地点の緯度、経度
    travelMode: google.maps.DirectionsTravelMode.WALKING //ルートの種類
  }
  directionsService.route(request,function(result, status){
    toRender(result);
  });
}

function toRender(result){
  directionsDisplay = new google.maps.DirectionsRenderer();
  directionsDisplay.setDirections(result); //取得した情報をset
  directionsDisplay.setMap(map); //マップに描画
}



