/// @description Pause the game
if (isGamePaused == false) {
	// ポーズが押されたとき、現在表示中の画面の全てのインスタンスのスプライト状況を配列へ保存する。
	var offset = 0;
	for (var i = 0; i < instance_count; ++i) {
		if (instance_find(all, i).sprite_index != -1) {
			allObjects[i - offset, 0] = instance_find(all, i).sprite_index;
			allObjects[i - offset, 1] = instance_find(all, i).image_index;
			allObjects[i - offset, 2] = instance_find(all, i).x;
			allObjects[i - offset, 3] = instance_find(all, i).y;
			allObjects[i - offset, 4] = instance_find(all, i).image_xscale;
			allObjects[i - offset, 5] = instance_find(all, i).image_yscale;
			allObjects[i - offset, 6] = instance_find(all, i).image_angle;
			allObjects[i - offset, 7] = instance_find(all, i).image_blend;
			allObjects[i - offset, 8] = instance_find(all, i).image_alpha;
		} else {
			++offset;
		}
	}

	// 全てのインスタンスを一時停止にする
	instance_deactivate_all(true);
	
	// メニューを出す
	arrayMenuItem= array_create(itemCount)
	
	for	(var i = 0; i < itemCount; ++i){
		var positionOnPath = 1 / itemCount * i
		var itemX = path_get_x(pCircle,positionOnPath) / 100 * 64;
		var itemY = path_get_y(pCircle,positionOnPath) / 100 * 64;
		arrayMenuItem[i] = instance_create_layer(player.x + itemX,player.y + itemY,"UI",opMenuItem);		
	}
	
	arrayMenuItem[0].sprite_index = sItem1;
	
	isGamePaused = true;

	// 背景のアニメーションのスピードを０にする？
	//layer_vspeed("background", 0);
} else {
	// 全てのインスタンスを一時停止を解除する
	// 内部プロパティはリセットされず、以前の状態へ戻る。
	instance_activate_all();
	isGamePaused = false;

	//layer_vspeed("background", 1);
}