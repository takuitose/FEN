
/*global google*/

document.addEventListener("DOMContentLoaded", function() {
  // フォームのlatitudeとlongitudeフィールドを取得
  const latitudeField = document.getElementById("spot_latitude");
  const longitudeField = document.getElementById("spot_longitude");

  // Google Maps APIが読み込まれた後に実行されるコールバック関数
  function initializeMap() {
    const opts = {
      zoom: 15,
      center: new google.maps.LatLng(33.5902479, 130.4177656)
    };
    const map = new google.maps.Map(document.getElementById("map"), opts);

    // マーカーを追加
    const marker = new google.maps.Marker({
      position: opts.center,
      map: map,
      title: "ここにマーカーが表示されます"
    });

    // マップクリック時に新しいマーカーを作成
    google.maps.event.addListener(map, "click", function(event) {
      const clickedLat = event.latLng.lat();
      const clickedLng = event.latLng.lng();

      // 新しいマーカーを作成
      const newMarker = new google.maps.Marker({
        position: event.latLng,
        map: map,
        title: "新しいマーカー"
      });

      // 新しいマーカーをクリックした際に緯度経度を表示
      google.maps.event.addListener(newMarker, "click", function() {
        alert("クリックされた位置の緯度: " + clickedLat + ", 経度: " + clickedLng);

        // フォームのlatitudeとlongitudeフィールドに値をセット
        latitudeField.value = clickedLat;
        longitudeField.value = clickedLng;
      }, { passive: true }); // リスナーに { passive: true } を追加
    });
  }

  // Google Maps APIの読み込みを確認し、初期化関数を実行
  if (typeof google !== "undefined" && typeof google.maps !== "undefined") {
    // Google Maps APIが読み込まれていることを確認してから地図を初期化
    initializeMap();
  } else {
    // Google Maps APIが読み込まれるまで待機
    window.initMap = initializeMap;
  }
});
