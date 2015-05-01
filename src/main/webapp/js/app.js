$(document).ready(function() {
    $("#addQuestions").click(function() {
        var obj = $("#selectQuestions option:selected");
        var num = +$("#counter").text();
        if($("#selectQuestions").has('option').length > 0) {
            var element = "<div class='form-group'>" + "<label style='margin-top:7px;' class='col-sm-1'>" + num + "</label>"
                + "<label style='margin-top:7px;' class='col-sm-7'>" + obj.text() + "</label>" +
                "<div class='col-sm-4'><input id='quest' name='answer' type='text' class='form-control questions'/></div>"
                + "</div><input name='questions' type='hidden' value='" + obj.text() + "'/>";
            $(".submit-buttons-hr").before(element);
        }
        $("#selectQuestions option:selected").remove();
        num++;
        $("#counter").text(num);
    });

    $("#add").click(function() {
        var question = $("#question").val();
        var num = +$("#counter").text();
        if(question == "") {
            alert("Empty");
        } else {
            var element = "<div class='form-group box" + num + "'>" + "<label style='margin-top:7px;' class='col-sm-1'>" + num + "</label>"
                + "<label style='margin-top:7px;' class='col-sm-7'>" + question + "</label>" +
                "<div class='col-sm-4'><input id='quest' name='answer' type='text' class='form-control questions'/></div>"
                + "</div><input name='questions' type='hidden' value='" + question + "'/>";
            $(".submit-buttons-hr").before(element);
            num++;
            $("#counter").text(num);
        }
    });

    $("#addPassword").click(function() {
        var element = "<div class='form-group'><label for='pswd'"
            + "style='margin-top:7px;' class='col-sm-1 control-label'>"
            + "Password</label><label style='margin-top:7px;' class='col-sm-1'>"
            + ":</label><div class='col-sm-9'><input id='pswd' name='password' type='password'"
            + "class='form-control' required='required'/></div></div>";
        $("#addPassword").after(element);
    });
});

function check() {
    var share = $(".questions").length;
    var k = +$(".k-value").val();
    if(share < k) {
        return false;
    } else {
        return true;
    }
}

