'use strict';

// お気に入り、イマイチ
let likes = document.getElementById('likes');
let dislikes = document.getElementById('dislikes');

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