module UtilsHelper

  def link_to_with_icon(t,h,c,s,i,d)
    html = %Q|<a href="#{h}" class="#{c}" style="#{s}" id="#{d}"><i class="#{i}"></i>#{t}</a>|
    html.html_safe
  end
  
  def link_to_remote(t,h,c,s)
    html = %Q|<a href="#{h}" class="#{c}" style="#{s}" rel="noffollow" data-remote="true" data-method="post">#{t}</a>|
    html.html_safe
  end

  def link_to_with_icon_remote(t,h,c,s,i)
    html = %Q|<a href="#{h}" class="#{c}" style="#{s}" rel="noffollow" data-remote="true" data-method="post"><i class="#{i}"></i>#{t}</a>|
    html.html_safe
  end
  
  def link_to_with_icon_remote_id(t,h,c,s,i,d)
    html = %Q|<a href="#{h}" class="#{c}" style="#{s}" rel="noffollow" data-remote="true" data-method="post" id="#{d}"><i class="#{i}"></i>#{t}</a>|
    html.html_safe
  end
  
  def link_to_modal(t,h,c,s,i,d)
    html = %Q|<a href="#{h}" class="#{c}" style="#{s}" role="button", data-toggle="modal" id="#{d}"><i class="#{i}"></i>#{t}</a>|
    html.html_safe
  end
  
  def show_notice(message=nil)
    html = ""
    msg = message.presence || notice.presence || nil
    if msg
      html = %Q|<div class="alert alert-info alert-block fade in"><button type="button" class="close" data-dismiss="alert">×</button><h4>#{msg}</h4></div>|
    end
    html.html_safe
  end
  
  def show_alert(message=nil)
    html = ""
    msg = message.presence || alert.presence || nil
    if msg  
      html = %Q|<div class="alert alert-block"><button type="button" class="close" data-dismiss="alert">×</button><h4>#{msg}</h4></div>|
    end
    html.html_safe
  end
  
  def _script_document_ready(script)
    html = %Q|<script type="text/javascript" charset="utf-8">$(document).ready(function() {#{script}});</script>|
    html.html_safe
  end
  
  def _script_pageinit(script)  
    html = %Q|<script type="text/javascript" charset="utf-8">$(document).bind('pageinit', function() {#{script}});</script>|
    html.html_safe
  end

  def _script(script)
    %Q|<script type="text/javascript" charset="utf-8">#{script}</script>|.html_safe
  end
  
  def _mobile_tap(element_id,func)
    _script(%Q|$('\##{element_id}').live('tap',function(event) {
      var lastclickpoint = $(this).attr('data-clickpoint');
      var curclickpoint = event.clientX+'x'+event.clientY
      if (lastclickpoint == curclickpoint) return false;
      $(this).attr('data-clickpoint',curclickpoint);
      #{func}
    });|)
  end
end