$(function () {
// お知らせボタン、やることボタンを押したら
  $(".todo_list a").on("click", function () {
    $(".mypage-tab-content > ul").hide().filter(this.hash).fadeIn();
    $(".mypage-tabs > .news_list").removeClass("active");
    $(".mypage-tabs > .todo_list").addClass("active");
  });

  $(".news_list a").on("click", function () {
    $(".mypage-tab-content > ul").hide().filter(this.hash).fadeIn();
    $(".mypage-tabs > .todo_list").removeClass("active");
    $(".mypage-tabs > .news_list").addClass("active");
  });
});
