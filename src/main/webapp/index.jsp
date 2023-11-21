<%@ page import="servlets.Point" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ArrayList<Point> history = (ArrayList<Point>) application.getAttribute("history");
%>
<html lang="ru">

<head>
    <meta charset="UTF-8">
    <script src="methods.js" type="text/javascript"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="style.css">
    <title>Lab 2</title>
</head>

<body>
<table width="100%" id="main_table" class="main_table">
    <tr>
        <td>
            <div class="header">
                <div class="container__head">
                    <div class="image__head"> <img src="assets/images/itmo.png"> </div>
                    <div class="text__head"> Шикунов Максим Евгеньевич
                        <br> P3233
                        <br> 99109 </div>
                </div>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="main__container">
                <a class="link cell" onclick="showTable()" id="btn"><img src="assets/images/cells.png" alt=""></a>
                <div class="main__text"> Введите координаты и параметр R для получения результата </div>
                <form action="" id="info" onsubmit="return checkY()">
                    <div class="slider">
                        <div class="text">
                            <h2>X</h2>
                            <select required class="input_style" name="x" id="x">
                                <option value="-4">-4</option>
                                <option value="-3">-3</option>
                                <option value="-2">-2</option>
                                <option value="-1">-1</option>
                                <option value="0" selected="selected">0</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                            </select>
                        </div>
                        <div class="text">
                            <h2>Y</h2>
                            <input autocomplete="off" required onchange="onChangeY()" onkeyup="onChangeY()" class="input_style" placeholder="Введите число от -3 до 5" name="y" id="y">
                        </div>
                        <div class="text">
                            <h2>R</h2>
                            <label>
                                <input class="required_checkbox" type="checkbox" name="r" id="r" value="1">
                                1
                            </label>
                            <label>
                                <input class="required_checkbox" type="checkbox" name="r" id="r2" value="2">
                                2
                            </label>
                            <label>
                                <input class="required_checkbox" type="checkbox" name="r" id="r3" value="3">
                                3
                            </label>
                            <label>
                                <input class="required_checkbox" type="checkbox" name="r" id="r4" value="4">
                                4
                            </label>
                            <label>
                                <input class="required_checkbox" type="checkbox" name="r" id="r5" value="5">
                                5
                            </label>
                        </div>
                    </div>
                    <div class="slider">
                        <div class="picture"> <canvas width="210px" height="210px" id="canvas" style="background-image: url('assets/images/picture.png'); cursor: pointer"></canvas> </div>
                        <div class="button__border">
                            <input type="submit" class="main__button" value="Проверить" id="submit"> </div>
                    </div>
                    <script>
                        $("#info").submit(function(event) {
                            event.preventDefault();
                            console.log("Обработчик submit выполняется");
                        });
                        const btn = document.getElementById("submit");
                        btn.addEventListener('click', tableInfo, false);
                    </script>
                    <script>
                        const canvas = document.getElementById("canvas");
                        canvas.addEventListener('click', makeForm, false);
                        <% if(history != null) {
                              Point lastPoint = history.get(history.size() - 1);
                        %>
                        drawPoint(<%=lastPoint.getX()%>, <%=lastPoint.getY()%>, <%=lastPoint.getR()%>, <%=lastPoint.getHit()%>)
                        <%}%>
                    </script>
                </form>
                <script>
                    var checkboxes = document.querySelectorAll('.required_checkbox');
                    checkboxes.forEach(function(checkbox) {
                        checkbox.addEventListener('change', function() {
                            checkboxes.forEach(function(otherCheckbox) {
                                if (otherCheckbox !== checkbox) {
                                    otherCheckbox.checked = false;
                                }
                            });
                        });
                    });
                </script>
                <script>
                    document.getElementById("info").addEventListener("submit", function(event) {
                        let checkboxes = document.querySelectorAll(".required_checkbox");
                        let isChecked = false;

                        checkboxes.forEach(function(checkbox) {
                            if (checkbox.checked) {
                                isChecked = true;
                            }
                        });
                        if (!isChecked) {
                            alert('Пожалуйста, выберите хотя бы одну опцию.');
                            event.preventDefault();
                        }
                    });
                </script>
                <div class="table_container" id="table" style="visibility: hidden">
                    <table class="table">
                        <tr>
                            <th width="15%">X</th>
                            <th width="15%">Y</th>
                            <th width="15%">R</th>
                            <th width="25%">Время выполнения</th>
                            <th width="30%">Результат</th>
                        </tr>
                        <%
                            if (history != null) {
                                for (Point point : history ) {
                        %>
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
                        <% }}%>
                    </table>
                </div>
            </div>
        </td>
    </tr>
    <script>
        var contextPath = "${pageContext.request.contextPath}";
    </script>
    <script src="methods.js"></script>

</table>
</body>

</html>
