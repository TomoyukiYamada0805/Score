// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.addEventListener("turbolinks:load", function(){

    // 評価グラフ作成
    var evaluate_json = document.getElementById("evaluate_json")
    if (evaluate_json){
      var evaluate = JSON.parse(evaluate_json.value)
      var team_name  = []
      var team_color = []
      var count      = []
      for (var i = 0; i < evaluate.length; i++) {
        team_name.push(evaluate[i].short_name)
        team_color.push(evaluate[i].team_color)
        count.push(evaluate[i].count)
      }
      
      var ctx = document.getElementsByClassName("post-teams-analysis");
      var myPieChart = new Chart(ctx, {
        type: 'pie',
        data: {
          labels: team_name,
          datasets: [{
              backgroundColor: team_color,
              data: count
          }]
        },
        options: {
          title: {
            display: true,
            text: '採点プレイヤーのチーム 割合'
          }
        }
      })
    }
})