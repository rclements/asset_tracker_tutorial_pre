$(function() {
  
  $(".accordion").accordion({ 
    header: 'h4', 
    clearStyle: true, 
    fillSpace: true
  });
  
  $(".recent-work").click(function() {
    bind_recent_work_navigation(this)
    return false;
  });

});