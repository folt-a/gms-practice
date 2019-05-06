/// @description actAs();で使用する 

key_up = keyboard_check(vk_up);
key_right = keyboard_check(vk_right);
key_down = keyboard_check(vk_down);
key_left = keyboard_check(vk_left);

key_shift = keyboard_check(vk_shift);

hInput = key_right - key_left;
vInput = key_down - key_up;

// 向いている方向 
if (hInput != 0 || vInput != 0) {
  dir = point_direction(0, 0, hInput, vInput)
  hsp = lengthdir_x(moveSpeed, dir);
  vsp = lengthdir_y(moveSpeed, dir);

  //ダッシュ
  if (key_shift == 1) {
    hsp *= dashSpeedRate;
    vsp *= dashSpeedRate;
  };

  // 向きによるスプライト変更
  // 斜め状態からキーを離した瞬間に同時に０にならず片方になってしまうため、
  // 向きチェックによるスプライト変更は数フレームずらす
  if (dir == 90 ||
    dir == 0 ||
    dir == 270 ||
    dir == 180
  ) {
    if nanameTimer > 0 {
      nanameTimer -= 1;
    } else {
      nanameTimer = 0;
    }
  } else {
    nanameTimer = 3;
  }

  switch (dir) {
    case 90:
      if nanameTimer <= 0 sprite_index = sPlayerUp;
      break;
    case 45:
      sprite_index = sPlayerUpRight;
      break;
    case 0:
      if nanameTimer <= 0 sprite_index = sPlayerRight;
      break;
    case 315:
      sprite_index = sPlayerDownRight;
      break;
    case 270:
      if nanameTimer <= 0 sprite_index = sPlayerDown;
      break;
    case 225:
      sprite_index = sPlayerDownLeft;
      break;
    case 180:
      if nanameTimer <= 0 sprite_index = sPlayerLeft;
      break;
    case 135:
      sprite_index = sPlayerUpLeft;
      break;
  }

  var bbox_side;
  tilemap = layer_tilemap_get_id(m_collision);

  //よこ タイルマップ判定
  if (hsp > 0) bbox_side = bbox_right;
  else bbox_side = bbox_left;
  //1フレーム後スプライトとタイルが重なっているかどうか判定
  if (tilemap_get_at_pixel(tilemap, bbox_side + hsp, bbox_top) != 0) ||
    (tilemap_get_at_pixel(tilemap, bbox_side + hsp, bbox_bottom) != 0) {
      if (hsp > 0) x = x - (x mod m_tileX) + (m_tileX - 1) - (bbox_right - x);
      else x = x - (x mod m_tileX) - (bbox_left - x);
      hsp = 0;
    }
  x += hsp;

  //たて タイルマップ判定
  if (vsp > 0) bbox_side = bbox_bottom;
  else bbox_side = bbox_top;
  //1フレーム後スプライトとタイルが重なっているかどうか判定
  if (tilemap_get_at_pixel(tilemap, bbox_left, bbox_side + vsp) != 0) ||
    (tilemap_get_at_pixel(tilemap, bbox_right, bbox_side + vsp) != 0) {
      if (vsp > 0) y = y - (y mod m_tileY) + (m_tileY - 1) - (bbox_bottom - y);
      else y = y - (y mod m_tileY) - (bbox_top - y);
      vsp = 0;
    }
  y += vsp;

} else {
  // 静止スプライト
  image_index = 0;
}