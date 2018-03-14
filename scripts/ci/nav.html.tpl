<html>
<body>
<% for @report in @reports %>
  <div><a href="<%= @report %>" target="report"><%= @report[0..@report.length-6] %></a></div>
<% end %>
</body>
</html>