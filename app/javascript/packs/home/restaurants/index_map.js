'use strict';

let target = document.getElementById('target');
// var geocoder = new google.maps.Geocoder();
const def_lat = Number(document.getElementById('gmap_def_lat').value);
const def_lng = Number(document.getElementById('gmap_def_lng').value);
const restaurants_count = Number(
  document.getElementById('restaurants_count').value
);
let gps_fixed = document.getElementById('gps_fixed');
let array_latitude = [];
let array_longitude = [];
let array_restaurant_name = [];
let point = null;
let data = [];
let gps_marker = null;

for (let i = 0; i < restaurants_count; i++) {
  data[i] = {
    name: document.getElementById('restaurant_name' + i).innerHTML,
    lat: Number(document.getElementById('latitude' + i).value),
    lng: Number(document.getElementById('longitude' + i).value),
  };

  // array_latitude.push(Number(document.getElementById("latitude" + i).value));
  // array_longitude.push(Number(document.getElementById("longitude" + i).value));
  // array_restaurant_name.push(document.getElementById("restaurant_name" + i).value);
}
console.log(restaurants_count);
console.log(data);
// if (restaurants_count > 0){
//   point =  { lat: array_latitude[0], lng: array_longitude[0]};
//   console.log(array_latitude);
//   console.log(array_longitude);
// }else{
point = { lat: def_lat, lng: def_lng };
//   console.log(point);
// };

// マップ作成
let map;
map = new google.maps.Map(target, {
  center: point,
  zoom: 17,
  maxZoom: 16,
  minZoom: 6,
  mapTypeControl: false,
  zoomControl: true,
  streetViewControl: false,
  // disableDefaultUI: true,
  // zoomControl: true,
});

for (let i = 0; i < data.length; i++) {
  console.log(data[i].lat);
  console.log(data[i].lng);
  // マーカーを生成
  let marker = new google.maps.Marker({
    position: new google.maps.LatLng(data[i].lat, data[i].lng),
    map: map,
    animation: google.maps.Animation.DROP,
    title: data[i].name,
  });
  let infoWindow = new google.maps.InfoWindow({
    content: data[i].name,
  });
  marker.addListener('click', function () {
    infoWindow.open(map, marker);
  });

  // マーカーを地図に表示
  // marker.setMap(map);
}

// マーカーがいい感じに表示できるよう調整
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

// point = null;
// for (let i = 0; i < restaurants_count; i++) {
//     point =  { lat: array_latitude[i], lng: array_longitude[i]};
//     //マーカーセット
//     marker = new google.maps.Marker({
//       position: point,
//       map: map,
//       title: array_restaurant_name[i],
//       animation: google.maps.Animation.DROP,
//     });
//     point = null;
// };

// geocoder.geocode(
//   {
//     address: document.getElementById("address1").innerHTML
//   },
//   function (results, status) {
//     if (status !== "OK") {
//       alert("マップの取得に失敗しました。: " + status);
//       document.getElementById('target').innerText ="地図情報が取得できません。";
//       return;
//     }
//     // results[0].geometry.locationに緯度経度の情報が入ってくる
//     if (results[0]) {
//       let location = results[0].geometry.location;
//       let restaurantmap = new google.maps.Map(target, {
//         center: location,
//         zoom: 17,
//       });
//       // 緯度経度の情報をハッシュに変換
//       let lat = location.lat();
//       let lng =  location.lng();
//       let latlng = {lat: lat, lng: lng};
//       var marker = new google.maps.Marker({
//         position: latlng,
//         map: restaurantmap,
//         animation: google.maps.Animation.DROP,
//         title: document.getElementById("restaurant_name1").innerHTML
//         });
//       var infoWindow = new google.maps.InfoWindow({
//         content: document.getElementById("restaurant_name1").innerHTML
//         });
//         marker.addListener('click', function() {
//           infoWindow.open(restaurantmap, marker);
//         });

//     } else {
//       arert("マップが見つかりませんでした。");
//       document.getElementById('target').innerText ="地図情報が取得できません。";
//       return;
//     }
//   }
// );

// イベント
gps_fixed.addEventListener('click', (event) => {
  console.log('clickイベント');
  if (!navigator.geolocation) {
    alert('GoogleのGeolocationサービスが使用できません。');
    return;
  }
  console.log('clickイベント２');
  navigator.geolocation.getCurrentPosition(
    function (position) {
      let lat = position.coords.latitude;
      let lng = position.coords.longitude;
      let latlng = { lat: lat, lng: lng };
      let center_position = new google.maps.LatLng(lat, lng);
      console.log(latlng);

      map.setCenter(center_position);
      // アイコンクリア
      if (gps_marker !== null) {
        gps_marker.setMap(null);
      }
      gps_marker = new google.maps.Marker({
        position: latlng,
        map: map,
        animation: google.maps.Animation.DROP,
        title: '現在地',
        // icon:{
        //   fillColor: "#0000ff",
        // }
      });
    },
    function () {
      alert('現在地が取得できませんでした。');
      return;
    }
  );
});
