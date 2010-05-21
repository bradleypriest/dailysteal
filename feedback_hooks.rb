class FeedbackHooks < Spree::ThemeSupport::HookListener
  insert_after :inside_head do
    %(<!--<%= javascript_include_tag :defaults, :cache => "cache/all" %>-->
    <%= feedback_includes %>
    <%= feedback_tab(:position => 'left') %>)
  end
end
