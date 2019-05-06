/// @description ポーズ中
if (isGamePaused) {
  draw_set_font(font0);
  draw_set_halign(fa_center);
  draw_text(room_width/2, window_get_height()/2, "Pause");
  for (var i = 0; i < array_height_2d(allObjects); ++i) {
    draw_sprite_ext(allObjects[i, 0],
      allObjects[i, 1],
      allObjects[i, 2],
      allObjects[i, 3],
      allObjects[i, 4],
      allObjects[i, 5],
      allObjects[i, 6],
      allObjects[i, 7],
      allObjects[i, 8]);
  }
  
}