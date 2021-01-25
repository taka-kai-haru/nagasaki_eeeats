let delicious = document.getElementById("delicious");
let atmosphere = document.getElementById("atmosphere");
let accessibility = document.getElementById("accessibility");
let cost_performance = document.getElementById("cost_performance");
let assortment = document.getElementById("assortment");
let service = document.getElementById("service");

let deliciousScore;
let atmosphereScore;
let accessibilityScore;
let cost_performanceScore;
let assortmentScore;
let serviceScore;


ChartDataSet();
DrawChart();
if (navigator.userAgent.match(/iPhone|Android.+Mobile/)) {
    // ボタンをクリックしたら、グラフを再描画
    delicious.addEventListener('touchend', function () {
        ChartDataSet();
        DrawChart();
    })

    atmosphere.addEventListener('touchend', function () {
        ChartDataSet();
        DrawChart();
    })

    accessibility.addEventListener('touchend', function () {
        ChartDataSet();
        DrawChart();
    })

    cost_performance.addEventListener('touchend', function () {
        ChartDataSet();
        DrawChart();
    })

    assortment.addEventListener('touchend', function () {
        ChartDataSet();
        DrawChart();
    })

    service.addEventListener('touchend', function () {
        ChartDataSet();
        DrawChart();
    })

} else {
    // ボタンをクリックしたら、グラフを再描画
    delicious.addEventListener('click', function () {
        ChartDataSet();
        DrawChart();
    })

    atmosphere.addEventListener('click', function () {
        ChartDataSet();
        DrawChart();
    })

    accessibility.addEventListener('click', function () {
        ChartDataSet();
        DrawChart();
    })

    cost_performance.addEventListener('click', function () {
        ChartDataSet();
        DrawChart();
    })

    assortment.addEventListener('click', function () {
        ChartDataSet();
        DrawChart();
    })

    service.addEventListener('click', function () {
        ChartDataSet();
        DrawChart();
    })
}


function ChartDataSet() {
    deliciousScore = Number(delicious.value);
    atmosphereScore = Number(atmosphere.value);
    accessibilityScore = Number(accessibility.value);
    cost_performanceScore = Number(cost_performance.value);
    assortmentScore = Number(assortment.value);
    serviceScore = Number(service.value);
    document.getElementById('delicious_score').innerText = deliciousScore;
    document.getElementById('atmosphere_score').innerText = atmosphereScore;
    document.getElementById('accessibility_score').innerText = accessibilityScore;
    document.getElementById('cost_performance_score').innerText = cost_performanceScore;
    document.getElementById('assortment_score').innerText = assortmentScore;
    document.getElementById('service_score').innerText = serviceScore;
    document.getElementById('chart_score_ave').innerText = (Math.round((deliciousScore + atmosphereScore + accessibilityScore + cost_performanceScore + assortmentScore + serviceScore) / 6 * 10) / 10).toFixed(1);
}


function DrawChart() {
    let ctx = document.getElementById("ScoreRaderChart");
    let ScoreRadarChart = new Chart(ctx, {
        type: 'radar',
        data: {
            labels: ["味", "雰囲気", "利便性", "コスパ", "品揃え", "接客"],
            datasets: [{
                label: '点数',
                data: [deliciousScore, atmosphereScore, accessibilityScore, cost_performanceScore, assortmentScore, serviceScore],
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
            scale: {
                pointLabels: {
                    fontSize: 16
                },
                ticks: {
                    suggestedMin: 0,
                    suggestedMax: 5,
                    stepSize: 1,
                    callback: function (value, index, values) {
                        return value + '点'
                    }
                }
            }
        }
    });
}