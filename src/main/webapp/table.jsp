<%@ page import="java.util.ArrayList" %>
<%@ page import="servlets.Point" %>
<%@ page import="java.time.Instant" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  ArrayList<Point> history = (ArrayList<Point>) application.getAttribute("history");
  Point currentPoint = history.get(history.size() - 1);
  Date currentTime = new Date();
  long executionTime = currentTime.getTime() - currentPoint.getTime();
  currentPoint.setTime(executionTime);
  history.remove(history.size() - 1);
  history.add(currentPoint);
  application.setAttribute("history", history);
%>
<html lang="ru">

<head>
  <meta charset="UTF-8">
  <script src="methods.js" type="text/javascript"></script>
  <link rel="stylesheet" href="styleTable.css">
  <title>Lab 2</title>
</head>

<body>
<table width="100%" height="100%">
  <tr>
    <td>
      <div class="main_container">
        <a href="index.jsp" class="link cross"><img src="assets/images/cross.png" alt=""></a>
        <a class="link cell" onclick="showTable()" id="btn"><img src="assets/images/cells.png" alt=""></a>
        <div class="info" id="info">
          <div class="column">
            <div class="param x"><b>X</b><span class="param_numbers" id="x"></span></div>
            <div class="param"><b>Y</b><span class="param_numbers" id="y"></span></div>
            <div class="param"><b>R</b><span class="param_numbers" id="r"></span></div>
            <div class="block">
              <b>Время выполнения</b>
              <br>
              <span id="exec_time"></span>
            </div>
          </div>
          <div class="column">
            <div class="block x">
              <b>Результат</b>
              <br>
              <span id="res"></span>
            </div>
            <div class="block">
              <b>Текущее время</b>
              <br>
              <span id="time">Сколько-то</span>
            </div>
          </div>
        </div>
        <div class="table_container" id="table" style="visibility: hidden">
          <table class="table">
            <tr>
              <th width="15%">X</th>
              <th width="15%">Y</th>
              <th width="15%">R</th>
              <th width="25%">Время выполнения</th>
              <th width="30%">Результат</th>
            </tr>
            <% for (Point point : history ) {%>
            <tr>
              <td><%=point.getX()%></td>
              <td><%=point.getY()%></td>
              <td><%=point.getR()%></td>
              <td><%=point.getTime()%></td>
              <% if (point.getHit()) { %>
              <td style='color:#48d848;'>Попадание</td>
              <% } else { %>
              <td style='color:#dd1818;'>Промах</td>
              <% } %>
            </tr>
            <% }%>
          </table>
        </div>
      </div>
    </td>
  </tr>
</table>
</body>
<script>
  function setTime() {
    document.getElementById("time").innerHTML = new Date().toLocaleTimeString();
  }

  setTime();
</script>
<script type="text/javascript">
  function setData() {



    let x =  <%=currentPoint.getX()%>;
    let res = <%=currentPoint.getHit()%>;

    if (x < 0) {
      document.getElementById("x").setAttribute("style", "margin-left: 145px;")
    }
    document.getElementById("x").innerHTML = x;
    document.getElementById("y").innerHTML = <%= currentPoint.getY()%>;
    document.getElementById("r").innerHTML = <%= currentPoint.getR()%>;
    document.getElementById("exec_time").innerHTML = <%=Long.toString(executionTime)%>;
    if (res) {
      document.getElementById("res").innerHTML = "Попадание";
      document.getElementById("res").setAttribute("style", "color:#48d848;")
    } else {
      document.getElementById("res").innerHTML = "Промах";
      document.getElementById("res").setAttribute("style", "color:#dd1818;")
    }
  }

  setData();
</script>
<script>
  function handleResize() {
    if (window.innerWidth < 1250) {
      document.getElementById("x").setAttribute("style", "margin-left: 69px;");
    } else {
      document.getElementById("x").setAttribute("style", "margin-left: 145px;");
    }
  }
  window.addEventListener('resize', handleResize);
  window.addEventListener('load', handleResize);
</script>
</html>
