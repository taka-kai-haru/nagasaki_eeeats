let delicious;
let atmosphere;
let accessibility;
let cost_performance;
let assortment;
let service;



    ChartDataSet();
    DrawChart();

    // ボタンをクリックしたら、グラフを再描画
    document.getElementById('delicious').onclick = function() {
      ChartDataSet();
      DrawChart();
    }

    document.getElementById('atmosphere').onclick = function() {
      ChartDataSet();
      DrawChart();
    }

    document.getElementById('accessibility').onclick = function() {
      ChartDataSet();
      DrawChart();
    }

    document.getElementById('cost_performance').onclick = function() {
      ChartDataSet();
      DrawChart();
    }

    document.getElementById('assortment').onclick = function() {
      ChartDataSet();
      DrawChart();
    }

    document.getElementById('service').onclick = function() {
      ChartDataSet();
      DrawChart();
    }


function ChartDataSet(){
  delicious = Number(document.getElementById("delicious").value);
  atmosphere = Number(document.getElementById("atmosphere").value);
  accessibility = Number(document.getElementById("accessibility").value);
  cost_performance = Number(document.getElementById("cost_performance").value);
  assortment = Number(document.getElementById("assortment").value);
  service = Number(document.getElementById("service").value);
  document.getElementById('delicious_score').innerText = delicious;
  document.getElementById('atmosphere_score').innerText = atmosphere;
  document.getElementById('accessibility_score').innerText = accessibility;
  document.getElementById('cost_performance_score').innerText = cost_performance;
  document.getElementById('assortment_score').innerText = assortment;
  document.getElementById('service_score').innerText = service;
  document.getElementById('chart_score_ave').innerText =  (Math.round((delicious + atmosphere + accessibility + cost_performance + assortment + service) / 6 * 10) / 10).toFixed(1);
}


function DrawChart(){
let ctx = document.getElementById("ScoreRaderChart");
let ScoreRadarChart = new Chart(ctx, {
    type: 'radar', 
    data: { 
        labels: ["味", "雰囲気", "利便性", "コスパ", "品揃え", "接客"],
        datasets: [{
            label: '点数',
            data: [delicious, atmosphere, accessibility, cost_performance, assortment, service],
            backgroundColor: 'RGBA(225,95,150, 0.5)',
            borderColor: 'RGBA(225,95,150, 1)',
            borderWidth: 1
        }]
    },
    options: {
        title: {
            display: false
        },
        legend: {
            display: false // 凡例を非表示
        },
        scale:{
            pointLabels:{
              fontSize: 16 
            },
            ticks:{
                suggestedMin: 0,
                suggestedMax: 5,
                stepSize: 1,
                callback: function(value, index, values){
                    return  value +  '点'
                }
            }
        }
    }
});
}