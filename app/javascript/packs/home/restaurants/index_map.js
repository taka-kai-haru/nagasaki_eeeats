'use strict';

let map_canvas = document.getElementById('map_canvas');
const def_lat = Number(document.getElementById('gmap_def_lat').value);
const def_lng = Number(document.getElementById('gmap_def_lng').value);
const restaurants_count = Number(
    document.getElementById('restaurants_count').value
);
let gps_fixed = document.getElementById('gps_fixed');
let point = {lat: def_lat, lng: def_lng};
let data = [];
let gps_marker = null;
let map = null;
let present_position_lat = document.getElementById('present_position_lat');
let present_position_lng = document.getElementById('present_position_lng');
let area = document.getElementById('area');
let order_near = document.getElementById('order_near');
let order_evaluation = document.getElementById('order_evaluation');
let order_my_evaluation = document.getElementById('order_my_evaluation');

if (navigator.userAgent.match(/iPhone|Android.+Mobile/)) {
    gps_fixed.addEventListener('touchend', function() {
        show_current_location();
    });

    order_near.addEventListener('touchend',function (){
        set_present_position_hidden_field();
    })

} else {
    gps_fixed.addEventListener('click', function() {
        show_current_location();
    });

    order_near.addEventListener('click',function (){
        set_present_position_hidden_field();
    })
}


    for (let i = 0; i < restaurants_count; i++) {
        data[i] = {
            name: document.getElementById('restaurant_name' + i).innerHTML,
            lat: Number(document.getElementById('latitude' + i).value),
            lng: Number(document.getElementById('longitude' + i).value),
        };
    }



// マップ作成
    map = new google.maps.Map(map_canvas, {
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
        AutoMapZoom();
    } else {
        map.setZoom(8);
    }

// 現在地取得後hidden_fieldへセット
function set_present_position_hidden_field() {

    // テスト時に作動すると現在地が所得出来ないのでデプロイ時にコメントを外す

    if (order_near.checked === true) {
        present_position_lat.value = null;
        present_position_lng.value = null;
        if (!navigator.geolocation) {
            alert('GoogleのGeolocationサービスが使用できません。');
            order_near.checked = false;
            order_evaluation.checked = true;
            order_my_evaluation.checked = false;
            document.getElementById("order_near_label").classList.remove("active");
            document.getElementById("order_evaluation_label").classList.add("active");
            document.getElementById("order_my_evaluation_label").classList.remove("active");
            return;
        }
        navigator.geolocation.getCurrentPosition(
            function (position) {
                present_position_lat.value = position.coords.latitude;
                present_position_lng.value = position.coords.longitude;
            },
            function () {
                alert('現在地が取得できませんでした。');
                order_near.checked = false;
                order_evaluation.checked = true;
                order_my_evaluation.checked = false;
                document.getElementById("order_near_label").classList.remove("active");
                document.getElementById("order_evaluation_label").classList.add("active");
                document.getElementById("order_my_evaluation_label").classList.remove("active");
            });
    }
}


// イベント
function show_current_location(){

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
            '../../../../assets/source-bluedot.png',
            null, // size
            null, // origin
            new google.maps.Point( 8, 8 ), // anchor (move to center of marker)
            new google.maps.Size( 17, 17 ) // scaled size (required for Retina display icon)
        );
      map.setCenter(center_position);
        AutoMapZoom();

      // アイコンクリア
      if (gps_marker !== null) {
        gps_marker.setMap(null);
          // divnone('inside');//◆watchPosition gif表示
          // document.getElementById('inside').style.display = 'none';
      }
        // divblock('inside');//◆watchPosition gif表示
        // document.getElementById('inside').style.display = 'block';
      gps_marker = new google.maps.Marker({
          flat: true,//・・・・・・アイコンにtrueで影を付けない
          icon: image,
          position: latlng,
          map: map,
          optimized: false,
          animation: google.maps.Animation.DROP,
          title: '現在地',
          visible: true
      });
    },
    function () {
      alert('現在地が取得できませんでした。');
    }
  );
}

//div表示の切換え
// function divblock(id)
// {
//     let ele = document.getElementById(id);
//     ele.display = 'block';
// }
//
// //div非表示の切換え
// function divnone(id)
// {
//     let ele = document.getElementById(id);
//     ele.display = 'none';
// }

function AutoMapZoom(){
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
}