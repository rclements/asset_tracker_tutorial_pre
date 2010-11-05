$("#schedule_modal").dialog({ 
  modal: true,
  autoOpen: false,
  width: 500,
  height: 500
});

$('#schedule_modal_link').click(function() {
  $("#schedule_modal").dialog('open');
  return false;
});

$("#scheduled_at").datepicker( {
  onSelect: function(dateText, inst) {
    $("#work_unit_scheduled_at").val(dateText);
    $("#schedule_modal").dialog('close');
    $('#schedule_modal_link').text($('#work_unit_scheduled_at').val());
  },
  dateFormat: 'yy-mm-dd'
});

$("#new_work_unit").submit(function() {
  var me = jQuery(this);
  jQuery.ajax(
  {
    async: true,
    global: false,
    url: me.attr("action"),
    type: "POST",
    dataType: "json",
    data: {"work_unit[description]": me.find("#work_unit_description").val(),
      "work_unit[scheduled_at]": me.find("#work_unit_scheduled_at").val(),
      "work_unit[client_id]": me.find("#work_unit_client_id").val(),
      "work_unit[project_id]": me.find("#work_unit_project_id").val(),
      "work_unit[ticket_id]": me.find("#work_unit_ticket_id").val(),
      "work_unit[hours]": me.find("#work_unit_hours").val(),
      "work_unit[overtime]": me.find("#work_unit_overtime").val()
       },
    success: function(result)
    {
      var json = jQuery.parseJSON( result.responseText )
      me.trigger("reset");
      me.effect("highlight");
    },
    error: function(result)
    {
      var json = jQuery.parseJSON( result.responseText )
      jQuery("#work-unit-errors").data('errors', json);
      jQuery("#work-unit-errors").dialog('open');
    }
  });
  return false;
});

$("#work-unit-errors").dialog( {
  autoOpen: false,
  hide: true,
  title: "Error",
  modal: true,
  draggable: false,
  open: function() {
    var dialog = jQuery("#work-unit-errors")
    dialog.html("")
    jQuery.each( dialog.data('errors'), function() {
      dialog.append("<p>" + this + "</p>")
    });
  },
  close: function() {
    var dialog = jQuery("#work-unit-errors")
    dialog.html("");
  }
});

$("#work_unit_client_id").change(function(){
  var me = $("#work_unit_project_id");
  me.children().remove();
  me.append( new Option("Select a project","") )
  $("#work_unit_ticket_id").children().remove();
  $("#work_unit_ticket_id").append( new Option("Select a ticket",""))
  if(this.value != "") {
    $.get("/dashboard/client", { id: this.value }, function(data){
      $.each(data, function(){
        $.each(this, function(k, v){
          me.append( new Option(v.name, v.id) )
        });
      });
    }, "json");
  }
});

$("#work_unit_project_id").change(function(){
  var me = $("#work_unit_ticket_id")
  me.children().remove();
  me.append( new Option("Select a ticket","") )
  if(this.value != "") {
    $.get("/dashboard/project", { id: this.value }, function(data){
      $.each(data, function(){
        $.each(this, function(k, v){
          me.append( new Option(v.name, v.id) )
        });
      });
    }, "json");
  }
});
