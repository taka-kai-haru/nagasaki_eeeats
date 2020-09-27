"use strict";
var target = document.getElementById("target");
let latitude = Number(document.getElementById("latitude").value);
let longitude = Number(document.getElementById("longitude").value);
let gps_fixed = document.getElementById("gps_fixed");
let point =  { lat: latitude, lng: longitude};
let map;
let gps_marker = null;

console.log(point);
map = new google.maps.Map(target, {
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
  },
  function () {
  alert("現在地が取得できませんでした。");
  return;
  });
});


