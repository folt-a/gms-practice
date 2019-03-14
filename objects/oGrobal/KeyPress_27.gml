/// @description Pause the game
if (isGamePaused == false) {
	// ポーズが押されたとき、現在表示中の画面の全てのインスタンスのスプライト状況を配列へ保存する。
	for (var i = 0; i < instance_count; ++i) {
		allObjects[i, 0] = instance_find(all, i).sprite_index;
		allObjects[i, 1] = instance_find(all, i).image_index;
		allObjects[i, 2] = instance_find(all, i).x;
		allObjects[i, 3] = instance_find(all, i).y;
		allObjects[i, 4] = instance_find(all, i).image_xscale;
		allObjects[i, 5] = instance_find(all, i).image_yscale;
		allObjects[i, 6] = instance_find(all, i).image_angle;
		allObjects[i, 7] = instance_find(all, i).image_blend;
		allObjects[i, 8] = instance_find(all, i).image_alpha;
	}

	// 全てのインスタンスを一時停止にする
	instance_deactivate_all(true);
	isGamePaused = true;

	// 背景のアニメーションのスピードを０にする？
	layer_vspeed("background", 0);
} else {
	// 全てのインスタンスを一時停止を解除する
	// 内部プロパティはリセットされず、以前の状態へ戻るので安心してよい。
	instance_activate_all();
	isGamePaused = false;

	layer_vspeed("background", 1);
}