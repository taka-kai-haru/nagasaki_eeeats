"use strict";
var target = document.getElementById("target");
var geocoder = new google.maps.Geocoder();
var textimput = document.getElementById("textimput");
var present_ocation = document.getElementById("present_ocation");
var google_map = document.getElementById("google_map");
var address = document.getElementById("address");
var googlemaker = null;
const my_reg = /日本、〒\s?\d{3}(-|ー)\d{4}/;

// イベント
textimput.addEventListener('click', (event) => {
  RadioButtonChanged();
});
present_ocation.addEventListener('click', (event) => {
  RadioButtonChanged();
});
google_map.addEventListener('click', (event) => {
  RadioButtonChanged();
});
address.addEventListener('focusout', (event) => {
  if (address.value !== "") {
        getAddressToMove(); //入力された住所へ移動
  };
});


// Map初期設定
  const def_lat = Number(document.getElementById("gmap_def_lat").value);
  const def_lng = Number(document.getElementById("gmap_def_lng").value);
  let restaurantmap = new google.maps.Map(target, {
      center: {
        lat: def_lat,
        lng: def_lng
      },
      zoom: 17,
      mapTypeControl: false,
      zoomControl: true,
      streetViewControl: false,
    });

// 住所があればGoogleMap表示
if (address.value !== "") {
  getAddressToMove();
};

//RadioButtonChangeイベント
function RadioButtonChanged(){
  // textエリア選択時
  if (textimput.checked){
      address.readonly = false;
      // present_ocation.checked = false;
      // google_map.checked = false;
  };
  //現在地選択時
  if (present_ocation.checked){
    // textimput.checked = false;
    // google_map = false;
    if (!navigator.geolocation) {
      alert('GoogleのGeolocationサービスが使用できません。');
      // textimput.checked = true;
      return;
    }
      address.readonly = true;
      getPresentOcation(); //現在地を取得
  };
  // GoogleMap選択時
  if (google_map.checked){
      // textimput.checked = false;
      // present_ocation.checked = false;
      address.readonly = true;
      if (address.value !== "") {
        getAddressToMove(); //入力された住所へ移動
      };
  };
};

// Mapクリックイベント
restaurantmap.addListener('click', function(e) {
geocoder.geocode({
  location: e.latLng
}, function(results, status) {
  if (status !== 'OK') {
    alert('マップの取得に失敗しました。: ' + status);
    document.getElementById('target').innerText ="地図情報が取得できません。1";
    return;
  }

  if (results[0]) {
    // 住所を整形
    let address_format = results[0].formatted_address;
    address_format = address_format.replace(my_reg, '');
    address_format = address_format.trim();
    
    merkerSet(e.latLng,restaurantmap,address_format);
    // 住所セット
    address.value = address_format;
    latitudelongitudeSet(e.latLng.lat(),e.latLng.lng()); // 緯度経度セット

  } else {
    arert("マップが見つかりませんでした。");
    document.getElementById('target').innerText ="地図情報が取得できません。2";
    return;
  }
});
});


// 緯度、経度セット
function latitudelongitudeSet(lat,lng) {
document.getElementById('latitude').value  = lat;
document.getElementById('longitude').value = lng;
}



// 現在地を取得
function getPresentOcation(){
navigator.geolocation.getCurrentPosition(function(position) {
let lat = position.coords.latitude;
let lng =  position.coords.longitude;
let latlng = {lat: lat, lng: lng};
let center_position = new google.maps.LatLng(lat,lng);
latitudelongitudeSet(lat,lng); // 緯度経度セット

restaurantmap.setCenter(center_position);
merkerSet(latlng,restaurantmap,"");

// 住所をセット
geocoder.geocode({
  location: {
    lat: position.coords.latitude,
    lng: position.coords.longitude
  }
}, function(results, status) {
  if (status !== 'OK') {
    alert('マップの取得に失敗しました。: ' + status);
    document.getElementById('target').innerText ="地図情報が取得できません。1";
    return;
  }

  if (results[0]) {
    // 住所を整形
    let address_format = results[0].formatted_address;
    address_format = address_format.replace(my_reg, '');
    address_format = address_format.trim();
    // merkerSet(latLng,restaurantmap,address_format);
    // 住所セット
    address.value = address_format;
  } else {
    arert("マップが見つかりませんでした。");
    document.getElementById('target').innerText ="地図情報が取得できません。2";
    return;
  }
});
}, function() {
alert('現在地が取得できませんでした。');
present_ocation.checked = false;
document.getElementById("present_ocation_label").classList.remove("active");
textimput.checked = true;
document.getElementById("textimput_label").classList.add("active");
address.readonly = false;
address.focus();
return;
});
};

// 住所からGoogoleMap更新
function getAddressToMove(){
// const target_address = document.getElementById("address");
geocoder.geocode(
{
  address: address.value
},
function (results, status) {
  if (status !== "OK") {
    alert("マップの取得に失敗しました。: " + status);
    document.getElementById('target').innerText ="地図情報が取得できません。3";
    return;
  }
  console.log("beforeset");
  // results[0].geometry.locationに緯度経度の情報が入ってくる
  if (results[0]) {
    let location = results[0].geometry.location;
    // 緯度経度の情報をハッシュに変換
    let lat = location.lat();
    let lng =  location.lng();
    let latlng = {lat: lat, lng: lng};
    let center_position = new google.maps.LatLng(lat,lng);
    
    restaurantmap.setCenter(center_position);
    latitudelongitudeSet(lat,lng); // 緯度経度セット
    merkerSet(latlng,restaurantmap,address.value);
  } else {
    arert("マップが見つかりませんでした。");
    document.getElementById('target').innerText ="地図情報が取得できません。4";
    return;
  }
}
);
};

// マーカーセット
function merkerSet(position,map,title) {
// アイコンクリア
if (googlemaker !== null){
    googlemaker.setMap(null);
};
googlemaker = new google.maps.Marker({
  position: position,
  map: map,
  animation: google.maps.Animation.DROP,
  title: title,
});
};