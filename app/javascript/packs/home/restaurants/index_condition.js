'use strict';

let my_post_none = document.getElementById('my_post_none');
let my_post_only = document.getElementById('my_post_only');
let likes_condition = document.getElementById('likes_condition');
let likes = document.getElementById('likes');
let dislikes = document.getElementById('dislikes');

// イベント追加
if (navigator.userAgent.match(/iPhone|Android.+Mobile/)) {

    // 自分の投稿データのみを選択した場合
    my_post_only.addEventListener('touchend', function () {
        my_post_only_clicked();
    });

// すべてを選んだ場合
    my_post_none.addEventListener('touchend', function () {
        my_post_none_clicked();
    })

} else {

// 自分の投稿データのみを選択した場合
    my_post_only.addEventListener('click', function () {
        my_post_only_clicked();
    });

// すべてを選んだ場合
    my_post_none.addEventListener('click', function () {
        my_post_none_clicked();
    })
}

function my_post_none_clicked() {
    // お気に入り、イマイチを非表示
    likes_condition.classList.add('display-none');
    // お気に入り、イマイチのチェックを外す
    likes.checked = false;
    dislikes.checked = false;
}

function my_post_only_clicked() {
    // お気に入り、イマイチを表示
    likes_condition.classList.remove('display-none');
}