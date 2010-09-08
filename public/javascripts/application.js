// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
   var $winwidth = $(window).width();
   var $width = Math.floor($winwidth/256);
   var $fin = $width*256+'px';
   $("#deal-list").css({
     width: $fin
   });
   $(window).bind("resize", function(){
     var $winwidth = $(window).width();
     var $width = Math.floor($winwidth/256);
     var $fin = $width*256+'px';
     $("#deal-list").css({
       width: $fin
     });
 });
 });