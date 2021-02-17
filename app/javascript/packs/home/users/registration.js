'use strict';

let official_no_release = document.getElementById('official_no_release');
let official_released = document.getElementById('official_released');
let official_release_checkbox = document.getElementById('switch1');

official_no_release_display();

official_release_checkbox.addEventListener('click', function () {
    official_no_release_display();
});

function official_no_release_display() {
    // 公開の場合公開コメント表示、非公開の場合非公開コメント表示
    if (official_release_checkbox.checked) {
        official_no_release.classList.add('display-none');
        official_released.classList.remove('display-none');
    } else {
        official_released.classList.add('display-none');
        official_no_release.classList.remove('display-none');
    }
}