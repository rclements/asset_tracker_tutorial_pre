function bind_recent_work_navigation(el)
{
  var me   = jQuery(el);
  var date = me.attr("date");
  jQuery.get("/dashboard/recent_work", {date: date}, function (data)
  {
    jQuery("#recent-work").html(data)
  });
  return true;
}
jQuery(document).ready(function(){
  jQuery("#message").dialog({modal: true});
  jQuery(".accordion").accordion({ header: 'h4', clearStyle: true, fillSpace: true });
  jQuery(".recent-work").click(function()
  {
    bind_recent_work_navigation(this);
    return false;
  });
  return false;
});
