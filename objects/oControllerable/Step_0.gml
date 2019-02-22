/// @description actAs();で使用する 

key_right = keyboard_check(vk_right);
key_left = keyboard_check(vk_left);
key_up = keyboard_check(vk_up);
key_down = keyboard_check(vk_down);

if (keyboard_check(vk_shift) == 1) {
  //Dash
  hsp = (key_right - key_left) * dashSpeed;
  vsp = (key_down - key_up) * dashSpeed;
  //ななめなら減速
  if (abs(keyboard_check(vk_left)) == 1 &&
    abs(keyboard_check(vk_right)) == 1) {
    hsp -= dashDiagonalAdjust;
    vsp -= dashDiagonalAdjust;
  }
} else {
  //walk
  hsp = (key_right - key_left) * moveSpeed;
  vsp = (key_down - key_up) * moveSpeed;
  //ななめなら減速
  if (abs(keyboard_check(vk_left)) == 1 &&
    abs(keyboard_check(vk_right)) == 1) {
    hsp -= moveDiagonalAdjust;
    vsp -= moveDiagonalAdjust;
  }
};

var bbox_side;
tilemap = layer_tilemap_get_id("Collision");

//Horizontal Collision
if (hsp > 0) bbox_side = bbox_right;
else bbox_side = bbox_left;
//1フレーム後スプライトとタイルが重なっているかどうか判定
if (tilemap_get_at_pixel(tilemap, bbox_side + hsp, bbox_top) != 0) ||
  (tilemap_get_at_pixel(tilemap, bbox_side + hsp, bbox_bottom) != 0) {
    if (hsp > 0) x = x - (x mod TileX) + (TileX - 1) - (bbox_right - x);
    else x = x - (x mod TileX) - (bbox_left - x);
    hsp = 0;
  }
x += hsp;

//Vertical Collision
if (vsp > 0) bbox_side = bbox_bottom;
else bbox_side = bbox_top;
//1フレーム後スプライトとタイルが重なっているかどうか判定
if (tilemap_get_at_pixel(tilemap, bbox_left, bbox_side + vsp) != 0) ||
  (tilemap_get_at_pixel(tilemap, bbox_right, bbox_side + vsp) != 0) {
    if (vsp > 0) y = y - (y mod TileY) + (TileY - 1) - (bbox_bottom - y);
    else y = y - (y mod TileY) - (bbox_top - y);
    vsp = 0;
  }
y += vsp;