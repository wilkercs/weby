//= require jquery.cookie
//= require_self
var tags = $('*');
var tags = tags.not(tags.find(".no_contrast").find("*"));
var font_original = new Array();
var font_up = new Array();
var font_down = new Array();

//setando cookies das fontes
tags.ready(function(){
  tags.each(function(){ font_original.push($(this).css('font-size'))})
  $.cookie("font_size_original", font_original, {path: '/' });
  tags.css('font-size', null + 'px');
  for (var i = 0; i < font_original.length; i++) {
    font_up[i] = font_original[i];
    font_down[i] = font_original[i];
  };
})


function font_size_up(){
 var cont = 0;
  tags.each(function  () {
    var currentSizeTag = parseInt(font_up[cont].substr(0, font_up[cont].length - 2));
    var newSizeTag = currentSizeTag + 2;
    
    font_up[cont] = newSizeTag.toString() + 'px';
     
    $(this).css('font-size', font_up[cont++] );
  })
  
}

function font_size_down(){
  var cont = 0;
  tags.each(function  () {
    var currentSizeTag = parseInt(font_down[cont].substr(0, font_down[cont].length - 2));
    var newSizeTag = currentSizeTag -2;
    
    font_down[cont] = newSizeTag.toString() + 'px';
    
    $(this).css('font-size', font_down[cont++] );
  })
}

function font_size_original(){
var i=0; 
  tags.each(function(){
    $(this).css('font-size',font_original[i++]);
  })
  for (var i = 0; i < font_original.length; i++) {
    font_up[i] = font_original[i];
    font_down[i] = font_original[i];
  };
}
