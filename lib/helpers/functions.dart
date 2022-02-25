String FormattedTitle(String title){
  var length = 30;
  if(title.length > length){
    return title.substring(0, length)+'...';
  }
  return title;
}