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

