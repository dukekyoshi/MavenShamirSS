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
            var element = "<div class='form-group'>"
                + "<label style='margin-top:7px;' class='col-sm-1'>" + num + "</label>"
                + "<label style='margin-top:7px;' class='col-sm-6'>" + question + "</label>"
                + "<div class='col-sm-4'><input id='quest' name='answer' type='text' class='form-control questions'/></div>"
                + "<a class='btn btn-danger' onclick='removeDiv(this)' style='margin-top:3px;'>"
                + "<span class='glyphicon glyphicon-remove-sign' aria-hidden='true'></span>"
                + "</a>"
                + "<input name='questions' type='hidden' value='" + question + "'/>"
                + "</div>";
            $(".submit-buttons-hr").before(element);
            num++;
            $("#counter").text(num);
        }
    });

    $("#addPassword").click(function() {
        var element = "<div class='form-group' style='margin-top:10px;'>"
            + "<label for='pswd' style='margin-top:7px;' class='col-sm-1 control-label'>Password</label>"
            + "<label style='margin-top:7px;' class='col-sm-1'>:</label>"
            + "<div class='col-sm-9'><input id='pswd' name='password' type='password' class='form-control' required='required'/></div>"
            + "<a class='btn btn-danger' onclick='removeDiv(this)' style='margin-top:3px;'>"
            + "<span class='glyphicon glyphicon-remove-sign' aria-hidden='true'></span>"
            + "</a></div>";
        $(".pswd-hr").before(element);
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

function removeDiv(e) {
    $(e).closest('div').remove();
}

function count() {
    var password = $("input#pswd").length;
//    var length = $("input#quest").length;
    if(password <= 0) {
        alert("Minimal 1 password");
        return false;
    }
//    if(length < 5) {
//        alert("Banyak pertanyaan minimum 5");
//        return false;
//    }
    return true;
}

