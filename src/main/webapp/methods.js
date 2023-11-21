const rDefault = 80
const zeroGraphic = 105
const acceptableX = [-4, -3, -2, -1, 0, 1, 2, 3, 4]
const acceptableR = ["1", "2", "3", "4", "5"]

function onChangeY() {
    let y = document.getElementById("y").value;

    if (y === "-" || y === "0") {
        return;
    }

    if ((y < 0 && y.length > 4) || (y > 0 && y.length > 3)) {
        document.getElementById("y").value = "";
    }

    if (parseInt(y)) {
        if (y >= -3 && y <= 5) {
            document.getElementById("y").setAttribute("style", "border: 2px green solid");
        } else {
            document.getElementById("y").setAttribute("style", "border: 2px red solid");
            document.getElementById("y").value = "";
        }
    } else {
        document.getElementById("y").setAttribute("style", "border: 2px red solid");
        document.getElementById("y").value = "";
    }
}

function checkY() {
    let y = document.getElementById("y").value;

    if(y === "-") {
        alert("Y не может быть \"-\"");
        return false;
    }
}

function showTable() {
    document.getElementById("info").setAttribute("style", "visibility: hidden");
    document.getElementById("table").setAttribute("style", "visibility: visible");
    document.getElementById("btn").setAttribute("onclick", "showInfo()");
}

function showInfo() {
    document.getElementById("info").setAttribute("style", "visibility: visible");
    document.getElementById("table").setAttribute("style", "visibility: hidden");
    document.getElementById("btn").setAttribute("onclick", "showTable()");
}

function makeForm(e) {
    if (checkBoxes()) {
        let image = document.getElementById("canvas");
        let imageBorders = image.getBoundingClientRect();
        let r = getR();
        //                   750 -
        let xCoordinate = e.clientX - imageBorders.left;
        let yCoordinate = e.clientY - imageBorders.top;
        let x = Math.round((xCoordinate - zeroGraphic) / rDefault * r);
        let y = ((zeroGraphic - yCoordinate) / rDefault * r).toFixed(1);
        if (acceptableX.includes(x) && y >= -3 && y <= 5) {
            document.getElementById("y").value = y;
            document.getElementById("x").value = x.toString();
        } else alert("Неподходящее значение для x или y")
    } else alert("Выберите радиус");
    console.log("Привет")
    tableInfo();
}

function checkBoxes() {
    let checkboxes = document.querySelectorAll(".required_checkbox");
    let isChecked = false;
    checkboxes.forEach(function(checkbox) {
        if (checkbox.checked) {
            isChecked = true;
        }
    });
    return isChecked
}

function getR() {
    let selectedR
    let checkboxes = document.querySelectorAll(".required_checkbox");
    checkboxes.forEach(function(checkbox) {
        if (checkbox.checked) {
            selectedR = checkbox.value;
        }
    });
    return selectedR
}

function clearCanvas() {
    let image = document.getElementById("canvas");
    let context = image.getContext('2d');
    context.clearRect(0, 0, image.width, image.height);
}

function drawPoint(x, y, r, hit) {
    let image = document.getElementById("canvas");
    let context = image.getContext('2d');
    let xCoordinate = zeroGraphic + x / r * rDefault;
    let yCoordinate = zeroGraphic - y / r * rDefault;
    if (hit) {
        context.fillStyle = 'rgb(173, 255, 47)'
    } else context.fillStyle = 'rgb(250, 47, 47)';
    context.strokeStyle = 'black';
    context.beginPath();
    context.arc(xCoordinate, yCoordinate, 3, 0, 2 * Math.PI);
    context.fill();
    context.stroke();
}

function tableInfo() {
    console.log("Функция tableInfo выполняется")
    let x = document.getElementById("x").value
    let y = document.getElementById("y").value
    let r = getR()
    console.log(y)

    console.log(y !== "")
    console.log(y >= -3 && y <= 5)
    if (acceptableX.includes(parseInt(x)) && acceptableR.includes(r) && y >= -3 && y <= 5 && y !== "") {
        console.log("Мы тут")
        let dataToSend = {
            x: x,
            y: y,
            r: r
        };
        console.log("Запрос выполняется")
        $.ajax({
            type: "POST",
            url: contextPath + "/controllerServlet",
            data: dataToSend,
            success: function (response) {
                let execution_time = response.time
                let x = response.x
                let y = response.y
                let r = response.r
                let hit = response.hit
                let newTableElement;
                document.getElementById("res_x").innerHTML = x;
                document.getElementById("res_y").innerHTML = y;
                document.getElementById("res_r").innerHTML = r;
                clearCanvas();
                drawPoint(x, y, r, hit);
                document.getElementById("res_exec_time").innerHTML = execution_time;
                document.getElementById("res_time").innerHTML = new Date().toLocaleTimeString();
                if (hit) {
                    document.getElementById("final_res").innerHTML = "Попадание";
                    document.getElementById("final_res").setAttribute("style", "color:#48d848;")
                    newTableElement = $("<tr>\n" +
                        "    <td>" + x + "</td>\n" +
                        "    <td>" + y + "</td>\n" +
                        "    <td>" + r + "</td>\n" +
                        "    <td>" + execution_time + "</td>\n" +
                        "    <td style='color:#48d848'>Попадание</td>\n" +
                        "</tr>");
                } else {
                    document.getElementById("final_res").innerHTML = "Промах";
                    document.getElementById("final_res").setAttribute("style", "color:#dd1818;")
                    newTableElement = $("<tr>\n" +
                        "    <td>" + x + "</td>\n" +
                        "    <td>" + y + "</td>\n" +
                        "    <td>" + r + "</td>\n" +
                        "    <td>" + execution_time + "</td>\n" +
                        "    <td style='color:#dd1818'>Промах</td>\n" +
                        "</tr>");
                }

                newTableElement.appendTo(".table")
            }
        })

        console.log("Запрос принимается")
        document.getElementById("main_table").setAttribute("style", "opacity: 0.2");
        let newElement = $("<div class=\"main_container\">\n" +
            "               <a onclick='tableMain()' class=\"link cross\"><img src=\"assets/images/cross.png\" alt=\"\"></a>\n" +
            "               <div class=\"info\" id=\"info\">\n" +
            "               <div class=\"column\">\n" +
            "               <div class=\"param x\"><b>X</b><span class=\"param_numbers\" id=\"res_x\"></span></div>\n" +
            "               <div class=\"param\"><b>Y</b><span class=\"param_numbers\" id=\"res_y\"></span></div>\n" +
            "               <div class=\"param\"><b>R</b><span class=\"param_numbers\" id=\"res_r\"></span></div>\n" +
            "               <div class=\"block\">\n" +
            "               <b>Время выполнения</b>\n" +
            "               <br>\n" +
            "               <span id=\"res_exec_time\"></span>\n" +
            "               </div>\n" +
            "               </div>\n" +
            "               <div class=\"column\">\n" +
            "               <div class=\"block x\">\n" +
            "               <b>Результат</b>\n" +
            "               <br>\n" +
            "               <span id=\"final_res\"></span>\n" +
            "               </div>\n" +
            "               <div class=\"block\">\n" +
            "               <b>Текущее время</b>\n" +
            "               <br>\n" +
            "               <span id=\"res_time\"></span>\n" +
            "               </div>\n" +
            "               </div>\n" +
            "               </div>\n" +
            "               </div>");
        newElement.appendTo("body");
    }
}

function tableMain() {
    document.getElementById("main_table").setAttribute("style", "opacity: 1");
    $(".main_container").remove();
}