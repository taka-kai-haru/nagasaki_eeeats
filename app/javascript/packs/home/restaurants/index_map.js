'use strict';

let target = document.getElementById('target');
const def_lat = Number(document.getElementById('gmap_def_lat').value);
const def_lng = Number(document.getElementById('gmap_def_lng').value);
const restaurants_count = Number(
  document.getElementById('restaurants_count').value
);
let gps_fixed = document.getElementById('gps_fixed');
let point = null;
let data = [];
let gps_marker = null;
let map = null;

function initMap() {

    for (let i = 0; i < restaurants_count; i++) {
        data[i] = {
            name: document.getElementById('restaurant_name' + i).innerHTML,
            lat: Number(document.getElementById('latitude' + i).value),
            lng: Number(document.getElementById('longitude' + i).value),
        };
    }


    point = {lat: def_lat, lng: def_lng};


// マップ作成
    map = new google.maps.Map(target, {
        center: point,
        zoom: 17,
        maxZoom: 17,
        minZoom: 8,
        mapTypeControl: false,
        zoomControl: true,
        streetViewControl: false,
        // disableDefaultUI: true,
        // zoomControl: true,
    });

    for (let i = 0; i < data.length; i++) {
        // マーカーを生成
        let marker = new google.maps.Marker({
            position: new google.maps.LatLng(data[i].lat, data[i].lng),
            map: map,
            animation: google.maps.Animation.DROP,
            title: data[i].name,
            label: String(i + 1),
        });
        let infoWindow = new google.maps.InfoWindow({
            content: data[i].name,
        });
        marker.addListener('click', function () {
            infoWindow.open(map, marker);
        });
    }

// マーカーがいい感じに表示できるよう調整
    if (data.length > 0) {
        map.fitBounds(
            new google.maps.LatLngBounds(
                // sw
                {
                    lat: Math.min(...data.map((d) => d.lat)),
                    lng: Math.min(...data.map((d) => d.lng)),
                },
                // ne
                {
                    lat: Math.max(...data.map((d) => d.lat)),
                    lng: Math.max(...data.map((d) => d.lng)),
                }
            )
        );
    } else {
        map.setZoom(8);
    }


}

// InvalidValueError: initMap is not a functionの対応
window.onload = function () {
  initMap();
};

// イベント
gps_fixed.addEventListener('click', (event) => {

  if (!navigator.geolocation) {
    alert('GoogleのGeolocationサービスが使用できません。');
    return;
  }

  navigator.geolocation.getCurrentPosition(
    function (position) {
      let lat = position.coords.latitude;
      let lng = position.coords.longitude;
      let latlng = { lat: lat, lng: lng };
      let center_position = new google.maps.LatLng(lat, lng);
        let image = new google.maps.MarkerImage(
            '../../../../assets/images/source-bluedot.png',
            null, // size
            null, // origin
            new google.maps.Point( 8, 8 ), // anchor (move to center of marker)
            new google.maps.Size( 17, 17 ) // scaled size (required for Retina display icon)
        );
      map.setCenter(center_position);
      // アイコンクリア
      if (gps_marker !== null) {
        gps_marker.setMap(null);
      }
      gps_marker = new google.maps.Marker({
          flat: true,//・・・・・・アイコンにtrueで影を付けない
          icon: image,
          position: latlng,
          map: map,
          animation: google.maps.Animation.DROP,
          title: '現在地',
          visible: true
      });
    },
    function () {
      alert('現在地が取得できませんでした。');
    }
  );
});
