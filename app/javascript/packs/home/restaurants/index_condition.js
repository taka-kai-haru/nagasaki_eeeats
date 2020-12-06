'use strict';

// 検索範囲
let my_post_none = document.getElementById('my_post_none');
let my_post_only = document.getElementById('my_post_only');
// お気に入り、イマイチ表示/非表示クラス設定用
let likes_condition = document.getElementById('likes_condition');
// お気に入り、イマイチ
let likes = document.getElementById('likes');
let dislikes = document.getElementById('dislikes');


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