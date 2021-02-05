'use strict';

// 検索範囲
let my_post_none = document.getElementById('my_post_none');
let my_post_only = document.getElementById('my_post_only');
// お気に入り、イマイチ表示/非表示クラス設定用
let likes_condition = document.getElementById('likes_condition');
// お気に入り、イマイチ
let likes = document.getElementById('likes');
let dislikes = document.getElementById('dislikes');
// 決済方法
let payment_method_not_display = document.getElementById('payment_method_not_display');
let payment_method_display = document.getElementById('payment_method_display');
let payment_method = document.getElementById('payment_method');
let payment_method_check_boxes = document.getElementsByClassName("payment_method_check_boxes");

// 初期表示
if (my_post_none.checked) {
    my_post_none_clicked();
}

if (my_post_only.checked) {
    my_post_only_clicked();
}

// // クリックイベント
// if (navigator.userAgent.match(/iPhone|Android.+Mobile/)) {
//     console.log("スマホイベントセット");
//     // 自分の投稿データのみを選択した場合
//     my_post_only.addEventListener('touchend', function () {
//         console.log("自分の評価分セット");
//         my_post_only_clicked();
//     });
//
//     // すべてを選んだ場合
//     my_post_none.addEventListener('touchend', function () {
//         my_post_none_clicked();
//     });
//
//     // お気に入り選択時、イマイチのチェックボックスを外す
//     likes.addEventListener('touchend',function (){
//         if (likes.checked){
//             dislikes.checked = false;
//         }
//     });
//
//     // イマイチ選択時、お気に入りのチェックボックスを外す
//     dislikes.addEventListener('touchend',function (){
//         if (dislikes.checked){
//             likes.checked = false;
//         }
//     });
//
// } else {

    // 自分の投稿データのみを選択した場合
    my_post_only.addEventListener('click', function () {
        my_post_only_clicked();
    });

    // すべてを選んだ場合
    my_post_none.addEventListener('click', function () {
        my_post_none_clicked();
    });

    // お気に入り選択時、イマイチのチェックボックスを外す
    likes.addEventListener('click',function (){
        if (likes.checked){
            dislikes.checked = false;
        }
    });

    // イマイチ選択時、お気に入りのチェックボックスを外す
    dislikes.addEventListener('click',function (){
        if (dislikes.checked){
            likes.checked = false;
        }
    });

    // 決済方法非表示の時
    payment_method_not_display.addEventListener('click',function (){
        payment_method_not_display_clicked();
    });

    // 決済方法表示の時
    payment_method_display.addEventListener('click',function (){
        payment_method_display_clicked();
    });

// }

// すべて選択時
function my_post_none_clicked() {
    // お気に入り、イマイチを非表示
    likes_condition.classList.add('display-none');
    // お気に入り、イマイチのチェックを外す
    likes.checked = false;
    dislikes.checked = false;
}

//　自分の登録分選択時
function my_post_only_clicked() {
    // お気に入り、イマイチを表示
    likes_condition.classList.remove('display-none');
}

// 決済方法　非表示選択時
function payment_method_not_display_clicked() {
    // 決済方法非表示
    payment_method.classList.add('display-none');
    // 決済方法ののチェックを外す
    for (let i = 0; i < payment_method_check_boxes.length; i++) {
        payment_method_check_boxes[i].checked = false;
    }
}

//　決済方法　表示選択時
function payment_method_display_clicked() {
    // 決済方法表示
    payment_method.classList.remove('display-none');
}